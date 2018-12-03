<%-- 
    Document   : downpayment_sales
    Created on : Nov 20, 2018, 4:42:16 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.DownPaymentSalesRequest"%>

<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Peþinatlý Satýþ </h2>
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
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Taksit Sayýsý:</label>
            <div class="col-md-4">
                <input value="" name="installmentCnt" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Peþinat Oraný:</label>
            <div class="col-md-4">
                <input value="" name="downPaymentRate" class="form-control input-md">
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
		  Peþinatlý Satýþ  servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		DownPaymentSalesRequest downPaymentSalesRequest = new DownPaymentSalesRequest();  

                downPaymentSalesRequest.Version=settings.Version;
                downPaymentSalesRequest.Mode=settings.Mode;
                
		downPaymentSalesRequest.Terminal=new Terminal();
                downPaymentSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                downPaymentSalesRequest.Terminal.UserID=terminal.UserID;
                downPaymentSalesRequest.Terminal.ID=terminal.ID;
                downPaymentSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                downPaymentSalesRequest.Customer= new Customer();
                downPaymentSalesRequest.Customer.EmailAddr="fatih@codevist.com";
                downPaymentSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                downPaymentSalesRequest.Card= new Card();
                downPaymentSalesRequest.Card.CVV2=request.getParameter("cvv");
                downPaymentSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                downPaymentSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               downPaymentSalesRequest.Order= new Order();
               downPaymentSalesRequest.Order.OrderID=orderId;
               downPaymentSalesRequest.Order.Description="";
               
               
               downPaymentSalesRequest.Transaction= new Transaction();
               downPaymentSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               downPaymentSalesRequest.Transaction.CurrencyCode="949";
               downPaymentSalesRequest.Transaction.Type="sales";
               downPaymentSalesRequest.Transaction.MotoInd="N";
               downPaymentSalesRequest.Transaction.DownPaymentRate=request.getParameter("downPaymentRate");
               downPaymentSalesRequest.Transaction.InstallmentCnt=request.getParameter("installmentCnt");
               
               String downPaymentSalesResponse = DownPaymentSalesRequest.execute(downPaymentSalesRequest,settings); //"Peþinatlý Satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(downPaymentSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Peþinatlý Satýþ servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
