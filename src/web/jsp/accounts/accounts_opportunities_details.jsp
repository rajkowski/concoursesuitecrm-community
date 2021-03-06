<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.pipeline.base.OpportunityComponent,com.zeroio.iteam.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="OpportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="ComponentList" class="org.aspcfs.modules.pipeline.base.OpportunityComponentList" scope="request"/>
<jsp:useBean id="AccountsComponentListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="accounts_opportunities_details_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<%-- Preload image rollovers for drop-down menu --%>
<script language="JavaScript" type="text/javascript">
  loadImages('select');

  function reopenOpportunity(id) {
    if (id == '<%= OpportunityHeader.getId() %>') {
      scrollReload('Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %><%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>');
      return id;
    } else {
      return '<%= OpportunityHeader.getId() %>';
    }
  }
</script>
<% boolean allowMultiple = allowMultipleComponents(pageContext, OpportunityComponent.MULTPLE_CONFIG_NAME, "multiple");%>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
  <a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
  <a href="Accounts.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
  <a href="Accounts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
  <a href="Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.Opportunities">Opportunities</dhv:label></a> >
  <dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:container name="accounts" selected="opportunities" hideContainer='<%="true".equals(request.getParameter("actionplan")) %>' object="OrgDetails" param='<%= "orgId=" + OrgDetails.getOrgId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>'>
  <img src="images/icons/stock_form-currency-field-16.gif" border="0" align="absmiddle">
  <strong><%= toHtml(OpportunityHeader.getDescription()) %></strong>
  <% FileItem thisFile = new FileItem(); %>
  <dhv:evaluate if="<%= OpportunityHeader.hasFiles() %>">
    <%= thisFile.getImageTag("-23") %>
  </dhv:evaluate>
  <br>
  <dhv:hasAuthority owner="<%= OpportunityHeader.getManager() %>">
    <dhv:evaluate if="<%= !OpportunityHeader.getLock() %>">
      <dhv:evaluate if="<%= !OpportunityHeader.isTrashed() %>" >
        <dhv:permission name="accounts-accounts-opportunities-add">
          <dhv:evaluate if="<%=allowMultiple || (!allowMultiple && (ComponentList.size() == 0))%>" >
            <br />
            <a href="OpportunitiesComponents.do?command=Prepare&headerId=<%= OpportunityHeader.getId() %>&orgId=<%= OrgDetails.getOrgId() %><%= isPopup(request)?"&popup=true&popupType=inline":"" %>"><dhv:label name="accounts.accounts_contacts_opps_details.AddAComponent">Add a Component</dhv:label></a><br>
          </dhv:evaluate>
        </dhv:permission>
      </dhv:evaluate>
    </dhv:evaluate>
  </dhv:hasAuthority>
 <dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="AccountsComponentListInfo"/>
 <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
   <tr>
    <th>
      &nbsp;
    </th>
    <th nowrap>
      <a href="Opportunities.do?command=Details&headerId=<%= OpportunityHeader.getId() %>&orgId=<%= OrgDetails.getId() %>&column=oc.description<%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>"><dhv:label name="accounts.accounts_contacts_opps_details.Component">Component</dhv:label></a>
      <%= AccountsComponentListInfo.getSortIcon("oc.description") %>
    </th>
    <th nowrap>
      <a href="Opportunities.do?command=Details&headerId=<%= OpportunityHeader.getId() %>&orgId=<%= OrgDetails.getId() %>&column=oc.closed<%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>"><dhv:label name="accounts.accountasset_include.Status">Status</dhv:label></a>
      <%= AccountsComponentListInfo.getSortIcon("oc.closed") %>
    </th>
    <th nowrap>
      <a href="Opportunities.do?command=Details&headerId=<%= OpportunityHeader.getId() %>&orgId=<%= OrgDetails.getId() %>&column=oc.guessvalue<%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>"><dhv:label name="accounts.accounts_contacts_opps_details.GuessAmount">Guess Amount</dhv:label></a>
      <%= AccountsComponentListInfo.getSortIcon("oc.guessvalue") %>
    </th>
    <th nowrap>
      <a href="Opportunities.do?command=Details&headerId=<%= OpportunityHeader.getId() %>&orgId=<%=OrgDetails.getId()%>&column=oc.closedate<%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>"><dhv:label name="accounts.accounts_contacts_opps_details.CloseDate">Close Date</dhv:label></a>
      <%= AccountsComponentListInfo.getSortIcon("oc.closedate") %>
    </th>
    <th nowrap>
      <a href="Opportunities.do?command=Details&headerId=<%= OpportunityHeader.getId() %>&orgId=<%=OrgDetails.getId()%>&column=stagename<%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_details.CurrentStage">Current Stage</dhv:label></a>
      <%= AccountsComponentListInfo.getSortIcon("stagename") %>
    </th>
    <th>
      <dhv:label name="accounts.accounts_contacts_detailsimport.Owner">Owner</dhv:label>
    </th>
  </tr>
  <%
    Iterator j = ComponentList.iterator();
    if (j.hasNext()) {
      int rowid = 0;
      int i = 0;
        while (j.hasNext()) {
          i++;
          rowid = (rowid != 1?1:2);
          OpportunityComponent oppComponent = (OpportunityComponent)j.next();
          boolean hasPermission = false;
  %>
  <dhv:hasAuthority owner='<%= String.valueOf(OpportunityHeader.getManager()+","+oppComponent.getOwner()) %>'>
    <% hasPermission = true; %>
  </dhv:hasAuthority>
  <tr class="row<%= rowid %>">
      <td width="8" valign="top" align="center" nowrap>
        <%-- Use the unique id for opening the menu, and toggling the graphics --%>
        <%-- To display the menu, pass the actionId, accountId and the contactId--%>
        <a href="javascript:displayMenu('select<%= i %>','menuOpp','<%= OrgDetails.getId() %>','<%= oppComponent.getId() %>', '<%= OpportunityHeader.getId() %>','<%= (OpportunityHeader.isTrashed() || oppComponent.isTrashed()) %>','<%= hasPermission %>');" onMouseOver="over(0, <%=i%>)" onmouseout="out(0, <%= i %>); hideMenu('menuOpp');"><img src="images/select.gif" name="select<%= i %>" id="select<%= i %>" align="absmiddle" border="0"></a>
      </td>
      <td width="100%" valign="top">
        <a href="OpportunitiesComponents.do?command=DetailsComponent&orgId=<%= OrgDetails.getId() %>&headerId=<%=oppComponent.getHeaderId()%>&id=<%=oppComponent.getId()%><%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>">
        <dhv:evaluate if="<%=allowMultiple%>" >
          <%= toHtml(oppComponent.getDescription()) %>
        </dhv:evaluate>
        <dhv:evaluate if="<%=!allowMultiple%>" >
          <%= toHtml(OpportunityHeader.getDescription()) %>
        </dhv:evaluate>
        </a>
      </td>
      <td valign="top" align="center" nowrap>
        <% if(oppComponent.getClosed() != null) {%>
         <font color="red"><dhv:label name="project.closed.lowercase">closed</dhv:label></font>
        <%} else {%>
         <font color="green"><dhv:label name="project.open.lowercase">open</dhv:label></font>
        <%}%>
      </td>
      <td valign="top" align="right" nowrap>
        <zeroio:currency value="<%= oppComponent.getGuess() %>" code='<%= applicationPrefs.get("SYSTEM.CURRENCY") %>' locale="<%= User.getLocale() %>" default="&nbsp;"/>
      </td>
      <td valign="top" align="center" nowrap>
        <zeroio:tz timestamp="<%= oppComponent.getCloseDate() %>" dateOnly="true" timeZone="<%= oppComponent.getCloseDateTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
        <% if(!User.getTimeZone().equals(oppComponent.getCloseDateTimeZone())){%>
        <br>
        <zeroio:tz timestamp="<%= oppComponent.getCloseDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
        <% } %>
      </td>
      <td valign="top" align="center" nowrap>
        <%= toHtml(oppComponent.getStageName()) %>
      </td>
      <td valign="top" align="center" nowrap>
        <dhv:username id="<%= oppComponent.getOwner() %>"/>
      </td>
    </tr>
  <%}%>
  <%} else {%>
    <tr class="containerBody">
      <td colspan="7">
        <dhv:label name="accounts.accounts_contacts_opps_details.NoOpportunityComponentsFound">No opportunity components found.</dhv:label>
      </td>
    </tr>
  <%}%>
  </table>
  <br />
  <dhv:pagedListControl object="AccountsComponentListInfo"/>
  <dhv:evaluate if="<%= !OpportunityHeader.getLock() %>">
    <dhv:evaluate if="<%= !OpportunityHeader.isTrashed() %>" >
      <br />
      <dhv:permission name="accounts-accounts-opportunities-edit"><input type="button" value="<dhv:label name="global.button.RenameOpportunity">Rename Opportunity</dhv:label>" onClick="javascript:window.location.href='Opportunities.do?command=Modify&headerId=<%= OpportunityHeader.getId() %>&orgId=<%= OrgDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>';"></dhv:permission>
      <dhv:permission name="accounts-accounts-opportunities-delete"><input type="button" value="<dhv:label name="global.button.DeleteOpportunity">Delete Opportunity</dhv:label>" onClick="javascript:popURLReturn('Opportunities.do?command=ConfirmDelete&orgId=<%= OrgDetails.getId() %>&headerId=<%= OpportunityHeader.getId() %>&popup=true<%= isPopup(request)?"&popupType=inline":"" %>','Opportunities.do?command=View&orgId=<%= OrgDetails.getId() %>', 'Delete_opp','320','200','yes','no')"></dhv:permission>
    </dhv:evaluate>
  </dhv:evaluate>
</dhv:container>
