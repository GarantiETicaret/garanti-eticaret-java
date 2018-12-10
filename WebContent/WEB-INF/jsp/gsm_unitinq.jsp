<%-- 
    Document   : gsm_unitinq
    Created on : Nov 20, 2018, 8:43:54 AM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.BaseEntity.SettlementInq"%>
<%@page import="garanti.core.Request.GsmUnitInqRequest"%>
<%@page import="garanti.core.HelperClass.GSMUnitInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>GSM TL Sorgulama </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> gsmunitinq<br>
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
            <label class="col-md-4 control-label" for="">  Kurum Ödeme Kodu:</label>
            <div class="col-md-4">
                <input value="0001" name="subscriberCode" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Kurum Kodu: </label>
            <div class="col-md-4">
                <input value="1" name="institutionCode" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Yüklenecek TL miktarý: </label>
            <div class="col-md-4">
                <input value="20" name="quantity" class="form-control input-md">
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
		 GSM TL Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		GsmUnitInqRequest gsmUnitInqRequest = new GsmUnitInqRequest();  

                gsmUnitInqRequest.Version=settings.Version;
                gsmUnitInqRequest.Mode=settings.Mode;
                
		gsmUnitInqRequest.Terminal=new Terminal();
                gsmUnitInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                gsmUnitInqRequest.Terminal.UserID=terminal.UserID;
                gsmUnitInqRequest.Terminal.ID=terminal.ID;
                gsmUnitInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                gsmUnitInqRequest.Customer= new Customer();
                gsmUnitInqRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                gsmUnitInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                gsmUnitInqRequest.Card= new Card();
                gsmUnitInqRequest.Card.CVV2=request.getParameter("cvv");
                gsmUnitInqRequest.Card.ExpireDate=request.getParameter("expireDate");
                gsmUnitInqRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               gsmUnitInqRequest.Order= new Order();
               gsmUnitInqRequest.Order.OrderID="";
               gsmUnitInqRequest.Order.Description="";
               
               
               gsmUnitInqRequest.Transaction= new Transaction();
               gsmUnitInqRequest.Transaction.Amount="100";
               gsmUnitInqRequest.Transaction.CurrencyCode="949";
               gsmUnitInqRequest.Transaction.Type="gsmunitinq";
               gsmUnitInqRequest.Transaction.MotoInd="H";

               
               gsmUnitInqRequest.Transaction.GSMUnitInq= new GSMUnitInq();
               gsmUnitInqRequest.Transaction.GSMUnitInq.SubscriberCode=request.getParameter("subscriberCode");
               gsmUnitInqRequest.Transaction.GSMUnitInq.InstitutionCode=request.getParameter("institutionCode");
               gsmUnitInqRequest.Transaction.GSMUnitInq.Quantity=request.getParameter("quantity");
               
               String gsmUnitInqResponse = GsmUnitInqRequest.execute(gsmUnitInqRequest,settings); //"GSM TL Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(gsmUnitInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"GSM TL Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />