<%-- 
    Document   : settlementinq
    Created on : Nov 19, 2018, 5:44:22 PM
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
<%@page import="garanti.core.Request.SettlementInqRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Gün Sonu Sorgulama </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> settlementinq<br>
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
            <label class="col-md-4 control-label" for=""> Tarih:</label>
            <div class="col-md-4">
                <input value="20180312" name="date" class="form-control input-md">
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
		
		SettlementInqRequest settlementInqRequest = new SettlementInqRequest();  

                settlementInqRequest.Version=settings.Version;
                settlementInqRequest.Mode=settings.Mode;
                
		settlementInqRequest.Terminal=new Terminal();
                settlementInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                settlementInqRequest.Terminal.UserID=terminal.UserID;
                settlementInqRequest.Terminal.ID=terminal.ID;
                settlementInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                settlementInqRequest.Customer= new Customer();
                settlementInqRequest.Customer.EmailAddr="fatih@codevist.com";
                settlementInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                settlementInqRequest.Card= new Card();
                settlementInqRequest.Card.CVV2="";
                settlementInqRequest.Card.ExpireDate="";
                settlementInqRequest.Card.Number="";
                
                
               settlementInqRequest.Order= new Order();
               settlementInqRequest.Order.OrderID="";
               settlementInqRequest.Order.Description="";
            
                
               
               settlementInqRequest.Transaction= new Transaction();
               settlementInqRequest.Transaction.Amount="100";
               settlementInqRequest.Transaction.CurrencyCode="949";
               settlementInqRequest.Transaction.Type="settlementinq";
               
               settlementInqRequest.SettlementInq= new SettlementInq();
               settlementInqRequest.SettlementInq.Date=request.getParameter("date");
               
                
               String settlementInqResponse = SettlementInqRequest.execute(settlementInqRequest,settings); //"Gün Sonu Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(settlementInqResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Gün Sonu Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
