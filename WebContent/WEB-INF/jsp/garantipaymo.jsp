<%-- 
    Document   : garantipaymo
    Created on : Nov 29, 2018, 5:03:10 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.GarantiPayMORequest "%>
<%@page import="garanti.core.HelperClass.GPInstallments"%>
<%@page import="garanti.core.HelperClass.GarantiPaY"%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Garanti Pay ile Mail Order Ýþlem </h2>
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
                <input value="" name="tckn" class="form-control input-md" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> Gsm Numarasý:</label>
            <div class="col-md-4">
                <input value="" name="gsmNumber" class="form-control input-md" >
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
		
	       GarantiPayMORequest garantiPayMORequest = new GarantiPayMORequest();  

               garantiPayMORequest.Version=settings.Version;
               garantiPayMORequest.Mode=settings.Mode;
                
	       garantiPayMORequest.Terminal=new Terminal();
               garantiPayMORequest.Terminal.ProvUserID=terminal.ProvUserID;
               garantiPayMORequest.Terminal.UserID=terminal.UserID;
               garantiPayMORequest.Terminal.ID=terminal.ID;
               garantiPayMORequest.Terminal.MerchantID=terminal.MerchantID;
                
               garantiPayMORequest.Customer= new Customer();
               garantiPayMORequest.Customer.EmailAddr="fatih@codevist.com";
               garantiPayMORequest.Customer.IPAddress="127.0.0.1";
                
                
               garantiPayMORequest.Card= new Card();
               garantiPayMORequest.Card.CVV2="";
               garantiPayMORequest.Card.ExpireDate="";
               garantiPayMORequest.Card.Number="";
                
                
               garantiPayMORequest.Order= new Order();
               garantiPayMORequest.Order.OrderID=orderId;
               garantiPayMORequest.Order.Description="";
               
               GarantiPaY garantipay =new GarantiPaY();
               
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
               garantipay.OrderInfo = "ürün hakkýnda bilgi içerir.";        
               garantipay.TxnTimeOutPeriod = "300";       
               garantipay.NotifSendInd = "Y";
               garantipay.TCKN= request.getParameter("tckn");
               garantipay.GSMNumber = request.getParameter("gsmNumber");
               garantipay.InstallmentOnlyForCommercialCard = "N";
               garantipay.TotalInstallmentCount = "2";
               garantipay.GPInstallmentsList = list;
              
                       
                       
                       
                       
                       
               garantiPayMORequest.Transaction= new Transaction();
               garantiPayMORequest.Transaction.Amount=request.getParameter("transactionAmount");
               garantiPayMORequest.Transaction.CurrencyCode="949";
               garantiPayMORequest.Transaction.Type="gpdatarequest";
               garantiPayMORequest.Transaction.MotoInd="Y";
               garantiPayMORequest.Transaction.CardholderPresentCode = "0";
               garantiPayMORequest.Transaction.SubType = "sales";

               garantiPayMORequest.Transaction.ReturnServerUrl = "";
               garantiPayMORequest.Transaction.GarantiPaYMO=garantipay;
               
               
               String garantiPayMOResponse= GarantiPayMORequest.execute(garantiPayMORequest,settings); //Garanti Pay Mail Order Ýle Ödeme servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(garantiPayMOResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Garanti Pay Mail Order Ýle Ödeme servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />