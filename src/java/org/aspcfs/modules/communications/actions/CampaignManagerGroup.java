/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.communications.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.AccessTypeList;
import org.aspcfs.modules.admin.base.AccessType;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.communications.base.*;
import org.aspcfs.modules.communications.beans.SearchFormBean;
import org.aspcfs.modules.contacts.base.ContactList;
import org.aspcfs.modules.contacts.base.ContactTypeList;
import org.aspcfs.utils.Template;
import org.aspcfs.utils.web.HtmlDialog;
import org.aspcfs.utils.web.HtmlSelect;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.PagedListInfo;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.StringTokenizer;

/**
 * Actions for dealing with Groups in the Communications Module
 *
 * @author mrajkowski
 * @version $Id: CampaignManagerGroup.java,v 1.7 2001/12/20 19:33:26
 *          mrajkowski Exp $
 * @created December 11, 2001
 */
public final class CampaignManagerGroup extends CFSModule {

  /**
   * Display a list of the SearchCriteriaLists that are currently in the
   * database
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   * @since 1.1
   */
  public String executeCommandView(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-view")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    PagedListInfo pagedListInfo = this.getPagedListInfo(
        context, "CampaignGroupListInfo");
    pagedListInfo.setLink("CampaignManagerGroup.do?command=View");
    Connection db = null;
    SearchCriteriaListList sclList = new SearchCriteriaListList();
    try {
      db = this.getConnection(context);
      sclList.setPagedListInfo(pagedListInfo);
      if ("all".equals(pagedListInfo.getListView())) {
        sclList.setOwnerIdRange(this.getUserRange(context));
      } else {
        sclList.setOwner(this.getUserId(context));
      }
      sclList.buildList(db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    String submenu = context.getRequest().getParameter("submenu");
    if (submenu == null) {
      submenu = (String) context.getRequest().getAttribute("submenu");
    }
    if (submenu == null) {
      submenu = "ManageGroups";
    }
    context.getRequest().setAttribute("submenu", submenu);
    addModuleBean(context, submenu, "View Groups");
    if (errorMessage == null) {
      context.getRequest().setAttribute("sclList", sclList);
      return ("ViewOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   */
  public String executeCommandAdd(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-add")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    String passedId = null;
    Connection db = null;
    String source = context.getRequest().getParameter("source");
    	if ((source == null) || ("".equals(source))){
    		source = "contacts";    		
    	}
    passedId = context.getRequest().getParameter("id");
    String name = context.getRequest().getParameter("name");
    // building the search field and operator lists
    try {
      db = this.getConnection(context);
      buildFormElements(context, db);

      if (passedId != null) {
        SearchCriteriaList scl = new SearchCriteriaList(db, passedId);
        context.getSession().setAttribute("SCL", scl);
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    String submenu = context.getRequest().getParameter("submenu");
    if (submenu == null) {
      submenu = (String) context.getRequest().getAttribute("submenu");
    }
    if (submenu == null) {
      submenu = "ManageGroups";
    }
    context.getRequest().setAttribute("submenu", submenu);
    context.getRequest().setAttribute("source", source);
    context.getRequest().setAttribute("name", name);
    addModuleBean(context, submenu, "Build New Group");
    
    if (errorMessage == null) {
      return ("AddOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Displays the Campaign Group Editor page - used to create a new set of
   * criteria for a query
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   */
  public String executeCommandDelete(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-delete")) {
      return ("PermissionError");
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Exception errorMessage = null;
    boolean recordDeleted = false;
    String passedId = null;
    SearchCriteriaList thisSCL = null;
    passedId = context.getRequest().getParameter("id");
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisSCL = new SearchCriteriaList(db, passedId);
      if (!hasAuthority(context, thisSCL.getOwner())) {
        return "PermissionError";
      }
      recordDeleted = thisSCL.delete(db);
      if (!recordDeleted) {
        HashMap map = new HashMap();
        map.put("${thisSCL.inactiveCount}", "" + thisSCL.getInactiveCount());
        map.put(
            "${thisSCL.campaign}", (thisSCL.getInactiveCount() == 1 ? "campaign is" : "campaigns are"));
        map.put(
            "${thisSCL.use}", (thisSCL.getInactiveCount() == 1 ? "uses" : "use"));

        Template template = new Template(
            systemStatus.getLabel(
                "object.validation.actionError.canNotDeleteSCL"));
        template.setParseElements(map);
        thisSCL.getErrors().put("actionError", template.getParsedText());
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      if (recordDeleted) {
        context.getRequest().setAttribute(
            "refreshUrl", "CampaignManagerGroup.do?command=View");
        //deleteRecentItem(context, thisContact);
        return ("DeleteOK");
      } else {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("CampaignManager-> Error deleting group");
        }
        processErrors(context, thisSCL.getErrors());
        return (executeCommandView(context));
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Confirms deletion of campaign criteria
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   */
  public String executeCommandConfirmDelete(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-delete")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    Connection db = null;
    SearchCriteriaList thisSCL = null;
    HtmlDialog htmlDialog = new HtmlDialog();
    String id = null;
    if (context.getRequest().getParameter("id") != null) {
      id = context.getRequest().getParameter("id");
    }
    try {
      db = this.getConnection(context);
      SystemStatus systemStatus = this.getSystemStatus(context);
      thisSCL = new SearchCriteriaList(db, id);
      if (!hasAuthority(context, thisSCL.getOwner())) {
        return "PermissionError";
      }
      DependencyList dependencies = thisSCL.processDependencies(db);
      dependencies.setSystemStatus(systemStatus);
      htmlDialog.addMessage(
          systemStatus.getLabel("confirmdelete.caution") + "\n" + dependencies.getHtmlString());
      htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));

      if (dependencies.size() == 0) {
        htmlDialog.setShowAndConfirm(false);
        htmlDialog.setDeleteUrl(
            "javascript:window.location.href='CampaignManagerGroup.do?command=Delete&id=" + id + "'");
      } else {
        htmlDialog.setHeader(
            systemStatus.getLabel("confirmdelete.groupCampaignHeader"));
        htmlDialog.addButton(
            systemStatus.getLabel("button.ok"), "javascript:parent.window.close()");
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      context.getSession().setAttribute("Dialog", htmlDialog);
      return ("ConfirmDeleteOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Insert criteria into the database
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   * @since 1.1
   */
  public String executeCommandInsert(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-add")) {
      return ("PermissionError");
    }
    Connection db = null;
    boolean recordInserted = false;
    boolean isValid = false;
    SearchFormBean thisSearchForm = (SearchFormBean) context.getFormBean();
    SearchCriteriaList thisSCL = thisSearchForm.getSearchCriteriaList();
    String source = context.getRequest().getParameter("source");
    try {
      db = this.getConnection(context);

      //do nothing if a criteria isn't chosen    
      if (!this.validateObject(context, db, thisSearchForm)) {
        return ("InsertOK");
      }
      isValid = true;
      StringTokenizer st = new StringTokenizer(thisSearchForm.getSearchCriteriaText(), "^");
      while (st.hasMoreTokens()) {
        String tmpCriteria = (String) st.nextToken();
        SearchCriteriaElement thisElement = new SearchCriteriaElement(tmpCriteria);
        isValid = this.validateObject(context, db, thisElement) && isValid;
      }
      
      thisSCL.setGroupName(thisSearchForm.getGroupName());
      if ("sales".equals(source)) {
        thisSCL.setSource(2);
      }else{
        if ("contacts".equals(source)) {
          thisSCL.setSource(1);
        }else{
          thisSCL.setSource(3);
        }
      }
      
      thisSCL.setEnteredBy(getUserId(context));
      thisSCL.setModifiedBy(getUserId(context));
      thisSCL.setOwner(getUserId(context));
      isValid = this.validateObject(context, db, thisSCL) && isValid;
      if (isValid) {
        recordInserted = thisSCL.insert(db);
      } else {
        LookupList siteList = new LookupList(db, "lookup_site_id");
        siteList.addItem(-1, this.getSystemStatus(context).getLabel("calendar.none.4dashes"));
        thisSCL.setSiteList(siteList);
        thisSCL.buildRelatedResources(db);
        context.getRequest().setAttribute("SCL", thisSCL);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (recordInserted) {
      return ("InsertOK");
    }
    return (executeCommandAdd(context));
  }


  /**
   * Displays the Campaign Group Editor page - used to modify an existing set
   * of criteria for a query
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   */
  public String executeCommandModify(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-edit")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    Connection db = null;
    SearchCriteriaList scl = null;
    String passedId = context.getRequest().getParameter("id");
    // building the search field and operator lists
    try {
      db = this.getConnection(context);
      if (passedId != null) {
        scl = new SearchCriteriaList(db, passedId);
        String source = null;  
        if (scl.getContactSource() == 1){
          source = "contacts";
        }
        if (scl.getContactSource() == 2 ){
          source = "sales";
        }
        if (scl.getContactSource() == 3 ){
          source = "employees";
        }
        context.getRequest().setAttribute("source", source);
        buildFormElements(context, db);
        LookupList siteList = new LookupList(db, "lookup_site_id");
        siteList.addItem(-1, this.getSystemStatus(context).getLabel("calendar.none.4dashes"));
        scl.setSiteList(siteList);
        context.getRequest().setAttribute("SCL", scl);
        User owner = new User(db, scl.getOwner());
        context.getRequest().setAttribute("owner", owner);
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    String submenu = context.getRequest().getParameter("submenu");
    if (submenu == null) {
      submenu = (String) context.getRequest().getAttribute("submenu");
    }
    if (submenu == null) {
      submenu = "ManageGroups";
    }
    context.getRequest().setAttribute("submenu", submenu);
    addModuleBean(context, submenu, "Modify Criteria");
    if (errorMessage == null) {
      if (!hasAuthority(context, scl.getOwner())) {
        return ("PermissionError");
      }
      return ("ModifyOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Updates a SearchCriteriaList in the database
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   */
  public String executeCommandUpdate(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-edit")) {
      return ("PermissionError");
    }
    Connection db = null;
    boolean isValid = false;
    int resultCount = -1;
    SearchFormBean thisSearchForm = (SearchFormBean) context.getRequest().getAttribute("SearchForm");
    SearchCriteriaList thisSCL = thisSearchForm.getSearchCriteriaList();
    try {
      db = this.getConnection(context);

      //do nothing if a criteria isn't chosen    
      if (!this.validateObject(context, db, thisSearchForm)) {
        return ("UpdateOK");
      }
      isValid = true;
      StringTokenizer st = new StringTokenizer(thisSearchForm.getSearchCriteriaText(), "^");
      while (st.hasMoreTokens()) {
        String tmpCriteria = (String) st.nextToken();
        SearchCriteriaElement thisElement = new SearchCriteriaElement(tmpCriteria);
        isValid = this.validateObject(context, db, thisElement) && isValid;
      }
      thisSCL.setId(Integer.parseInt(context.getRequest().getParameter("id")));
      thisSCL.setGroupName(thisSearchForm.getGroupName());
      String source = context.getRequest().getParameter("source");
      if ("sales".equals(source)) {
        thisSCL.setSource(2);
      }else{
        if ("contacts".equals(source)) {
          thisSCL.setSource(1);
        }else{
          thisSCL.setSource(3);
        }
      }
      thisSCL.setOwner(thisSearchForm.getOwner());
      thisSCL.setModifiedBy(getUserId(context));
      if (!hasAuthority(context, thisSCL.getOwner())) {
        return ("PermissionError");
      }
      isValid = this.validateObject(context, db, thisSCL) && isValid;
      if (isValid) {
        resultCount = thisSCL.update(db);
      }
      if (resultCount != -1) {
        context.getRequest().setAttribute(
            "id", String.valueOf(thisSCL.getId()));
        context.getSession().removeAttribute("CampaignGroupsPreviewInfo");
        PagedListInfo pagedListInfo = this.getPagedListInfo(
            context, "CampaignGroupsPreviewInfo");
        pagedListInfo.setLink(
            "CampaignManagerGroup.do?command=Preview&id=" + thisSCL.getId());
      }
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "ManageGroups", "Preview");
    if (resultCount == 1) {
      if ("list".equals(context.getRequest().getParameter("return"))) {
        return executeCommandView(context);
      } else {
        return ("UpdateOK");
      }
    } else {
      if (resultCount == -1) {
        return executeCommandModify(context);
      }
      context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDetails(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-view")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    Connection db = null;
    SearchCriteriaList thisSCL = null;
    try {
      db = this.getConnection(context);
      //The criteria that makes up the contact list query
      thisSCL = new SearchCriteriaList(
          db, context.getRequest().getParameter("id"));
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1, this.getSystemStatus(context).getLabel("calendar.none.4dashes"));
      thisSCL.setSiteList(siteList);
      context.getRequest().setAttribute("scl", thisSCL);
      context.getRequest().setAttribute("id", String.valueOf(thisSCL.getId()));
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "ManageGroups", "Criteria");
    if (errorMessage == null) {
      if (!hasAuthority(context, thisSCL.getEnteredBy())) {
        return ("PermissionError");
      }
      return ("DetailsOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Preview the results of applying a SearchCriteriaList's criteria to the
   * data in the database
   *
   * @param context ActionContext
   * @return Description of the Returned Value
   */
  public String executeCommandPreview(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-view")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    Connection db = null;
    User user = this.getUser(context, this.getUserId(context));
    SearchCriteriaList thisSCL = null;
    try {
      db = this.getConnection(context);
      //The criteria that makes up the contact list query
      thisSCL = new SearchCriteriaList(
          db, context.getRequest().getParameter("id"));
      context.getRequest().setAttribute("scl", thisSCL);
      context.getRequest().setAttribute("id", String.valueOf(thisSCL.getId()));
      //Enable paging through records
      if ("true".equals(context.getRequest().getParameter("reset"))) {
        context.getSession().removeAttribute("CampaignGroupsPreviewInfo");
      }
      PagedListInfo pagedListInfo = this.getPagedListInfo(
          context, "CampaignGroupsPreviewInfo");
      pagedListInfo.setLink(
          "CampaignManagerGroup.do?command=Preview&id=" + thisSCL.getId());
      //Build the contactList
      ContactList contacts = new ContactList();
      contacts.setScl(
          thisSCL, this.getUserId(context), this.getUserRange(context));
      contacts.setPagedListInfo(pagedListInfo);
      contacts.setBuildDetails(true);
      if (thisSCL.getContactSource()==2) {
        contacts.setLeadsOnly(Constants.TRUE);
        contacts.setEmployeesOnly(Constants.FALSE);
      }else{
        if (thisSCL.getContactSource()==1) {
          contacts.setLeadsOnly(Constants.FALSE);
          contacts.setEmployeesOnly(Constants.FALSE);
        }else{
          contacts.setEmployeesOnly(Constants.TRUE);
        }
      }
      if (contacts.getSiteId() == Constants.INVALID_SITE) {
        contacts.setSiteId(user.getSiteId());
        contacts.setIncludeAllSites(true);
      } else {
        contacts.setExclusiveToSite(true);
        contacts.setIncludeAllSites(false);
      }
      contacts.setBuildTypes(false);
      
      AccessTypeList accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.GENERAL_CONTACTS);
      contacts.setGeneralContactAccessTypes(accessTypeList);
      contacts.buildList(db);
      context.getRequest().setAttribute("ContactList", contacts);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "ManageGroups", "Preview");
    if (errorMessage == null) {
      if (!hasAuthority(context, thisSCL.getEnteredBy())) {
        return ("PermissionError");
      }
      return ("PreviewOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Prepares a pop-up window to show contacts from a query
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandPopPreview(ActionContext context) {
    if (!hasPermission(context, "campaign-campaigns-groups-view")) {
      return ("PermissionError");
    }
    Exception errorMessage = null; 
    Connection db = null;
    SearchCriteriaList thisSCL = null;
    User user = this.getUser(context, this.getUserId(context));
    String source = context.getRequest().getParameter("source");
    boolean isValid = false;
    try {
      String criteria = context.getRequest().getParameter("criteria");
      //Enable paging through records
      if ("true".equals(context.getRequest().getParameter("reset"))) {
        context.getSession().removeAttribute("CampaignGroupsPreviewInfo");
      }
      PagedListInfo pagedListInfo = this.getPagedListInfo(
          context, "CampaignGroupsPreviewInfo");
      pagedListInfo.setLink(
          "CampaignManagerGroup.do?command=PopPreview&criteria=" + criteria + "&popup=true");
      //The criteria that makes up the contact list query
      isValid = true;
      StringTokenizer st = new StringTokenizer(criteria, "^");
      while (st.hasMoreTokens()) {
        String tmpCriteria = (String) st.nextToken();
        SearchCriteriaElement thisElement = new SearchCriteriaElement(tmpCriteria);
        isValid = this.validateObject(context, db, thisElement) && isValid;
      }
        db = this.getConnection(context);
      if (isValid) {
        thisSCL = new SearchCriteriaList(criteria);
        thisSCL.setGroupName("Preview Group");
        thisSCL.setEnteredBy(getUserId(context));
        thisSCL.setModifiedBy(getUserId(context));
        thisSCL.setOwner(getUserId(context));
        thisSCL.buildRelatedResources(db);
      }
      //Build the contactList
      ContactList contacts = new ContactList();
      if (isValid) {
        contacts.setScl(thisSCL, this.getUserId(context), this.getUserRange(context));
      contacts.setPagedListInfo(pagedListInfo);
      contacts.setBuildDetails(true);
      if ("sales".equals(source)) {
        contacts.setLeadsOnly(Constants.TRUE);
        contacts.setEmployeesOnly(Constants.FALSE);
      }else{
        if ("contacts".equals(source)) {
          contacts.setLeadsOnly(Constants.FALSE);
          contacts.setEmployeesOnly(Constants.FALSE);
        }else{
          contacts.setEmployeesOnly(Constants.TRUE);
        }
      }
      if (contacts.getSiteId() == Constants.INVALID_SITE) {
        contacts.setIncludeAllSites(true);
        contacts.setSiteId(user.getSiteId());
      } else {
        contacts.setIncludeAllSites(false);
        contacts.setExclusiveToSite(true);
      }
      contacts.setBuildTypes(false);
      //contacts.setOrgSiteId(UserUtils.getUserSiteId(context.getRequest()));
      AccessTypeList accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.GENERAL_CONTACTS);
      contacts.setGeneralContactAccessTypes(accessTypeList);
      contacts.buildList(db);
      } else {
        context.getRequest().setAttribute("errorString",
          this.getSystemStatus(context).getLabel("object.validation.checkCriteria.error",
            "Error. Please enter valid search criteria."));
      }
      context.getRequest().setAttribute("scl", thisSCL);
      context.getRequest().setAttribute("ContactList", contacts);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "ManageGroups", "Pop-up Preview");
    if (errorMessage == null) {
      return ("PopPreviewOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   * Build the objects that are used in creating the HTML form elements for
   * these pages
   *
   * @param context ActionContext
   * @param db      db connection
   * @throws SQLException SQL Exception
   */
  public void buildFormElements(ActionContext context, Connection db) throws SQLException {
    SearchFieldList searchFieldList = new SearchFieldList();
    SearchOperatorList stringOperatorList = new SearchOperatorList();
    SearchOperatorList dateOperatorList = new SearchOperatorList();
    SearchOperatorList numberOperatorList = new SearchOperatorList();

    SystemStatus thisSystem = this.getSystemStatus(context);
    HtmlSelect contactSource = new HtmlSelect();
    String source = context.getRequest().getParameter("source");
    if ((source == null) || ("".equals(source))){
      source = (String) context.getRequest().getAttribute("source");        
    }
    if ((source == null) || ("".equals(source))){
      source = "contacts";        
    }

    if ("contacts".equals(source)) {
      contactSource.addItem(
          SearchCriteriaList.SOURCE_MY_CONTACTS, thisSystem.getLabel(
              "contact.myContacts"));
      contactSource.addItem(
          SearchCriteriaList.SOURCE_ALL_CONTACTS, thisSystem.getLabel(
              "actionList.allContacts"));
      contactSource.addItem(
          SearchCriteriaList.SOURCE_ALL_ACCOUNTS, thisSystem.getLabel(
              "actionList.allAccountContacts"));
    }
    if ("sales".equals(source)) {
      contactSource.addItem(
          SearchCriteriaList.SOURCE_LEADS, thisSystem.getLabel(
              "sales.leads"));
    }
    if ("employees".equals(source)) {
      contactSource.addItem(
          SearchCriteriaList.SOURCE_EMPLOYEES, thisSystem.getLabel(
              "employees.employees"));
    }
    
    context.getRequest().setAttribute("ContactSource", contactSource);

    ContactTypeList typeList = new ContactTypeList();
    PagedListInfo contactTypeInfo = new PagedListInfo();
    contactTypeInfo.setItemsPerPage(0);
    typeList.setPagedListInfo(contactTypeInfo);
    typeList.buildList(db);
    LookupList ctl = typeList.getLookupList(thisSystem, "typeId", 0);
    ctl.setExcludeDisabledIfUnselected(true);
    ctl.setJsEvent(
        "onChange = \"javascript:setText(document.searchForm.typeId)\"");
    context.getRequest().setAttribute("ContactTypeList", ctl);

    LookupList accountTypeList = new LookupList();
    accountTypeList.setTableName("lookup_account_types");
    accountTypeList.setSelectSize(1);
    accountTypeList.setShowDisabledFlag(true);
    accountTypeList.setExcludeDisabledIfUnselected(true);
    accountTypeList.buildList(db);
    context.getRequest().setAttribute("AccountTypeList", accountTypeList);

    searchFieldList.buildFieldList(db);
    context.getRequest().setAttribute("SearchFieldList", searchFieldList);

    stringOperatorList.buildOperatorList(db, 0);
    context.getRequest().setAttribute(
        "StringOperatorList", stringOperatorList);

    dateOperatorList.buildOperatorList(db, 1);
    context.getRequest().setAttribute("DateOperatorList", dateOperatorList);

    numberOperatorList.buildOperatorList(db, 2);
    context.getRequest().setAttribute(
        "NumberOperatorList", numberOperatorList);

    LookupList siteValueList = new LookupList(db, "lookup_site_id");
    siteValueList.addItem(-1, thisSystem.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("SiteValueList", siteValueList);

    LookupList siteCriteriaList = new LookupList(db, "lookup_site_id");
    siteCriteriaList.addItem(-1, thisSystem.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("SiteCriteriaList", siteCriteriaList);
  }
}

