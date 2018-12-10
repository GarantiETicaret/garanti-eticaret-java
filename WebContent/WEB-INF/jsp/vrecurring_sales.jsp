<%-- 
    Document   : vrecurring_sales
    Created on : Nov 20, 2018, 11:07:56 AM
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
<%@page import="garanti.core.Request.VRecurringSalesRequest "%>
<%@page import="garanti.core.HelperClass.Recurring"%>
<%@page import="garanti.core.HelperClass.Payment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
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
                        <td>100</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>100</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Toplam Tekrar Sayýsý:</label>
            <div class="col-md-4">
                <input value="2" name="totalPaymentNum" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Tekrar Sýklýðý: </label>
            <div class="col-md-4">
                <input value="1" name="frequencyInterval" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Sýklýk Tipi (D/W/M/Y): </label>
            <div class="col-md-4">
                <input value="M" name="frequencyType" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Baþlangýç Tarihi: </label>
            <div class="col-md-4">
                <input value="20181201" name="startDate" class="form-control input-md" readonly>
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
                
               <input value= '<%=UUID.randomUUID().toString().replace("-", "")%>'   name="orderID" class="form-control input-md">

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="100" name="transactionAmount" class="form-control input-md" readonly>
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
		  Deðiþken tekrarlý satýþ servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		VRecurringSalesRequest vrecurringSalesRequest = new VRecurringSalesRequest();  

                vrecurringSalesRequest.Version=settings.Version;
                vrecurringSalesRequest.Mode=settings.Mode;
                
		vrecurringSalesRequest.Terminal=new Terminal();
                vrecurringSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                vrecurringSalesRequest.Terminal.UserID=terminal.UserID;
                vrecurringSalesRequest.Terminal.ID=terminal.ID;
                vrecurringSalesRequest.Terminal.MerchantID=terminal.MerchantID;
                
                vrecurringSalesRequest.Customer= new Customer();
                vrecurringSalesRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                vrecurringSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                vrecurringSalesRequest.Card= new Card();
                vrecurringSalesRequest.Card.CVV2=request.getParameter("cvv");
                vrecurringSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                vrecurringSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               vrecurringSalesRequest.Order= new Order();
               vrecurringSalesRequest.Order.OrderID=orderId;
               vrecurringSalesRequest.Order.Description="";
               vrecurringSalesRequest.Order.Recurring= new Recurring();
               
               vrecurringSalesRequest.Order.Recurring.TotalPaymentNum="2";// tekrar sayýsý girilir.
               vrecurringSalesRequest.Order.Recurring.FrequencyInterval="1";// tekrar sýklýðýnýn girildiði alandýr. Ör: 2 girilirse type W için iki haftada bir anlamýna gelir.
               vrecurringSalesRequest.Order.Recurring.FrequencyType="M";// tekrar tipi girilir. Günlük: D, Haftalýk: W, Aylýk: M, Yýllýk: Y
               vrecurringSalesRequest.Order.Recurring.Type="R"; // deðiþken tekrarlý iþlem tipi
               vrecurringSalesRequest.Order.Recurring.StartDate="20181201";// YYYYMMGG
               
               vrecurringSalesRequest.Order.Recurring.Payment=new ArrayList<>();
                
               Payment payment1 = new Payment();
               payment1.PaymentNum="1";
               payment1.Amount="100";
               vrecurringSalesRequest.Order.Recurring.Payment.add(payment1);
               Payment payment2 = new Payment();
               payment2.PaymentNum="2";
               payment2.Amount="100";
               vrecurringSalesRequest.Order.Recurring.Payment.add(payment2);
               
               vrecurringSalesRequest.Transaction= new Transaction();
               vrecurringSalesRequest.Transaction.Amount="100"; 
               vrecurringSalesRequest.Transaction.CurrencyCode="949";
               vrecurringSalesRequest.Transaction.Type="sales";
               vrecurringSalesRequest.Transaction.MotoInd="H";
         
               String vrecurringSalesResponse= VRecurringSalesRequest.execute(vrecurringSalesRequest,settings); //Deðiþken Tekrarlý Satýþ servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(vrecurringSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Deðiþken Tekrarlý Satýþ servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
