//Copyright 2003 Dark Horse Ventures
package org.aspcfs.apps.workFlowManager;

import java.util.*;
import org.w3c.dom.Element;
import org.aspcfs.utils.*;
import org.aspcfs.modules.base.Constants;
import java.io.*;
import java.sql.*;

/**
 *  Contains a list of Parameter objects and can be used for initially building
 *  the list.
 *
 *@author     matt rajkowski
 *@created    June 6, 2003
 *@version    $Id$
 */
public class ProcessParameterList extends ArrayList {
  private int processId = -1;
  private int enabled = Constants.UNDEFINED;


  /**
   *  Constructor for the ProcessParameterList object
   */
  public ProcessParameterList() { }


  /**
   *  Sets the componentId attribute of the ComponentParameterList object
   *
   *@param  tmp  The new componentId value
   */
  public void setProcessId(int tmp) {
    this.processId = tmp;
  }


  /**
   *  Sets the enabled attribute of the ComponentParameterList object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(int tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the ComponentParameterList object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = Integer.parseInt(tmp);
  }


  /**
   *  Gets the componentId attribute of the ComponentParameterList object
   *
   *@return    The componentId value
   */
  public int getProcessId() {
    return processId;
  }


  /**
   *  Gets the enabled attribute of the ComponentParameterList object
   *
   *@return    The enabled value
   */
  public int getEnabled() {
    return enabled;
  }


  /**
   *  Builds a list of parameters from a database using selected filters
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();
    sqlSelect.append(
        "SELECT id, process_id, param_name, param_value, " +
        "enabled " +
        "FROM business_process_parameter " +
        "WHERE id > 0 ");
    createFilter(sqlFilter);
    sqlOrder.append("ORDER BY param_name ");
    PreparedStatement pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    prepareFilter(pst);
    ResultSet rs = pst.executeQuery();
    while (rs.next()) {
      ProcessParameter thisParameter = new ProcessParameter(rs);
      this.add(thisParameter);
    }
    rs.close();
    pst.close();
  }


  /**
   *  Adds filters to the WHERE clause of the database query
   *
   *@param  sqlFilter  Description of the Parameter
   */
  private void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }
    if (processId > -1) {
      sqlFilter.append("AND process_id = ? ");
    }
    if (enabled != Constants.UNDEFINED) {
      sqlFilter.append("AND enabled = ? ");
    }
  }


  /**
   *  Adds database parameters based on selected filters
   *
   *@param  pst               Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  private int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (processId > -1) {
      pst.setInt(++i, processId);
    }
    if (enabled != Constants.UNDEFINED) {
      pst.setBoolean(++i, enabled == Constants.TRUE);
    }
    return i;
  }


  /**
   *  Inserts the list of parameters into a database
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void insert(Connection db) throws SQLException {
    boolean autoCommit = db.getAutoCommit();
    try {
      if (autoCommit) {
        db.setAutoCommit(false);
      }
      //Insert the parameters
      Iterator parameters = this.iterator();
      while (parameters.hasNext()) {
        ProcessParameter parameter = (ProcessParameter) parameters.next();
        parameter.setProcessId(processId);
        parameter.insert(db);
      }
      if (autoCommit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (autoCommit) {
        db.rollback();
      }
    } finally {
      if (autoCommit) {
        db.setAutoCommit(true);
      }
    }
  }
}
