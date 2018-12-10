/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Request;

import garanti.core.BaseEntity.Settings3D;
import garanti.core.HelperClass.PreparePOSTForm;
import garanti.core.RestHttpCaller;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import org.apache.commons.collections.MultiMap;
import org.apache.commons.collections.map.MultiValueMap;

/**
 *
 * @author Codevist
 */
@XmlRootElement(name = "GVPSRequest")
public class Sale3DPayRequest {
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
   
  
   
   
    public static String execute(Sale3DPayRequest request, Settings3D settings3D) 
        {
            request.secure3dhash = Compute3DHash(request, settings3D);
                    MultiMap Data = new MultiValueMap();
            Data.put("mode", request.mode);
            Data.put("secure3dsecuritylevel", request.secure3dsecuritylevel);
            Data.put("apiversion", request.apiversion);
            Data.put("terminalprovuserid", request.terminalprovuserid);
            Data.put("terminaluserid", request.terminaluserid);
            Data.put("terminalmerchantid", request.terminalmerchantid);
            Data.put("terminalid", request.terminalid);
            Data.put("txntype", request.txntype);
            Data.put("txnamount", request.txnamount);
            Data.put("txncurrencycode", request.txncurrencycode);
            Data.put("txninstallmentcount", request.txninstallmentcount);
            Data.put("orderid", request.orderid);
            Data.put("successurl", request.successurl);
            Data.put("errorurl", request.errorurl);
            Data.put("customeremailaddress", request.customeremailaddress);
            Data.put("customeripaddress", request.customeripaddress);
            Data.put("secure3dhash", request.secure3dhash);
            Data.put("txntimestamp", request.txntimestamp);
            Data.put("cardnumber", request.cardnumber);
            Data.put("cardexpiredatemonth", request.cardexpiredatemonth);
            Data.put("cardexpiredateyear", request.cardexpiredateyear);
            Data.put("cardcvv2", request.cardcvv2);
            Data.put("storekey", request.storekey);

            return PreparePOSTForm.PreparePost(settings3D.BaseUrl, Data);
        }
        public static String Compute3DHash(Sale3DPayRequest request, Settings3D settings3D) 
        {
  
            String temp = settings3D.Password + String.format("%09d", Integer.parseInt(request.terminalid));
            String hashedPassword = RestHttpCaller.generateHash(temp);
                    
            StringBuilder sb = new StringBuilder();
sb.append(hashedPassword);


            temp = request.terminalid + request.orderid + request.txnamount + request.successurl + request.errorurl + request.txntype
                + request.txninstallmentcount + request.storekey + sb.toString();
            String hashData = RestHttpCaller.generateHash(temp);
            sb = new StringBuilder();
            
            sb.append(hashData);
 

            return sb.toString();
            
            

        }
}
