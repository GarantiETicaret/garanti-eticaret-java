<%-- 
    Document   : recurring_sales
    Created on : Nov 20, 2018, 11:28:54 AM
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
<%@page import="garanti.core.Request.RecurringSalesRequest "%>
<%@page import="garanti.core.HelperClass.Recurring"%>
<%@page import="garanti.core.HelperClass.Payment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Tekrarlý Satýþ </h2>
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
            <label class="col-md-4 control-label" for="">  Toplam Tekrar Sayýsý:</label>
            <div class="col-md-4">
                <input value="2" name="totalPaymentNum" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Tekrar Sýklýðý: </label>
            <div class="col-md-4">
                <input value="2" name="frequencyInterval" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Sýklýk Tipi (D/W/M/Y): </label>
            <div class="col-md-4">
                <input value="D" name="frequencyType" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Baþlangýç Tarihi: </label>
            <div class="col-md-4">
                <input value="20181201" name="startDate" class="form-control input-md" readonly>
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
		  Sabit tekrarlý satýþ servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		RecurringSalesRequest recurringSalesRequest = new RecurringSalesRequest();  

                recurringSalesRequest.Version=settings.Version;
                recurringSalesRequest.Mode=settings.Mode;
                
		recurringSalesRequest.Terminal=new Terminal();
                recurringSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                recurringSalesRequest.Terminal.UserID=terminal.UserID;
                recurringSalesRequest.Terminal.ID=terminal.ID;
                recurringSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                recurringSalesRequest.Customer= new Customer();
                recurringSalesRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                recurringSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                recurringSalesRequest.Card= new Card();
                recurringSalesRequest.Card.CVV2=request.getParameter("cvv");
                recurringSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                recurringSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               recurringSalesRequest.Order= new Order();
               recurringSalesRequest.Order.OrderID=orderId;
               recurringSalesRequest.Order.Description="";
               recurringSalesRequest.Order.Recurring= new Recurring();
               
               recurringSalesRequest.Order.Recurring.TotalPaymentNum="2";// tekrar sayýsý girilir.
               recurringSalesRequest.Order.Recurring.FrequencyInterval="1";// tekrar sýklýðýnýn girildiði alandýr. Ör: 2 girilirse type W için iki haftada bir anlamýna gelir.
               recurringSalesRequest.Order.Recurring.FrequencyType="M";// tekrar tipi girilir. Günlük: D, Haftalýk: W, Aylýk: M, Yýllýk: Y
               recurringSalesRequest.Order.Recurring.Type="R"; // deðiþken tekrarlý iþlem tipi
               recurringSalesRequest.Order.Recurring.StartDate="20181201";// YYYYMMGG
               recurringSalesRequest.Order.Recurring.RecurringRetryAttemptCount = "10"; // red alan iþlemin kaç gün tekrarlanacaðý bilgisi
               recurringSalesRequest.Order.Recurring.RetryAttemptEmail = "eticaret@garanti.com.tr"; // iþlem durumunun gönderileceði adres
              
               
               recurringSalesRequest.Transaction= new Transaction();
               recurringSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               recurringSalesRequest.Transaction.CurrencyCode="949";
               recurringSalesRequest.Transaction.Type="sales";
               recurringSalesRequest.Transaction.MotoInd="H";
         
               String recurringSalesResponse= RecurringSalesRequest.execute(recurringSalesRequest,settings); //Sabit Tekrarlý Satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(recurringSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Sabit Tekrarlý Satýþ servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
