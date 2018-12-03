<%-- 
    Document   : gsmunit_sales
    Created on : Nov 20, 2018, 9:32:09 AM
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
<%@page import="garanti.core.Request.GsmUnitSalesRequest"%>
<%@page import="garanti.core.HelperClass.GSMUnitSales"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>GSM TL Ödeme </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> gsmunitsales<br>
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
            <label class="col-md-4 control-label" for="">  Abone Kodu:</label>
            <div class="col-md-4">
                <input value="0001" name="subscriberCode" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Kurum Kodu: </label>
            <div class="col-md-4">
                <input value="1" name="institutionCode" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Yükleme Yapýlacak Telefon Numarasý: </label>
            <div class="col-md-4">
                <input value="12" name="unitID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Paket Bilgisi (TL miktarý): </label>
            <div class="col-md-4">
                <input value="12" name="quantity" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Fatura Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="invoiceAmount" class="form-control input-md">
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
		 GSM TL Ödeme servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		GsmUnitSalesRequest gsmUnitSalesRequest = new GsmUnitSalesRequest();  

                gsmUnitSalesRequest.Version=settings.Version;
                gsmUnitSalesRequest.Mode=settings.Mode;
                
		gsmUnitSalesRequest.Terminal=new Terminal();
                gsmUnitSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                gsmUnitSalesRequest.Terminal.UserID=terminal.UserID;
                gsmUnitSalesRequest.Terminal.ID=terminal.ID;
                gsmUnitSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                gsmUnitSalesRequest.Customer= new Customer();
                gsmUnitSalesRequest.Customer.EmailAddr="fatih@codevist.com";
                gsmUnitSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                gsmUnitSalesRequest.Card= new Card();
                gsmUnitSalesRequest.Card.CVV2=request.getParameter("cvv");
                gsmUnitSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                gsmUnitSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               gsmUnitSalesRequest.Order= new Order();
               gsmUnitSalesRequest.Order.OrderID="";
               gsmUnitSalesRequest.Order.Description="";
               
               
               gsmUnitSalesRequest.Transaction= new Transaction();
               gsmUnitSalesRequest.Transaction.Amount=request.getParameter("invoiceAmount");
               gsmUnitSalesRequest.Transaction.CurrencyCode="949";
               gsmUnitSalesRequest.Transaction.Type="gsmunitsales";
               gsmUnitSalesRequest.Transaction.MotoInd="H";

               
               gsmUnitSalesRequest.Transaction.GSMUnitSales= new GSMUnitSales();
               gsmUnitSalesRequest.Transaction.GSMUnitSales.SubscriberCode=request.getParameter("subscriberCode");
               gsmUnitSalesRequest.Transaction.GSMUnitSales.InstitutionCode=request.getParameter("institutionCode");
               gsmUnitSalesRequest.Transaction.GSMUnitSales.Quantity=request.getParameter("quantity");
               gsmUnitSalesRequest.Transaction.GSMUnitSales.UnitID=request.getParameter("unitID");
               gsmUnitSalesRequest.Transaction.GSMUnitSales.Amount=request.getParameter("invoiceAmount");
                
               String gsmUnitSalesResponse = GsmUnitSalesRequest.execute(gsmUnitSalesRequest,settings); //"GSM TL Ödeme servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(gsmUnitSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"GSM TL Ödeme servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />