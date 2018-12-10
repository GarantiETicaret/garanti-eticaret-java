<%-- 
    Document   : Success
    Created on : Nov 29, 2018, 10:12:32 AM
    Author     : Codevist
--%>


<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="com.google.gson.Gson"%>


<%@page import="garanti.core.HelperClass.Secure3D"%>

<%@page import="garanti.core.Response.*"%>
<%@page import="garanti.core.Request.*"%>
<%@page import="garanti.core.BaseEntity.*"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.Helper"%>

<%@page contentType="text/html" pageEncoding="windows-1254"%>
<!DOCTYPE html>
<%!Secure3DResponse secure3DResponse = new Secure3DResponse();%>

<%!String responseSuccess = new String();%>
<%!Secure3DSuccessRequest secure3DSuccess = new Secure3DSuccessRequest();%>


<jsp:include page="layout.jsp" />

<%
	request.setCharacterEncoding("UTF-8");
	Settings settings = new Settings();
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
	if ((request.getParameter("mdstatus").equals("1") ) || (request.getParameter("mdstatus").equals("2") ) || (request.getParameter("mdstatus").equals("3") ) || (request.getParameter("mdstatus").equals("4") )) 
        {

          
                Secure3DResponse secure3DResponse = new Secure3DResponse();
           

                secure3DResponse.orderID=request.getParameter("orderid");
                secure3DResponse.authenticationCode=request.getParameter("cavv");
                secure3DResponse.securityLevel=request.getParameter("eci");
                secure3DResponse.txnID=request.getParameter("xid");
                secure3DResponse.MD=request.getParameter("md");
                secure3DResponse.mode=request.getParameter("mode");
                secure3DResponse.apiversion=request.getParameter("apiversion");
                secure3DResponse.terminalProvUserID=request.getParameter("terminalprovuserid");
                secure3DResponse.installmentCount=request.getParameter("txninstallmentcount");
                secure3DResponse.terminalUserID=request.getParameter("terminaluserid");
                secure3DResponse.terminalID=request.getParameter("clientid");
                secure3DResponse.amount=request.getParameter("txnamount");
                secure3DResponse.currencyCode=request.getParameter("txncurrencycode");
                secure3DResponse.customerIpAddres=request.getParameter("customeripaddress");
                secure3DResponse.customerEmailAddress=request.getParameter("customeremailaddress");
                secure3DResponse.terminalMerchantID=request.getParameter("terminalmerchantid");
                secure3DResponse.txnType=request.getParameter("txntype");
                secure3DResponse.procreturnCode=request.getParameter("procreturncode");
                secure3DResponse.authcode=request.getParameter("authcode");
                secure3DResponse.response=request.getParameter("response");
                secure3DResponse.mdstatus=request.getParameter("msstatus");
                secure3DResponse.rnd=request.getParameter("rnd");
                secure3DResponse.xmlResponse="";            

               

              

                        Secure3DSuccessRequest secure3DSuccessRequest = new Secure3DSuccessRequest();

                        secure3DSuccessRequest.Version=secure3DResponse.apiversion;
                        secure3DSuccessRequest.Mode=secure3DResponse.mode;

                        Terminal t=new Terminal();
                        t.ID=secure3DResponse.terminalID;
                        t.MerchantID=secure3DResponse.terminalMerchantID;
                        t.ProvUserID = secure3DResponse.terminalProvUserID;
                        t.UserID = secure3DResponse.terminalUserID;

                        secure3DSuccessRequest.Terminal=t;
                        Card c=new Card();
                        c.CVV2 = "";
                        c.ExpireDate = "";
                        c.Number = "";
                        secure3DSuccessRequest.Card=c;

                        Customer customer = new Customer();
                        customer.EmailAddress = secure3DResponse.customerEmailAddress;
                        customer.IPAddress = secure3DResponse.customerIpAddres;

                        secure3DSuccessRequest.Customer=customer;

                        Order order=new Order();
                        order.OrderID = secure3DResponse.orderID;
                        order.Description="";

                        secure3DSuccessRequest.Order=order;

                        Transaction transaction=new Transaction();
                        transaction.Amount = secure3DResponse.amount;
                        transaction.CurrencyCode = secure3DResponse.currencyCode;
                        transaction.InstallmentCnt = secure3DResponse.installmentCount;
                        transaction.Type = secure3DResponse.txnType;
                        transaction.MotoInd = "N";
                        transaction.CardholderPresentCode = "13";
                        Secure3D secure3d =new Secure3D();
                        secure3d.AuthenticationCode = secure3DResponse.authenticationCode;
                        secure3d.Md = secure3DResponse.MD;
                        secure3d.SecurityLevel = secure3DResponse.securityLevel;
                        secure3d.TxnID = secure3DResponse.txnID;
                        transaction.Secure3D=secure3d;
                        secure3DSuccessRequest.Transaction=transaction;
                        
                        responseSuccess = Secure3DSuccessRequest.execute(secure3DSuccessRequest, settings); //"3D secure 2. adýmýnýn baþlatýlmasý için gerekli servis çaðrýsýný temsil eder."
                        secure3DSuccess=secure3DSuccessRequest;   
        }}
       else
       out.println("Hash Doðrulamasý Yapýlamadý.");
%>

   <h1>3d Baþarýlý!</h1>


    <%
         StringWriter swa = new StringWriter();
                 JAXB.marshal(secure3DSuccess, swa);	
		out.println("  <h1>Sonuç</h1>");
		out.println("<pre>" + Helper.prettyPrintXml(swa.toString()) + "</pre>");
        
        
    	       StringWriter sw = new StringWriter();
                 JAXB.marshal(responseSuccess, sw);	
		out.println("  <h1>Sonuç</h1>");
		out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ödeme iþlemi sonucunda ekranda gösterilecek servis çýktý parametrelerinin yer aldýðý kýsmý temsil etmektedir.
    %>

<jsp:include page="footer.jsp" />