/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Request;

import garanti.core.BaseEntity.Settings;
import garanti.core.BaseEntity.VPOSRequest;
import garanti.core.HelperClass.GarantiPaY;
import garanti.core.HelperClass.GPInstallments;
import garanti.core.RestHttpCaller;
import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Codevist
 */
@XmlRootElement(name = "GVPSRequest")

public class GarantiPayMORequest extends VPOSRequest{
    
    
   
  
    
    public static String execute(GarantiPayMORequest request, Settings settings) 
        {
        
            
            
            request.Terminal.HashData = Compute3DHash(request, settings);
            return RestHttpCaller.getInstance().postXML(settings.BaseUrl, request);
        }
     
     public static String Compute3DHash(GarantiPayMORequest request, Settings settings) 
        {
            
  
            String temp = settings.Password + String.format("%09d", Integer.parseInt(request.Terminal.ID));
            String hashedPassword = RestHttpCaller.generateHash(temp);
                    
            StringBuilder sb = new StringBuilder();
sb.append(hashedPassword);


            temp = request.Order.OrderID +request.Terminal.ID  + request.Card.Number + request.Transaction.Amount+ sb.toString();
            String hashData = RestHttpCaller.generateHash(temp);
            sb = new StringBuilder();
            
            sb.append(hashData);
 

            return sb.toString();
            
        }
}
