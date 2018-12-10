<%-- 
    Document   : commercial_cardlimitinq
    Created on : Nov 19, 2018, 6:28:41 PM
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
<%@page import="garanti.core.Request.CommercialCardLimitInqRequest"%>


<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Ortak Kart Limit Sorgulama </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> commercialcardlimitinq<br>
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
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
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
		   Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		CommercialCardLimitInqRequest commercialCardLimitInqRequest = new CommercialCardLimitInqRequest();  

                commercialCardLimitInqRequest.Version=settings.Version;
                commercialCardLimitInqRequest.Mode=settings.Mode;
                
		commercialCardLimitInqRequest.Terminal=new Terminal();
                commercialCardLimitInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                commercialCardLimitInqRequest.Terminal.UserID=terminal.UserID;
                commercialCardLimitInqRequest.Terminal.ID=terminal.ID;
                commercialCardLimitInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                commercialCardLimitInqRequest.Customer= new Customer();
                commercialCardLimitInqRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                commercialCardLimitInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                commercialCardLimitInqRequest.Card= new Card();
                commercialCardLimitInqRequest.Card.CVV2=request.getParameter("cvv");
                commercialCardLimitInqRequest.Card.ExpireDate=request.getParameter("expireDate");
                commercialCardLimitInqRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               commercialCardLimitInqRequest.Order= new Order();
               commercialCardLimitInqRequest.Order.OrderID="";
               commercialCardLimitInqRequest.Order.Description="";
               
               
               commercialCardLimitInqRequest.Transaction= new Transaction();
               commercialCardLimitInqRequest.Transaction.Amount=request.getParameter("transactionAmount");
               commercialCardLimitInqRequest.Transaction.CurrencyCode="949";
               commercialCardLimitInqRequest.Transaction.Type="commercialcardlimitinq";
               commercialCardLimitInqRequest.Transaction.MotoInd="H";
               commercialCardLimitInqRequest.Transaction.CardholderPresentCode="0";
               
               
               String commercialCardLimitInqResponse = CommercialCardLimitInqRequest.execute(commercialCardLimitInqRequest,settings); //"Ortak Kart Limit Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(commercialCardLimitInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ortak Kart Limit Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />