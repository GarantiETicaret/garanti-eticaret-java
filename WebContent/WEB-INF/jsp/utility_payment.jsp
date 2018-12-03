<%-- 
    Document   : utility_payment
    Created on : Nov 20, 2018, 9:45:38 AM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.BaseEntity.SettlementInq"%>
<%@page import="garanti.core.Request.UtilityPaymentRequest"%>
<%@page import="garanti.core.HelperClass.UtilityPayment"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Fatura Ödeme </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> utilitypayment<br>
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
            <label class="col-md-4 control-label" for="">  Abone Kodu:</label>
            <div class="col-md-4">
                <input value="0001" name="subscriberCode" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Kurum Kodu: </label>
            <div class="col-md-4">
                <input value="1" name="institutionCode" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Fatura Numarasý: </label>
            <div class="col-md-4">
                <input value="12" name="invoiceID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Fatura Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="invoiceAmount" class="form-control input-md">
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Ödeme Yap</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		Fatura Ödeme servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		UtilityPaymentRequest utilityPaymentRequest = new UtilityPaymentRequest();  

                utilityPaymentRequest.Version=settings.Version;
                utilityPaymentRequest.Mode=settings.Mode;
                
		utilityPaymentRequest.Terminal=new Terminal();
                utilityPaymentRequest.Terminal.ProvUserID=terminal.ProvUserID;
                utilityPaymentRequest.Terminal.UserID=terminal.UserID;
                utilityPaymentRequest.Terminal.ID=terminal.ID;
                utilityPaymentRequest.Terminal.MerchantID=terminal.MerchantID;
                
                utilityPaymentRequest.Customer= new Customer();
                utilityPaymentRequest.Customer.EmailAddr="fatih@codevist.com";
                utilityPaymentRequest.Customer.IPAddress="127.0.0.1";
                
                
                utilityPaymentRequest.Card= new Card();
                utilityPaymentRequest.Card.CVV2=request.getParameter("cvv");
                utilityPaymentRequest.Card.ExpireDate=request.getParameter("expireDate");
                utilityPaymentRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               utilityPaymentRequest.Order= new Order();
               utilityPaymentRequest.Order.OrderID="";
               utilityPaymentRequest.Order.Description="";
               
               
               utilityPaymentRequest.Transaction= new Transaction();
               utilityPaymentRequest.Transaction.Amount=request.getParameter("invoiceAmount");
               utilityPaymentRequest.Transaction.CurrencyCode="949";
               utilityPaymentRequest.Transaction.Type="utilitypayment";
               utilityPaymentRequest.Transaction.MotoInd="H";

               
               utilityPaymentRequest.Transaction.UtilityPayment= new  UtilityPayment();
               utilityPaymentRequest.Transaction.UtilityPayment.SubscriberCode=request.getParameter("subscriberCode");
               utilityPaymentRequest.Transaction.UtilityPayment.InstitutionCode=request.getParameter("institutionCode");
               utilityPaymentRequest.Transaction.UtilityPayment.Amount=request.getParameter("invoiceAmount");
               utilityPaymentRequest.Transaction.UtilityPayment.InvoiceID=request.getParameter("invoiceID");
               
               String utilityPaymentInqResponse = UtilityPaymentRequest.execute(utilityPaymentRequest,settings); //"Fatura Ödeme servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(utilityPaymentInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Fatura Ödeme servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />