<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home">My Home Page</a> > 
<a href="MyTasks.do?command=ListTasks">Tasks</a> >
Forward Task
</td>
</tr>
</table>
<%-- End Trails --%>
<form name="newMessageForm" action="MyTasksForward.do?command=SendMessage&actionSource=MyTasksForward" method="post" onSubmit="return sendMessage();">
<input type="submit" value="Send">
<input type="button" value="Cancel" onClick="javascript:window.location.href='MyTasks.do?command=ListTasks'"><br><br>
<%@ include file="../newmessage.jsp" %>
<br>
<input type="submit" value="Send">
<input type="button" value="Cancel" onClick="javascript:window.location.href='MyTasks.do?command=ListTasks'">
</form>

