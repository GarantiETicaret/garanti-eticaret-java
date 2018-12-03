<%-- 
    Document   : recurring_void
    Created on : Nov 20, 2018, 11:00:19 AM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.RecurringVoidRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Tekrarlý Ýptal </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> recurringvoid<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVRFN <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">Ýade Bilgileri</label></legend>
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
        
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Ýptal Et</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		   Tekrarlý Ýptal servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId = UUID.randomUUID().toString().replace("-", "");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		RecurringVoidRequest recurringVoidRequest = new RecurringVoidRequest();  

                recurringVoidRequest.Version=settings.Version;
                recurringVoidRequest.Mode=settings.Mode;
                
		recurringVoidRequest.Terminal=new Terminal();
                recurringVoidRequest.Terminal.ProvUserID="PROVRFN";
                recurringVoidRequest.Terminal.UserID=terminal.UserID;
                recurringVoidRequest.Terminal.ID=terminal.ID;
                recurringVoidRequest.Terminal.MerchantID=terminal.MerchantID;
                
                recurringVoidRequest.Customer= new Customer();
                recurringVoidRequest.Customer.EmailAddr="fatih@codevist.com";
                recurringVoidRequest.Customer.IPAddress="127.0.0.1";
                
                
                recurringVoidRequest.Card= new Card();
                recurringVoidRequest.Card.CVV2=request.getParameter("cvv");
                recurringVoidRequest.Card.ExpireDate=request.getParameter("expireDate");
                recurringVoidRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               recurringVoidRequest.Order= new Order();
               recurringVoidRequest.Order.OrderID=orderId; // Tekrarlý yapýlan bir satýþ iþlemindeki orderID buraya yazýlmalýdýr. Satýþý olmayan bir iþlemin iptali olmaz.
               recurringVoidRequest.Order.Description="";
            
                
               
               recurringVoidRequest.Transaction= new Transaction();
               recurringVoidRequest.Transaction.Amount="1"; // Amount alanu boþ gönderilmemelidir. Minimum 1 gönderilmelidir.
               recurringVoidRequest.Transaction.CurrencyCode="949";
               recurringVoidRequest.Transaction.Type="recurringvoid";
               
          
               
                
               String recurringVoidResponse= RecurringVoidRequest.execute(recurringVoidRequest,settings); //" Tekrarlý Ýptal servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(recurringVoidResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //" Tekrarlý Ýptal servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />