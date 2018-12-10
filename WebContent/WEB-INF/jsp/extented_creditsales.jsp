<%-- 
    Document   : extented_creditsales
    Created on : Nov 20, 2018, 3:00:41 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings3D"%>
<%@page import="garanti.core.Request.Sale3DPayRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.time.*"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Tüketici Kredisi </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Ýþlem Bilgileri</label></legend>
    <label style="font-weight:bold;">Ýþlem Tipi &nbsp; :   &nbsp; </label> extendedcredit<br>
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
                <input value="4282209004348015" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay: </label>
            <div class="col-md-4">
                <input value="08" name="expireMonth" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Yýl: </label>
            <div class="col-md-4">
                <input value="22" name="expireYear" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  CVC: </label>
            <div class="col-md-4">
                <input value="123" name="cvv" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Taksit Sayýsý: </label>
            <div class="col-md-4">
                <input value="" name="installmentCount" class="form-control input-md">
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
		   Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings3D settings3D = new Settings3D();
		
		Sale3DPayRequest sale3DPayRequest = new Sale3DPayRequest();  
            sale3DPayRequest.apiversion = settings3D.apiversion;
            sale3DPayRequest.mode = settings3D.mode;
            sale3DPayRequest.terminalid = "30691299";
            sale3DPayRequest.terminaluserid = "PROVAUT";
            sale3DPayRequest.terminalprovuserid = "PROVAUT";
            sale3DPayRequest.terminalmerchantid = "7000679";
            //TODO: ERROR ADRESÝNÝ GÜNCELLE.
            sale3DPayRequest.successurl = "http://localhost:8084/garanti-java/oossuccess.htm";
            sale3DPayRequest.errorurl = "http://localhost:8084/garanti-java/ooserror.htm";
            sale3DPayRequest.customeremailaddress = "eticaret@garanti.com.tr";
            sale3DPayRequest.customeripaddress = "127.0.0.1";
            sale3DPayRequest.secure3dsecuritylevel = "CUSTOM_PAY";
            sale3DPayRequest.orderid = request.getParameter("orderID");
            sale3DPayRequest.txnamount = request.getParameter("transactionAmount");
            sale3DPayRequest.txntype = "extendedcredit";
            sale3DPayRequest.txninstallmentcount = request.getParameter("installmentCount");;
            sale3DPayRequest.txncurrencycode = "949";
            sale3DPayRequest.storekey = "12345678";
            sale3DPayRequest.txntimestamp = Instant.now().toString();
            sale3DPayRequest.cardnumber = request.getParameter("creditCardNo");
            sale3DPayRequest.cardexpiredatemonth = request.getParameter("expireMonth");
            sale3DPayRequest.cardexpiredateyear = request.getParameter("expireYear");
            sale3DPayRequest.cardcvv2 = request.getParameter("cvv");
            
            
            
                           
                
               String form = Sale3DPayRequest.execute(sale3DPayRequest,settings3D); //"Tarih aralýðý ile Ýþlem Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               		out.println(form);

                //"Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />