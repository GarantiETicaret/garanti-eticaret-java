<%-- 
    Document   : identityinq
    Created on : Nov 20, 2018, 9:10:02 AM
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
<%@page import="garanti.core.Request.IdentityInqRequest"%>
<%@page import="garanti.core.HelperClass.Verification"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>TCKN Sorgulama</h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> identifyinq<br>
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
            <label class="col-md-4 control-label" for=""> Tc Numarasý:</label>
            <div class="col-md-4">
                <input value="" name="identity" class="form-control input-md">
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
		 TCKN Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		IdentityInqRequest identityInqRequest = new IdentityInqRequest();  

                identityInqRequest.Version=settings.Version;
                identityInqRequest.Mode=settings.Mode;
                
		identityInqRequest.Terminal=new Terminal();
                identityInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                identityInqRequest.Terminal.UserID=terminal.UserID;
                identityInqRequest.Terminal.ID=terminal.ID;
                identityInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                identityInqRequest.Customer= new Customer();
                identityInqRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                identityInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                identityInqRequest.Card= new Card();
                identityInqRequest.Card.CVV2=request.getParameter("cvv");
                identityInqRequest.Card.ExpireDate=request.getParameter("expireDate");
                identityInqRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               identityInqRequest.Order= new Order();
               identityInqRequest.Order.OrderID="";
               identityInqRequest.Order.Description="";
               
               
               identityInqRequest.Transaction= new Transaction();
               identityInqRequest.Transaction.Amount="100";
               identityInqRequest.Transaction.CurrencyCode="949";
               identityInqRequest.Transaction.Type="identifyinq";
               identityInqRequest.Transaction.MotoInd="H";

               
               identityInqRequest.Transaction.Verification= new Verification();
               identityInqRequest.Transaction.Verification.Identity=request.getParameter("identity");
               
               
               String identityResponse = IdentityInqRequest.execute(identityInqRequest,settings); //"TCKN Sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(identityResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"TCKN Sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />