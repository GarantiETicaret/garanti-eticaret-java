/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Request;


import garanti.core.BaseEntity.Settings;
import garanti.core.BaseEntity.VPOSRequest;
import garanti.core.RestHttpCaller;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Codevist
 */
@XmlRootElement(name = "GVPSRequest")
public class ExtentedCreditSalesRequest extends VPOSRequest
{
     @XmlElement(name = "mode")
      public String mode ; 
   
   @XmlElement(name = "apiversion")
      public String apiversion ; 
   
   @XmlElement(name = "terminalprovuserid")
      public String terminalprovuserid ; 
   
   @XmlElement(name = "terminaluserid")
      public String terminaluserid ; 
   
   @XmlElement(name = "terminalmerchantid")
      public String terminalmerchantid ; 
   
   @XmlElement(name = "terminalid")
      public String terminalid ; 
   
   @XmlElement(name = "errorurl")
      public String errorurl ; 
   
   @XmlElement(name = "secure3dsecuritylevel")
      public String secure3dsecuritylevel ; 
   
   @XmlElement(name = "successurl")
      public String successurl ; 
   
   @XmlElement(name = "secure3dhash")
      public String secure3dhash ; 
   
   @XmlElement(name = "orderid")
      public String orderid ; 
   
   @XmlElement(name = "txnamount")
      public String txnamount ; 
   
   @XmlElement(name = "txntype")
      public String txntype ; 
   
   @XmlElement(name = "txninstallmentcount")
      public String txninstallmentcount ; 
   
   @XmlElement(name = "txncurrencycode")
      public String txncurrencycode ; 
   
   @XmlElement(name = "customeremailaddress")
      public String customeremailaddress ; 
   
   @XmlElement(name = "customeripaddress")
      public String customeripaddress ; 
   
   @XmlElement(name = "storekey")
      public String storekey ; 
   
   @XmlElement(name = "cardnumber")
      public String cardnumber ; 
   
   @XmlElement(name = "cardexpiredatemonth")
      public String cardexpiredatemonth ; 
   
   @XmlElement(name = "cardexpiredateyear")
      public String cardexpiredateyear ; 
   
   @XmlElement(name = "cardcvv2")
      public String cardcvv2 ; 
   
   @XmlElement(name = "txntimestamp")
      public String txntimestamp ; 
    
     public static String execute(ExtentedCreditSalesRequest request, Settings settings) throws Exception 
     {  
         
         
         
         
         request.Terminal.HashData=RestHttpCaller.createToken(request.Terminal,request.Order,request.Card,request.Transaction,settings);
         return RestHttpCaller.getInstance().postXML(settings.BaseUrl,request);
     }

}