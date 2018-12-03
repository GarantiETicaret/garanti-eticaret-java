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
public class Cheque 
{
     @XmlElement(name = "Type")
      public String Type ; 
     
     @XmlElement(name = "Amount")
      public String Amount ; 
     
     @XmlElement(name = "Count")
      public String Count ; 
     
      @XmlElement(name = "ID")
      public String ID ; 
      
      @XmlElement(name = "Bitmap")
      public String Bitmap ; 
}
