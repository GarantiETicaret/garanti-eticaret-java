<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.PrintWriter"%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.SalesRequest"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Sales </h2>
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
		  Ortak Kart Ön Otorizasyon çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId =  request.getParameter("orderID");

		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		SalesRequest salesRequest = new SalesRequest();  
                
                salesRequest.Version=settings.Version;
                salesRequest.Mode=settings.Mode;
                
		salesRequest.Terminal=new Terminal();
                salesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                salesRequest.Terminal.UserID=terminal.UserID;
                salesRequest.Terminal.ID=terminal.ID;
                salesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                salesRequest.Customer= new Customer();
                salesRequest.Customer.EmailAddr="fatih@codevist.com";
                salesRequest.Customer.IPAddress="127.0.0.1";
                
                
                salesRequest.Card= new Card();
                salesRequest.Card.CVV2=request.getParameter("cvv");
                salesRequest.Card.ExpireDate=request.getParameter("expireDate");
                salesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               salesRequest.Order= new Order();
               salesRequest.Order.OrderID=orderId;
               salesRequest.Order.Description="";
               
               salesRequest.Transaction= new Transaction();
               salesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               salesRequest.Transaction.CurrencyCode="949";
               salesRequest.Transaction.Type="sales";
               salesRequest.Transaction.MotoInd="N";          
               
               
         
               String salesResponse= SalesRequest.execute(salesRequest,settings); //Ortak Kart Ön Otorizasyon servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(salesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ortak Kart Ön Otorizasyon servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
