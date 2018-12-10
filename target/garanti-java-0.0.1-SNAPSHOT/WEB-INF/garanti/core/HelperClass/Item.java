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
public class Item 
{
    @XmlElement(name = "Number")
    public String Number ;    
    
    @XmlElement(name = "ProductID")
    public String ProductID ;    
    
    @XmlElement(name = "ProductCode")
    public String ProductCode ;    
    
    @XmlElement(name = "Quantity")
    public String Quantity ;    
    
    @XmlElement(name = "Price")
    public String Price ;    
    
    @XmlElement(name = "TotalAmount")
    public String TotalAmount ;  
    
    @XmlElement(name = "Description")
    public String Description ;
    
}
