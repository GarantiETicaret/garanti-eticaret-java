<%-- 
    Document   : extended_creditinquiry
    Created on : Nov 19, 2018, 6:09:57 PM
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
<%@page import="garanti.core.Request.ExtendedCreditInquiryRequest"%>


<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>T�ketici Kredisi Sorgulama </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> extendedcreditinq<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">Sorgulama Bilgileri</label></legend>
        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Kart Numaras�:</label>
            <div class="col-md-4">
                <input value="4282209027132016" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay/Y�l: </label>
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
            <label class="col-md-4 control-label" for="">  Taksit Say�s�: </label>
            <div class="col-md-4">
                <input value="" name="installmentCnt" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  ��lem Tutar�:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
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
		   Tarih aral��� ile ��lem Sorgulama servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		ExtendedCreditInquiryRequest extendedCreditInquiryRequest = new ExtendedCreditInquiryRequest();  

                extendedCreditInquiryRequest.Version=settings.Version;
                extendedCreditInquiryRequest.Mode=settings.Mode;
                
		extendedCreditInquiryRequest.Terminal=new Terminal();
                extendedCreditInquiryRequest.Terminal.ProvUserID=terminal.ProvUserID;
                extendedCreditInquiryRequest.Terminal.UserID=terminal.UserID;
                extendedCreditInquiryRequest.Terminal.ID=terminal.ID;
                extendedCreditInquiryRequest.Terminal.MerchantID=terminal.MerchantID;
                
                extendedCreditInquiryRequest.Customer= new Customer();
                extendedCreditInquiryRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                extendedCreditInquiryRequest.Customer.IPAddress="127.0.0.1";
                
                
                extendedCreditInquiryRequest.Card= new Card();
                extendedCreditInquiryRequest.Card.CVV2=request.getParameter("cvv");
                extendedCreditInquiryRequest.Card.ExpireDate=request.getParameter("expireDate");
                extendedCreditInquiryRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               extendedCreditInquiryRequest.Order= new Order();
               extendedCreditInquiryRequest.Order.OrderID="";
               extendedCreditInquiryRequest.Order.Description="";
               
               
               extendedCreditInquiryRequest.Transaction= new Transaction();
               extendedCreditInquiryRequest.Transaction.Amount="100";
               extendedCreditInquiryRequest.Transaction.CurrencyCode="949";
               extendedCreditInquiryRequest.Transaction.Type="extendedcreditinq";
               extendedCreditInquiryRequest.Transaction.MotoInd="H";
               extendedCreditInquiryRequest.Transaction.CardholderPresentCode="0";
               extendedCreditInquiryRequest.Transaction.InstallmentCnt=request.getParameter("installmentCnt");
               
               
               String extendedCreditInquiryResponse = ExtendedCreditInquiryRequest.execute(extendedCreditInquiryRequest,settings); //"T�ketici Kredisi Sorgulama servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(extendedCreditInquiryResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"T�ketici Kredisi Sorgulama servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
