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
  - Version: $Id: accounts_OppComponents_history.jsp 13379 2005-11-22 21:58:54Z kbhoopal $
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.pipeline.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.base.Constants" %>
<jsp:useBean id="orgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="opportunityComponent" class="org.aspcfs.modules.pipeline.base.OpportunityComponent" scope="request"/>
<jsp:useBean id="componentHistoryList" class="org.aspcfs.modules.pipeline.base.OpportunityComponentLogList" scope="request"/>
<jsp:useBean id="componentHistoryListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="accounts_opp_components_history_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  loadImages('select');

  function reopenOpportunity(id) {
    if (id == '<%= opportunityHeader.getId() %>') {
      scrollReload('Opportunities.do?command=View&orgId=<%= orgDetails.getOrgId() %><%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>');
      return id;
    } else {
      return '<%= opportunityHeader.getId() %>';
    }
  }
</script>
<%-- Trails --%>
<%
  boolean allowMultiple = allowMultipleComponents(pageContext, OpportunityComponent.MULTPLE_CONFIG_NAME, "multiple");
%>
<dhv:evaluate if="<%= !isPopup(request) %>">
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<a href="Accounts.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<a href="Accounts.do?command=Details&orgId=<%= orgDetails.getOrgId() %>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="Opportunities.do?command=View&orgId=<%= orgDetails.getOrgId() %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.Opportunities">Opportunities</dhv:label></a> >
<a href="Opportunities.do?command=Details&orgId=<%= orgDetails.getOrgId() %>&headerId=<%= opportunityHeader.getId() %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label></a> >
<dhv:label name="accounts.accounts_contacts_oppcomponent.componentLog">Componet Log</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:formMessage showSpace="false" />
<dhv:container name="accounts" selected="opportunities" hideContainer='<%="true".equals(request.getParameter("actionplan")) %>' object="orgDetails" param='<%= "orgId=" + orgDetails.getOrgId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>'>
<dhv:evaluate if="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <dhv:label name="pipeline.viewpoint.colon" param='<%= "username="+PipelineViewpointInfo.getVpUserName() %>'><b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b></dhv:label><br />
  &nbsp;<br>
</dhv:evaluate>
  <img src="images/icons/stock_form-currency-field-16.gif" border="0" align="absmiddle">
  <strong><%= toHtml(opportunityHeader.getDescription()) %></strong>
  <% FileItem thisFile = new FileItem(); %>
  <dhv:evaluate if="<%= opportunityHeader.hasFiles() %>">
    <%= thisFile.getImageTag("-23") %>
  </dhv:evaluate>
  <br>
  <dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="componentHistoryListInfo"/>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
    <tr>
      <th align="center" nowrap>
        &nbsp;
      </th>
      <dhv:include name="opportunity.openOrClosed" none="true">
        <th nowrap>
          <strong><a href="OpportunitiesComponents.do?command=ComponentHistory&orgId=<%= orgDetails.getOrgId() %>&headerId=<%= opportunityHeader.getId() %>&id=<%= opportunityComponent.getId() %>&column=ocl.description<%= addLinkParams(request, "viewSource|popup|popupType") %>"><dhv:label name="accounts.accounts_contacts_opps_details.Component">Component</dhv:label></a></strong>
          <%= componentHistoryListInfo.getSortIcon("ocl.description") %>
        </th>
      </dhv:include>
      <dhv:include name="opportunity.singleComponent" none="true">
        <th align="center" nowrap>
          <strong><a href="OpportunitiesComponents.do?command=ComponentHistory&orgId=<%= orgDetails.getOrgId() %>&headerId=<%= opportunityHeader.getId() %>&id=<%= opportunityComponent.getId() %>&column=ocl.owner<%= addLinkParams(request, "viewSource|popup|popupType") %>"><dhv:label name="accounts.accounts_contacts_detailsimport.Owner">Owner</dhv:label></strong>
          <%= componentHistoryListInfo.getSortIcon("ocl.owner") %>
        </th>
      </dhv:include>
      <th align="center" nowrap>
        <strong><a href="OpportunitiesComponents.do?command=ComponentHistory&orgId=<%= orgDetails.getOrgId() %>&headerId=<%= opportunityHeader.getId() %>&id=<%= opportunityComponent.getId() %>&column=ocl.closeprob<%= addLinkParams(request, "viewSource|popup|popupType") %>"><dhv:label name="reports.pipeline.probability">Probability</dhv:label></a></strong>
        <%= componentHistoryListInfo.getSortIcon("ocl.closeprob") %>
      </th>
      <th nowrap>
        <strong><a href="OpportunitiesComponents.do?command=ComponentHistory&orgId=<%= orgDetails.getOrgId() %>&headerId=<%= opportunityHeader.getId() %>&id=<%= opportunityComponent.getId() %>&column=ocl.closedate<%= addLinkParams(request, "viewSource|popup|popupType") %>"><dhv:label name="accounts.accounts_contacts_opps_details.CloseDate">Close Date</dhv:label></a></strong>
        <%= componentHistoryListInfo.getSortIcon("ocl.closedate") %>
      </th>
      <dhv:include name="opportunity.currentStage" none="true">
        <th nowrap>
          <strong><a href="OpportunitiesComponents.do?command=ComponentHistory&orgId=<%= orgDetails.getOrgId() %>&headerId=<%= opportunityHeader.getId() %>&id=<%= opportunityComponent.getId() %>&column=enteredby<%= addLinkParams(request, "viewSource|popup|popupType") %>"><dhv:label name="accounts.accounts_fields_list.ModifiedBy">Modified By</dhv:label></a></strong>
          <%= componentHistoryListInfo.getSortIcon("enteredby") %>
        </th>
      </dhv:include>
      <th nowrap>
        <strong><a href="OpportunitiesComponents.do?command=ComponentHistory&orgId=<%= orgDetails.getOrgId() %>&headerId=<%= opportunityHeader.getId() %>&id=<%= opportunityComponent.getId() %>&column=entered<%= addLinkParams(request, "viewSource|popup|popupType") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_list.LastModified">Last Modified</dhv:label></a></strong>
        <%= componentHistoryListInfo.getSortIcon("entered") %>
      </th>
    </tr>
<%
	Iterator j = componentHistoryList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
    int i =0;
	    while (j.hasNext()) {
        i++;
        rowid = (rowid != 1?1:2);
        OpportunityComponentLog thisComponentLog = (OpportunityComponentLog)j.next();
        boolean hasPermission = false;
%>
  <dhv:hasAuthority owner='<%= String.valueOf(opportunityHeader.getManager()+(opportunityHeader.getManager() == thisComponentLog.getOwner()?"":","+thisComponentLog.getOwner())) %>'>
    <% hasPermission = true;%>
  </dhv:hasAuthority>
    <tr class="row<%= rowid %>">
      <td width="8" valign="top" align="center" nowrap>
        <%-- Use the unique id for opening the menu, and toggling the graphics --%>
         <a href="javascript:displayMenu('select<%= i %>','menuOpp',<%= orgDetails.getOrgId() %>,'<%= thisComponentLog.getId() %>','<%= hasPermission %>');"
         onMouseOver="over(0, <%= i %>)" onmouseout="out(0, <%= i %>); hideMenu('menuOpp');"><img src="images/select.gif" name="select<%= i %>" id="select<%= i %>" align="absmiddle" border="0"></a>
      </td>
      <td width="100%" valign="top">
        <a href="OpportunitiesComponents.do?command=ComponentHistoryDetails&headerId=<%= opportunityHeader.getId() %>&orgId=<%= orgDetails.getOrgId() %>&id=<%= thisComponentLog.getId() %>&return=details<%= addLinkParams(request, "viewSource|popup|popupType") %>">
          <%= toHtml(thisComponentLog.getDescription()) %></a>
      </td>
      <td valign="top" align="center" nowrap>
        <dhv:username id="<%= thisComponentLog.getOwner() %>"/>
      </td>
      <td valign="top" align="center" nowrap>
        <%= thisComponentLog.getCloseProbValue() %>%
      </td>
      <td valign="top" align="center" nowrap>
        <% if(!User.getTimeZone().equals(thisComponentLog.getCloseDateTimeZone())){%>
        <zeroio:tz timestamp="<%= thisComponentLog.getCloseDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
        <% } else { %>
        <zeroio:tz timestamp="<%= thisComponentLog.getCloseDate() %>" dateOnly="true" timeZone="<%= thisComponentLog.getCloseDateTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
        <% } %>
      </td>
      <td valign="top" align="center" nowrap>
        <dhv:username id="<%= thisComponentLog.getEnteredBy() %>"/>
      </td>
      <td valign="top" align="center" nowrap>
        <zeroio:tz timestamp="<%= thisComponentLog.getEntered() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
      </td>
    </tr>
<%}%>
<%} else {%>
    <tr class="containerBody">
      <td colspan="9">
        <dhv:label name="accounts.accounts_contacts_opps_details.NoOpportunityComponentLogFound">No opportunity component history found.</dhv:label>
      </td>
    </tr>
<%}%>
  </table>
  <br>
  <dhv:pagedListControl object="componentHistoryListInfo"/>
  &nbsp;<br>
</dhv:container>
