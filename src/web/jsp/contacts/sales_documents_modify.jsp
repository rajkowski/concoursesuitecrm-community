<%-- 
  - Copyright(c) 2007 Concursive Corporation (http://www.concursive.com/) All
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
  - Version: $Id: contacts_documents_modify.jsp 17754 2006-12-11 vadim.vishnevsky@corratech.com $
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.contacts.base.*,com.zeroio.iteam.base.*,org.aspcfs.modules.base.Constants" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="FileItem" class="com.zeroio.iteam.base.FileItem" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="from" class="java.lang.String" scope="request" />
<jsp:useBean id="listForm" class="java.lang.String" scope="request" />
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" type="text/javascript" src="javascript/tasks.js"></script>
<script language="JavaScript">
  function checkFileForm(form) {
    if (form.dosubmit.value == "false") {
      return true;
    }
    var formTest = true;
    var messageText = "";
    if (form.subject.value == "") {
      messageText += label("Subject.required", "- Subject is required\r\n");
      formTest = false;
    }
    if ((form.clientFilename.value) == "") {
      messageText += label("Filename.required", "- Filename is required\r\n");
      formTest = false;
    }
    if (formTest == false) {
      messageText = label("Fileinfo.not.submitted", "The file information could not be submitted.          \r\nPlease verify the following items:\r\n\r\n") + messageText;
      form.dosubmit.value = "true";
      alert(messageText);
      return false;
    } else {
      return true;
    }
  }
</script>
<body onLoad="document.inputForm.subject.focus();">
<form method="post" name="inputForm" action="SalesDocuments.do?command=Update<%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>" onSubmit="return checkFileForm(this);">
<input type="hidden" name="dosubmit" value="true">
<input type="hidden" name="contactId" value="<%= ContactDetails.getId() %>">
<input type="hidden" name="fid" value="<%= FileItem.getId() %>">
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Sales.do"><dhv:label name="Leads" mainMenuItem="true">Leads</dhv:label></a> >
<% if (from != null && "list".equals(from) && !"dashboard".equals(from)) { %>
  <a href="Sales.do?command=List&listForm=<%= (listForm != null? listForm:"") %>"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<%}%>
<a href="Sales.do?command=Details&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>"><dhv:label name="sales.leadDetails">Lead Details</dhv:label></a> >
<a href="SalesDocuments.do?command=View&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>"><dhv:label name="contacts.documents">Documents</dhv:label></a> >
<dhv:label name="accounts.accounts_documents_modify.ModifyDocument">Modify Document</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:container name="contacts" selected="documents" object="ContactDetails" hideContainer='<%= "true".equals(request.getParameter("actionplan")) %>' param='<%= "id=" + ContactDetails.getId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId|actionplan|from|listForm") %>'>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr class="subtab">
    <td>
      <% String documentLink = "SalesDocuments.do?command=View&contactId="+ContactDetails.getId(); %>
      <zeroio:folderHierarchy module="Sales" link="<%= documentLink %>" />
    </td>
  </tr>
</table>
  <dhv:formMessage />
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2">
        <img border="0" src="images/file.gif" align="absmiddle"><b><dhv:label name="accounts.accounts_documents_modify.ModifyDocumentInformation">Modify Document Information</dhv:label></b>
      </th>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_documents_modify.SubjectOfFile">Subject of file</dhv:label>
      </td>
      <td>
        <input type="hidden" name="folderId" value="<%= request.getParameter("folderId") %>">
        <input type="text" name="subject" size="59" maxlength="255" value="<%= FileItem.getSubject() %>">
        <%= showAttribute(request, "subjectError") %>
      </td>
    </tr>
    <%if (ContactDetails.getOrgId()!=-1){ %>
    <% if (User.getRoleType() == Constants.ROLETYPE_CUSTOMER){ %>
    <input type="hidden" name="allowPortalAccess" value="1"></input>
    <%} else { %>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_document_portal_include.ShareWithPortalUser">Share With Portal User?</dhv:label>
      </td>
      <td>
        <input type="checkbox" name="chk1" value="on" onclick="javascript:setField('allowPortalAccess', document.inputForm.chk1.checked, 'inputForm');" <%= FileItem.getAllowPortalAccess() ? "checked":""%> />
        <input type="hidden" name="allowPortalAccess" value="<%= FileItem.getAllowPortalAccess() ? "1":"0"%>"></input>
      </td>
    </tr>
 		<%}%>
 		<%} else { %>
 		<input type="hidden" name="allowPortalAccess" value="0"></input>
 		<%} %>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_documents_modify.Filename">Filename</dhv:label>
      </td>
      <td>
        <input type="text" name="clientFilename" size="59" maxlength="255" value="<%= FileItem.getClientFilename() %>">
      </td>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_documents_details.Version">Version</dhv:label>
      </td>
      <td>
        <%= FileItem.getVersion() %>
      </td>
    </tr>
  </table>
  <br />
  <input type="submit" value="<dhv:label name="global.button.update">Update</dhv:label>" name="update" />
  <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.dosubmit.value='false';this.form.action='SalesDocuments.do?command=View<%= addLinkParams(request, "popup|popupType|actionId|actionplan|from|listForm") %>';" />
</dhv:container>
</form>
</body>
