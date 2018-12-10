<%-- 
    Document   : sale3dsecure
    Created on : Nov 27, 2018, 2:04:49 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings3D"%>
<%@page import="garanti.core.Request.Sale3DSecureRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.time.*"%>

<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>3D Satýþ </h2>
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
		  Bonus Kullanýmý Satýþ servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings3D settings3D = new Settings3D();
		
		Sale3DSecureRequest sale3DSecureRequest = new Sale3DSecureRequest();  

                sale3DSecureRequest.apiversion=settings3D.apiversion;
                sale3DSecureRequest.mode=settings3D.mode;
                
		sale3DSecureRequest.terminalid = "30691297";
                sale3DSecureRequest.terminaluserid = "PROVAUT";
                sale3DSecureRequest.terminalprovuserid = "PROVAUT";
                sale3DSecureRequest.terminalmerchantid = "7000679";
                
                sale3DSecureRequest.successurl = "http://localhost:8084/garanti-java/success.htm";
                sale3DSecureRequest.errorurl = "http://localhost:8084/garanti-java/error.htm";
                sale3DSecureRequest.customeremailaddress = "eticaret@garanti.com.tr";
                
                
                sale3DSecureRequest.customeripaddress = "127.0.0.1";
                sale3DSecureRequest.secure3dsecuritylevel = "3D";
                sale3DSecureRequest.orderid = request.getParameter("orderID");
                sale3DSecureRequest.txnamount = request.getParameter("transactionAmount");
                
                
                sale3DSecureRequest.txntype = "sales";
                sale3DSecureRequest.txninstallmentcount = "";
                sale3DSecureRequest.txncurrencycode = "949";
             
              
               
                sale3DSecureRequest.storekey = "12345678";
                sale3DSecureRequest.txntimestamp =Instant.now().toString();
                sale3DSecureRequest.cardnumber = request.getParameter("creditCardNo");
                sale3DSecureRequest.cardexpiredatemonth = request.getParameter("expireMonth");
                sale3DSecureRequest.cardexpiredateyear = request.getParameter("expireYear");
                sale3DSecureRequest.cardcvv2 = request.getParameter("cvv");

                sale3DSecureRequest.lang = "tr";
                sale3DSecureRequest.refreshtime = "5";               
               
               
         
                String form= Sale3DSecureRequest.execute(sale3DSecureRequest,settings3D); //3D Secure Ýþlem servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
                out.println(form);//"3D Secure Ýþlem servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />


