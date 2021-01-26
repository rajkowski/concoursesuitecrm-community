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
  - Version: $Id: contacts_documents_details.jsp 17754 2006-12-11 vadim.vishnevsky@corratech.com $
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="FileItem" class="com.zeroio.iteam.base.FileItem" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="ExternalContacts.do"><dhv:label name="Contacts">Contacts</dhv:label></a> > 
<a href="ExternalContacts.do?command=SearchContacts"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<a href="ExternalContacts.do?command=ContactDetails&id=<%=ContactDetails.getId()%>"><dhv:label name="accounts.accounts_contacts_add.ContactDetails">Contact Details</dhv:label></a> >
<a href="ExternalContactsDocuments.do?command=View&contactId=<%=ContactDetails.getId()%>"><dhv:label name="contacts.documents">Documents</dhv:label></a> >
<dhv:label name="accounts.accounts_documents_details.DocumentDetails">Document Details</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:container name="contacts" selected="documents" object="ContactDetails" hideContainer='<%= "true".equals(request.getParameter("actionplan")) %>' param="<%= "id=" + ContactDetails.getId() %>" appendToUrl="<%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>">
  <table border="0" cellpadding="4" cellspacing="0" width="100%">
    <tr class="subtab">
      <td>
        <% String documentLink = "ExternalContactsDocuments.do?command=View&contactId="+ContactDetails.getId()+ addLinkParams(request, "popup|popupType|actionId|actionplan"); %>
        <zeroio:folderHierarchy module="ExternalContacts" link="<%= documentLink %>" showLastLink="true"/> >
        <%= FileItem.getSubject() %>
      </td>
    </tr>
  </table>
  <dhv:formMessage showSpace="false"/>
  <br />
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
    <tr>
      <th colspan="7">
        <strong><dhv:label name="accounts.accounts_documents_details.AllVersionsDocument">All Versions of this Document</dhv:label></strong>
      </th>
    </tr>
    <tr class="title2">
      <td width="8">&nbsp;</td>
      <td><dhv:label name="accounts.accounts_documents_details.Item">Item</dhv:label></td>
      <td><dhv:label name="accounts.accounts_documents_details.Size">Size</dhv:label></td>
      <td><dhv:label name="accounts.accounts_documents_details.Version">Version</dhv:label></td>
      <td><dhv:label name="accounts.accounts_documents_details.Submitted">Submitted</dhv:label></td>
      <td><dhv:label name="accounts.accounts_documents_details.SentBy">Sent By</dhv:label></td>
      <td><dhv:label name="accounts.accounts_documents_details.DL">D/L</dhv:label></td>
    </tr>
  <%
    Iterator versionList = FileItem.getVersionList().iterator();
    int rowid = 0;
    while (versionList.hasNext()) {
      rowid = (rowid != 1?1:2);
      FileItemVersion thisVersion = (FileItemVersion)versionList.next();
  %>
      <tr class="row<%= rowid %>">
        <td width="10" align="center" rowspan="2" nowrap>
          <a href="ExternalContactsDocuments.do?command=Download&contactId=<%= ContactDetails.getId() %>&fid=<%= FileItem.getId() %>&ver=<%= thisVersion.getVersion() %><%= addLinkParams(request, "popup|popupType|actionId|actionplan") %>"><dhv:label name="accounts.accounts_documents_details.Download">Download</dhv:label></a>
        </td>
        <td width="100%">
          <%= FileItem.getImageTag("-23") %><%= thisVersion.getClientFilename() %>
        </td>
        <td align="right" nowrap>
          <%= thisVersion.getRelativeSize() %> <dhv:label name="admin.oneThousand.abbreviation">k</dhv:label>&nbsp;
        </td>
        <td align="right" nowrap>
          <%= thisVersion.getVersion() %>&nbsp;
        </td>
        <td nowrap>
          <zeroio:tz timestamp="<%= thisVersion.getEntered() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" />
        </td>
        <td>
          <dhv:username id="<%= thisVersion.getEnteredBy() %>"/>
        </td>
        <td align="right">
          <%= thisVersion.getDownloads() %>
        </td>
      </tr>
      <tr class="row<%= rowid %>">
        <td colspan="6">
          <i><%= thisVersion.getSubject() %></i>
        </td>
      </tr>
    <%}%>
  </table>
</dhv:container>