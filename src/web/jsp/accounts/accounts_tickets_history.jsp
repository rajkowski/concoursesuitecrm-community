<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<a href="Accounts.do?command=Search">Search Results</a> >
<a href="Accounts.do?command=Details&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="Accounts.do?command=ViewTickets&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="accounts.tickets.tickets">Tickets</dhv:label></a> >
<a href="AccountTickets.do?command=TicketDetails&id=<%=TicketDetails.getId()%>"><dhv:label name="accounts.tickets.details">Ticket Details</dhv:label></a> >
History
</td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="accounts_details_header_include.jsp" %>
<% String param1 = "orgId=" + TicketDetails.getOrgId(); %>      
<dhv:container name="accounts" selected="tickets" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
  	<td class="containerBack">
        <%@ include file="accounts_ticket_header_include.jsp" %>
        <% String param2 = "id=" + TicketDetails.getId(); %>
        [ <dhv:container name="accountstickets" selected="history" param="<%= param2 %>"/> ]
        <br><br>
        <%-- display history --%>
        <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
          <tr>
            <th colspan="4">
              <strong><dhv:label name="accounts.tickets.historyLog">Ticket Log History</dhv:label></strong>
            </th>     
          </tr>
        <%  
            Iterator hist = TicketDetails.getHistory().iterator();
            if (hist.hasNext()) {
              while (hist.hasNext()) {
                TicketLog thisEntry = (TicketLog)hist.next();
        %>    
        <% if (thisEntry.getSystemMessage() == true) {%>
          <tr class="row1">
        <% } else { %>
          <tr class="containerBody">
        <%}%>
            <td nowrap valign="top" class="formLabel">
              <%= toHtml(thisEntry.getEnteredByName()) %>
            </td>
            <td nowrap valign="top">
              <zeroio:tz timestamp="<%= thisEntry.getEntered() %>" />
            </td>
            <td valign="top" width="100%">
              <%= toHtml(thisEntry.getEntryText()) %>
            </td>
          </tr>
        <%    
            }
          } else {
        %>
          <tr class="containerBody">
            <td>
              <font color="#9E9E9E" colspan="3">No Log Entries.</font>
            </td>
          </tr>
        <%}%>
       <%-- ticket container end --%>
      </table>
    </td>
  </tr>
  <%-- account container end --%>
</table>
