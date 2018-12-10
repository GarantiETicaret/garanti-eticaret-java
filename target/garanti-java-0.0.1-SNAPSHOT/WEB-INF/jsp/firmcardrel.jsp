<%-- 
    Document   : firmcardrel
    Created on : Nov 20, 2018, 2:13:30 PM
    Author     : Codevist
--%>


<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.FirmCardRelRequest "%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Firma Kart Eþleþtirme </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> firmcardrel<br>
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
            <label class="col-md-4 control-label" for=""> Firma Kart Numarasý:</label>
            <div class="col-md-4">
                <input value="6072140039194927" name="firmCardNo" class="form-control input-md">
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Eþleþtir</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		Firma Kart eþleþtirme servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = UUID.randomUUID().toString().replace("-", "");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		FirmCardRelRequest firmCardRelRequest = new FirmCardRelRequest();  

                firmCardRelRequest.Version=settings.Version;
                firmCardRelRequest.Mode=settings.Mode;
                
		firmCardRelRequest.Terminal=new Terminal();
                firmCardRelRequest.Terminal.ProvUserID=terminal.ProvUserID;
                firmCardRelRequest.Terminal.UserID=terminal.UserID;
                firmCardRelRequest.Terminal.ID="30690168";
                firmCardRelRequest.Terminal.MerchantID=terminal.MerchantID;
                
                firmCardRelRequest.Customer= new Customer();
                firmCardRelRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                firmCardRelRequest.Customer.IPAddress="127.0.0.1";
                
                
                firmCardRelRequest.Card= new Card();
                firmCardRelRequest.Card.CVV2=request.getParameter("cvv");
                firmCardRelRequest.Card.ExpireDate=request.getParameter("expireDate");
                firmCardRelRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               firmCardRelRequest.Order= new Order();
               firmCardRelRequest.Order.OrderID="";
               firmCardRelRequest.Order.Description="";
               
               
               firmCardRelRequest.Transaction= new Transaction();
               firmCardRelRequest.Transaction.Amount="1";
               firmCardRelRequest.Transaction.CurrencyCode="949";
               firmCardRelRequest.Transaction.Type="firmcardrel";
               firmCardRelRequest.Transaction.MotoInd="H";
               firmCardRelRequest.Transaction.FirmCardNo=request.getParameter("firmCardNo");
    

               
               String firmCardRelResponse = FirmCardRelRequest.execute(firmCardRelRequest,settings); //"Firma Kart Eþleþtirme servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(firmCardRelResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //Firma Kart Eþleþtirme servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />