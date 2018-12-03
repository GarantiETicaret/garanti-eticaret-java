<%-- 
    Document   : dcc_inquiry
    Created on : Nov 19, 2018, 6:50:24 PM
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
<%@page import="garanti.core.Request.DccInquiryRequest"%>


<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>DCC Sorgulama </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> dccinq<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30690133 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 3424113 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">Sorgulama Bilgileri</label></legend>
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
            <button type="submit" id="" name="" class="btn btn-danger"> Sorgulama Yap</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		  DCC Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		DccInquiryRequest dccInquiryRequest = new DccInquiryRequest();  

                dccInquiryRequest.Version=settings.Version;
                dccInquiryRequest.Mode=settings.Mode;
                
		dccInquiryRequest.Terminal=new Terminal();
                dccInquiryRequest.Terminal.ProvUserID=terminal.ProvUserID;
                dccInquiryRequest.Terminal.UserID=terminal.UserID;
                dccInquiryRequest.Terminal.ID=terminal.ID;
                dccInquiryRequest.Terminal.MerchantID=terminal.MerchantID;
                
                dccInquiryRequest.Customer= new Customer();
                dccInquiryRequest.Customer.EmailAddr="fatih@codevist.com";
                dccInquiryRequest.Customer.IPAddress="127.0.0.1";
                
                
                dccInquiryRequest.Card= new Card();
                dccInquiryRequest.Card.CVV2=request.getParameter("cvv");
                dccInquiryRequest.Card.ExpireDate=request.getParameter("expireDate");
                dccInquiryRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               dccInquiryRequest.Order= new Order();
               dccInquiryRequest.Order.OrderID=request.getParameter("orderID");
               dccInquiryRequest.Order.Description="";
               
               
               dccInquiryRequest.Transaction= new Transaction();
               dccInquiryRequest.Transaction.Amount=request.getParameter("transactionAmount");
               dccInquiryRequest.Transaction.CurrencyCode="949";
               dccInquiryRequest.Transaction.Type="dccinq";
               dccInquiryRequest.Transaction.MotoInd="H";
               dccInquiryRequest.Transaction.CardholderPresentCode="0";
               
               
               String extendedCreditInquiryResponse = DccInquiryRequest.execute(dccInquiryRequest,settings); //"DCC Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(extendedCreditInquiryResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"DCC Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
