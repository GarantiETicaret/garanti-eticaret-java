<%-- 
    Document   : orderlistinq
    Created on : Nov 19, 2018, 5:06:41 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.OrderListInqRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Tarih aralýðý ile Ýþlem Sorgulama</h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> orderlistinq<br>
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
            <label class="col-md-4 control-label" for="">  Baþlangýç Tarihi:</label>
            <div class="col-md-4">
                <input value="12/11/2018 08:00" name="startDate" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Bitiþ Tarihi:</label>
            <div class="col-md-4">
                <input value="13/11/2018 08:00" name="endDate" class="form-control input-md">
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
		   Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		OrderListInqRequest orderListInqRequest = new OrderListInqRequest();  

                orderListInqRequest.Version=settings.Version;
                orderListInqRequest.Mode=settings.Mode;
                
		orderListInqRequest.Terminal=new Terminal();
                orderListInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                orderListInqRequest.Terminal.UserID=terminal.UserID;
                orderListInqRequest.Terminal.ID=terminal.ID;
                orderListInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                orderListInqRequest.Customer= new Customer();
                orderListInqRequest.Customer.EmailAddr="fatih@codevist.com";
                orderListInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                orderListInqRequest.Card= new Card();
                orderListInqRequest.Card.CVV2="";
                orderListInqRequest.Card.ExpireDate="";
                orderListInqRequest.Card.Number="";
                
                
               orderListInqRequest.Order= new Order();
               orderListInqRequest.Order.OrderID="";
               orderListInqRequest.Order.Description="";
               orderListInqRequest.Order.StartDate=request.getParameter("startDate");
               orderListInqRequest.Order.EndDate=request.getParameter("endDate");
               orderListInqRequest.Order.ListPageNum="1";
                
               
               orderListInqRequest.Transaction= new Transaction();
               orderListInqRequest.Transaction.Amount="100";
               orderListInqRequest.Transaction.CurrencyCode="949";
               orderListInqRequest.Transaction.Type="orderlistinq";
               
                
               String orderListInqResponse = OrderListInqRequest.execute(orderListInqRequest,settings); //"Tarih aralýðý ile Ýþlem Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(orderListInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Tarih aralýðý ile Ýþlem Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
