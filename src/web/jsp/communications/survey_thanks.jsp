<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<jsp:useBean id="ThankYouText" class="java.lang.String" scope="request"/>
<%@ include file="../initPage.jsp" %>
<html>
<head>
  <title>Thank you for visiting our survey page</title>
</head>
<body>
&nbsp;<br>
&nbsp;<br>
<center>
<table cellpadding="4" cellspacing="0" border="0" width="85%">
  <tr class="row1">
    <td>
      <font color="#8c8c8c"><strong>Web Survey</strong></font>
    </td>
  </tr>
</table>
&nbsp;<br>
<table cellpadding="4" cellspacing="0" border="0" width="85%">
  <tr>
    <td>
      <strong>Survey Submitted</strong>
    </td>
  </tr>
  <tr>
    <td>
      <%= toHtml(ThankYouText) %> <br>
    </td>
  </tr>
</table>
&nbsp;<br>
<table cellpadding="4" cellspacing="0" border="0" width="85%">
  <tr class="row1">
    <td align="center">
      <font color="#8c8c8c"><strong>(C) 2002-2004 Dark Horse Ventures, LLC</strong></font>
    </td>
  </tr>
</table>
</center>
</body>
</html>
