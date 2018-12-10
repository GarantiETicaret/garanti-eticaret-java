<%-- 
    Document   : saleswith_addressinfo
    Created on : Nov 20, 2018, 5:43:09 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.SalesWithAddressInfoRequest "%>
<%@page import="garanti.core.HelperClass.Address"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Adres Bilgileri ile Satýnalma iþlemi </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> Sales<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

    <label style="font-weight:bold;">&nbsp; Adres Bilgileri:   &nbsp; </label> <br>
    <label style="font-weight:bold;">Adres Tipi &nbsp; :&nbsp; </label> S <br>
    <label style="font-weight:bold;">Ýsim  &nbsp;:   &nbsp;</label> Ali <br>
    <label style="font-weight:bold;">Soyisim &nbsp;:  &nbsp;</label> Mehmet <br>
    <label style="font-weight:bold;">Þirket &nbsp;:  &nbsp;</label> ABC<br>

    <label style="font-weight:bold;">Adres  &nbsp;:   &nbsp;</label> Üsküdar/Ýstanbul <br>
    <label style="font-weight:bold;">Þehir &nbsp;:  &nbsp;</label> Ýstanbul <br>
    <label style="font-weight:bold;">ülke &nbsp;:  &nbsp;</label> Türkiye<br>
    <label style="font-weight:bold;">Posta kodu  &nbsp;:   &nbsp;</label> 34000 <br>
    <label style="font-weight:bold;">Telefon Numarasý &nbsp;:  &nbsp;</label> 02123212121 <br>
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
            <label class="col-md-4 control-label" for="">  Tutar:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
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
		Adres Bilgileri ile Satýnalma iþlemi servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId =  request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		SalesWithAddressInfoRequest salesWithAddressInfoRequest = new SalesWithAddressInfoRequest();  

                salesWithAddressInfoRequest.Version=settings.Version;
                salesWithAddressInfoRequest.Mode=settings.Mode;
                
		salesWithAddressInfoRequest.Terminal=new Terminal();
                salesWithAddressInfoRequest.Terminal.ProvUserID=terminal.ProvUserID;
                salesWithAddressInfoRequest.Terminal.UserID=terminal.UserID;
                salesWithAddressInfoRequest.Terminal.ID=terminal.ID;
                salesWithAddressInfoRequest.Terminal.MerchantID=terminal.MerchantID;
                
                salesWithAddressInfoRequest.Customer= new Customer();
                salesWithAddressInfoRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                salesWithAddressInfoRequest.Customer.IPAddress="127.0.0.1";
                
                
                salesWithAddressInfoRequest.Card= new Card();
                salesWithAddressInfoRequest.Card.CVV2=request.getParameter("cvv");
                salesWithAddressInfoRequest.Card.ExpireDate=request.getParameter("expireDate");
                salesWithAddressInfoRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               salesWithAddressInfoRequest.Order= new Order();
               salesWithAddressInfoRequest.Order.OrderID=orderId;
               salesWithAddressInfoRequest.Order.Description="";
               
               salesWithAddressInfoRequest.Order.AddressList=new ArrayList<>();
                
               Address address = new Address();
               address.Type="S";
               address.Name="Ali";
               address.LastName="Mehmet";
               address.Company="ABC";
               address.Text="Üsküdar/Ýstanbul";
               address.City="Ýstanbul";
               address.Country="Türkiye";
               address.PostalCode="34000";
               address.PhoneNumber="02123212121";
               
               salesWithAddressInfoRequest.Order.AddressList.add(address);
              
               
               salesWithAddressInfoRequest.Transaction= new Transaction();
               salesWithAddressInfoRequest.Transaction.Amount=request.getParameter("transactionAmount");
               salesWithAddressInfoRequest.Transaction.CurrencyCode="949";
               salesWithAddressInfoRequest.Transaction.Type="sales";
               salesWithAddressInfoRequest.Transaction.MotoInd="N";
               
               
               
         
               String salesWithAddressInfoResponse= SalesWithAddressInfoRequest.execute(salesWithAddressInfoRequest,settings); //Adres Bilgileri ile Satýnalma iþlemi servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(salesWithAddressInfoResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Adres Bilgileri ile Satýnalma iþlemi servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />