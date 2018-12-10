<%-- 
    Document   : firmcardpreauth
    Created on : Nov 20, 2018, 12:47:49 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.FirmCardPreauthRequest "%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Firma Card Ön Otorizasyon </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> firmcardpreauth<br>
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
            <label class="col-md-4 control-label" for=""> Firma Kart Numarasý:</label>
            <div class="col-md-4">
                <input value="6072140606442865" name="creditCardNo" class="form-control input-md">
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
            <button type="submit" id="" name="" class="btn btn-danger"> Otorizasyon </button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		Firma Card Ön Otorizasyon servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		FirmCardPreauthRequest firmCardPreauthRequest = new FirmCardPreauthRequest();  

                firmCardPreauthRequest.Version=settings.Version;
                firmCardPreauthRequest.Mode=settings.Mode;
                
		firmCardPreauthRequest.Terminal=new Terminal();
                firmCardPreauthRequest.Terminal.ProvUserID=terminal.ProvUserID;
                firmCardPreauthRequest.Terminal.UserID=terminal.UserID;
                firmCardPreauthRequest.Terminal.ID="30690168";
                firmCardPreauthRequest.Terminal.MerchantID=terminal.MerchantID;
                
                firmCardPreauthRequest.Customer= new Customer();
                firmCardPreauthRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                firmCardPreauthRequest.Customer.IPAddress="127.0.0.1";
                
                
                firmCardPreauthRequest.Card= new Card();
                firmCardPreauthRequest.Card.CVV2="";
                firmCardPreauthRequest.Card.ExpireDate="";
                firmCardPreauthRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               firmCardPreauthRequest.Order= new Order();
               firmCardPreauthRequest.Order.OrderID=orderId;
               firmCardPreauthRequest.Order.Description="";
               
               
               firmCardPreauthRequest.Transaction= new Transaction();
               firmCardPreauthRequest.Transaction.Amount=request.getParameter("transactionAmount");
               firmCardPreauthRequest.Transaction.CurrencyCode="949";
               firmCardPreauthRequest.Transaction.Type="firmcardpreauth";
               firmCardPreauthRequest.Transaction.MotoInd="N";
    

               
               String firmCardPreauthResponse = FirmCardPreauthRequest.execute(firmCardPreauthRequest,settings); //"Firma Card Ön Otorizasyon servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(firmCardPreauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Firma Card Ön Otorizasyon servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
