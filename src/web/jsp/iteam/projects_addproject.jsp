<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="Project" class="com.zeroio.iteam.base.Project" scope="request"/>
<jsp:useBean id="ProjectList" class="com.zeroio.iteam.base.ProjectList" scope="request"/>
<jsp:useBean id="DepartmentList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<%@ include file="initPage.jsp" %>
<body bgcolor='#FFFFFF' onLoad="document.inputForm.title.focus()">
<script language="JavaScript" type="text/javascript" src="/javascript/checkDate.js"></script>
<script language="JavaScript" type="text/javascript" src="/javascript/popCalendar.js"></script>
<form method="POST" name="inputForm" action="/ProjectManagement.do?command=InsertProject&auto-populate=true">
  <center>
  <table border="0" width="100%" cellspacing="0" cellpadding="0">
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="100%" colspan="2" bgcolor="#808080" rowspan="2">
        <font color="#FFFFFF">
        &nbsp;<img border='0' src='/images/task.gif'>
        <b>New Project Information</b>
        </font>
      </td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
		<tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="100%" colspan="2">
        &nbsp;<br>
				&nbsp;Import Requirements, Assignments, and Team from an Existing Project<br>
        &nbsp;
				<%= ProjectList.getHtmlSelect("templateId", 0) %>
      </td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="100%" colspan="2">
        &nbsp;<br>
        &nbsp;Project Title:<br>
        &nbsp;
        <input type="text" name="title" size="57" maxlength="100" value="<%= toHtmlValue(Project.getTitle()) %>"><font color=red>*</font> <%= showAttribute(request, "titleError") %><br>
        &nbsp;
      </td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="100%" colspan="2">
        &nbsp;Project Short
        Description:<br>
        &nbsp;
        <input type="text" name="shortDescription" size="57" maxlength="200" value="<%= toHtmlValue(Project.getShortDescription()) %>"><font color=red>*</font> <%= showAttribute(request, "shortDescriptionError") %><br>
        &nbsp;
      </td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="50%">
        &nbsp;Project Requested By:<br>
        &nbsp;
        <input type="text" name="requestedBy" size="24" maxlength="50" value="<%= toHtmlValue(Project.getRequestedBy()) %>"><br>
        &nbsp;
      </td>
      <td width="50%">
        &nbsp;Department:<br>
        &nbsp;
        <input type="text" name="requestedByDept" size="24" maxlength="50" value="<%= toHtmlValue(Project.getRequestedByDept()) %>"><br>
        &nbsp;
      </td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="50%">
        &nbsp;Start Date:<br>
        &nbsp;
        <input type="text" name="requestDate" size="10" value="<%= Project.getRequestDateString() %>">
        <a href="javascript:popCalendar('inputForm', 'requestDate');">Date</a>
        <font color=red>*</font> <%= showAttribute(request, "requestDateError") %><br>
        &nbsp;
      </td>
      <td width="50%">
        &nbsp;Category:<br>
        &nbsp;
        <%= DepartmentList.getHtmlSelect("departmentId", 0) %>
        <br>&nbsp;
      </td>    
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
<%
  String projectApprovedCheck = "";
  String projectClosedCheck = "";
%>
      <td width="100%" colspan="2">
        &nbsp;<input type="checkbox" name="approved" value="ON"<%=projectApprovedCheck%>>
        Project Approved <%= Project.getApprovedDateString() %>
      </td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="100%" colspan="2">
        &nbsp;<input type="checkbox" name="closed" value="ON"<%=projectClosedCheck%>>
        Project Closed <%= Project.getCloseDateString() %><br>
        &nbsp;
      </td>
      <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
    <tr>
      <td width="2" bgcolor="#808080">&nbsp;</td>
      <td width="50%" bgcolor="#808080" height="30">
        <p align="right">
          &nbsp;
          <input type='submit' value=' Save '>
          &nbsp;&nbsp;
        </p>
    </td>
      <td width="50%" bgcolor="#808080" height="30">
        <p align="left">
          &nbsp;&nbsp;<input type="submit" value="Cancel" onClick="javascript:this.form.action='/ProjectManagement.do'">
        </p>
    </td>
    <td width="2" bgcolor="#808080">&nbsp;</td>
    </tr>
  </table>
  </center>
</form>
</body>
