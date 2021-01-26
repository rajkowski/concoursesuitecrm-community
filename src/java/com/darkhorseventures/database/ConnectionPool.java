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
package com.darkhorseventures.database;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.log4j.Logger;

import java.sql.*;
import java.util.*;

/**
 * A class for recycling, and managing JDBC connections. <P>
 * <p/>
 * Taken from Core Servlets and JavaServer Pages http://www.coreservlets.com/.
 * &copy; 2000 Marty Hall; may be freely used or adapted. <P>
 * <p/>
 * The ConnectionPool class requires a ConnectionElement to be supplied for
 * each request to getConnection(connectionElement). This allows the
 * ConnectionPool to work in an ASP setting in which multiple databases are
 * cached by the pool.<P>
 * <p/>
 * Busy connections are stored with a connection key and a connection element
 * value.<br>
 * .free(connection) removes the connection from busy and then puts it on the
 * available list with a new connection element. <P>
 * <p/>
 * Available connections are stored with a connection element and connection
 * value.<br>
 * .getConnection(connectionElement) returns the connection, removes it from
 * the available connections, and then puts it on the busy list with a new
 * connection element.
 *
 * @author Matt Rajkowski
 * @version $Id: ConnectionPool.java,v 1.11 2003/01/13 14:42:24 mrajkowski Exp
 * $
 * @created December 12, 2000
 */
public class ConnectionPool {

  private final static Logger log = Logger.getLogger(com.darkhorseventures.database.ConnectionPool.class);

  private HikariDataSource ds = null;

  //Thread properties for creating a new connection
  private String url = null;
  private String username = null;
  private String password = null;
  private String driver = null;
  //Connection Pool Properties
  private java.util.Date startDate = new java.util.Date();
  private Hashtable availableConnections;
  private Hashtable busyConnections;
  //Connection Pool Settings
  private boolean debug = false;
  private int maxConnections = 10;
  private boolean waitIfBusy = true;
  private boolean allowShrinking = false;
  private boolean testConnections = false;
  private boolean forceClose = false;
  private int maxIdleTime = 60000;
  private int maxDeadTime = 300000;
  private Timer cleanupTimer = null;


  /**
   * Constructor for the ConnectionPool object. <p>
   * <p/>
   * Instantiates the pool and background timer with default settings.
   *
   * @throws SQLException Description of Exception
   * @since 1.2
   */
  public ConnectionPool() throws SQLException {
    availableConnections = new Hashtable();
    busyConnections = new Hashtable();
  }


  /**
   * Sets whether connection pool statistics and connection information are
   * output
   *
   * @param tmp The new debug value
   */
  public void setDebug(boolean tmp) {
    this.debug = tmp;
  }


  /**
   * Sets the debug attribute of the ConnectionPool object
   *
   * @param tmp The new debug value
   */
  public void setDebug(String tmp) {
    this.debug = "true".equals(tmp);
  }


  /**
   * Sets the behavior of connection requests. If all connections are busy,
   * then the thread requesting the connection will either wait or throw an
   * exception if waitIfBusy is false
   *
   * @param tmp The new waitIfBusy value
   */
  public void setWaitIfBusy(boolean tmp) {
    this.waitIfBusy = tmp;
  }


  /**
   * Sets whether a background process is allowed to close unused connections
   * after the maxIdleTime has been reached
   *
   * @param tmp The new allowShrinking value
   */
  public void setAllowShrinking(boolean tmp) {
    this.allowShrinking = tmp;
  }


  /**
   * Sets the allowShrinking attribute of the ConnectionPool object
   *
   * @param tmp The new allowShrinking value
   */
  public void setAllowShrinking(String tmp) {
    this.allowShrinking = "true".equals(tmp);
  }


  /**
   * Sets whether connections will be tested, by executing a simple query,
   * before being handed out. If the test fails, then a new connection is
   * attempted without throwing an exception.
   *
   * @param tmp The new testConnections value
   */
  public void setTestConnections(boolean tmp) {
    this.testConnections = tmp;
  }


  /**
   * Sets the testConnections attribute of the ConnectionPool object
   *
   * @param tmp The new testConnections value
   */
  public void setTestConnections(String tmp) {
    this.testConnections = "true".equals(tmp);
  }


  /**
   * Sets whether connections are immediately closed, instead of pooled for
   * later use
   *
   * @param tmp The new ForceClose value
   * @since 1.1
   */
  public void setForceClose(boolean tmp) {
    this.forceClose = tmp;
  }


  /**
   * Sets the maximum number of connections that can be open at once, if the
   * max is reached, then behavior is determined by the waitIfBusy property
   *
   * @param tmp The new maxConnections value
   */
  public void setMaxConnections(int tmp) {
    this.maxConnections = tmp;
  }


  /**
   * Sets the maxConnections attribute of the ConnectionPool object
   *
   * @param tmp The new maxConnections value
   */
  public void setMaxConnections(String tmp) {
    this.maxConnections = Integer.parseInt(tmp);
  }


  /**
   * Sets the maximum number of milliseconds a connection can remain idle for
   * until shrinking occurs.
   *
   * @param tmp The new maxIdleTime value
   */
  public void setMaxIdleTime(int tmp) {
    this.maxIdleTime = tmp;
  }


  /**
   * Sets the maxIdleTime attribute of the ConnectionPool object
   *
   * @param tmp The new maxIdleTime value
   */
  public void setMaxIdleTime(String tmp) {
    this.maxIdleTime = Integer.parseInt(tmp);
  }


  /**
   * Sets the maxIdleTimeSeconds attribute of the ConnectionPool object
   *
   * @param tmp The new maxIdleTimeSeconds value
   */
  public void setMaxIdleTimeSeconds(String tmp) {
    this.maxIdleTime = 1000 * Integer.parseInt(tmp);
  }


  /**
   * Sets the maxIdleTimeSeconds attribute of the ConnectionPool object
   *
   * @param tmp The new maxIdleTimeSeconds value
   */
  public void setMaxIdleTimeSeconds(int tmp) {
    this.maxIdleTime = 1000 * tmp;
  }


  /**
   * Sets the maximum number of milliseconds a connection can checked out and
   * remain busy for. If the connection is not returned, or not renewed, then
   * it will be closed. The connection might be in use, or some process may
   * have forget to return it. This prevents an application from completely
   * being unusable if the connection is not returned.
   *
   * @param tmp The new maxDeadTime value
   */
  public void setMaxDeadTime(int tmp) {
    this.maxDeadTime = tmp;
  }


  /**
   * Sets the maxDeadTime attribute of the ConnectionPool object
   *
   * @param tmp The new maxDeadTime value
   */
  public void setMaxDeadTime(String tmp) {
    this.maxDeadTime = Integer.parseInt(tmp);
  }


  /**
   * Sets the maxDeadTimeSeconds attribute of the ConnectionPool object
   *
   * @param tmp The new maxDeadTimeSeconds value
   */
  public void setMaxDeadTimeSeconds(String tmp) {
    this.maxDeadTime = 1000 * Integer.parseInt(tmp);
  }


  /**
   * Sets the maxDeadTimeSeconds attribute of the ConnectionPool object
   *
   * @param tmp The new maxDeadTimeSeconds value
   */
  public void setMaxDeadTimeSeconds(int tmp) {
    this.maxDeadTime = 1000 * tmp;
  }

  public boolean getDebug() {
    return debug;
  }

  public boolean getAllowShrinking() {
    return allowShrinking;
  }

  public boolean getTestConnections() {
    return testConnections;
  }

  /**
   * Gets the username attribute of the ConnectionPool object
   *
   * @return The username value
   */
  public String getUsername() {
    return username;
  }


  /**
   * Gets the password attribute of the ConnectionPool object
   *
   * @return The password value
   */
  public String getPassword() {
    return password;
  }


  /**
   * Gets the driver attribute of the ConnectionPool object
   *
   * @return The driver value
   */
  public String getDriver() {
    return driver;
  }


  /**
   * Gets the maxConnections attribute of the ConnectionPool object
   *
   * @return The maxConnections value
   */
  public int getMaxConnections() {
    return maxConnections;
  }


  /**
   * Gets the maxIdleTime attribute of the ConnectionPool object
   *
   * @return The maxIdleTime value
   */
  public int getMaxIdleTime() {
    return maxIdleTime;
  }


  /**
   * Gets the maxDeadTime attribute of the ConnectionPool object
   *
   * @return The maxDeadTime value
   */
  public int getMaxDeadTime() {
    return maxDeadTime;
  }


  /**
   * When a connection is needed, ask the class for the next available, if the
   * max connections has been reached then a thread will be spawned to wait for
   * the next available connection.
   *
   * @param requestElement Description of the Parameter
   * @return The connection value
   * @throws SQLException Description of the Exception
   */
  public Connection getConnection(ConnectionElement requestElement) throws SQLException {

    synchronized (this) {
      if (ds == null) {
        // Determine the database connection
        Properties databaseProperties = new Properties();
        databaseProperties.setProperty("dataSourceClassName", "org.postgresql.ds.PGSimpleDataSource");
        databaseProperties.setProperty("dataSource.user", requestElement.getUsername());
        databaseProperties.setProperty("dataSource.password", requestElement.getPassword());
        databaseProperties.setProperty("dataSource.databaseName", requestElement.getDbName());
        databaseProperties.setProperty("dataSource.portNumber", "5432");
        databaseProperties.setProperty("dataSource.serverName", "localhost");
        // Create the pool
        HikariConfig config = new HikariConfig(databaseProperties);
        config.setMaxLifetime(600000);
        ds = new HikariDataSource(config);
      }
    }
    return ds.getConnection();
  }

  /**
   * Displays the date/time when the ConnectionPool was created
   *
   * @return The StartDate value
   * @since 1.2
   */
  public String getStartDate() {
    return (startDate.toString());
  }

  /**
   * When finished with the connection, don't close it, free the connection and
   * it will be reused by another request. If it's closed then remove the
   * reference to it and another will just have to be opened.
   *
   * @param connection Description of Parameter
   * @since 1.0
   */
  public void free(Connection connection) {
    if (connection != null) {
      try {
        if (!connection.isClosed()) {
          connection.close();
        }
      } catch (SQLException e) {
        log.error("SQL connection close error", e);
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param connection Description of the Parameter
   */
  public void renew(Connection connection) {

  }

  /**
   * Close all the connections. Use with caution: be sure no connections are in
   * use before calling. Note that you are not <I>required</I> to call this
   * when done with a ConnectionPool, since connections are guaranteed to be
   * closed when garbage collected. But this method gives more control
   * regarding when the connections are closed.
   *
   * @since 1.1
   */
  public synchronized void closeAllConnections() {
    log.debug("Status: " + this.toString());
    log.debug("Closing available connections");
//    closeConnections(AVAILABLE_CONNECTION, availableConnections);
//    availableConnections.clear();
    log.debug("Closing busy connections");
//    closeConnections(BUSY_CONNECTION, busyConnections);
//    busyConnections.clear();
  }

  /**
   * More debugging information... displays the current state of the
   * ConnectionPool
   *
   * @return Description of the Returned Value
   * @since 1.1
   */
  public String toString() {
    String info =
        "(avail=" + availableConnections.size() +
            ", busy=" + busyConnections.size() +
            ", max=" + maxConnections + ")";
    return (info);
  }


  /**
   * Cleans up the connection pool when destroyed, it's important to remove any
   * open timers -- this does not appear to be automatically called so the
   * application should call this to make sure the timer is stopped.
   *
   * @since 1.1
   */
  public void destroy() {
    if (ds != null) {
      ds.close();
    }
    log.debug("Stopped");
  }

}

