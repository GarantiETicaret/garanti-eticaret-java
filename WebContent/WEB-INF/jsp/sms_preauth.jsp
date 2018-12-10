<%-- 
    Document   : sms_preauth
    Created on : Nov 20, 2018, 11:47:10 AM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.SMSPreauthRequest "%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>SMS Do�rulama/�n Otorizasyon </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Ad� &nbsp; :   &nbsp; </label> preauth<br>
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
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> ��lem Yap</button>
        </div>
    </div>
</form>

<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		 SMS Do�rulama/�n Otorizasyon servis �a�r�s�n�n yap�ld��� alan� temsil etmektedir.
		  
		*/
                String orderId = request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		SMSPreauthRequest smsPreauthRequest = new SMSPreauthRequest();  

                smsPreauthRequest.Version=settings.Version;
                smsPreauthRequest.Mode=settings.Mode;
                
		smsPreauthRequest.Terminal=new Terminal();
                smsPreauthRequest.Terminal.ProvUserID=terminal.ProvUserID;
                smsPreauthRequest.Terminal.UserID=terminal.UserID;
                smsPreauthRequest.Terminal.ID=terminal.ID;
                smsPreauthRequest.Terminal.MerchantID=terminal.MerchantID;
                
                smsPreauthRequest.Customer= new Customer();
                smsPreauthRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                smsPreauthRequest.Customer.IPAddress="127.0.0.1";
                
                
                smsPreauthRequest.Card= new Card();
                smsPreauthRequest.Card.CVV2=request.getParameter("cvv");
                smsPreauthRequest.Card.ExpireDate=request.getParameter("expireDate");
                smsPreauthRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               smsPreauthRequest.Order= new Order();
               smsPreauthRequest.Order.OrderID=orderId;
               smsPreauthRequest.Order.Description="";
               
               
               smsPreauthRequest.Transaction= new Transaction();
               smsPreauthRequest.Transaction.Amount=request.getParameter("transactionAmount");
               smsPreauthRequest.Transaction.CurrencyCode="949";
               smsPreauthRequest.Transaction.Type="preauth";
               smsPreauthRequest.Transaction.MotoInd="N";
               smsPreauthRequest.Transaction.SubType="sms";
               
               
               String smsPreauthResponse = SMSPreauthRequest.execute(smsPreauthRequest,settings); //"SMS Do�rulama/�n Otorizasyon servisi ba�lat�lmas� i�in gerekli servis �a��r�s�n� temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(smsPreauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"SMS Do�rulama/�n Otorizasyon servis �a�r�s� sonucunda olu�an servis ��kt� parametrelerinin ekranda g�sterilmesini sa�lar"
	}
%>

<jsp:include page="footer.jsp" />
