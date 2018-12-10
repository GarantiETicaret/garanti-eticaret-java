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
public class Address 
{
      @XmlElement(name = "Type")
      public String Type ; 
      
      @XmlElement(name = "Name")
      public String Name ; 
      
      @XmlElement(name = "LastName")
      public String LastName ; 
      
      @XmlElement(name = "Company")
      public String Company ; 
      
      @XmlElement(name = "Text")
      public String Text ; 
      
      @XmlElement(name = "City")
      public String City ; 
     
      @XmlElement(name = "Country")
      public String Country ; 
      
      @XmlElement(name = "PostalCode")
      public String PostalCode ; 
      
      @XmlElement(name = "PhoneNumber")
      public String PhoneNumber ; 
}
