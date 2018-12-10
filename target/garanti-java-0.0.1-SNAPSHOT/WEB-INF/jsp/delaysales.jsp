<%-- 
    Document   : delaysales
    Created on : Nov 20, 2018, 5:00:55 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.DelaySalesRequest"%>

<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>�temeli Sat�� </h2>
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
            <label class="col-md-4 control-label" for="">  �telenecek G�n say�s�:</label>
            <div class="col-md-4">
                <input value="" name="delayDayCount" class="form-control input-md">
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
		  �telemeli Sat��  servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		*/
                String orderId =  request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		DelaySalesRequest delaySalesRequest = new DelaySalesRequest();  

                delaySalesRequest.Version=settings.Version;
                delaySalesRequest.Mode=settings.Mode;
                
		delaySalesRequest.Terminal=new Terminal();
                delaySalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                delaySalesRequest.Terminal.UserID=terminal.UserID;
                delaySalesRequest.Terminal.ID=terminal.ID;
                delaySalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                delaySalesRequest.Customer= new Customer();
                delaySalesRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                delaySalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                delaySalesRequest.Card= new Card();
                delaySalesRequest.Card.CVV2=request.getParameter("cvv");
                delaySalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                delaySalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               delaySalesRequest.Order= new Order();
               delaySalesRequest.Order.OrderID=orderId;
               delaySalesRequest.Order.Description="";
               
               
               delaySalesRequest.Transaction= new Transaction();
               delaySalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               delaySalesRequest.Transaction.CurrencyCode="949";
               delaySalesRequest.Transaction.Type="sales";
               delaySalesRequest.Transaction.MotoInd="N";
               delaySalesRequest.Transaction.DelayDayCount=request.getParameter("delayDayCount");
               
               String delaySalesResponse = DelaySalesRequest.execute(delaySalesRequest,settings); //"�telemeli Sat�� servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(delaySalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"�telemeli Sat�� servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />