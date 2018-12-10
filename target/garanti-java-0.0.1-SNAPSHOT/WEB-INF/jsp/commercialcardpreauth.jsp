<%-- 
    Document   : commercialcardpreauth
    Created on : Nov 20, 2018, 12:07:06 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.CommercialCardPreauthRequest "%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Ortak Kart �n Otorizasyon </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> commercialcardpreauth<br>
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
		 Ortak Kart �n Otorizasyon servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		CommercialCardPreauthRequest commercialCardPreauthRequest = new CommercialCardPreauthRequest();  

                commercialCardPreauthRequest.Version=settings.Version;
                commercialCardPreauthRequest.Mode=settings.Mode;
                
		commercialCardPreauthRequest.Terminal=new Terminal();
                commercialCardPreauthRequest.Terminal.ProvUserID=terminal.ProvUserID;
                commercialCardPreauthRequest.Terminal.UserID=terminal.UserID;
                commercialCardPreauthRequest.Terminal.ID=terminal.ID;
                commercialCardPreauthRequest.Terminal.MerchantID=terminal.MerchantID;
                
                commercialCardPreauthRequest.Customer= new Customer();
                commercialCardPreauthRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                commercialCardPreauthRequest.Customer.IPAddress="127.0.0.1";
                
                
                commercialCardPreauthRequest.Card= new Card();
                commercialCardPreauthRequest.Card.CVV2=request.getParameter("cvv");
                commercialCardPreauthRequest.Card.ExpireDate=request.getParameter("expireDate");
                commercialCardPreauthRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               commercialCardPreauthRequest.Order= new Order();
               commercialCardPreauthRequest.Order.OrderID=orderId;
               commercialCardPreauthRequest.Order.Description="";
               
               
               commercialCardPreauthRequest.Transaction= new Transaction();
               commercialCardPreauthRequest.Transaction.Amount=request.getParameter("transactionAmount");
               commercialCardPreauthRequest.Transaction.CurrencyCode="949";
               commercialCardPreauthRequest.Transaction.Type="commercialcardpreauth";
               commercialCardPreauthRequest.Transaction.MotoInd="N";
               
               
               String commercialCardPreauthResponse = CommercialCardPreauthRequest.execute(commercialCardPreauthRequest,settings); //"Ortak Kart �n Otorizasyon servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(commercialCardPreauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ortak Kart �n Otorizasyon servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
