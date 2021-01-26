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
  - Version: $Id: companydirectory_reports_generate.jsp,v 1.32 2005/08/05 17:37:02 mrajkowski Exp $
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../initPage.jsp" %>
<jsp:useBean id="sourceList" class="org.aspcfs.utils.web.LookupList" scope="request" />
<jsp:useBean id="industryList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/reportSelect.js"></script>
<script language="JavaScript">
	function checkForm(form) {
		var test = document.generate.selectedList;
		formTest = true;
		message = "";
		if (checkNullString(form.subject.value)) { 
			message += label("subject.required", "- A subject is required\r\n");
			formTest = false;
		}
		if (formTest == false) {
			alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
			return false;
		} else {
			if (test != null) {
				return selectAllOptions(document.generate.selectedList);
			} else {
				return true;
			}
		}
	}
  function update() {
    if (document.generate.type.options[document.generate.type.selectedIndex].value == 4) {
      javascript:showSpan('new0');
    } else {
      javascript:hideSpan('new0');
    }
  }
</script>
<body onLoad="javascript:document.generate.subject.focus()">
<form name="generate" action="Sales.do?command=ExportReport" method="post" onSubmit="return checkForm(this);">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Sales.do"><dhv:label name="Leads" mainMenuItem="true">Leads</dhv:label></a> > 
<a href="Sales.do?command=Reports"><dhv:label name="accounts.accounts_relationships_view.ExportData">Export Data</dhv:label></a> >
<dhv:label name="accounts.accounts_reports_generate.NewExport">New Export</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<input type="submit" value="<dhv:label name="global.button.Generate">Generate</dhv:label>">
<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='Sales.do?command=Reports';javascript:this.form.submit();">
<br>
&nbsp;
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="5">
      <strong><dhv:label name="accounts.accounts_relationships_view.ExportData">Export Data</dhv:label></strong>
    </th>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accounts_contacts_calls_details_include.Subject">Subject</dhv:label>
    </td>
    <td colspan="4">
      <input type="text" size="35" name="subject" maxlength="50">&nbsp;<font color="red">*</font>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accountasset_include.Status">Status</dhv:label>
    </td>
    <td colspan="4">
      <select name="leadStatus" size="1">
        <option value="-1"><dhv:label name="quotes.all">All</dhv:label></option>
      <dhv:include name="leads.search.unread" none="true">
        <option value="<%= Contact.LEAD_UNREAD %>"><dhv:label name="sales.Unread">Unread</dhv:label></option>
      </dhv:include>
        <option value="<%= Contact.LEAD_UNPROCESSED %>"><dhv:label name="sales.Unprocessed">Unprocessed</dhv:label></option>
        <option value="<%= Contact.LEAD_ASSIGNED %>"><dhv:label name="sales.Assigned">Assigned</dhv:label></option>
        <option value="<%= Contact.LEAD_TRASHED %>"><dhv:label name="sales.Trashed">Trashed</dhv:label></option>
        <option value="<%= Contact.LEAD_WORKED %>"><dhv:label name="sales.working">Working</dhv:label></option>
      </select>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="contact.source">Source</dhv:label>
    </td>
    <td colspan="4">
      <%= sourceList.getHtmlSelect("sourceCode", -1) %>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accounts_add.Industry">Industry</dhv:label>
    </td>
    <td colspan="4">
      <%= industryList.getHtmlSelect("industryCode", -1) %>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      <dhv:label name="contact.sorting">Sorting</dhv:label>
    </td>
    <td colspan="4">
      <select name="sort">
        <option value="c.namelast"><dhv:label name="accounts.accounts_add.LastName">Last Name</dhv:label></option>
        <option value="c.contact_id"><dhv:label name="contact.leadId">Lead ID</dhv:label></option>
        <option value="c.namefirst"><dhv:label name="accounts.accounts_add.FirstName">First Name</dhv:label></option>
        <option value="c.org_name"><dhv:label name="accounts.accounts_contacts_detailsimport.Company">Company</dhv:label></option>
        <option value="c.title"><dhv:label name="accounts.accounts_contacts_add.Title">Title</dhv:label></option>
        <option value="departmentname"><dhv:label name="project.department">Department</dhv:label></option>
        <option value="c.entered"><dhv:label name="accounts.accounts_calls_list.Entered">Entered</dhv:label></option>
        <option value="c.modified"><dhv:label name="accounts.accounts_contacts_calls_details.Modified">Modified</dhv:label></option>
      </select>
    </td>
  </tr>
  <tr>
    <td nowrap valign="top" class="formLabel">
      <dhv:label name="accounts.accounts_reports_generate.SelectFields">Select fields</dhv:label><br>
      <dhv:label name="accounts.accounts_reports_generate.ToInclude">to include</dhv:label>
    </td>
    <td width="50%">
      <select size="5" name="fields">
      <option value="status" ><dhv:label name="accounts.accountasset_include.Status">Status</dhv:label></option>
      <option value="nameMiddle" ><dhv:label name="accounts.accounts_add.MiddleName">Middle Name</dhv:label></option>
      <option value="title" ><dhv:label name="accounts.accounts_contacts_add.Title">Title</dhv:label></option>
      <option value="department" ><dhv:label name="project.department">Department</dhv:label></option>
      <option value="entered" ><dhv:label name="accounts.accounts_calls_list.Entered">Entered</dhv:label></option>
      <option value="enteredBy" ><dhv:label name="accounts.accounts_calls_list.EnteredBy">Entered By</dhv:label></option>
      <option value="modified" ><dhv:label name="accounts.accounts_contacts_calls_details.Modified">Modified</dhv:label></option>
      <option value="modifiedBy" ><dhv:label name="accounts.accounts_fields_list.ModifiedBy">Modified By</dhv:label></option>
      <option value="owner" ><dhv:label name="accounts.accounts_contacts_detailsimport.Owner">Owner</dhv:label></option>
      <option value="businessEmail" ><dhv:label name="contact.businessEmail">Business Email</dhv:label></option>
      <option value="businessPhone" ><dhv:label name="contact.businessPhone">Business Phone</dhv:label></option>
      <option value="businessAddress" ><dhv:label name="contact.businessAddress">Business Address</dhv:label></option>
      <option value="city" ><dhv:label name="accounts.accounts_add.City">City</dhv:label></option>
      <option value="state" ><dhv:label name="contacts.address.state">State</dhv:label></option>
      <option value="zip" ><dhv:label name="accounts.accounts_add.ZipPostalCode">Zip/Postal Code</dhv:label></option>
      <option value="country" ><dhv:label name="accounts.accounts_add.Country">Country</dhv:label></option>
      <option value="notes" ><dhv:label name="accounts.accounts_add.Notes">Notes</dhv:label></option>
      <option value="source" ><dhv:label name="contact.source">Source</dhv:label></option>
      <option value="rating" ><dhv:label name="sales.rating">Rating</dhv:label></option>
      <option value="industry" ><dhv:label name="accounts.accounts_add.Industry">Industry</dhv:label></option>
      <option value="potential" ><dhv:label name="sales.potential">Potential</dhv:label></option>
      </select>
    </td>
    <td width="25">
      <table width="100%" cellspacing="0" cellpadding="2" border="0" class="empty">
        <tr>
          <td>
            <input type="button" value="<dhv:label name="accounts.accounts_reports_generate.AllR">All ></dhv:label>" onclick="javascript:allValues()">
          </td>
        </tr>
        <tr>
          <td>
            <input type="button" value="<dhv:label name="accounts.accounts_reports_generate.AddR">Add ></dhv:label>" onclick="javascript:addValue()">
          </td>
        </tr>
        <tr>
          <td>
            <input type="button" value="<dhv:label name="accounts.accounts_reports_generate.DelL">< Del</dhv:label>" onclick="javascript:removeValue()">
          </td>
        </tr>
      </table>
    </td>
    <td align="right" width="50%">
      <select size="5" name="selectedList" multiple>
      <option value="id" ><dhv:label name="contact.leadId">Lead ID</dhv:label></option>
      <option value="nameLast" ><dhv:label name="accounts.accounts_add.LastName">Last Name</dhv:label></option>
      <option value="nameFirst" ><dhv:label name="accounts.accounts_add.FirstName">First Name</dhv:label></option>
      <option value="company" ><dhv:label name="accounts.accounts_contacts_detailsimport.Company">Company</dhv:label></option>
      </select>
    </td>
    <td width="25">
	<table width="100%" cellspacing="0" cellpadding="2" border="0" class="empty">
    <tr>
      <td>
        <input type="button" value="<dhv:label name="global.button.Up">Up</dhv:label>" onclick="javascript:moveOptionUp(document.generate.selectedList)">
      </td>
    </tr>
    <tr>
      <td>
        <input type="button" value="<dhv:label name="global.button.Down">Down</dhv:label>" onclick="javascript:moveOptionDown(document.generate.selectedList)">
      </td>
    </tr>
	</table>
</td>
</tr>
</table>
<br>
<input type="submit" value="<dhv:label name="global.button.Generate">Generate</dhv:label>">
<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='Sales.do?command=Reports';javascript:this.form.submit();">
</form>
</body>
