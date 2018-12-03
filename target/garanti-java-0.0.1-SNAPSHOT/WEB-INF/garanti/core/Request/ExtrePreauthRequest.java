/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Request;


import garanti.core.BaseEntity.Settings;
import garanti.core.BaseEntity.VPOSRequest;
import garanti.core.RestHttpCaller;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Codevist
 */

@XmlRootElement(name = "GVPSRequest")
public class ExtrePreauthRequest extends VPOSRequest
{
   
    
    
    public static String execute(ExtrePreauthRequest request, Settings settings) throws Exception 
    {  
         request.Terminal.HashData=RestHttpCaller.createToken(request.Terminal,request.Order,request.Card,request.Transaction,settings);
         return RestHttpCaller.getInstance().postXML(settings.BaseUrl,request);
    }
}