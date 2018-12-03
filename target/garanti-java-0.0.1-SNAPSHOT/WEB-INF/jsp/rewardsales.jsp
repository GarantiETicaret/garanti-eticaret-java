<%-- 
    Document   : rewardsales
    Created on : Nov 20, 2018, 4:35:57 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.RewardSalesRequest "%>
<%@page import="garanti.core.HelperClass.Reward"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Bonus Kullaným </h2>
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
		  Bonus Kullanýmý Satýþ servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		RewardSalesRequest rewardSalesRequest = new RewardSalesRequest();  

                rewardSalesRequest.Version=settings.Version;
                rewardSalesRequest.Mode=settings.Mode;
                
		rewardSalesRequest.Terminal=new Terminal();
                rewardSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                rewardSalesRequest.Terminal.UserID=terminal.UserID;
                rewardSalesRequest.Terminal.ID=terminal.ID;
                rewardSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                rewardSalesRequest.Customer= new Customer();
                rewardSalesRequest.Customer.EmailAddr="fatih@codevist.com";
                rewardSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                rewardSalesRequest.Card= new Card();
                rewardSalesRequest.Card.CVV2=request.getParameter("cvv");
                rewardSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                rewardSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               rewardSalesRequest.Order= new Order();
               rewardSalesRequest.Order.OrderID=orderId;
               rewardSalesRequest.Order.Description="";
             
              
               
               rewardSalesRequest.Transaction= new Transaction();
               rewardSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               rewardSalesRequest.Transaction.CurrencyCode="949";
               rewardSalesRequest.Transaction.Type="sales";
               rewardSalesRequest.Transaction.MotoInd="H";
               
               rewardSalesRequest.Transaction.RewardList=new ArrayList<>();
                
               Reward reward = new Reward();
               reward.Type="BNS";
               reward.UsedAmount=request.getParameter("usedAmount");
               
               rewardSalesRequest.Transaction.RewardList.add(reward);
               
         
               String rewardSalesResponse= RewardSalesRequest.execute(rewardSalesRequest,settings); // Bonus Kullanýmý Satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(rewardSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //" Bonus Kullanýmý Satýþ  servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />

