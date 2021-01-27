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
<%@ page import="org.aspcfs.modules.base.Constants, org.aspcfs.modules.troubletickets.base.Ticket" %>
<%
  Ticket thisTicket = (Ticket)request.getAttribute("TicketDetails");
  if (thisTicket == null) {
    thisTicket = (Ticket)request.getAttribute("ticketDetails");
  }
  if (thisTicket == null) {
    thisTicket = (Ticket) request.getAttribute("ticket");
  }
%>
<table width="100%" border="0">
  <tr>
    <td colspan="2" align="right">
      <a href="TroubleTickets.do?command=PrintReport&id=<%= thisTicket.getId() %>"><dhv:label name="accounts.tickets.print">Printable Ticket Form</dhv:label></a>
    </td>
  </tr>
  <tr>
    <td nowrap>
      <strong><dhv:label name="quotes.quotes.header.status">Status:</dhv:label></strong>
<% if (thisTicket.getClosed() == null){ %>
      <dhv:label name="quotes.open">Open</dhv:label>
<%}else{%>
      <font color="red">Closed on
      <zeroio:tz timestamp="<%= thisTicket.getClosed() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true"/>
      </font>
<%}%>
    </td>
  <dhv:evaluate if="<%= thisTicket.getContractId() > -1 %>">
    <td align="right" nowrap>
      <strong><dhv:label name="account.ticket.hoursRemaining.colon">Hours Remaining:</dhv:label></strong>
      <%= thisTicket.getTotalHoursRemaining() %>
      <input type="hidden" name="totalHoursRemaining" value="<%= thisTicket.getTotalHoursRemaining() %>" />
    </td>
  </dhv:evaluate>
  </tr>
</table>
<br />
