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
<h2>De�i�ken Tekrarl� Sat�� </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> Sales<br>
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
            <label class="col-md-4 control-label" for="">  �deme Listesi:</label>
            <div class="col-md-4">
                <table border="1">
                    <tr>
                        <td><label class="col-md-4 control-label" for="">S�ra</label></td>
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
            <label class="col-md-4 control-label" for="">  Toplam Tekrar Say�s�:</label>
            <div class="col-md-4">
                <input value="2" name="totalPaymentNum" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Tekrar S�kl���: </label>
            <div class="col-md-4">
                <input value="1" name="frequencyInterval" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> S�kl�k Tipi (D/W/M/Y): </label>
            <div class="col-md-4">
                <input value="M" name="frequencyType" class="form-control input-md" readonly>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Ba�lang�� Tarihi: </label>
            <div class="col-md-4">
                <input value="20181201" name="startDate" class="form-control input-md" readonly>
            </div>
        </div>
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
                <input value="100" name="transactionAmount" class="form-control input-md" readonly>
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
		  De�i�ken tekrarl� sat�� servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
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
               
               vrecurringSalesRequest.Order.Recurring.TotalPaymentNum="2";// tekrar say�s� girilir.
               vrecurringSalesRequest.Order.Recurring.FrequencyInterval="1";// tekrar s�kl���n�n girildi�i aland�r. �r: 2 girilirse type W i�in iki haftada bir anlam�na gelir.
               vrecurringSalesRequest.Order.Recurring.FrequencyType="M";// tekrar tipi girilir. G�nl�k: D, Haftal�k: W, Ayl�k: M, Y�ll�k: Y
               vrecurringSalesRequest.Order.Recurring.Type="R"; // de�i�ken tekrarl� i�lem tipi
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
         
               String vrecurringSalesResponse= VRecurringSalesRequest.execute(vrecurringSalesRequest,settings); //De�i�ken Tekrarl� Sat�� servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(vrecurringSalesResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"De�i�ken Tekrarl� Sat�� servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
