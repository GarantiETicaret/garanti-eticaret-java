<%-- 
    Document   : void
    Created on : Nov 20, 2018, 5:16:50 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.VoidRequest"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>�ptal (Void) </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> Void<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVRFN <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">�ade Bilgileri</label></legend>
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
              
                <input value="" name="orderID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  ��lem Tutar�:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> �ptal Edilecek ��lem No: </label>
            <div class="col-md-4">
                <input value="" name="originalRetrefNum" class="form-control input-md">
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> �ptal Et</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		  iptal  servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		*/
              
               Settings settings = new Settings();
               Terminal terminal= new Terminal();
		
               VoidRequest voidRequest = new VoidRequest();  

               voidRequest.Version=settings.Version;
               voidRequest.Mode=settings.Mode;
                
               voidRequest.Terminal=new Terminal();
               voidRequest.Terminal.ProvUserID="PROVRFN";
               voidRequest.Terminal.UserID=terminal.UserID;
               voidRequest.Terminal.ID=terminal.ID;
               voidRequest.Terminal.MerchantID=terminal.MerchantID;
                
               voidRequest.Customer= new Customer();
               voidRequest.Customer.EmailAddr="fatih@codevist.com";
               voidRequest.Customer.IPAddress="127.0.0.1";
                
                
               
               voidRequest.Card= new Card();
               voidRequest.Card.CVV2=request.getParameter("cvv");
               voidRequest.Card.ExpireDate=request.getParameter("expireDate");
               voidRequest.Card.Number=request.getParameter("creditCardNo");
                
               voidRequest.Order= new Order();
               voidRequest.Order.OrderID=request.getParameter("orderID");
               voidRequest.Order.Description="";
               
               voidRequest.Transaction= new Transaction();
               voidRequest.Transaction.Amount=request.getParameter("transactionAmount");
               voidRequest.Transaction.CurrencyCode="949";
               voidRequest.Transaction.Type="void";
               voidRequest.Transaction.OriginalRetrefNum=request.getParameter("originalRetrefNum");
               String voidResponse = VoidRequest.execute(voidRequest,settings); //iptal servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(voidResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"iptal servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />