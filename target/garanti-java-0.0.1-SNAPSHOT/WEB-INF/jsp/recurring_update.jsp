<%-- 
    Document   : utility_paymentinq
    Created on : Nov 19, 2018, 7:01:27 PM
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
<%@page import="garanti.core.Request.RecurringUpdateRequest"%>
<%@page import="garanti.core.HelperClass.Recurring"%>
<%@page import="garanti.core.HelperClass.Payment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Deðiþken Tekrarlý Satýþ </h2>
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
            <label class="col-md-4 control-label" for="">  Ödeme Listesi:</label>
            <div class="col-md-4">
                <table border="1">
                    <tr>
                        <td><label class="col-md-4 control-label" for="">Sýra</label></td>
                        <td><label class="col-md-4 control-label" for="">  Tutar</label></td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>101</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>101</td>
                    </tr>
                </table>
            </div>
        </div>
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
		  Fatura Sorgulamaservis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		RecurringUpdateRequest recurringUpdateRequest = new RecurringUpdateRequest();  

                recurringUpdateRequest.Version=settings.Version;
                recurringUpdateRequest.Mode=settings.Mode;
                
		recurringUpdateRequest.Terminal=new Terminal();
                recurringUpdateRequest.Terminal.ProvUserID=terminal.ProvUserID;
                recurringUpdateRequest.Terminal.UserID=terminal.UserID;
                recurringUpdateRequest.Terminal.ID=terminal.ID;
                recurringUpdateRequest.Terminal.MerchantID=terminal.MerchantID;
                
                recurringUpdateRequest.Customer= new Customer();
                recurringUpdateRequest.Customer.EmailAddr="fatih@codevist.com";
                recurringUpdateRequest.Customer.IPAddress="127.0.0.1";
                
                
                recurringUpdateRequest.Card= new Card();
                recurringUpdateRequest.Card.CVV2=request.getParameter("cvv");
                recurringUpdateRequest.Card.ExpireDate=request.getParameter("expireDate");
                recurringUpdateRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               recurringUpdateRequest.Order= new Order();
               recurringUpdateRequest.Order.OrderID=request.getParameter("orderID");
               recurringUpdateRequest.Order.Description="";
               recurringUpdateRequest.Order.Recurring= new Recurring();
               recurringUpdateRequest.Order.Recurring.Payment=new ArrayList<>();
                
               Payment payment1 = new Payment();
               payment1.PaymentNum="1";
               payment1.Amount="101";
               recurringUpdateRequest.Order.Recurring.Payment.add(payment1);
               Payment payment2 = new Payment();
               payment2.PaymentNum="1";
               payment2.Amount="101";
               recurringUpdateRequest.Order.Recurring.Payment.add(payment2);
               
               recurringUpdateRequest.Transaction= new Transaction();
               recurringUpdateRequest.Transaction.Amount="100"; 
               recurringUpdateRequest.Transaction.CurrencyCode="949";
               recurringUpdateRequest.Transaction.Type="recurringupdate";
               recurringUpdateRequest.Transaction.MotoInd="H";
         
               String recurringUpdateResponse= RecurringUpdateRequest.execute(recurringUpdateRequest,settings); //Deðiþken Tekrarlý Satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(recurringUpdateResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Deðiþken Tekrarlý Satýþ servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
