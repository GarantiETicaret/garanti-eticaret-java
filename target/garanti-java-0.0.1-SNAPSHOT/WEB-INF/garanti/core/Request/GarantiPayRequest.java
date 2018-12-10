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
/**
 *
 * @author Codevist
 */
public class GarantiPayRequest {
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
   
   @XmlElement(name = "txnsubtype")
      public String txnsubtype ; 
   
   @XmlElement(name = "companyname")
      public String companyname ; 
   
   @XmlElement(name = "bnsuseflag")
      public String bnsuseflag ; 
   
   @XmlElement(name = "fbbuseflag")
      public String fbbuseflag ; 
   
   @XmlElement(name = "chequeuseflag")
      public String chequeuseflag ; 
   
   @XmlElement(name = "garantipay")
      public String garantipay ; 
   
   @XmlElement(name = "totallinstallmentcount")
      public String totallinstallmentcount ; 
   
   @XmlElement(name = "installmentnumber1")
      public String installmentnumber1 ; 
   
   @XmlElement(name = "installmentamount1")
      public String installmentamount1 ; 
   
   @XmlElement(name = "installmentnumber2")
      public String installmentnumber2 ; 
   
   @XmlElement(name = "installmentamount2")
      public String installmentamount2 ;
   
   @XmlElement(name = "txntimeoutperiod")
      public String txntimeoutperiod ; 
   
   
   
     @XmlElement(name = "txncurrencycode")
      public String txncurrencycode ; 
   
   @XmlElement(name = "customeremailaddress")
      public String customeremailaddress ; 
   
   @XmlElement(name = "customeripaddress")
      public String customeripaddress ; 
   
   @XmlElement(name = "storekey")
      public String storekey ; 
   
   @XmlElement(name = "txntimestamp")
      public String txntimestamp ; 
   
   @XmlElement(name = "lang")
      public String lang ; 
   
   @XmlElement(name = "refreshtime")
      public String refreshtime ; 
   
   @XmlElement(name = "installmentratewithreward1")
      public String installmentratewithreward1 ; 
   
   @XmlElement(name = "installmentratewithreward2")
      public String installmentratewithreward2 ; 
   
   @XmlElement(name = "txninstallmentcount")
      public String txninstallmentcount ; 
   
   
   
   
    public static String execute(GarantiPayRequest request, Settings3D settings3D) 
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

            Data.put("installmentratewithreward1", request.installmentratewithreward1);
            Data.put("installmentratewithreward2", request.installmentratewithreward2);
            Data.put("totallinstallmentcount", request.totallinstallmentcount);

            Data.put("installmentnumber1", request.installmentnumber1);
            Data.put("installmentnumber2", request.installmentnumber2);
            Data.put("installmentamount1", request.installmentamount1);
            Data.put("installmentamount2", request.installmentamount2);

            Data.put("bnsuseflag", request.bnsuseflag);
            Data.put("fbbuseflag", request.fbbuseflag);
            Data.put("chequeuseflag", request.chequeuseflag);
            Data.put("garantipay", request.garantipay);
            Data.put("refreshtime", request.refreshtime);
            Data.put("txnsubtype", request.txnsubtype);
            Data.put("companyname", request.companyname);
            Data.put("txntimeoutperiod", request.txntimeoutperiod);
            Data.put("storekey", request.storekey);

            return PreparePOSTForm.PreparePost(settings3D.BaseUrl, Data);
        }
        public static String Compute3DHash(GarantiPayRequest request, Settings3D settings3D) 
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
