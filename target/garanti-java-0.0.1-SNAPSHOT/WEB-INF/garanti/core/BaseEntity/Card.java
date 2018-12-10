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
public class Card 
{
    @XmlElement(name = "Number")
        public String Number ;   
    @XmlElement(name = "ExpireDate")
        public String ExpireDate ;   
     @XmlElement(name = "CVV2")
        public String CVV2 ;   
}
