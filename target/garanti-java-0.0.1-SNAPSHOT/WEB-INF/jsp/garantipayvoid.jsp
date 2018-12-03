<%-- 
    Document   : garantipayvoid
    Created on : Nov 29, 2018, 2:51:26 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.HelperClass.GarantiPayv"%>

<%@page import="garanti.core.Request.GarantiPayVoidRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page import="java.time.*"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<!DOCTYPE html>

<h2>Garanti Pay Ýþlem Ýptali </h2>
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
        <!-- Text input-->

        <div class="form-group">
            <label class="col-md-4 control-label" for="">  OrderID:</label>
            <div class="col-md-4">
                <input value="" name="orderID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  gpID:</label>
            <div class="col-md-4">
                <input value="" name="gpID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="100" name="transactionAmount" class="form-control input-md">
            </div>
        </div>

    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Ýþlem Yap</button>
        </div>
    </div>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		   Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();

		GarantiPayVoidRequest garantiPayVoidRequest = new GarantiPayVoidRequest();  
            garantiPayVoidRequest.Version = settings.Version;
            garantiPayVoidRequest.Mode = settings.Mode;
            
		garantiPayVoidRequest.Terminal=new Terminal();
            garantiPayVoidRequest.Terminal.ProvUserID=terminal.ProvUserID;
                garantiPayVoidRequest.Terminal.UserID=terminal.UserID;
                garantiPayVoidRequest.Terminal.ID=terminal.ID;
                garantiPayVoidRequest.Terminal.MerchantID=terminal.MerchantID;
                         //TODO: ERROR ADRESÝNÝ GÜNCELLE.
             garantiPayVoidRequest.Card= new Card();            
            garantiPayVoidRequest.Card.CVV2="";
            garantiPayVoidRequest.Card.ExpireDate = "";
            garantiPayVoidRequest.Card.Number = "";
            
            garantiPayVoidRequest.Customer= new Customer();

            garantiPayVoidRequest.Customer.EmailAddr = "fatih@codevist.com";
            garantiPayVoidRequest.Customer.IPAddress = "127.0.0.1";
            
            garantiPayVoidRequest.Order= new Order();
            garantiPayVoidRequest.Order.OrderID = request.getParameter("orderID");
            garantiPayVoidRequest.Order.Description ="";
            
            GarantiPayv garantipayv =new GarantiPayv();
            
            garantipayv.GPID=request.getParameter("gpID");
            garantipayv.Status = "E";

            garantiPayVoidRequest.Transaction= new Transaction();
            garantiPayVoidRequest.Transaction.Amount = request.getParameter("transactionAmount");
            garantiPayVoidRequest.Transaction.CurrencyCode="949";
            garantiPayVoidRequest.Transaction.CardholderPresentCode="0";
            garantiPayVoidRequest.Transaction.ReturnServerUrl="";
            garantiPayVoidRequest.Transaction.Type = "garantipaycancel";
            garantiPayVoidRequest.Transaction.MotoInd = "N";
            garantiPayVoidRequest.Transaction.GarantiPayV=garantipayv;
                    
                         
                    
            
                           
                
               String payVoidResponse = GarantiPayVoidRequest.execute(garantiPayVoidRequest,settings); //Sipariþ Detayý servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(payVoidResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>");

                //"Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />