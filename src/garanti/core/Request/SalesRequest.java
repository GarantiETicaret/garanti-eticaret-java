/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Request;

import com.sun.org.apache.xerces.internal.parsers.XMLDocumentParser;
import garanti.core.BaseEntity.Settings;
import garanti.core.BaseEntity.Card;
import garanti.core.BaseEntity.Order;

import garanti.core.BaseEntity.VPOSRequest;
import garanti.core.RestHttpCaller;
import java.io.File;
import java.io.IOException;
import java.io.StringReader;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.io.SAXReader;



import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;





/**
 *
 * @author Codevist
 */

@XmlRootElement(name = "GVPSRequest")
public class SalesRequest extends VPOSRequest
{
    public static String execute(SalesRequest request, Settings settings) throws Exception 
    {  
         request.Terminal.HashData=ComputeHash(request, settings);
         
         String result=RestHttpCaller.getInstance().postXML(settings.BaseUrl,request);
         if(XmlValidation(result, settings)==true)
         {
             return result;
         }
         else
         return "Validation Hatalý!";
       
    }
    
    
    public static boolean XmlValidation(String result, Settings settings) throws DocumentException, ParserConfigurationException {           
        SAXReader reader = new SAXReader();

Document document = reader.read(new InputSource(new StringReader(result)));

String reasonCode = document.selectSingleNode("//GVPSResponse/Transaction/Response/ReasonCode").getText();
        String retRefNum = document.selectSingleNode("//GVPSResponse/Transaction/RetrefNum").getText();
String authCode = document.selectSingleNode("//GVPSResponse/Transaction/AuthCode").getText();
String provDate = document.selectSingleNode("//GVPSResponse/Transaction/ProvDate").getText();
String orderId = document.selectSingleNode("//GVPSResponse/Order/OrderID").getText();
String terminalId = document.selectSingleNode("//GVPSResponse/Terminal/ID").getText();
String hashData = document.selectSingleNode("//GVPSResponse/Transaction/HashData").getText();

String hashString= reasonCode + retRefNum + authCode + provDate + orderId;
String validhash= ComputeHash(hashString, terminalId, settings);

if("00".equals(reasonCode) && hashData!= null && !"".equals(hashData))
{
    if (hashData.equals(validhash)) {
        
        return true;
    }
    return false;
}
return false;
        }
    
    
    
    
     public static String ComputeHash(SalesRequest request, Settings settings) 
        {
  
            String temp = settings.Password + String.format("%09d",Integer.parseInt(request.Terminal.ID));
            String hashedPassword = RestHttpCaller.generateHash(temp);
                    
            StringBuilder sb = new StringBuilder();
sb.append(hashedPassword);


            temp = request.Order.OrderID + request.Terminal.ID + request.Card.Number + request.Transaction.Amount + sb.toString();
            String hashData = RestHttpCaller.generateHash(temp);
            sb = new StringBuilder();
            
            sb.append(hashData);
 

            return sb.toString();
            
            

        }
      public static String ComputeHash(String hashString,String terminalID, Settings settings) 
        {
  
            String temp = settings.Password + String.format("%09d",Integer.parseInt(terminalID));
            String hashedPassword = RestHttpCaller.generateHash(temp);
                    
            StringBuilder sb = new StringBuilder();
sb.append(hashedPassword);


            temp = hashString + sb.toString();
            String hashData = RestHttpCaller.generateHash(temp);
            sb = new StringBuilder();
            
            sb.append(hashData);
 

            return sb.toString();
            
            

        }
}
