
package garanti.core.HelperClass;

import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */
public class Verification 
{
     @XmlElement(name = "Identity")
     public String Identity ; 
     
     @XmlElement(name = "SMSPassword")
     public String SMSPassword ;
      
     @XmlElement(name = "ExtreInfo")
     public String ExtreInfo ;
}
