/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.controller;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;
import com.darkhorseventures.framework.servlets.ControllerGlobalItemsHook;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.tasks.base.TaskList;
import org.aspcfs.modules.actionplans.base.ActionStep;
import org.aspcfs.utils.DatabaseUtils;

import javax.servlet.Servlet;
import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

/**
 * Configures globally available items for CFS.
 *
 * @author mrajkowski
 * @version $Id: GlobalItemsHook.java,v 1.15 2002/12/23 16:12:28 mrajkowski
 * Exp $
 * @created July 9, 2001
 */
public class GlobalItemsHook implements ControllerGlobalItemsHook {

  /**
   * Generates all of the HTML for the permissable items.
   *
   * @param request Description of Parameter
   * @param servlet Description of the Parameter
   * @return Description of the Returned Value
   * @since 1.0
   */
  public String generateItems(Servlet servlet, HttpServletRequest request) {
    ConnectionElement ce = (ConnectionElement) request.getSession().getAttribute(
        "ConnectionElement");
    if (ce == null) {
      return null;
    }
    Hashtable systems = (Hashtable) servlet.getServletConfig().getServletContext().getAttribute(
        "SystemStatus");
    if (systems == null) {
      return null;
    }
    SystemStatus systemStatus = (SystemStatus) (systems).get(ce.getUrl());
    if (systemStatus == null) {
      return null;
    }
    UserBean thisUser = (UserBean) request.getSession().getAttribute("User");
    if (thisUser == null) {
      return null;
    }
    TimeZone timeZone = TimeZone.getTimeZone(
        thisUser.getUserRecord().getTimeZone());
    int userId = thisUser.getUserId();
    int departmentId = thisUser.getUserRecord().getContact().getDepartment();
    int contactId = thisUser.getUserRecord().getContact().getId();

    //get today
    Calendar today = Calendar.getInstance(timeZone);
    today.set(Calendar.HOUR, 0);
    today.set(Calendar.MINUTE, 0);
    today.set(Calendar.SECOND, 0);
    today.set(Calendar.MILLISECOND, 0);
    //get tomorrow
    Calendar tomorrow = Calendar.getInstance(timeZone);
    tomorrow.set(Calendar.HOUR, 0);
    tomorrow.set(Calendar.MINUTE, 0);
    tomorrow.set(Calendar.SECOND, 0);
    tomorrow.set(Calendar.MILLISECOND, 0);
    tomorrow.add(Calendar.DAY_OF_MONTH, 1);

    StringBuffer items = new StringBuffer();

    //Site Search
    boolean isOfflineMode = Boolean.parseBoolean(ApplicationPrefs.getPref(servlet.getServletConfig().getServletContext(), "OFFLINE_MODE"));
    String om = isOfflineMode ? "-offline" : "";
    if (systemStatus.hasPermission(userId, "globalitems-search-view" + om)) {
      items.append(
          "<!-- Site Search -->" +
              "<table class=\"globalItem\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">" +
              "<form action='Search.do?command=SiteSearch' method='post'>" +
              "<tr><th>" + systemStatus.getLabel("search.header") + "</th></tr>" +
              "<tr>" +
              "<td nowrap>" +
              "<img src=\"images/icons/stock_zoom-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<input type='text' size='10' name='searchSearchText'>" +
              "<input type='submit' value='" + systemStatus.getLabel("search.go") + "' name='Search'>" +
              "</td>" +
              "</tr>" +
              "</form>" +
              "</table>");
    }

    //Quick Items
    if (!systemStatus.hasField("global.quickactions")) {
      if (systemStatus.hasPermission(userId, "globalitems-search-view" + om)) {
        items.append(
            "<!-- Quick Action -->" +
                "<script language='javascript' type='text/javascript' src='javascript/popURL.js'></script>" +
                "<script language='javascript' type='text/javascript' src='javascript/quickAction.js'></script>" +
                "<table class=\"globalItem\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">" +
                "<tr><th>" + systemStatus.getLabel("quickactions.header") + "</th></tr>" +
                "<tr>" +
                "<td nowrap>");
        if (systemStatus.hasPermission(userId, "contacts-external_contacts-calls-add" + om)) {
          items.append("<img src=\"images/alertcall.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('ExternalContactsCalls.do?command=Log&contactId=-1&actionSource=GlobalItem&popup=true','Activity','630','425','yes','yes');\">" +
              systemStatus.getLabel("quickactions.logActivity") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "contacts-external_contacts-calls-add" + om)) {
          items.append("<img src=\"images/box-hold.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('ExternalContactsCalls.do?command=Schedule&contactId=-1&actionSource=GlobalItem&popup=true','Activity','630','425','yes','yes');\">" +
              systemStatus.getLabel("quickactions.scheduleActivity") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "contacts-external_contacts-add" + om)) {
          items.append("<img src=\"images/icons/stock_bcard-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('ExternalContacts.do?command=Prepare&actionSource=GlobalItem&popup=true','contact','630','425','yes','yes');\">" +
              systemStatus.getLabel("quickactions.addContact") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "accounts-accounts-add" + om)) {
          items.append("<img src=\"images/icons/stock_account-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('Accounts.do?command=Add&actionSource=GlobalItem&popup=true','Account','630','425','yes','yes');\">" +
              systemStatus.getLabel("quickactions.addAccount") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "myhomepage-tasks-add" + om)) {
          items.append("<img src=\"images/box.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('MyTasks.do?command=New&actionSource=GlobalItem&popup=true&moreFields=false','Task','600','425','yes','yes');\">" +
              systemStatus.getLabel("quickactions.addTask") +
              "</a> </br>");
        }

        items.append("<img src=\"images/icons/stock_data-edit-table-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
            "<a href=\"javascript:popURL('MyCFS.do?command=AddNote&actionSource=GlobalItem&popup=true','Note','600','500','yes','yes');\">" +
            systemStatus.getLabel("quickactions.addNote") +
            "</a> </br>");

        if (systemStatus.hasPermission(userId, "contacts-external_contacts-messages-add" + om) || systemStatus.hasPermission(userId, "contacts-external_contacts-messages-view" + om)) {
          items.append("<img src=\"images/icons/stock_mail-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('ExternalContactsMessages.do?command=PrepareQuickMessage&actionSource=GlobalItem&popup=true','contact','600','425','yes','yes');\">" +
              systemStatus.getLabel("quickactions.mailToContact") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "sales-leads-add" + om)) {
          items.append("<img src=\"images/icons/stock_hyperlink-target-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('Sales.do?command=Add&actionSource=GlobalItem&popup=true','Lead','600','500','yes','yes');\">" +
              systemStatus.getLabel("quickactions.addLead") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "quotes-quotes-add" + om)) {
          items.append("<img src=\"images/icons/stock_hyperlink-target-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('Quotes.do?command=AddQuoteForm&actionSource=GlobalItem&popup=true','Quote','600','500','yes','yes');\">" +
              systemStatus.getLabel("quickactions.addQuote") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "tickets-tickets-add" + om)) {
          items.append("<img src=\"images/icons/stock_hyperlink-target-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('TroubleTickets.do?command=Add&actionSource=GlobalItem&popup=true','Lead','600','500','yes','yes');\">" +
              systemStatus.getLabel("quickactions.addTicket") +
              "</a> </br>");
        }

        if (systemStatus.hasPermission(userId, "pipeline-opportunities-add" + om)) {
          items.append("<img src=\"images/icons/stock_hyperlink-target-16.gif\" border=\"0\" align=\"absmiddle\" height=\"16\" width=\"16\"/> " +
              "<a href=\"javascript:popURL('Leads.do?command=Prepare&actionSource=GlobalItem&popup=true','Opportunity','600','500','yes','yes');\">" +
              systemStatus.getLabel("quickactions.addOpportunity") +
              "</a> </br>");
        }
        items.append(
            "</td>" +
                "</tr>" +
                "</form>" +
                "</table>");
      }
    }

    //My Items
    if (systemStatus.hasPermission(userId, "globalitems-myitems-view" + om)) {
      ConnectionPool sqlDriver = (ConnectionPool) servlet.getServletConfig().getServletContext().getAttribute(
          "ConnectionPool");
      Connection db = null;

      //Output
      items.append(
          "<!-- My Items -->" +
              "<table class=\"globalItem\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">" +
              "<tr><th>" + systemStatus.getLabel("myitems.header") + "</th></tr>" +
              "<tr>" +
              "<td nowrap>");

      try {
        int myItems = 0;
        db = sqlDriver.getConnection(ce);
        String sql = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        //External Contact Calls
        if (systemStatus.hasPermission(
            userId, "contacts-external_contacts-calls-view" + om)) {
          int callCount = 0;
          sql =
              "SELECT COUNT(*) as callcount " +
                  "FROM call_log " +
                  "WHERE alertdate >= ? " +
                  "AND alertdate < ? " +
                  "AND enteredby = ?";
          pst = db.prepareStatement(sql);
          pst.setTimestamp(1, new java.sql.Timestamp(today.getTimeInMillis()));
          pst.setTimestamp(
              2, new java.sql.Timestamp(tomorrow.getTimeInMillis()));
          pst.setInt(3, userId);
          rs = pst.executeQuery();
          if (rs.next()) {
            callCount = rs.getInt("callcount");
            if (System.getProperty("DEBUG") != null) {
              System.out.println("GlobalItemsHook-> Calls: " + callCount);
            }
          }
          rs.close();
          pst.close();
          if (callCount > 0) {
            items.append(
                "<a href='MyCFS.do?command=Home' class='s'>" + systemStatus.getLabel(
                    "myitems.pendingActivities") + "</a> (" + paint(callCount) + ")<br>");
            ++myItems;
          }
        }

        //Project Activities
        if (systemStatus.hasPermission(userId, "projects-view" + om)) {
          int activityCount = 0;
          sql =
              "SELECT count(*) as activitycount " +
                  "FROM project_assignments " +
                  "WHERE complete_date IS NULL " +
                  "AND user_assign_id = ?";
          pst = db.prepareStatement(sql);
          pst.setInt(1, userId);
          rs = pst.executeQuery();
          if (rs.next()) {
            activityCount = rs.getInt("activitycount");
            if (System.getProperty("DEBUG") != null) {
              System.out.println(
                  "GlobalItemsHook-> Activities: " + activityCount);
            }
          }
          rs.close();
          pst.close();
          if (activityCount > 0) {
            items.append(
                "<a href='ProjectManagement.do?command=Overview' class='s'>" + systemStatus.getLabel(
                    "myitems.assignedActivities") + "</a> (" + paint(
                    activityCount) + ")<br>");
            ++myItems;
          }
        }

        //Tickets Assigned to me
        if (systemStatus.hasPermission(userId, "tickets-view" + om)) {
          int ticketCount = 0;
          sql =
              "SELECT COUNT(*) as ticketcount FROM ticket WHERE assigned_to = ? AND closed IS NULL AND ticketid NOT IN (SELECT ticket_id FROM ticketlink_project) AND trashed_date IS NULL";
          pst = db.prepareStatement(sql);
          pst.setInt(1, userId);
          rs = pst.executeQuery();
          if (rs.next()) {
            ticketCount = rs.getInt("ticketcount");
            if (System.getProperty("DEBUG") != null) {
              System.out.println("GlobalItemsHook-> Tickets: " + ticketCount);
            }
          }
          rs.close();
          pst.close();
          if (ticketCount > 0) {
            items.append(
                "<a href='TroubleTickets.do?command=Home' class='s'>" + systemStatus.getLabel(
                    "myitems.assignedTickets") + "</a> (" + paint(ticketCount) + ")<br>");
            ++myItems;
          }
        }

        //Action Plans
        if (systemStatus.hasPermission(userId, "myhomepage-action-plans-view" + om)) {
          int i = 0;
          int planCount = 0;
          sql =
              "SELECT count(*) AS plancount " +
                  "FROM action_plan_work apw " +
                  "WHERE apw.enabled = ? " +
                  "AND apw.plan_work_id IN (SELECT aphw.plan_work_id FROM action_phase_work aphw " +
                  "WHERE aphw.phase_work_id IN (SELECT phase_work_id FROM action_item_work aiw " +
                  "WHERE aiw.start_date IS NOT NULL " +
                  "AND aiw.end_date IS NULL " +
                  "AND (aiw.owner = ? " +
                  "OR aiw.action_step_id IN (SELECT s.step_id FROM action_step s " +
                  "WHERE (s.permission_type = ? AND s.role_id IN (SELECT role_id FROM " + DatabaseUtils.addQuotes(db, "access") + " WHERE user_id = ? ))) " +
                  "OR aiw.action_step_id IN (SELECT s.step_id FROM action_step s " +
                  "WHERE s.permission_type = ? AND s.department_id IN (SELECT department FROM contact WHERE user_id = ? )) " +
                  "OR aiw.action_step_id IN (SELECT s.step_id FROM action_step s " +
                  "WHERE s.permission_type = ? AND s.group_id IN (SELECT group_id from user_group_map WHERE user_id = ? )) " +
                  ")) " +
                  "AND aphw.start_date IS NOT NULL AND aphw.end_date IS NULL AND aphw.status_id IS NULL ) ";

          pst = db.prepareStatement(sql);
          pst.setBoolean(++i, true);
          pst.setInt(++i, userId);
          pst.setInt(++i, ActionStep.ROLE);
          pst.setInt(++i, userId);
          pst.setInt(++i, ActionStep.DEPARTMENT);
          pst.setInt(++i, userId);
          pst.setInt(++i, ActionStep.SPECIFIC_USER_GROUP);
          pst.setInt(++i, userId);
          rs = pst.executeQuery();
          if (rs.next()) {
            planCount = rs.getInt("plancount");
            if (System.getProperty("DEBUG") != null) {
              System.out.println(
                  "GlobalItemsHook-> Action Plans: " + planCount);
            }
          }
          rs.close();
          pst.close();
          if (planCount > 0) {
            items.append(
                "<a href='MyActionPlans.do?command=View' class='s'>" + systemStatus.getLabel(
                    "actionPlan.myWaitingActionPlans") + "</a> (" + paint(
                    planCount) + ")<br>");
            ++myItems;
          }
        }

        //Project Tickets Assigned to me
        if (systemStatus.hasPermission(userId, "tickets-view" + om)) {
          int ticketCount = 0;
          sql =
              "SELECT COUNT(*) as ticketcount FROM ticket WHERE assigned_to = ? AND closed IS NULL AND ticketid IN (SELECT ticket_id FROM ticketlink_project) ";
          pst = db.prepareStatement(sql);
          pst.setInt(1, userId);
          rs = pst.executeQuery();
          if (rs.next()) {
            ticketCount = rs.getInt("ticketcount");
            if (System.getProperty("DEBUG") != null) {
              System.out.println("GlobalItemsHook-> Tickets: " + ticketCount);
            }
          }
          rs.close();
          pst.close();
          if (ticketCount > 0) {
            items.append(
                "<a href='ProjectManagement.do?' class='s'>" + systemStatus.getLabel(
                    "myitems.assignedProjectTickets") + "</a> (" + paint(
                    ticketCount) + ")<br>");
            ++myItems;
          }
        }

        //Tickets Unassigned
        if (systemStatus.hasPermission(userId, "tickets-view" + om)) {
          int ticketCount = 0;
          sql =
              "SELECT COUNT(*) as ticketcount " +
                  "FROM ticket " +
                  "WHERE (assigned_to = -1 OR assigned_to IS NULL) " +
                  "AND closed IS NULL " +
                  "AND (department_code = ? OR department_code in (0, -1)) " +
                  "AND ticketid NOT IN (SELECT ticket_id FROM ticketlink_project) ";
          pst = db.prepareStatement(sql);
          pst.setInt(1, departmentId);
          rs = pst.executeQuery();
          if (rs.next()) {
            ticketCount = rs.getInt("ticketcount");
            if (System.getProperty("DEBUG") != null) {
              System.out.println(
                  "GlobalItemsHook-> Tickets (Unassigned): " + ticketCount);
            }
          }
          rs.close();
          pst.close();
          if (ticketCount > 0) {
            items.append(
                "<a href='TroubleTickets.do?command=Home' class='s'>" + systemStatus.getLabel(
                    "myitems.unassignedTickets") + "</a> (" + paint(
                    ticketCount) + ")<br>");
            ++myItems;
          }
        }

        //CFS Inbox Items
        if (systemStatus.hasPermission(userId, "myhomepage-inbox-view" + om)) {
          int inboxCount = 0;
          sql =
              "SELECT COUNT(*) as inboxcount " +
                  "FROM cfsinbox_message m, cfsinbox_messagelink ml " +
                  "WHERE m.id = ml.id AND ml.sent_to = ? AND m.delete_flag = ? AND ml.status IN (0) ";
          pst = db.prepareStatement(sql);
          pst.setInt(1, contactId);
          pst.setBoolean(2, false);
          rs = pst.executeQuery();
          if (rs.next()) {
            inboxCount = rs.getInt("inboxcount");
          }
          rs.close();
          pst.close();
          if (inboxCount > 0) {
            items.append(
                "<a href='MyCFSInbox.do?command=Inbox&return=1' class='s'>" + systemStatus.getLabel(
                    "myitems.inbox") + "</a> (" + paint(inboxCount) + " " + systemStatus.getLabel(
                    "myitems.inbox.new") + ")<br>");
            ++myItems;
          }
        }

        //Tasks Items
        if (systemStatus.hasPermission(userId, "myhomepage-tasks-view" + om)) {
          int taskCount = TaskList.queryPendingCount(db, userId);
          if (taskCount > 0) {
            items.append(
                "<a href='MyTasks.do?command=ListTasks' class='s'>" + systemStatus.getLabel(
                    "myitems.tasks") + "</a> (" + paint(taskCount) + " " + systemStatus.getLabel(
                    "myitems.tasks.incomplete") + ")<br>");
            ++myItems;
          }
        }

        //Default no items
        if (myItems == 0) {
          items.append(
              systemStatus.getLabel("myitems.noItems") + "<br />&nbsp;<br />");
        }
      } catch (Exception e) {
        System.out.println("GlobalItemsHook Error-> " + e.toString());
        e.printStackTrace(System.out);
      }
      sqlDriver.free(db);

      items.append(
          "</td>" +
              "</tr>" +
              "</table>");
    }

    //Recent Items
    if (systemStatus.hasPermission(userId, "globalitems-recentitems-view" + om)) {
      items.append(
          "<!-- Recent Items -->" +
              "<table class=\"globalItem\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">" +
              "<tr><th>" + systemStatus.getLabel("myitems.recentItems") + "</th></tr>" +
              "<tr>" +
              "<td>");

      ArrayList recentItems = (ArrayList) request.getSession().getAttribute(
          "RecentItems");
      if (recentItems != null) {
        Iterator i = recentItems.iterator();
        while (i.hasNext()) {
          RecentItem thisItem = (RecentItem) i.next();
          items.append(thisItem.getHtml());
          if (i.hasNext()) {
            items.append("<br>");
            //items.append("<hr color=\"#BFBFBB\" noshade>");
          }
        }
      } else {
        items.append(
            systemStatus.getLabel("myitems.noRecentItems") + "<br>&nbsp;<br>");
      }

      items.append(
          "</td>" +
              "</tr>" +
              "</table>");
    }

    if (items.length() > 0) {
      //If they have any modules, then create a cell to hold them...
      return (items.toString());
    } else {
      //No global items
      return "";
    }
  }


  /**
   * Description of the Method
   *
   * @param count Description of the Parameter
   * @return Description of the Return Value
   */
  private static String paint(int count) {
    if (count > 0) {
      return "<font color=\"red\">" + count + "</font>";
    } else {
      return "" + count;
    }
  }

}


