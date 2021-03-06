package org.aspcfs.modules.accounts.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.contacts.base.ContactPhoneNumber;
import org.aspcfs.modules.contacts.base.ContactPhoneNumberList;
import org.aspcfs.utils.web.LookupList;

import java.sql.Connection;
import java.util.Iterator;

/**
 * Description of the Class
 *
 * @author partha
 * @version $Id$
 * @created November 4, 2004
 */
public final class ContactPhoneNumberSelector extends CFSModule {

  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandList(ActionContext context) {
    Connection db = null;
    ContactPhoneNumberList phoneNumberList = null;
    User user = this.getUser(context, getUserId(context));
    Contact contact = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenField = (String) context.getRequest().getParameter(
        "hiddenField");
    try {
      db = this.getConnection(context);
      if (hiddenField != null && !"".equals(hiddenField)) {
        context.getRequest().setAttribute("hiddenField", hiddenField);
      }
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      if (contact != null && contact.getPhoneNumberList() != null) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute(
            "contactPhoneNumberList", contact.getPhoneNumberList());
      } else {
        user.setBuildContact(true);
        user.setBuildContactDetails(true);
        user.buildRecord(db, user.getId());
        context.getRequest().setAttribute(
            "contactPhoneNumberList", user.getContact().getPhoneNumberList());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("ListOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDelete(ActionContext context) {
    Connection db = null;
    ContactPhoneNumberList phoneNumberList = null;
    User user = this.getUser(context, getUserId(context));
    String addressId = (String) context.getRequest().getParameter("addressId");
    Iterator iterator = null;
    Contact contact = null;
    ContactPhoneNumber deleteItem = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenField = (String) context.getRequest().getParameter(
        "hiddenField");
    try {
      db = this.getConnection(context);
      if (hiddenField != null && !"".equals(hiddenField)) {
        context.getRequest().setAttribute("hiddenField", hiddenField);
      }
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      user.setBuildContact(true);
      user.setBuildContactDetails(true);
      user.buildRecord(db, user.getId());
      if (contact != null) {
        iterator = (Iterator) contact.getPhoneNumberList().iterator();
      } else {
        iterator = (Iterator) user.getContact().getPhoneNumberList().iterator();
      }
      while (iterator.hasNext()) {
        ContactPhoneNumber phoneNumber = (ContactPhoneNumber) iterator.next();
        if (phoneNumber.getId() == Integer.parseInt(addressId)) {
          deleteItem = phoneNumber;
          break;
        }
      }
      if (deleteItem != null) {
        deleteItem.delete(db);
      }
      if (contact != null && contact.getPhoneNumberList() != null) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute(
            "contactPhoneNumberList", contact.getPhoneNumberList());
      } else {
        user.buildRecord(db, user.getId());
        context.getRequest().setAttribute(
            "contactPhoneNumberList", user.getContact().getPhoneNumberList());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("ListOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandPhoneNumberForm(ActionContext context) {
    Connection db = null;
    Contact contact = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenField = (String) context.getRequest().getParameter(
        "hiddenField");
    try {
      db = this.getConnection(context);
      if (hiddenField != null && !"".equals(hiddenField)) {
        context.getRequest().setAttribute("hiddenField", hiddenField);
      }
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      SystemStatus systemStatus = this.getSystemStatus(context);
      LookupList typeSelect = systemStatus.getLookupList(
          db, "lookup_contactphone_types");
      context.getRequest().setAttribute("typeSelect", typeSelect);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("PhoneNumberFormOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandAdd(ActionContext context) {
    Connection db = null;
    User user = this.getUser(context, getUserId(context));
    user.setBuildContact(true);
    user.setBuildContactDetails(true);
    ContactPhoneNumber deleteItem = null;
    Contact contact = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenField = (String) context.getRequest().getParameter(
        "hiddenField");
    try {
      db = this.getConnection(context);
      if (hiddenField != null && !"".equals(hiddenField)) {
        context.getRequest().setAttribute("hiddenField", hiddenField);
      }
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      user.buildRecord(db, user.getId());
      ContactPhoneNumber phoneNumber = new ContactPhoneNumber();
      phoneNumber.buildRecord(context, 1);
      if (contact != null && contact.getPhoneNumberList() != null) {
        phoneNumber.process(db, contact.getId(), user.getId(), user.getId());
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute(
            "contactPhoneNumberList", contact.getPhoneNumberList());
      } else {
        phoneNumber.process(
            db, user.getContact().getId(), user.getId(), user.getId());
        user.buildRecord(db, user.getId());
        context.getRequest().setAttribute(
            "contactPhoneNumberList", user.getContact().getPhoneNumberList());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("ListOK");
  }
}

