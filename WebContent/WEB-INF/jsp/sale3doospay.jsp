<%-- 
    Document   : sale3doospay
    Created on : Nov 27, 2018, 4:07:14 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings3D"%>
<%@page import="garanti.core.Request.Sale3DOOSPayRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.time.*"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>3D OOS Pay Satýþ</h2>
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
            <br />
            <label class="col-md-4 control-label" for=""> Ödeme Tipi :</label>
            <div class="col-md-4">
                <select name="secure3dsecuritylevel">
                    <option value="3D_OOS_PAY">3D_OOS_PAY</option>
                    <option value="3D_OOS_FULL">3D_OOS_FULL</option>
                    <option value="3D_OOS_HALF">3D_OOS_HALF</option>
                </select>
            </div>
        </div>
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
		
		Sale3DOOSPayRequest sale3DOOSPayRequest = new Sale3DOOSPayRequest();  
            sale3DOOSPayRequest.apiversion = settings3D.apiversion;
            sale3DOOSPayRequest.mode = settings3D.mode;
            sale3DOOSPayRequest.terminalid = "30691299";
            sale3DOOSPayRequest.terminaluserid = "PROVOOS";
            sale3DOOSPayRequest.terminalprovuserid = "PROVOOS";
            sale3DOOSPayRequest.terminalmerchantid = "7000679";
            //TODO: ERROR ADRESÝNÝ GÜNCELLE.
            sale3DOOSPayRequest.successurl = "http://localhost:8084/garanti-java/oossuccess.htm";
            sale3DOOSPayRequest.errorurl = "http://localhost:8084/garanti-java/ooserror.htm";
            sale3DOOSPayRequest.customeremailaddress = "fatih@codevist.com";
            sale3DOOSPayRequest.customeripaddress = "127.0.0.1";
            sale3DOOSPayRequest.secure3dsecuritylevel = request.getParameter("secure3dsecuritylevel");
            sale3DOOSPayRequest.orderid = request.getParameter("orderID");
            sale3DOOSPayRequest.txnamount = request.getParameter("transactionAmount");
            sale3DOOSPayRequest.txntype = "sales";
            sale3DOOSPayRequest.txninstallmentcount = "";
            sale3DOOSPayRequest.txncurrencycode = "949";
            sale3DOOSPayRequest.storekey = "12345678";
            sale3DOOSPayRequest.txntimestamp = Instant.now().toString();
            sale3DOOSPayRequest.cardnumber = request.getParameter("creditCardNo");
            sale3DOOSPayRequest.cardexpiredatemonth = request.getParameter("expireMonth");
            sale3DOOSPayRequest.cardexpiredateyear = request.getParameter("expireYear");
            sale3DOOSPayRequest.cardcvv2 = request.getParameter("cvv");
            sale3DOOSPayRequest.lang = "tr";
            sale3DOOSPayRequest.refreshtime = "5";
            
            
                           
                
               String form = Sale3DOOSPayRequest.execute(sale3DOOSPayRequest,settings3D); //"3D OOS Ödeme servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               out.println(form);//"3D OOS Ödeme servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"

                
	}
%>

<jsp:include page="footer.jsp" />