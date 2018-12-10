<%-- 
    Document   : postauth
    Created on : Nov 20, 2018, 3:16:52 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.PostauthRequest "%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Ön Otorizasyon Kapama</h2>
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
            <label class="col-md-4 control-label" for="">  OrderID </label>
            <div class="col-md-4">
                <input value="" name="orderID" class="form-control input-md">
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
		 Ön Otorizasyon Kapama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = UUID.randomUUID().toString().replace("-", "");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		PostauthRequest postauthRequest = new PostauthRequest();  

                postauthRequest.Version=settings.Version;
                postauthRequest.Mode=settings.Mode;
                
		postauthRequest.Terminal=new Terminal();
                postauthRequest.Terminal.ProvUserID=terminal.ProvUserID;
                postauthRequest.Terminal.UserID=terminal.UserID;
                postauthRequest.Terminal.ID=terminal.ID;
                postauthRequest.Terminal.MerchantID=terminal.MerchantID;
                
                postauthRequest.Customer= new Customer();
                postauthRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                postauthRequest.Customer.IPAddress="127.0.0.1";
                
                
                postauthRequest.Card= new Card();
                postauthRequest.Card.CVV2=request.getParameter("cvv");
                postauthRequest.Card.ExpireDate=request.getParameter("expireDate");
                postauthRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               postauthRequest.Order= new Order();
               postauthRequest.Order.OrderID=request.getParameter("orderID");
               postauthRequest.Order.Description="";
               
               
               postauthRequest.Transaction= new Transaction();
               postauthRequest.Transaction.Amount=request.getParameter("transactionAmount");
               postauthRequest.Transaction.CurrencyCode="949";
               postauthRequest.Transaction.Type="postauth";
               postauthRequest.Transaction.MotoInd="N";
               
               
               
               String postauthResponse = PostauthRequest.execute(postauthRequest,settings); //"Ön Otorizasyon Kapama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(postauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ön Otorizasyon Kapama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />