<%-- 
    Document   : cardtxnlistinq
    Created on : Nov 19, 2018, 5:28:32 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.CardtxnListInqRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Kredi Kartý ile Ýþlem Sorgulama</h2>
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
        <legend><label style="font-weight:bold;width:250px;">Sorgulama Bilgileri</label></legend>
        <!-- Text input-->

        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Kredi Kartý Numaarsý:</label>
            <div class="col-md-4">
                <input value="" name="creditCard" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Baþlangýç Tarihi:</label>
            <div class="col-md-4">
                <input value="06/11/2018 08:00" name="startDate" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Bitiþ Tarihi:</label>
            <div class="col-md-4">
                <input value="07/11/2018 08:00" name="endDate" class="form-control input-md">
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Sorgulama Yap</button>
        </div>
    </div>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		 Kredi Kartý ile Ýþlem Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		CardtxnListInqRequest cardtxnListInqRequest = new CardtxnListInqRequest();  

                cardtxnListInqRequest.Version=settings.Version;
                cardtxnListInqRequest.Mode=settings.Mode;
                
		cardtxnListInqRequest.Terminal=new Terminal();
                cardtxnListInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                cardtxnListInqRequest.Terminal.UserID=terminal.UserID;
                cardtxnListInqRequest.Terminal.ID=terminal.ID;
                cardtxnListInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                cardtxnListInqRequest.Customer= new Customer();
                cardtxnListInqRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                cardtxnListInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                cardtxnListInqRequest.Card= new Card();
                cardtxnListInqRequest.Card.CVV2="";
                cardtxnListInqRequest.Card.ExpireDate="";
                cardtxnListInqRequest.Card.Number=request.getParameter("creditCard");
                
                
               cardtxnListInqRequest.Order= new Order();
               cardtxnListInqRequest.Order.OrderID="";
               cardtxnListInqRequest.Order.Description="";
               cardtxnListInqRequest.Order.StartDate=request.getParameter("startDate");
               cardtxnListInqRequest.Order.EndDate=request.getParameter("endDate");
               cardtxnListInqRequest.Order.ListPageNum="1";
                
               
               cardtxnListInqRequest.Transaction= new Transaction();
               cardtxnListInqRequest.Transaction.Amount="100";
               cardtxnListInqRequest.Transaction.CurrencyCode="949";
               cardtxnListInqRequest.Transaction.Type="orderlistinq";
               
                
               String cardtxnListInqResponse = CardtxnListInqRequest.execute(cardtxnListInqRequest,settings); //"Kredi Kartý ile Ýþlem Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(cardtxnListInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Kredi Kartý ile Ýþlem Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
