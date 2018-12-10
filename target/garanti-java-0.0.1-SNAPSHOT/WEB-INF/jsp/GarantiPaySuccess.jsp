<%-- 
    Document   : GarantiPaySuccess
    Created on : Nov 30, 2018, 1:54:46 PM
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

                String storeKey="12345678";
                
                String gpHash=request.getParameter("clientid") + request.getParameter("oid") + request.getParameter("authcode")
                    + request.getParameter("procreturncode") + request.getParameter("gpinstallmentamount") + request.getParameter("gpinstallment") + storeKey;
                String gphashdata=request.getParameter("gphashdata");
                
                boolean valid=false;
                
                valid=Secure3DSuccessRequest.Validate3DReturn(gpHash, gphashdata);
                

                if(valid==true)
       
                {
            
                    Enumeration en = request.getParameterNames();
                    StringBuilder sb = new StringBuilder();

                    while (en.hasMoreElements()) 
                    {


                        String parameterName = (String) en.nextElement();
                
                        String parameterValue = request.getParameter(parameterName);
                
                        String value = parameterName+":"+parameterValue+"\n";
 
 
                
                        sb.append(value);

                    }
        
        
                    StringWriter sw = new StringWriter();
                    JAXB.marshal(sb.toString(), sw);	
                    out.println("  <h1>Sonu�</h1>");
                    out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>");
        
                }
            else
                out.println("Hash Do�rulamas� Yap�lamad�.");


      
%>

  


    
        
    	    
    

<jsp:include page="footer.jsp" />

