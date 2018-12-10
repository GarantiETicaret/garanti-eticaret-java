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
public class Payment 
{
      @XmlElement(name = "PaymentNum")
      public String PaymentNum ; 
       
      @XmlElement(name = "Number")
      public String Number ; 
      @XmlElement(name = "Amount")
      public String Amount ; 
      
     @XmlElement(name = "DueDate")
      public String DueDate ; 
      
}
