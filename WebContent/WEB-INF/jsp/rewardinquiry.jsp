<%-- 
    Document   : rewardinquiry
    Created on : Nov 19, 2018, 5:59:58 PM
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
<%@page import="garanti.core.Request.RewardInquiryRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Bonus Sorgulama </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> rewardinq<br>
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
                <input value="4824914752007011" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay/Y�l: </label>
            <div class="col-md-4">
                <input value="0421" name="expireDate" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  CVC: </label>
            <div class="col-md-4">
                <input value="446" name="cvv" class="form-control input-md">
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Sorgulama Yap</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		   Tarih aral��� ile ��lem Sorgulama servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		RewardInquiryRequest rewardInquiryRequest = new RewardInquiryRequest();  

                rewardInquiryRequest.Version=settings.Version;
                rewardInquiryRequest.Mode=settings.Mode;
                
		rewardInquiryRequest.Terminal=new Terminal();
                rewardInquiryRequest.Terminal.ProvUserID=terminal.ProvUserID;
                rewardInquiryRequest.Terminal.UserID=terminal.UserID;
                rewardInquiryRequest.Terminal.ID=terminal.ID;
                rewardInquiryRequest.Terminal.MerchantID=terminal.MerchantID;
                
                rewardInquiryRequest.Customer= new Customer();
                rewardInquiryRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                rewardInquiryRequest.Customer.IPAddress="127.0.0.1";
                
                
                rewardInquiryRequest.Card= new Card();
                rewardInquiryRequest.Card.CVV2=request.getParameter("cvv");
                rewardInquiryRequest.Card.ExpireDate=request.getParameter("expireDate");
                rewardInquiryRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               rewardInquiryRequest.Order= new Order();
               rewardInquiryRequest.Order.OrderID="";
               rewardInquiryRequest.Order.Description="";
            
                
               
               rewardInquiryRequest.Transaction= new Transaction();
               rewardInquiryRequest.Transaction.Amount="1"; // Amount alanu bo� g�nderilmemelidir. Minimum 1 g�nderilmelidir.
               rewardInquiryRequest.Transaction.CurrencyCode="949";
               rewardInquiryRequest.Transaction.Type="rewardinq";
               rewardInquiryRequest.Transaction.MotoInd="H";
               rewardInquiryRequest.Transaction.CardholderPresentCode="0";
               
          
               
                
               String rewardInquiryResponse= RewardInquiryRequest.execute(rewardInquiryRequest,settings); //"Bonus Sorgulama servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(rewardInquiryResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Bonus Sorgulama servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
