/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Request;
 import garanti.core.BaseEntity.*;
 import garanti.core.HelperClass.Secure3D;

import garanti.core.RestHttpCaller;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import javax.xml.bind.annotation.XmlRootElement;
/**
 *
 * @author Codevist
 */
@XmlRootElement(name = "GVPSRequest")
public class Secure3DSuccessRequest extends VPOSRequest{
    
    
   

    
    public static String execute(Secure3DSuccessRequest request, Settings settings) 
        {
            request.Terminal.HashData = Compute3DHash(request, settings);
            return RestHttpCaller.getInstance().postXML(settings.BaseUrl, request);
        }
    
    public static String Compute3DHash(Secure3DSuccessRequest request, Settings settings) 
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
    
    public static boolean Validate3DReturn(String hashString, String validHash) throws UnsupportedEncodingException
        {
            //SHA1 sha = new SHA1CryptoServiceProvider();
            String hashData = generateHashForValidate(hashString);
            if (hashData == null ? validHash == null : hashData.equals(validHash))
                return true;
            return false;
        }
    
    public static String generateHashForValidate(String input ) throws UnsupportedEncodingException
    {
        try
        {
            MessageDigest md = MessageDigest.getInstance("SHA1");
            md.reset();
            byte[] buffer = input.getBytes("ISO-8859-9");
            md.update(buffer);
            byte[] digest = md.digest();
            String valueString = Base64.getEncoder().encodeToString(digest);

            
            return valueString;
        }
        catch(NoSuchAlgorithmException e)
        {
           // setError(ss,"SHA1",ss.translate("SHA1 Hashing Error 3DPay"));//Sorr
            return null;
        }
    }
}
