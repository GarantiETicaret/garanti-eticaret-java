<%-- 
    Document   : playerchequesales
    Created on : Nov 20, 2018, 4:10:56 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.PlayerChequeSalesRequest "%>
<%@page import="garanti.core.HelperClass.Cheque"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Player �ek Kullan�m </h2>
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
                <input value="4824894728063019" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay/Y�l: </label>
            <div class="col-md-4">
                <input value="0723" name="expireDate" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  CVC: </label>
            <div class="col-md-4">
                <input value="172" name="cvv" class="form-control input-md">
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
            <label class="col-md-4 control-label" for="">  �ek Say�s�:</label>
            <div class="col-md-4">
                <input value="" name="count" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  �ek ID:</label>
            <div class="col-md-4">
                <input value="" name="ID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  �ek Tutar:</label>
            <div class="col-md-4">
                <input value="" name="amount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> BitMap De�eri:</label>
            <div class="col-md-4">
                <input value="3C00" name="bitmap" class="form-control input-md">
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> ��lem Yap</button>
        </div>
    </div>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		 Player �ek Kullan�m servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		PlayerChequeSalesRequest playerChequeSalesRequest = new PlayerChequeSalesRequest();  

                playerChequeSalesRequest.Version=settings.Version;
                playerChequeSalesRequest.Mode=settings.Mode;
                
		playerChequeSalesRequest.Terminal=new Terminal();
                playerChequeSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                playerChequeSalesRequest.Terminal.UserID=terminal.UserID;
                playerChequeSalesRequest.Terminal.ID=terminal.ID;
                playerChequeSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                playerChequeSalesRequest.Customer= new Customer();
                playerChequeSalesRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                playerChequeSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                playerChequeSalesRequest.Card= new Card();
                playerChequeSalesRequest.Card.CVV2=request.getParameter("cvv");
                playerChequeSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                playerChequeSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               playerChequeSalesRequest.Order= new Order();
               playerChequeSalesRequest.Order.OrderID=orderId;
               playerChequeSalesRequest.Order.Description="";
             
              
               
               playerChequeSalesRequest.Transaction= new Transaction();
               playerChequeSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               playerChequeSalesRequest.Transaction.CurrencyCode="949";
               playerChequeSalesRequest.Transaction.Type="sales";
               playerChequeSalesRequest.Transaction.MotoInd="H";
               
               playerChequeSalesRequest.Transaction.ChequeList=new ArrayList<>();
                
               Cheque cheque = new Cheque();
               cheque.Type="P";
               cheque.Amount=request.getParameter("amount");
               cheque.Count=request.getParameter("count");
               cheque.ID=request.getParameter("ID");
               cheque.Bitmap=request.getParameter("bitmap");
               playerChequeSalesRequest.Transaction.ChequeList.add(cheque);
               
               String playerChequeSalesResponse= PlayerChequeSalesRequest.execute(playerChequeSalesRequest,settings); //Player �ek Kullan�m servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(playerChequeSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Player �ek Kullan�m servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
