<%-- 
    Document   : saleoospay
    Created on : Nov 28, 2018, 7:10:20 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings3D"%>
<%@page import="garanti.core.Request.SaleOOSPayRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.time.*"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<!DOCTYPE html>
<h2>OOS Pay Ödeme Ýþlemi </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> Sales<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVOOS<br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVOOS<br>

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
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi / Ay: </label>
            <div class="col-md-4">
                <input value="08 " name="expireMonth" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi / Yýl: </label>
            <div class="col-md-4">
                <input value="22 " name="expireYear" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  CVC: </label>
            <div class="col-md-4">
                <input value="123" name="cvv" class="form-control input-md">
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
		
            SaleOOSPayRequest saleOOSPayRequest = new SaleOOSPayRequest();  
            saleOOSPayRequest.apiversion = settings3D.apiversion;
            saleOOSPayRequest.mode = settings3D.mode;
            saleOOSPayRequest.terminalid = "30691299";
            saleOOSPayRequest.terminaluserid = "PROVOOS";
            saleOOSPayRequest.terminalprovuserid = "PROVOOS";
            saleOOSPayRequest.terminalmerchantid = "7000679";
            //TODO: ERROR ADRESÝNÝ GÜNCELLE.
            saleOOSPayRequest.successurl = "http://localhost:8084/garanti-java/oossuccess.htm";
            saleOOSPayRequest.errorurl = "http://localhost:8084/garanti-java/ooserror.htm";
            saleOOSPayRequest.customeremailaddress = "fatih@codevist.com";
            saleOOSPayRequest.customeripaddress = "127.0.0.1";
            saleOOSPayRequest.secure3dsecuritylevel = "OOS_PAY";
            saleOOSPayRequest.orderid = request.getParameter("orderID");
            saleOOSPayRequest.txnamount = request.getParameter("transactionAmount");
            saleOOSPayRequest.txntype = "sales";
            saleOOSPayRequest.txninstallmentcount = "";
            saleOOSPayRequest.txncurrencycode = "949";
            saleOOSPayRequest.storekey = "12345678";
            saleOOSPayRequest.txntimestamp = Instant.now().toString();
            saleOOSPayRequest.cardnumber = request.getParameter("creditCardNo");
            saleOOSPayRequest.cardexpiredatemonth = request.getParameter("expireMonth");
            saleOOSPayRequest.cardexpiredateyear = request.getParameter("expireYear");
            saleOOSPayRequest.cardcvv2 = request.getParameter("cvv");
            
            
            
                           
                
            String form = SaleOOSPayRequest.execute(saleOOSPayRequest,settings3D); //"OOS Pay Ödeme servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
            out.println(form);//"OOS Pay Ödeme servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"

                
	}
%>

<jsp:include page="footer.jsp" />