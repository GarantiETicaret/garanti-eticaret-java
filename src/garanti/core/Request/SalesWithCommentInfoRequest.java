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
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */

@XmlRootElement(name = "GVPSRequest")
public class SalesWithCommentInfoRequest extends VPOSRequest 
{
@XmlElement(name ="Number")
    public int Number ;
    
    @XmlElement(name ="Text")
    public String Text ;
    
    public static String execute(SalesWithCommentInfoRequest request, Settings settings) throws Exception 
    {  
         request.Terminal.HashData=RestHttpCaller.createToken(request.Terminal,request.Order,request.Card,request.Transaction,settings);
         return RestHttpCaller.getInstance().postXML(settings.BaseUrl,request);
    }

    private static class ElementName {

        public ElementName() {
        }
    }
}
