<%-- 
    Document   : orderiteminq
    Created on : Nov 19, 2018, 4:35:55 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.OrderItemInqRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Ürün Sorgulama</h2>
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
        <legend><label style="font-weight:bold;width:250px;">Ürün Bilgileri</label></legend>
        <!-- Text input-->

        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Sipariþ Id:</label>
            <div class="col-md-4">
                <input value="" name="orderID" class="form-control input-md">
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
		   Ürün Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		OrderItemInqRequest orderItemInqRequest = new OrderItemInqRequest();  

                orderItemInqRequest.Version=settings.Version;
                orderItemInqRequest.Mode=settings.Mode;
                
		orderItemInqRequest.Terminal=new Terminal();
                orderItemInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                orderItemInqRequest.Terminal.UserID=terminal.UserID;
                orderItemInqRequest.Terminal.ID=terminal.ID;
                orderItemInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                orderItemInqRequest.Customer= new Customer();
                orderItemInqRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                orderItemInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                orderItemInqRequest.Card= new Card();
                orderItemInqRequest.Card.CVV2="";
                orderItemInqRequest.Card.ExpireDate="";
                orderItemInqRequest.Card.Number="";
                
                
               orderItemInqRequest.Order= new Order();
               orderItemInqRequest.Order.OrderID=request.getParameter("orderID");
               orderItemInqRequest.Order.Description="";
                
               orderItemInqRequest.Transaction= new Transaction();
               orderItemInqRequest.Transaction.Amount="100";
               orderItemInqRequest.Transaction.CurrencyCode="949";
               orderItemInqRequest.Transaction.Type="orderiteminq";
                
               String orderItemInqResponse = OrderItemInqRequest.execute(orderItemInqRequest,settings); //"Ürün sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(orderItemInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Bin sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
