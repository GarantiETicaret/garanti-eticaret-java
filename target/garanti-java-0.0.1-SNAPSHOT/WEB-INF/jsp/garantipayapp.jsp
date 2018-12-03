<%-- 
    Document   : garantipayapp
    Created on : Nov 30, 2018, 8:24:41 AM
    Author     : Codevist
--%>


<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.GarantiPayAppRequest "%>
<%@page import="garanti.core.HelperClass.GPInstallments"%>
<%@page import="garanti.core.HelperClass.GarantiPaYApp"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<!DOCTYPE html>
<h2>Garanti Pay App Ýþlem </h2>
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
                        <td><label class="col-md-4 control-label" for="">Taksit Sayýsý</label></td>
                        <td><label class="col-md-4 control-label" for="">Taksit Tutarý</label></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>102</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>104</td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  TC Kimlik:</label>
            <div class="col-md-4">
                <input value="" name="tckn" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Gsm Numarasý:</label>
            <div class="col-md-4">
                <input value="" name="gsmNumber" class="form-control input-md">
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
		Ürün Bilgileri ile Satýnalma iþlemi servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId =  request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		GarantiPayAppRequest garantiPayAppRequest = new GarantiPayAppRequest();  

                garantiPayAppRequest.Version=settings.Version;
                garantiPayAppRequest.Mode=settings.Mode;
                
		garantiPayAppRequest.Terminal=new Terminal();
                garantiPayAppRequest.Terminal.ProvUserID=terminal.ProvUserID;
                garantiPayAppRequest.Terminal.UserID=terminal.UserID;
                garantiPayAppRequest.Terminal.ID=terminal.ID;
                garantiPayAppRequest.Terminal.MerchantID=terminal.MerchantID;
                
                garantiPayAppRequest.Customer= new Customer();
                garantiPayAppRequest.Customer.EmailAddr="fatih@codevist.com";
                garantiPayAppRequest.Customer.IPAddress="127.0.0.1";
                
                
                garantiPayAppRequest.Card= new Card();
                garantiPayAppRequest.Card.CVV2="";
                garantiPayAppRequest.Card.ExpireDate="";
                garantiPayAppRequest.Card.Number="";
                
                
               garantiPayAppRequest.Order= new Order();
               garantiPayAppRequest.Order.OrderID=orderId;
               garantiPayAppRequest.Order.Description="";
               
               GarantiPaYApp garantipay =new GarantiPaYApp();
               
               ArrayList<GPInstallments> list=new ArrayList<>();

               
                
               GPInstallments item = new GPInstallments();
               item.Installmentnumber = 2;
               item.Installmentamount = "10200";
               
              GPInstallments item2 = new GPInstallments();
               item.Installmentnumber = 4;
               item.Installmentamount = "10400";
               
               list.add(item);
               list.add(item2);
               
               
               garantipay.bnsuseflag = "N";
               garantipay.fbbuseflag = "N";
               garantipay.chequeuseflag = "N";
               garantipay.mileuseflag = "N";
               garantipay.CompanyName = "Abc";
               garantipay.TxnTimeOutPeriod = "300";       
               garantipay.NotifSendInd = "N";
               garantipay.TCKN= request.getParameter("tckn");
               garantipay.GSMNumber = request.getParameter("gsmNumber");
               garantipay.InstallmentOnlyForCommercialCard = "N";
               garantipay.TotalInstallmentCount = "2";
               garantipay.GPInstallmentsList = list;
              
                       
                       
                       
                       
                       
               garantiPayAppRequest.Transaction= new Transaction();
               garantiPayAppRequest.Transaction.Amount=request.getParameter("transactionAmount");
               garantiPayAppRequest.Transaction.CurrencyCode="949";
               garantiPayAppRequest.Transaction.Type="gpdatarequest";
               garantiPayAppRequest.Transaction.MotoInd="N";
               garantiPayAppRequest.Transaction.CardholderPresentCode = "0";
               garantiPayAppRequest.Transaction.SubType = "sales";

               garantiPayAppRequest.Transaction.ReturnServerUrl = "";
               garantiPayAppRequest.Transaction.GarantiPaY=garantipay;
               
               
               String GarantiPayAppResponse= GarantiPayAppRequest.execute(garantiPayAppRequest,settings); //ürün Bilgileri ile Satýnalma iþlemi servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(GarantiPayAppResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ürün Bilgileri ile Satýnalma iþlemi servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />