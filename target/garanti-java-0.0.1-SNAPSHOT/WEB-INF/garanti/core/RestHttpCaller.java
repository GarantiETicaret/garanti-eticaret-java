/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core;


import garanti.core.BaseEntity.Card;
import garanti.core.BaseEntity.Order;
import garanti.core.BaseEntity.Settings;
import garanti.core.BaseEntity.Terminal;
import garanti.core.BaseEntity.Transaction;
import garanti.core.BaseEntity.VPOSRequest;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import javax.xml.bind.JAXB;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSSerializer;
import org.xml.sax.InputSource;

/**
 *
 * @author Codevist
 */
public class RestHttpCaller 
{
    public static RestHttpCaller getInstance() {
        return new RestHttpCaller();
    }

    public String postXML(String url,Object request) 
    {
        StringWriter sw = new StringWriter();
        JAXB.marshal(request, sw);
        String body = sw.toString();
        try {
            String response = send(url,new ByteArrayInputStream(body.getBytes(Constants.Formats.UTF8)), Constants.ContentTypes.APPLICATION_XML_UTF8);
            return response;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
    /*
     * Xml çaðrýlarýnýn yapýlmasý için  xml datasýnýn parametre olarak gönderileren adrese post edilmesini saðlar.
    */
    private String send(String url,InputStream content, String contentType) {

        URLConnection raw;
        HttpURLConnection conn = null;
        try {
            raw = new URL(url).openConnection();
            conn = HttpURLConnection.class.cast(raw);

            conn.setRequestMethod(Constants.HTTPMethods.POST);

            conn.setConnectTimeout(1000000);
            conn.setReadTimeout(1000000);
            conn.setUseCaches(false);
            conn.setInstanceFollowRedirects(false);
            conn.addRequestProperty(Constants.StandardHTTPHeaders.CONTENT_TYPE, contentType);
            prepareRequestBody(content, conn);
            return new String(body(conn), Charset.forName(Constants.Formats.UTF8));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
		
    private void prepareRequestBody(InputStream content, HttpURLConnection conn) throws IOException {

        conn.setDoOutput(true);
        final OutputStream output = conn.getOutputStream();
        try {
            prepareOutputStream(content, output);
        } finally {
            output.close();
            content.close();
        }
    }

    
    private void prepareOutputStream(InputStream content, OutputStream output) throws IOException {
        final byte[] buffer = new byte[8192];
        for (int bytes = content.read(buffer); bytes != -1;
                bytes = content.read(buffer)) {
            output.write(buffer, 0, bytes);
        }
    }

    private byte[] body(HttpURLConnection conn) throws IOException {
        final InputStream input;
        if (conn.getResponseCode() >= HttpURLConnection.HTTP_BAD_REQUEST) {
            input = conn.getErrorStream();
        } else {
            input = conn.getInputStream();
        }
        final byte[] body;
        if (input == null) {
            body = new byte[0];
        } else {
            try {
                final byte[] buffer = new byte[8192];
                final ByteArrayOutputStream output = new ByteArrayOutputStream();
                for (int bytes = input.read(buffer); bytes != -1;
                        bytes = input.read(buffer)) {
                    output.write(buffer, 0, bytes);
                }
                body = output.toByteArray();
            } finally {
                input.close();
            }
        }
        return body;
    }
    
    public static String createToken(Terminal terminal,Order order,Card card,Transaction transaction, Settings settings) throws Exception 
    {
        
            String hashPassword=settings.Password+String.format("%09d", Integer.parseInt(terminal.ID));//9 karaktere tamamlanacak
            String hashedPassword=generateHash(hashPassword).toUpperCase();
            String hashstr =order.OrderID +terminal.ID+card.Number+transaction.Amount+hashedPassword;
            return generateHash(hashstr).toUpperCase();
    }
      
    public static String generateHash(String input )
    {
        try
        {
            MessageDigest md = MessageDigest.getInstance("SHA1");
            md.reset();
            byte[] buffer = input.getBytes();
            md.update(buffer);
            byte[] digest = md.digest();

            String hexStr = "";
            for (int i = 0; i < digest.length; i++) {
                    hexStr +=  Integer.toString( ( digest[i] & 0xff ) + 0x100, 16).substring( 1 );
            }
            return hexStr.toUpperCase();
        }
        catch(NoSuchAlgorithmException e)
        {
           // setError(ss,"SHA1",ss.translate("SHA1 Hashing Error 3DPay"));//Sorr
            return null;
        }
    }
    public String getFormattedAmount(double amount) 
    {
        DecimalFormat df = new DecimalFormat(".00");
        String formattedAmount = 
            df.format(amount).replaceAll(",", "").replaceAll("\\.", "");
        return formattedAmount;
    }
    
    
   
}
