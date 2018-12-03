/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.BaseEntity;

import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */
public class Customer 
{
     @XmlElement(name = "IPAddress")
        public String IPAddress ;    
     @XmlElement(name = "EmailAddr")
        public String EmailAddr ;   
}
