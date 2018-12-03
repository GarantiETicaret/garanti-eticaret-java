<%-- 
    Document   : extrepostauth
    Created on : Nov 20, 2018, 2:20:02 PM
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
<%@page import="garanti.core.Request.ExtrePostauthRequest"%>
<%@page import="garanti.core.HelperClass.Verification"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Ekstre Doðrulama/Ön Otorizasyon Kapama</h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> postauth<br>
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
                <input value="" name="orderID" class="form-control input-md">
            </div>
        </div>
          <div class="form-group">
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
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
            <button type="submit" id="" name="" class="btn btn-danger"> Ýþlem Yap</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		 Ekstre Doðrulama/Ön Otorizasyon Kapama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
              
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		ExtrePostauthRequest extrePostauthRequest = new ExtrePostauthRequest();  

                extrePostauthRequest.Version=settings.Version;
                extrePostauthRequest.Mode=settings.Mode;
                
		extrePostauthRequest.Terminal=new Terminal();
                extrePostauthRequest.Terminal.ProvUserID=terminal.ProvUserID;
                extrePostauthRequest.Terminal.UserID=terminal.UserID;
                extrePostauthRequest.Terminal.ID=terminal.ID;
                extrePostauthRequest.Terminal.MerchantID=terminal.MerchantID;
                
                extrePostauthRequest.Customer= new Customer();
                extrePostauthRequest.Customer.EmailAddr="fatih@codevist.com";
                extrePostauthRequest.Customer.IPAddress="127.0.0.1";
                
                
                extrePostauthRequest.Card= new Card();
                extrePostauthRequest.Card.CVV2=request.getParameter("cvv");
                extrePostauthRequest.Card.ExpireDate=request.getParameter("expireDate");
                extrePostauthRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               extrePostauthRequest.Order= new Order();
               extrePostauthRequest.Order.OrderID=request.getParameter("orderID");
               extrePostauthRequest.Order.Description="";
               
               
               extrePostauthRequest.Transaction= new Transaction();
               extrePostauthRequest.Transaction.Amount=request.getParameter("transactionAmount");
               extrePostauthRequest.Transaction.CurrencyCode="949";
               extrePostauthRequest.Transaction.Type="postauth";
               extrePostauthRequest.Transaction.MotoInd="H";
               extrePostauthRequest.Transaction.SubType="extre";
               
               extrePostauthRequest.Transaction.Verification= new Verification();
               extrePostauthRequest.Transaction.Verification.ExtreInfo=request.getParameter("extreInfo");
               extrePostauthRequest.Transaction.Verification.SMSPassword="";
               extrePostauthRequest.Transaction.Verification.Identity="";
               
               
               String extrePostauthResponse = ExtrePostauthRequest.execute(extrePostauthRequest,settings); //"Ekstre Doðrulama/Ön Otorizasyon Kapama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(extrePostauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ekstre Doðrulama/Ön Otorizasyon Kapatma servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
