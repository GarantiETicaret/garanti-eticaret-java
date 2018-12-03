/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.HelperClass;

import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;

/**
 *
 * @author Codevist
 */
public class Recurring 
{
    @XmlElement(name = "Type")
    public String Type;
    
    @XmlElement(name = "TotalPaymentNum")
    public String TotalPaymentNum;
    
    @XmlElement(name = "FrequencyType")
    public String FrequencyType;
    
     @XmlElement(name = "FrequencyInterval")
    public String FrequencyInterval;
     
    @XmlElement(name = "StartDate")
    public String StartDate;
    
    
    
    @XmlElementWrapper(name = "PaymentList")
    @XmlElement(name = "Payment")
    public List<Payment> Payment;
}
