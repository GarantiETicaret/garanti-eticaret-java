/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.HelperClass;

import java.util.Set;
import org.apache.commons.collections.MultiMap;

/**
 *
 * @author Codevist
 */
//Form Oluþturma
public class  PreparePOSTForm 
{
    public static String PreparePost (String url, MultiMap data)
    {
    String formID = "PostForm";
            StringBuilder strForm = new StringBuilder();
            strForm.append("<form id=\"").append(formID).append("\" name=\"").append(formID).append("\" action=\"").append(url).append("\" method=\"POST\">");

            Set<String> keys = data.keySet();
            keys.forEach((key) -> {
                String value=data.get(key).toString();
                String valuereplacefirst=value.replace("[", "");
                String valuereplacelast=valuereplacefirst.replace("]", "");

                strForm.append("<input type=\"hidden\" name=\"").append(key).append("\" value=\"").append(valuereplacelast).append("\">");
        });
            strForm.append("</form>");
            StringBuilder strScript = new StringBuilder();
            strScript.append("<script language=\"javascript\">");
            strScript.append("var v").append(formID).append(" = document.").append(formID).append(";");
            strScript.append("v").append(formID).append(".submit();");
            strScript.append("</script>");
            return strForm.toString() + strScript.toString();
            
           
    }
            
}
