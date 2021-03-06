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
<%@ page import="java.util.*,org.aspcfs.modules.base.*,org.aspcfs.modules.contacts.base.*" %>
<%@ page import="org.aspcfs.modules.contacts.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="typeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="contactPhoneNumberList" class="org.aspcfs.modules.contacts.base.ContactPhoneNumberList" scope="request"/>
<jsp:useBean id="contact" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="hiddenField" class="java.lang.String" scope="request" />
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popContactPhoneNumberListSingle.js"></script>
<script language="JavaScript" TYPE="text/javascript">
  function confirmDelete(addressId){
    if (confirm(label('confirm.delete.contact.address','Are you sure you want to delete the selected contact address?'))) {
      window.location.href = 'ContactPhoneNumberSelector.do?command=Delete&addressId=' + addressId+'&contactId='+'<%= (contact != null)?""+contact.getId():"" %>&hiddenField=<%= ((hiddenField!=null)? hiddenField:"") %>';
    }
  }
</script>
<a href="ContactPhoneNumberSelector.do?command=PhoneNumberForm&hiddenField=<%= ((hiddenField!=null)? hiddenField:"") %>&contactId=<%= (contact != null? ""+contact.getId():"") %>"><dhv:label name="button.addPhoneNumber">Add Phone Number</dhv:label></a><br />
<br />
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th colspan="3"><dhv:label name="contacts.contactsPhoneNumberList">Contact Phone Number List</dhv:label></th>
  </tr>
  <tr>
    <td nowrap><strong><dhv:label name="accounts.Action">Action</dhv:label></strong></td>
    <td width="50%"><strong><dhv:label name="quotes.phoneNumber">Phone Number</dhv:label></strong></td>
    <td width="50%"><strong><dhv:label name="accounts.accounts_add.Type">Type</dhv:label></strong></td>
  </tr>
<%
  if (contactPhoneNumberList.size() > 0) {
     int rowid=0;
     int i=0;
    Iterator iterator = (Iterator) contactPhoneNumberList.iterator();
    while (iterator.hasNext()) {
      ContactPhoneNumber address = (ContactPhoneNumber) iterator.next();
      i++;
      rowid = ( rowid != 1 ? 1:2 );
%>
  <tr class="row<%= rowid %>">
    <td valign="top" nowrap>
      <a href="javascript:setContactPhoneNumber( '<%= address.getPhoneNumber() %>','<%= address.getType() %>', '<%= ((hiddenField != null)?hiddenField:"") %>');"><dhv:label name="accounts.accounts_add.select">Select</dhv:label></a> / 
      <a href="javascript:confirmDelete('<%= address.getId() %>');"><dhv:label name="global.button.delete">Delete</dhv:label></a></td>
    <td nowrap valign="top"><%= toHtml(address.getPhoneNumber()) %></td>
    <td nowrap valign="top"><%= toHtml(address.getTypeName()) %></td>
  </tr>
<%
    }
  } else {
%>
  <tr>
    <td colspan="3"><dhv:label name="contacts.noContactPhoneNumberFound">No Contact Phone Number found. Please add one.</dhv:label></td>
  </tr>
<%
  }
%>
</table>
<br />
<input type="button" value="<dhv:label name="button.cancel">Cancel</dhv:label>" onClick="javascript:window.close();" />
