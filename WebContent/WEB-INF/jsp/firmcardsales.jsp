<%-- 
    Document   : firmcardsales
    Created on : Nov 20, 2018, 12:59:13 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.FirmCardSalesRequest "%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Firma Kartý ile Satýþ </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> firmcardsales<br>
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
                <input value="6072140606442865" name="firmCreditCardNo" class="form-control input-md">
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
		Firma Kart Satýþ servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		FirmCardSalesRequest firmCardSalesRequest = new FirmCardSalesRequest();  

                firmCardSalesRequest.Version=settings.Version;
                firmCardSalesRequest.Mode=settings.Mode;
                
		firmCardSalesRequest.Terminal=new Terminal();
                firmCardSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                firmCardSalesRequest.Terminal.UserID=terminal.UserID;
                firmCardSalesRequest.Terminal.ID="30690168";
                firmCardSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                firmCardSalesRequest.Customer= new Customer();
                firmCardSalesRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                firmCardSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                firmCardSalesRequest.Card= new Card();
                firmCardSalesRequest.Card.CVV2=request.getParameter("cvv");
                firmCardSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                firmCardSalesRequest.Card.Number=request.getParameter("firmCreditCardNo");
                
                
               firmCardSalesRequest.Order= new Order();
               firmCardSalesRequest.Order.OrderID=orderId;
               firmCardSalesRequest.Order.Description="";
               
               
               firmCardSalesRequest.Transaction= new Transaction();
               firmCardSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               firmCardSalesRequest.Transaction.CurrencyCode="949";
               firmCardSalesRequest.Transaction.Type="firmcardsales";
               firmCardSalesRequest.Transaction.MotoInd="N";
    

               
               String firmCardSalesResponse = FirmCardSalesRequest.execute(firmCardSalesRequest,settings); //"Firma Kart Satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(firmCardSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //Firma Kart Satýþ servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />