<%-- 
    Document   : garantipay
    Created on : Nov 29, 2018, 2:21:06 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings3D"%>
<%@page import="garanti.core.Request.GarantiPayRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.time.*"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<!DOCTYPE html>
<h2>GarantiPay Satýþ </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> Sales<br>
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
		
		GarantiPayRequest garantiPayRequest = new GarantiPayRequest();  
            garantiPayRequest.apiversion = settings3D.apiversion;
            garantiPayRequest.mode = settings3D.mode;
             garantiPayRequest.terminalid = "30690133";
            garantiPayRequest.terminaluserid = "PROVOOS";
            garantiPayRequest.terminalprovuserid = "PROVOOS";
            garantiPayRequest.terminalmerchantid = "3424113";
            //TODO: ERROR ADRESÝNÝ GÜNCELLE.
            garantiPayRequest.successurl = "http://localhost:8084/garanti-java/garantipaysuccess.htm";
            garantiPayRequest.errorurl = "http://localhost:8084/garanti-java/garantipayerror.htm";
            garantiPayRequest.customeremailaddress = "fatih@codevist.com";
            garantiPayRequest.customeripaddress = "127.0.0.1";
            garantiPayRequest.secure3dsecuritylevel = "CUSTOM_PAY";
            garantiPayRequest.orderid = request.getParameter("orderID");
            garantiPayRequest.txnamount = request.getParameter("transactionAmount");
            garantiPayRequest.txntype = "gpdatarequest";
            garantiPayRequest.txnsubtype = "sales";
            garantiPayRequest.txninstallmentcount = "";
            garantiPayRequest.totallinstallmentcount = "2";
            garantiPayRequest.installmentamount1 = "110";
            garantiPayRequest.installmentamount2 = "120";
            garantiPayRequest.installmentnumber1 = "2";
            garantiPayRequest.installmentnumber2 = "3";
            garantiPayRequest.bnsuseflag = "N";
            garantiPayRequest.chequeuseflag = "N";
            garantiPayRequest.fbbuseflag = "N";
            garantiPayRequest.garantipay = "Y";
            garantiPayRequest.txntimeoutperiod = "300";
            garantiPayRequest.installmentratewithreward1 = "1000";
            garantiPayRequest.installmentratewithreward2 = "2000";
            garantiPayRequest.companyname = "DENEME";
            garantiPayRequest.txncurrencycode = "949";
            garantiPayRequest.storekey = "12345678";
            garantiPayRequest.txntimestamp = Instant.now().toString();
            garantiPayRequest.lang = "tr";
            garantiPayRequest.refreshtime = "1";
            
            
                           
                
               String form = GarantiPayRequest.execute(garantiPayRequest,settings3D); //"Tarih aralýðý ile Ýþlem Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               		out.println(form);

                //"Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />