<%-- 
    Document   : orderhistoryinq
    Created on : Nov 19, 2018, 4:59:42 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.OrderHistoryInqRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Sipariþ Detay Sorgulama</h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> orderhistoryinq<br>
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
		   Sipariþ Detayý servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		OrderHistoryInqRequest orderHistoryInqRequest = new OrderHistoryInqRequest();  

                orderHistoryInqRequest.Version=settings.Version;
                orderHistoryInqRequest.Mode=settings.Mode;
                
		orderHistoryInqRequest.Terminal=new Terminal();
                orderHistoryInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                orderHistoryInqRequest.Terminal.UserID=terminal.UserID;
                orderHistoryInqRequest.Terminal.ID=terminal.ID;
                orderHistoryInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                orderHistoryInqRequest.Customer= new Customer();
                orderHistoryInqRequest.Customer.EmailAddr="fatih@codevist.com";
                orderHistoryInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                orderHistoryInqRequest.Card= new Card();
                orderHistoryInqRequest.Card.CVV2="";
                orderHistoryInqRequest.Card.ExpireDate="";
                orderHistoryInqRequest.Card.Number="";
                
                
               orderHistoryInqRequest.Order= new Order();
               orderHistoryInqRequest.Order.OrderID=request.getParameter("orderID");
               orderHistoryInqRequest.Order.Description="";
                
               orderHistoryInqRequest.Transaction= new Transaction();
               orderHistoryInqRequest.Transaction.Amount="100";
               orderHistoryInqRequest.Transaction.CurrencyCode="949";
               orderHistoryInqRequest.Transaction.Type="orderhistoryinq";
                
               String orderHistoryInqResponse = OrderHistoryInqRequest.execute(orderHistoryInqRequest,settings); //Sipariþ Detayý servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(orderHistoryInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Sipariþ Detayý servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />