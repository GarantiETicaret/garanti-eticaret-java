<%-- 
    Document   : OOSSuccess
    Created on : Nov 30, 2018, 1:42:11 PM
    Author     : Codevist
--%>

<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.*"%>


<%@page import="garanti.core.HelperClass.Secure3D"%>

<%@page import="garanti.core.Response.*"%>
<%@page import="garanti.core.Request.*"%>
<%@page import="garanti.core.BaseEntity.*"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.Helper"%>

<%@page contentType="text/html" pageEncoding="windows-1254"%>
<!DOCTYPE html>



<jsp:include page="layout.jsp" />

<%
	request.setCharacterEncoding("UTF-8");

        
                String hash=request.getParameter("hash");
                String hashParamsVal="";
                String storeKey="12345678";
                String hashParams = request.getParameter("hashparams");
                boolean valid=false;
                
                if(hashParams!=null && hashParams!= "")
                {
                    String[] validate=hashParams.split(":");
                    
                    for (String param : validate) 
                    {
                          hashParamsVal += request.getParameter(param);
                    }
                    hashParamsVal += storeKey;
                    valid=Secure3DSuccessRequest.Validate3DReturn(hashParamsVal, hash);
                }

                if(valid==true)
       {
           Enumeration en = request.getParameterNames();
                    StringBuilder sb = new StringBuilder();
        while (en.hasMoreElements()) {

           String parameterName = (String) en.nextElement();
                String parameterValue = request.getParameter(parameterName);
                String value = parameterName+":"+parameterValue+"\n";
 
           sb.append(value);
        }
        
        StringWriter sw = new StringWriter();
                 JAXB.marshal(sb.toString(), sw);	
		out.println("  <h1>Sonuç</h1>");
		out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>");
        
       }
        else
                out.println("Hash Doðrulamasý Yapýlamadý.");


      
%>

  


    
        
    	    
    

<jsp:include page="footer.jsp" />
