<%-- 
    Document   : refund
    Created on : Nov 20, 2018, 5:09:04 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.RefundRequest"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Ýade (Refund) </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> refund<br>
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
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
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
            <button type="submit" id="" name="" class="btn btn-danger"> Ýade Et</button>
        </div>
    </div>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		  Ýade  servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		*/
              
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		RefundRequest refundRequest = new RefundRequest();  

                refundRequest.Version=settings.Version;
                refundRequest.Mode=settings.Mode;
                
		refundRequest.Terminal=new Terminal();
                refundRequest.Terminal.ProvUserID="PROVRFN";
                refundRequest.Terminal.UserID=terminal.UserID;
                refundRequest.Terminal.ID=terminal.ID;
                refundRequest.Terminal.MerchantID=terminal.MerchantID;
                
                refundRequest.Customer= new Customer();
                refundRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                refundRequest.Customer.IPAddress="127.0.0.1";
                
                
                refundRequest.Card= new Card();
                refundRequest.Card.CVV2=request.getParameter("cvv");
                refundRequest.Card.ExpireDate=request.getParameter("expireDate");
                refundRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               refundRequest.Order= new Order();
               refundRequest.Order.OrderID=request.getParameter("orderID");
               refundRequest.Order.Description="";
               
               
               refundRequest.Transaction= new Transaction();
               refundRequest.Transaction.Amount=request.getParameter("transactionAmount");
               refundRequest.Transaction.CurrencyCode="949";
               refundRequest.Transaction.Type="refund";
              
               
               String refundResponse = RefundRequest.execute(refundRequest,settings); //iade servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(refundResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"iade servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />