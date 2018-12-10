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
public class GSMUnitSales 
{
    @XmlElement(name = "InstitutionCode")
      public String InstitutionCode ; 
     
    @XmlElement(name = "SubscriberCode")
      public String SubscriberCode ; 
      
     @XmlElement(name = "UnitID")
      public String UnitID ; 
     
     @XmlElement(name = "Quantity")
      public String Quantity ; 
      
     @XmlElement(name = "Amount")
      public String Amount ; 
}
