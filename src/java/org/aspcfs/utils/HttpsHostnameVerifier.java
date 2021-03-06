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
package org.aspcfs.utils;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;

/**
 * This is a replacement hostname verifier that accepts ANYTHING. This was
 * created to allow self-signed X509 certificates to work.
 *
 * @author matt rajkowski
 * @version $Id: HttpsHostnameVerifier.java,v 1.2 2003/09/08 20:55:10
 *          mrajkowski Exp $
 * @created August 12, 2003
 */
public class HttpsHostnameVerifier implements HostnameVerifier {

  /**
   * Verifies certificate for Java 1.4 and up
   *
   * @param hostname Description of the Parameter
   * @param session  Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean verify(String hostname, SSLSession session) {
    //accept any name
    return true;
  }
}

