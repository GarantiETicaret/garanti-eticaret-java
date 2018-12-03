/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.HelperClass;

import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */
public class Secure3D {
     @XmlElement(name = "AuthenticationCode")
      public String AuthenticationCode ; 
      @XmlElement(name = "SecurityLevel")
      public String SecurityLevel ; 
       @XmlElement(name = "TxnID")
      public String TxnID ; 
        @XmlElement(name = "Md")
      public String Md ; 
}
