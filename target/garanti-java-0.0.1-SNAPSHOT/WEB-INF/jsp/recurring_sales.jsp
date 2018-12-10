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
<h2>Tekrarl� Sat�� </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> Sales<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">�deme Bilgileri</label></legend>
        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Kart Numaras�:</label>
            <div class="col-md-4">
                <input value="4282209027132016" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay/Y�l: </label>
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
            <label class="col-md-4 control-label" for="">  ��lem Tutar�:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Toplam Tekrar Say�s�:</label>
            <div class="col-md-4">
                <input value="2" name="totalPaymentNum" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Tekrar S�kl���: </label>
            <div class="col-md-4">
                <input value="2" name="frequencyInterval" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> S�kl�k Tipi (D/W/M/Y): </label>
            <div class="col-md-4">
                <input value="D" name="frequencyType" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Ba�lang�� Tarihi: </label>
            <div class="col-md-4">
                <input value="20181201" name="startDate" class="form-control input-md" readonly>
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> �deme Yap</button>
        </div>
    </div>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		  Sabit tekrarl� sat�� servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
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
               
               recurringSalesRequest.Order.Recurring.TotalPaymentNum="2";// tekrar say�s� girilir.
               recurringSalesRequest.Order.Recurring.FrequencyInterval="1";// tekrar s�kl���n�n girildi�i aland�r. �r: 2 girilirse type W i�in iki haftada bir anlam�na gelir.
               recurringSalesRequest.Order.Recurring.FrequencyType="M";// tekrar tipi girilir. G�nl�k: D, Haftal�k: W, Ayl�k: M, Y�ll�k: Y
               recurringSalesRequest.Order.Recurring.Type="R"; // de�i�ken tekrarl� i�lem tipi
               recurringSalesRequest.Order.Recurring.StartDate="20181201";// YYYYMMGG
               recurringSalesRequest.Order.Recurring.RecurringRetryAttemptCount = "10"; // red alan i�lemin ka� g�n tekrarlanaca�� bilgisi
               recurringSalesRequest.Order.Recurring.RetryAttemptEmail = "eticaret@garanti.com.tr"; // i�lem durumunun g�nderilece�i adres
              
               
               recurringSalesRequest.Transaction= new Transaction();
               recurringSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               recurringSalesRequest.Transaction.CurrencyCode="949";
               recurringSalesRequest.Transaction.Type="sales";
               recurringSalesRequest.Transaction.MotoInd="H";
         
               String recurringSalesResponse= RecurringSalesRequest.execute(recurringSalesRequest,settings); //Sabit Tekrarl� Sat�� servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(recurringSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Sabit Tekrarl� Sat�� servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
