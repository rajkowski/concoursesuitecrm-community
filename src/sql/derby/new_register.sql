-- ----------------------------------------------------------------------------
--  Apache Derby Table Creation
--
--  @author     Andrei I. Holub
--  @created    August 31, 2006
--  @version    $Id:$
-- ----------------------------------------------------------------------------

-- Tables for registration process
CREATE TABLE registration (
  registration_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  email VARCHAR(300),
  profile VARCHAR(300),
  name_first VARCHAR(300),
  name_last VARCHAR(300),
  company VARCHAR(300),
  registration_text VARCHAR(300),
  os_version VARCHAR(300),
  java_version VARCHAR(300),
  webserver VARCHAR(300),
  ip_address VARCHAR(20),
  ip_name VARCHAR(300),
  edition VARCHAR(300),
  crc CLOB,
  key_file CLOB,
  enabled CHAR(1) NOT NULL DEFAULT '1',
  entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
