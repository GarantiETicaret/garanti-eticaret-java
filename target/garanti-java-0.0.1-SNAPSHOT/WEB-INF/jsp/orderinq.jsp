<%-- 
    Document   : orderinq
    Created on : Nov 19, 2018, 4:47:29 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.OrderInqRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Sipariþ Sorgulama</h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> orderinq<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>

</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">Sipariþ Bilgileri</label></legend>
        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Sipariþ Numarasý:</label>
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
		
		OrderInqRequest orderInqRequest = new OrderInqRequest();  

                orderInqRequest.Version=settings.Version;
                orderInqRequest.Mode=settings.Mode;
                
		orderInqRequest.Terminal=new Terminal();
                orderInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                orderInqRequest.Terminal.UserID=terminal.UserID;
                orderInqRequest.Terminal.ID=terminal.ID;
                orderInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                orderInqRequest.Customer= new Customer();
                orderInqRequest.Customer.EmailAddr="fatih@codevist.com";
                orderInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                orderInqRequest.Card= new Card();
                orderInqRequest.Card.CVV2="";
                orderInqRequest.Card.ExpireDate="";
                orderInqRequest.Card.Number="";
                
                
               orderInqRequest.Order= new Order();
               orderInqRequest.Order.OrderID=request.getParameter("orderID");
               orderInqRequest.Order.Description="";
                
               orderInqRequest.Transaction= new Transaction();
               orderInqRequest.Transaction.Amount="100";
               orderInqRequest.Transaction.CurrencyCode="949";
               orderInqRequest.Transaction.Type="orderinq";
                
               String orderInqResponse = OrderInqRequest.execute(orderInqRequest,settings); //"Sipariþ sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(orderInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Bin sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />