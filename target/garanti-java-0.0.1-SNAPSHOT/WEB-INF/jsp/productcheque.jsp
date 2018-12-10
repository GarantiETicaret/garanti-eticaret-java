<%-- 
    Document   : productcheque
    Created on : Nov 20, 2018, 3:38:00 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.ProductChequeRequest "%>
<%@page import="garanti.core.HelperClass.Cheque"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Sözünüze Ürün Çek Kullaným </h2>
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
                <input value="4824894728063019" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay/Yýl: </label>
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
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Çek Sayýsý:</label>
            <div class="col-md-4">
                <input value="" name="count" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Çek ID:</label>
            <div class="col-md-4">
                <input value="" name="ID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Çek Tutar:</label>
            <div class="col-md-4">
                <input value="" name="amount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> BitMap Deðeri:</label>
            <div class="col-md-4">
                <input value="3C00" name="bitmap" class="form-control input-md">
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
		 Sözünüze Ürün Çek Kullaným servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		ProductChequeRequest productChequeRequest = new ProductChequeRequest();  

                productChequeRequest.Version=settings.Version;
                productChequeRequest.Mode=settings.Mode;
                
		productChequeRequest.Terminal=new Terminal();
                productChequeRequest.Terminal.ProvUserID=terminal.ProvUserID;
                productChequeRequest.Terminal.UserID=terminal.UserID;
                productChequeRequest.Terminal.ID=terminal.ID;
                productChequeRequest.Terminal.MerchantID=terminal.MerchantID;
                
                productChequeRequest.Customer= new Customer();
                productChequeRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                productChequeRequest.Customer.IPAddress="127.0.0.1";
                
                
                productChequeRequest.Card= new Card();
                productChequeRequest.Card.CVV2=request.getParameter("cvv");
                productChequeRequest.Card.ExpireDate=request.getParameter("expireDate");
                productChequeRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               productChequeRequest.Order= new Order();
               productChequeRequest.Order.OrderID=orderId;
               productChequeRequest.Order.Description="";
             
              
               
               productChequeRequest.Transaction= new Transaction();
               productChequeRequest.Transaction.Amount=request.getParameter("transactionAmount");
               productChequeRequest.Transaction.CurrencyCode="949";
               productChequeRequest.Transaction.Type="sales";
               productChequeRequest.Transaction.MotoInd="H";
               
               productChequeRequest.Transaction.ChequeList=new ArrayList<>();
                
               Cheque cheque = new Cheque();
               cheque.Type="S";
               cheque.Amount=request.getParameter("amount");
               cheque.Count=request.getParameter("count");
               cheque.ID=request.getParameter("ID");
               cheque.Bitmap=request.getParameter("bitmap");
               productChequeRequest.Transaction.ChequeList.add(cheque);
               
               
               
         
               String productChequeResponse= ProductChequeRequest.execute(productChequeRequest,settings); //Sözünüze Ürün Çek Kullaným servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(productChequeResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Sözünüze Ürün Çek Kullaným servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
