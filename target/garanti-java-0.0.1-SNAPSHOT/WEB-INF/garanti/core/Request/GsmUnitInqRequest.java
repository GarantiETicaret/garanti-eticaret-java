
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
public class GsmUnitInqRequest extends VPOSRequest
{

    
    public static String execute(GsmUnitInqRequest request, Settings settings) throws Exception 
    {  
         request.Terminal.HashData=RestHttpCaller.createToken(request.Terminal,request.Order,request.Card,request.Transaction,settings);
         return RestHttpCaller.getInstance().postXML(settings.BaseUrl,request);
    }
}