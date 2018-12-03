<%-- 
    Document   : firmrewardsales
    Created on : Nov 20, 2018, 4:17:40 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.FirmRewardSalesRequest "%>
<%@page import="garanti.core.HelperClass.Reward"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Firma Bonus Kullaným </h2>
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
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Bonus Bilgisi:</label>
            <div class="col-md-4">
                <input value="" name="usedAmount" class="form-control input-md">
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
		 Firma Bonus Kullanýmý Satýþ servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		FirmRewardSalesRequest firmRewardSalesRequest = new FirmRewardSalesRequest();  

                firmRewardSalesRequest.Version=settings.Version;
                firmRewardSalesRequest.Mode=settings.Mode;
                
		firmRewardSalesRequest.Terminal=new Terminal();
                firmRewardSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                firmRewardSalesRequest.Terminal.UserID=terminal.UserID;
                firmRewardSalesRequest.Terminal.ID=terminal.ID;
                firmRewardSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                firmRewardSalesRequest.Customer= new Customer();
                firmRewardSalesRequest.Customer.EmailAddr="fatih@codevist.com";
                firmRewardSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                firmRewardSalesRequest.Card= new Card();
                firmRewardSalesRequest.Card.CVV2=request.getParameter("cvv");
                firmRewardSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                firmRewardSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               firmRewardSalesRequest.Order= new Order();
               firmRewardSalesRequest.Order.OrderID=orderId;
               firmRewardSalesRequest.Order.Description="";
             
              
               
               firmRewardSalesRequest.Transaction= new Transaction();
               firmRewardSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               firmRewardSalesRequest.Transaction.CurrencyCode="949";
               firmRewardSalesRequest.Transaction.Type="sales";
               firmRewardSalesRequest.Transaction.MotoInd="H";
               
               firmRewardSalesRequest.Transaction.RewardList=new ArrayList<>();
                
               Reward reward = new Reward();
               reward.Type="FBB";
               reward.UsedAmount=request.getParameter("usedAmount");
               
               firmRewardSalesRequest.Transaction.RewardList.add(reward);
               
         
               String firmRewardSalesResponse= FirmRewardSalesRequest.execute(firmRewardSalesRequest,settings); //Firma Bonus Kullanýmý Satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(firmRewardSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Firma Bonus Kullanýmý Satýþ servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
