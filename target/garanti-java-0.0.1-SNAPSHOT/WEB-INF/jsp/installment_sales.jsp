<%-- 
    Document   : installment_sales
    Created on : Nov 20, 2018, 5:26:34 PM
    Author     : Codevist
--%>
<%@page import="java.util.UUID"%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.InstallmentSalesRequest"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Taksitli Satýþ</h2>

<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> sales<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">Kart Bilgileriyle Ödeme</label></legend>
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
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
      <div class="form-group">
            <label class="col-md-4 control-label" for="">  OrderID:</label>
            <div class="col-md-4">
                
               <input value= '<%=UUID.randomUUID().toString().replace("-", "")%>'   name="orderID" class="form-control input-md">

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Taksit Sayýsý:</label>
            <div class="col-md-4">
                <input value="2" name="installmentCnt" class="form-control input-md">
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
		  Taksitli satýþ  servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		*/
              
               Settings settings = new Settings();
               Terminal terminal= new Terminal();
		
               InstallmentSalesRequest installmentSalesRequest = new InstallmentSalesRequest();  

               installmentSalesRequest.Version=settings.Version;
               installmentSalesRequest.Mode=settings.Mode;
                
               installmentSalesRequest.Terminal=new Terminal();
               installmentSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
               installmentSalesRequest.Terminal.UserID=terminal.UserID;
               installmentSalesRequest.Terminal.ID=terminal.ID;
               installmentSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
               installmentSalesRequest.Customer= new Customer();
               installmentSalesRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
               installmentSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
               
               installmentSalesRequest.Card= new Card();
               installmentSalesRequest.Card.CVV2=request.getParameter("cvv");
               installmentSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
               installmentSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
               installmentSalesRequest.Order= new Order();
               installmentSalesRequest.Order.OrderID=request.getParameter("orderID");
               installmentSalesRequest.Order.Description="";
               
               installmentSalesRequest.Transaction= new Transaction();
               installmentSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               installmentSalesRequest.Transaction.CurrencyCode="949";
               installmentSalesRequest.Transaction.Type="sales";
               installmentSalesRequest.Transaction.InstallmentCnt=request.getParameter("installmentCnt");
               installmentSalesRequest.Transaction.MotoInd="N";
               
               String installmentSalesResponse = InstallmentSalesRequest.execute(installmentSalesRequest,settings); //Taksitli satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(installmentSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Taksitli satýþ servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
