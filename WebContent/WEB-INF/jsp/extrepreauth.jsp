<%-- 
    Document   : extrepreauth
    Created on : Nov 20, 2018, 2:37:51 PM
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
<%@page import="garanti.core.Request.ExtrePreauthRequest"%>
<%@page import="garanti.core.HelperClass.Verification"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Ekstre Do�rulama/�n Otorizasyon </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> preauth<br>
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
            <label class="col-md-4 control-label" for="">  Ekstre Bilgisi:</label>
            <div class="col-md-4">
                <input value="" name="extreInfo" class="form-control input-md">
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
		 Ekstre Do�rulama/�n Otorizasyon servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
		*/
              
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		ExtrePreauthRequest extrePreauthRequest = new ExtrePreauthRequest();  

                extrePreauthRequest.Version=settings.Version;
                extrePreauthRequest.Mode=settings.Mode;
                
		extrePreauthRequest.Terminal=new Terminal();
                extrePreauthRequest.Terminal.ProvUserID=terminal.ProvUserID;
                extrePreauthRequest.Terminal.UserID=terminal.UserID;
                extrePreauthRequest.Terminal.ID=terminal.ID;
                extrePreauthRequest.Terminal.MerchantID=terminal.MerchantID;
                
                extrePreauthRequest.Customer= new Customer();
                extrePreauthRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                extrePreauthRequest.Customer.IPAddress="127.0.0.1";
                
                
                extrePreauthRequest.Card= new Card();
                extrePreauthRequest.Card.CVV2=request.getParameter("cvv");
                extrePreauthRequest.Card.ExpireDate=request.getParameter("expireDate");
                extrePreauthRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               extrePreauthRequest.Order= new Order();
               extrePreauthRequest.Order.OrderID=request.getParameter("orderID");
               extrePreauthRequest.Order.Description="";
               
               
               extrePreauthRequest.Transaction= new Transaction();
               extrePreauthRequest.Transaction.Amount=request.getParameter("transactionAmount");
               extrePreauthRequest.Transaction.CurrencyCode="949";
               extrePreauthRequest.Transaction.Type="preauth";
               extrePreauthRequest.Transaction.MotoInd="H";
               extrePreauthRequest.Transaction.SubType="extre";
               
               extrePreauthRequest.Transaction.Verification= new Verification();
               extrePreauthRequest.Transaction.Verification.ExtreInfo=request.getParameter("extreInfo");
               extrePreauthRequest.Transaction.Verification.SMSPassword="";
               extrePreauthRequest.Transaction.Verification.Identity="";
               
               
               String extrePreauthResponse = ExtrePreauthRequest.execute(extrePreauthRequest,settings); //"Ekstre Do�rulama/�n Otorizasyon servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(extrePreauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ekstre Do�rulama/�n Otorizasyon  servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
