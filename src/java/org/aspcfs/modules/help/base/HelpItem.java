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
package org.aspcfs.modules.help.base;

import com.darkhorseventures.framework.beans.GenericBean;
import org.aspcfs.utils.DatabaseUtils;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Represents help for a page
 *
 * @author matt rajkowski
 * @version $Id$
 * @created January 21, 2002
 */
public class HelpItem extends GenericBean {

  public final static String fs = System.getProperty("file.separator");
  //help item properties
  private int id = -1;
  private int categoryId = -1;
  private int moduleId = -1;
  private String module = null;
  private String section = null;
  private String subsection = null;
  private String description = null;
  private String title = null;
  private String permission = null;
  private int nextContent = -1;
  private int prevContent = -1;
  private int upContent = -1;
  private int enteredBy = -1;
  private java.sql.Timestamp entered = null;
  private int modifiedBy = -1;
  private java.sql.Timestamp modified = null;

  //delay loading properties
  private boolean buildFeatures = false;
  private boolean buildRules = false;
  private boolean buildNotes = false;
  private boolean buildTips = false;
  //details
  private HelpFeatureList features = new HelpFeatureList();
  private HelpNoteList notes = new HelpNoteList();
  private HelpTipList tips = new HelpTipList();
  private HelpBusinessRuleList businessRules = new HelpBusinessRuleList();


  /**
   * Constructor for the HelpItem object
   */
  public HelpItem() {
  }


  /**
   * Constructor for the HelpItem object
   *
   * @param rs Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public HelpItem(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   * Constructor for the HelpItem object
   *
   * @param db         Description of the Parameter
   * @param module     Description of the Parameter
   * @param section    Description of the Parameter
   * @param subsection Description of the Parameter
   * @param userId     Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public HelpItem(Connection db, String module, String section, String subsection, int userId) throws SQLException {
    if ("null".equals(module)) {
      module = null;
    }
    if ("null".equals(section)) {
      section = null;
    }
    if ("null".equals(subsection)) {
      subsection = null;
    }
    processRecord(db, userId);
  }


  /**
   * Constructor for the HelpItem object
   *
   * @param db Description of the Parameter
   * @param id Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public HelpItem(Connection db, int id) throws SQLException {
    this.id = id;
    queryRecord(db);
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void queryRecord(Connection db) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    String sql =
        "SELECT * " +
        "FROM help_contents h " +
        "WHERE help_id = ? ";
    pst = db.prepareStatement(sql);
    if (System.getProperty("DEBUG") != null) {
      System.out.println("HelpItem-> Prepared");
    }
    int i = 0;
    pst.setInt(++i, id);
    rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();

    buildFeatures(db);
    buildRules(db);
    buildNotes(db);
    buildTips(db);
  }


  /**
   * Description of the Method
   *
   * @param db     Description of the Parameter
   * @param userId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public synchronized void processRecord(Connection db, int userId) throws SQLException {
    boolean newItem = true;
    PreparedStatement pst = db.prepareStatement(
        "SELECT * " +
        "FROM help_contents h " +
        "WHERE " + DatabaseUtils.addQuotes(db, "module") + " = ? " +
        (section != null ? "AND " + DatabaseUtils.addQuotes(db, "section") + " = ? " : "AND " + DatabaseUtils.addQuotes(db, "section") + " IS NULL ") +
        (subsection != null ? "AND subsection = ? " : "AND subsection IS NULL "));
    if (System.getProperty("DEBUG") != null) {
      System.out.println("HelpItem-> Prepared");
    }
    int i = 0;
    pst.setString(++i, module);
    if (section != null) {
      pst.setString(++i, section);
    }
    if (subsection != null) {
      pst.setString(++i, subsection);
    }
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
      newItem = false;
    }
    rs.close();
    pst.close();
    //check for a new entry
    if (newItem) {
      this.setEnteredBy(userId);
      this.setModifiedBy(userId);
      this.insert(db);
      if (System.getProperty("DEBUG") != null) {
        System.out.println(
            "HelpItem-> Record not present.. Inserting new record ");
      }
    } else {
      //build general features
      if (buildFeatures) {
        buildFeatures(db);
      }
      //build business rules
      if (buildRules) {
        buildRules(db);
      }
      //build notes
      if (buildNotes) {
        buildNotes(db);
      }
      //build tips
      if (buildTips) {
        buildTips(db);
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void fetchRecord(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT * " +
        "FROM help_contents h " +
        "WHERE " + DatabaseUtils.addQuotes(db, "module") + " = ? " +
        (section != null ? "AND " + DatabaseUtils.addQuotes(db, "section") + " = ? " : "AND " + DatabaseUtils.addQuotes(db, "section") + " IS NULL ") +
        (subsection != null ? "AND subsection = ? " : "AND subsection IS NULL "));
    int i = 0;
    pst.setString(++i, module);
    if (section != null) {
      pst.setString(++i, section);
    }
    if (subsection != null) {
      pst.setString(++i, subsection);
    }
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
  }


  /**
   * Sets the id attribute of the HelpItem object
   *
   * @param tmp The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   * Sets the id attribute of the HelpItem object
   *
   * @param tmp The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   * Sets the categoryId attribute of the HelpItem object
   *
   * @param tmp The new categoryId value
   */
  public void setCategoryId(int tmp) {
    this.categoryId = tmp;
  }


  /**
   * Sets the categoryId attribute of the HelpItem object
   *
   * @param tmp The new categoryId value
   */
  public void setCategoryId(String tmp) {
    this.categoryId = Integer.parseInt(tmp);
  }


  /**
   * Sets the id attribute of the HelpItem object
   *
   * @param tmp The new module id value
   */
  public void setModuleId(int tmp) {
    this.moduleId = tmp;
  }


  /**
   * Sets the id attribute of the HelpItem object
   *
   * @param tmp The new module id value
   */
  public void setModuleId(String tmp) {
    this.moduleId = Integer.parseInt(tmp);
  }


  /**
   * Sets the module attribute of the HelpItem object
   *
   * @param tmp The new module value
   */
  public void setModule(String tmp) {
    this.module = tmp;
  }


  /**
   * Sets the title attribute of the HelpItem object
   *
   * @param tmp The new title value
   */
  public void setTitle(String tmp) {
    this.title = tmp;
  }


  /**
   * Sets the section attribute of the HelpItem object
   *
   * @param tmp The new section value
   */
  public void setSection(String tmp) {
    this.section = tmp;
  }


  /**
   * Sets the subsection attribute of the HelpItem object
   *
   * @param tmp The new subsection value
   */
  public void setSubsection(String tmp) {
    this.subsection = tmp;
  }


  /**
   * Sets the description attribute of the HelpItem object
   *
   * @param tmp The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   * Sets the permission attribute of the HelpItem object
   *
   * @param tmp The new permission value
   */
  public void setPermission(String tmp) {
    this.permission = tmp;
  }


  /**
   * Sets the enteredBy attribute of the HelpItem object
   *
   * @param tmp The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   * Sets the entered attribute of the HelpItem object
   *
   * @param tmp The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   * Sets the modifiedBy attribute of the HelpItem object
   *
   * @param tmp The new modifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   * Sets the modified attribute of the HelpItem object
   *
   * @param tmp The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   * Sets the features attribute of the HelpItem object
   *
   * @param features The new features value
   */
  public void setFeatures(HelpFeatureList features) {
    this.features = features;
  }


  /**
   * Sets the buildFeatures attribute of the HelpItem object
   *
   * @param buildFeatures The new buildFeatures value
   */
  public void setBuildFeatures(boolean buildFeatures) {
    this.buildFeatures = buildFeatures;
  }


  /**
   * Sets the businessRules attribute of the HelpItem object
   *
   * @param businessRules The new businessRules value
   */
  public void setBusinessRules(HelpBusinessRuleList businessRules) {
    this.businessRules = businessRules;
  }


  /**
   * Sets the buildRules attribute of the HelpItem object
   *
   * @param buildRules The new buildRules value
   */
  public void setBuildRules(boolean buildRules) {
    this.buildRules = buildRules;
  }


  /**
   * Sets the buildNotes attribute of the HelpItem object
   *
   * @param buildNotes The new buildNotes value
   */
  public void setBuildNotes(boolean buildNotes) {
    this.buildNotes = buildNotes;
  }


  /**
   * Sets the buildTips attribute of the HelpItem object
   *
   * @param buildTips The new buildTips value
   */
  public void setBuildTips(boolean buildTips) {
    this.buildTips = buildTips;
  }


  /**
   * Sets the notes attribute of the HelpItem object
   *
   * @param notes The new notes value
   */
  public void setNotes(HelpNoteList notes) {
    this.notes = notes;
  }


  /**
   * Sets the tips attribute of the HelpItem object
   *
   * @param tips The new tips value
   */
  public void setTips(HelpTipList tips) {
    this.tips = tips;
  }


  /**
   * Gets the notes attribute of the HelpItem object
   *
   * @return The notes value
   */
  public HelpNoteList getNotes() {
    return notes;
  }


  /**
   * Gets the tips attribute of the HelpItem object
   *
   * @return The tips value
   */
  public HelpTipList getTips() {
    return tips;
  }


  /**
   * Gets the buildRules attribute of the HelpItem object
   *
   * @return The buildRules value
   */
  public boolean getBuildRules() {
    return buildRules;
  }


  /**
   * Gets the buildNotes attribute of the HelpItem object
   *
   * @return The buildNotes value
   */
  public boolean getBuildNotes() {
    return buildNotes;
  }


  /**
   * Gets the buildTips attribute of the HelpItem object
   *
   * @return The buildTips value
   */
  public boolean getBuildTips() {
    return buildTips;
  }


  /**
   * Gets the businessRules attribute of the HelpItem object
   *
   * @return The businessRules value
   */
  public HelpBusinessRuleList getBusinessRules() {
    return businessRules;
  }


  /**
   * Gets the buildFeatures attribute of the HelpItem object
   *
   * @return The buildFeatures value
   */
  public boolean getBuildFeatures() {
    return buildFeatures;
  }


  /**
   * Gets the features attribute of the HelpItem object
   *
   * @return The features value
   */
  public HelpFeatureList getFeatures() {
    return features;
  }


  /**
   * Gets the id attribute of the HelpItem object
   *
   * @return The id value
   */
  public int getId() {
    return id;
  }


  /**
   * Gets the categoryId attribute of the HelpItem object
   *
   * @return The categoryId value
   */
  public int getCategoryId() {
    return categoryId;
  }


  /**
   * Gets the id attribute of the HelpItem object
   *
   * @return The id value
   */
  public int getModuleId() {
    return moduleId;
  }


  /**
   * Gets the module attribute of the HelpItem object
   *
   * @return The module value
   */
  public String getModule() {
    return module;
  }


  /**
   * Gets the module attribute of the HelpItem object
   *
   * @return The page title
   */
  public String getTitle() {
    return title;
  }


  /**
   * Gets the section attribute of the HelpItem object
   *
   * @return The section value
   */
  public String getSection() {
    return section;
  }


  /**
   * Gets the subsection attribute of the HelpItem object
   *
   * @return The subsection value
   */
  public String getSubsection() {
    return subsection;
  }


  /**
   * Gets the description attribute of the HelpItem object
   *
   * @return The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   * Gets the permission attribute of the HelpItem object
   *
   * @return The permission value
   */
  public String getPermission() {
    return permission;
  }


  /**
   * Gets the enteredBy attribute of the HelpItem object
   *
   * @return The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   * Gets the entered attribute of the HelpItem object
   *
   * @return The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   * Gets the modifiedBy attribute of the HelpItem object
   *
   * @return The modifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   * Gets the modified attribute of the HelpItem object
   *
   * @return The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   * Description of the Method
   *
   * @param rs Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("help_id");
    categoryId = rs.getInt("category_id");
    moduleId = rs.getInt("link_module_id");
    module = rs.getString("module");
    section = rs.getString("section");
    subsection = rs.getString("subsection");
    title = rs.getString("title");
    description = rs.getString("description");
    nextContent = rs.getInt("nextcontent");
    prevContent = rs.getInt("prevcontent");
    upContent = rs.getInt("upcontent");
    enteredBy = rs.getInt("enteredby");
    entered = rs.getTimestamp("entered");
    modifiedBy = rs.getInt("modifiedby");
    modified = rs.getTimestamp("modified");
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    id = DatabaseUtils.getNextSeq(db, "help_contents_help_id_seq");
    PreparedStatement pst = db.prepareStatement(
        "INSERT INTO help_contents " +
        "(" + (id > -1 ? "help_id, " : "") + "" + DatabaseUtils.addQuotes(db, "module") +
        ", " + DatabaseUtils.addQuotes(db, "section") +
        ", subsection, title, description, enteredby, modifiedby) " +
        "VALUES (" + (id > -1 ? "?, " : "") + "?, ?, ?, ?, ?, ?, ?) ");
    int i = 0;
    if (id > -1) {
      pst.setInt(++i, id);
    }
    pst.setString(++i, module);
    pst.setString(++i, section);
    pst.setString(++i, subsection);
    pst.setString(++i, title);
    pst.setString(++i, description);
    pst.setInt(++i, enteredBy);
    pst.setInt(++i, modifiedBy);
    pst.execute();
    pst.close();
    id = DatabaseUtils.getCurrVal(db, "help_contents_help_id_seq", id);
    return true;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public int update(Connection db) throws SQLException {
    if (id == -1) {
      if ("null".equals(module)) {
        module = null;
      }
      if ("null".equals(section)) {
        section = null;
      }
      if ("null".equals(subsection)) {
        subsection = null;
      }
      this.insert(db);
      return 1;
    }

    // inserting categoryid into help_module if it does not exist
    HelpModuleList hml = new HelpModuleList();
    hml.setCategoryId(categoryId);
    hml.buildList(db);
    if (hml.size() == 0) {
      HelpModule hm = new HelpModule();
      hm.setLinkCategoryId(categoryId);
      hm.insert(db);
      moduleId = hm.getId();
    } else {
      moduleId = ((HelpModule) hml.get(0)).getId();
    }

    PreparedStatement pst = db.prepareStatement(
        "UPDATE help_contents " +
        "SET category_id = ? , link_module_id = ?, title = ?, description = ?, modifiedby = ?, modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
        "WHERE help_id = ? ");
    int i = 0;
    pst.setInt(++i, categoryId);
    pst.setInt(++i, moduleId);
    pst.setString(++i, title);
    pst.setString(++i, description);
    pst.setInt(++i, modifiedBy);
    pst.setInt(++i, id);
    int count = pst.executeUpdate();
    pst.close();
    return count;
  }


  /**
   * Builds features of this help item
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildFeatures(Connection db) throws SQLException {
    features.setLinkHelpId(this.getId());
    features.buildList(db);
  }


  /**
   * Builds Notes for this help item
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildNotes(Connection db) throws SQLException {
    notes.setLinkHelpId(this.getId());
    notes.setEnabledOnly(true);
    notes.buildList(db);
  }


  /**
   * Builds Tips for this help item
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildTips(Connection db) throws SQLException {
    tips.setLinkHelpId(this.getId());
    tips.buildList(db);
  }


  /**
   * Builds business rules for this help item
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildRules(Connection db) throws SQLException {
    businessRules.setLinkHelpId(this.getId());
    businessRules.buildList(db);
  }


  /**
   * Gets the baseFilename attribute of the HelpItem object
   *
   * @return The baseFilename value
   */
  public String getBaseFilename() {
    StringBuffer filename = new StringBuffer();
    if (module.indexOf(".do") > -1) {
      filename.append(module.substring(0, module.indexOf(".do")));
    } else {
      filename.append(module);
    }
    filename.append("-");
    filename.append(section);
    if (subsection != null && subsection.length() > 0) {
      filename.append("-" + subsection);
    }
    return filename.toString().toLowerCase();
  }


  /**
   * Description of the Method
   *
   * @param path Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean hasImageFile(String path) {
    if (System.getProperty("DEBUG") != null) {
      System.out.println(
          "HelpItem-> Looking for the following image: " + path + fs + this.getBaseFilename() + ".png");
    }
    File helpImage = new File(path + fs + this.getBaseFilename() + ".png");
    return helpImage.exists();
  }
}

