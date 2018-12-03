<%-- 
    Document   : utility_paymentinq
    Created on : Nov 19, 2018, 7:01:27 PM
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
<%@page import="garanti.core.Request.UtilityPaymentInqRequest"%>
<%@page import="garanti.core.HelperClass.UtilityPaymentInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Fatura Sorgulama </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> utilitypaymentinq<br>
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
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Sorgulama Yap</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		  Fatura Sorgulamaservis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		UtilityPaymentInqRequest utilityPaymentInqRequest = new UtilityPaymentInqRequest();  

                utilityPaymentInqRequest.Version=settings.Version;
                utilityPaymentInqRequest.Mode=settings.Mode;
                
		utilityPaymentInqRequest.Terminal=new Terminal();
                utilityPaymentInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                utilityPaymentInqRequest.Terminal.UserID=terminal.UserID;
                utilityPaymentInqRequest.Terminal.ID=terminal.ID;
                utilityPaymentInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                utilityPaymentInqRequest.Customer= new Customer();
                utilityPaymentInqRequest.Customer.EmailAddr="fatih@codevist.com";
                utilityPaymentInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                utilityPaymentInqRequest.Card= new Card();
                utilityPaymentInqRequest.Card.CVV2=request.getParameter("cvv");
                utilityPaymentInqRequest.Card.ExpireDate=request.getParameter("expireDate");
                utilityPaymentInqRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               utilityPaymentInqRequest.Order= new Order();
               utilityPaymentInqRequest.Order.OrderID="";
               utilityPaymentInqRequest.Order.Description="";
               
               
               utilityPaymentInqRequest.Transaction= new Transaction();
               utilityPaymentInqRequest.Transaction.Amount="100";
               utilityPaymentInqRequest.Transaction.CurrencyCode="949";
               utilityPaymentInqRequest.Transaction.Type="utilitypaymentinq";
               utilityPaymentInqRequest.Transaction.MotoInd="H";

               
               utilityPaymentInqRequest.Transaction.UtilityPaymentInq= new  UtilityPaymentInq();
               utilityPaymentInqRequest.Transaction.UtilityPaymentInq.SubscriberCode=request.getParameter("subscriberCode");
               utilityPaymentInqRequest.Transaction.UtilityPaymentInq.InstitutionCode=request.getParameter("institutionCode");
               
               
               
               String utilityPaymentInqResponse = UtilityPaymentInqRequest.execute(utilityPaymentInqRequest,settings); //"Fatura Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(utilityPaymentInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Fatura Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
