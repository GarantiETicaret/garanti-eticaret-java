/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Request;

/**
 *
 * @author Codevist
 */
import garanti.core.BaseEntity.Settings3D;
import garanti.core.RestHttpCaller;
import java.math.BigInteger;
import java.net.Proxy;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.util.StringUtils;

/**
 *
 * @author Codevist
 */

@XmlRootElement(name = "GVPSRequest")
public class Sale3DSecureRequest {
    
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
   
   @XmlElement(name = "lang")
      public String lang ;
   
   @XmlElement(name = "refreshtime")
      public String refreshtime ; 
   
   public static String execute(Sale3DSecureRequest request, Settings3D settings3D)
        {
            request.secure3dhash = Compute3DHash(request, settings3D);
            return CreateThreeDPaymentForm(request, settings3D);
            //return RestHttpCaller.Create().PostXMLString(settings3D.BaseUrl, request);
        }


   
        public static String Compute3DHash(Sale3DSecureRequest request, Settings3D settings3D)
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

        //Form Oluþturma
        public static String CreateThreeDPaymentForm(Sale3DSecureRequest request, Settings3D settings3D)
        {
           
            StringBuilder builder = new StringBuilder();
            builder.append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">");
            builder.append("<html>");
            builder.append("<body>");
            builder.append("<form //action=\"").append(settings3D.BaseUrl).append("\" method=\"POST\" id=\"three_d_form\" >");

            builder.append("<input type=\"hidden\" name=\"secure3dsecuritylevel\" id=\"secure3dsecuritylevel\" value=\"").append(request.secure3dsecuritylevel).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"mode\" id=\"mode\" value=\"").append(request.mode).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"apiversion\" id=\"apiversion\" value=\"").append(request.apiversion).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"terminalid\" id=\"terminalid\" value=\"").append(request.terminalid).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"terminalprovuserid\" id=\"terminalprovuserid\" value=\"").append(request.terminalprovuserid).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"terminaluserid\" id=\"terminaluserid\" value=\"").append(request.terminaluserid).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"terminalmerchantid\" id=\"terminalmerchantid\" value=\"").append(request.terminalmerchantid).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"txntype\" id=\"txntype\" value=\"").append(request.txntype).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"cardnumber\" id=\"cardnumber\" value=\"").append(request.cardnumber).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"cardexpiredatemonth\" id=\"cardexpiredatemonth\" value=\"").append(request.cardexpiredatemonth).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"cardexpiredateyear\" id=\"cardexpiredateyear\" value=\"").append(request.cardexpiredateyear).append("\"/>");

            builder.append("<input type=\"hidden\" name=\"cardcvv2\" id=\"cardcvv2\" value=\"").append(request.cardcvv2).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"txnamount\" id=\"txnamount\" value=\"").append(request.txnamount).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"txncurrencycode\" id=\"txncurrencycode\" value=\"").append(request.txncurrencycode).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"txninstallmentcount\" id=\"txninstallmentcount\" value=\"").append(request.txninstallmentcount).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"orderid\" id=\"orderid\" value=\"").append(request.orderid).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"successurl\" id=\"successurl\" value=\"").append(request.successurl).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"errorurl\" id=\"errorurl\" value=\"").append(request.errorurl).append("\"/>");

            builder.append("<input type=\"hidden\" name=\"secure3dhash\" id=\"secure3dhash\" value=\"").append(request.secure3dhash).append("\"/>");
            //builder.Append("<input type=\"hidden\" name=\"companyname\" id=\"companyname\" value=\"" + request.companyname + "\"/>");
            builder.append("<input type=\"hidden\" name=\"customeremailaddress\" id=\"customeremailaddress\" value=\"").append(request.customeremailaddress).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"customeripaddress\" id=\"customeripaddress\" value=\"").append(request.customeripaddress).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"txntimestamp\" id=\"txntimestamp\" value=\"").append(request.txntimestamp).append("\"/>");

            builder.append("<input type=\"hidden\" name=\"lang\" id=\"lang\" value=\"").append(request.lang).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"customeripaddress\" id=\"customeripaddress\" value=\"").append(request.customeripaddress).append("\"/>");
            builder.append("<input type=\"hidden\" name=\"refreshtime\" id=\"refreshtime\" value=\"").append(request.refreshtime).append("\"/>");

            builder.append("<input type=\"submit\" value=\"Öde\" style=\"display:none;\"/>");
            builder.append("</form>");
            builder.append("</body>");
            builder.append("<script>document.getElementById(\"three_d_form\").submit();</script>");
            builder.append("</html>");
            return builder.toString();
        }
}
