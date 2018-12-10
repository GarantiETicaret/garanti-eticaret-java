<%-- 
    Document   : bininq
    Created on : Nov 19, 2018, 12:16:50 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.BINInqRequest"%>
<%@page import="garanti.core.HelperClass.BINInq"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>

<jsp:include page="layout.jsp" />
<h2>BIN Sorgulama</h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> bininq<br>
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
            <label class="col-md-4 control-label" for="">  Kart Tipi:</label>
            <div class="col-md-4">
                <input value="A" name="cardType" class="form-control input-md" >
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Grup Tipi:</label>
            <div class="col-md-4">
                <input value="A" name="groupType" class="form-control input-md" >
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
		   BIN Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		BINInqRequest binInqRequest = new BINInqRequest();  

                binInqRequest.Version=settings.Version;
                binInqRequest.Mode=settings.Mode;
                
		binInqRequest.Terminal=new Terminal();
                binInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
                binInqRequest.Terminal.UserID=terminal.UserID;
                binInqRequest.Terminal.ID=terminal.ID;
                binInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
                binInqRequest.Customer= new Customer();
                binInqRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                binInqRequest.Customer.IPAddress="127.0.0.1";
                
                
                binInqRequest.Card= new Card();
                binInqRequest.Card.CVV2="";
                binInqRequest.Card.ExpireDate="";
                binInqRequest.Card.Number="";
                
                
               binInqRequest.Order= new Order();
               binInqRequest.Order.OrderID="";
               binInqRequest.Order.Description="";
                
               binInqRequest.Transaction= new Transaction();
               binInqRequest.Transaction.Amount="100";
               binInqRequest.Transaction.CurrencyCode="949";
               binInqRequest.Transaction.Type="bininq";
               
               binInqRequest.Transaction.BINInq= new  BINInq();
               binInqRequest.Transaction.BINInq.Group=request.getParameter("groupType");
               binInqRequest.Transaction.BINInq.CardType=request.getParameter("cardType");
               
                
		String binQueryResponse = BINInqRequest.execute(binInqRequest,settings); //"Bin sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
		StringWriter sw = new StringWriter();
                JAXB.marshal(binQueryResponse, sw);
		out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Bin sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
