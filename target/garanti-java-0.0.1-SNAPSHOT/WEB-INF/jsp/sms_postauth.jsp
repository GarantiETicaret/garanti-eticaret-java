<%-- 
    Document   : sms_postauth
    Created on : Nov 20, 2018, 11:35:31 AM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.SMSPostauthRequest "%>
<%@page import="garanti.core.HelperClass.Verification "%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>SMS Doðrulama/Ön Otorizasyon Kapama</h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> postauth<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">Ödeme Bilgileri</label></legend>
        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Kart Numarasý:</label>
            <div class="col-md-4">
                <input value="4282209027132016" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay/Yýl: </label>
            <div class="col-md-4">
                <input value="0520" name="expireDate" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  CVC: </label>
            <div class="col-md-4">
                <input value="165" name="cvv" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  OrderID:</label>
            <div class="col-md-4">
                
               <input value= '<%=UUID.randomUUID().toString().replace("-", "")%>'   name="orderID" class="form-control input-md">

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  SMS Þifresi:</label>
            <div class="col-md-4">
                <input value="" name="smsPassword" class="form-control input-md">
            </div>
        </div>
        

    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Ýþlem Yap</button>
        </div>
    </div>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		 SMS Doðrulama/Ön Otorizasyon Kapama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		SMSPostauthRequest smsPostauthRequest = new SMSPostauthRequest();  

                smsPostauthRequest.Version=settings.Version;
                smsPostauthRequest.Mode=settings.Mode;
                
		smsPostauthRequest.Terminal=new Terminal();
                smsPostauthRequest.Terminal.ProvUserID=terminal.ProvUserID;
                smsPostauthRequest.Terminal.UserID=terminal.UserID;
                smsPostauthRequest.Terminal.ID=terminal.ID;
                smsPostauthRequest.Terminal.MerchantID=terminal.MerchantID;
                
                smsPostauthRequest.Customer= new Customer();
                smsPostauthRequest.Customer.EmailAddr="fatih@codevist.com";
                smsPostauthRequest.Customer.IPAddress="127.0.0.1";
                
                
                smsPostauthRequest.Card= new Card();
                smsPostauthRequest.Card.CVV2=request.getParameter("cvv");
                smsPostauthRequest.Card.ExpireDate=request.getParameter("expireDate");
                smsPostauthRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               smsPostauthRequest.Order= new Order();
               smsPostauthRequest.Order.OrderID=orderId;
               smsPostauthRequest.Order.Description="";
               
               
               smsPostauthRequest.Transaction= new Transaction();
               smsPostauthRequest.Transaction.Amount=request.getParameter("transactionAmount");
               smsPostauthRequest.Transaction.CurrencyCode="949";
               smsPostauthRequest.Transaction.Type="postauth";
               smsPostauthRequest.Transaction.MotoInd="H";
               smsPostauthRequest.Transaction.SubType="sms";
               
               smsPostauthRequest.Transaction.Verification= new Verification();
               smsPostauthRequest.Transaction.Verification.SMSPassword=request.getParameter("smsPassword");
               
               
               String smsPostauthResponse = SMSPostauthRequest.execute(smsPostauthRequest,settings); //"SMS Doðrulama/Ön Otorizasyon Kapama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(smsPostauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"SMS Doðrulama/Ön Otorizasyon Kapama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
