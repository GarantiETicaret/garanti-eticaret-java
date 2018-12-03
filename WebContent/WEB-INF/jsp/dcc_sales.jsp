<%-- 
    Document   : dcc_sales
    Created on : Nov 20, 2018, 2:44:34 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.DCCSalesRequest"%>
<%@page import="garanti.core.HelperClass.DCC"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>DCC Satýþ </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> sales<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30690133 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 3424113 <br>
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
                <input value="4005520000000129" name="creditCardNo" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Son Kullanma Tarihi Ay/Yýl: </label>
            <div class="col-md-4">
                <input value="1222" name="expireDate" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  CVC: </label>
            <div class="col-md-4">
                <input value="" name="cvv" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  OrderID:</label>
            <div class="col-md-4">
        
                <input value="" name="orderID" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for=""> OriginalRetRefNum Deðeri:</label>
            <div class="col-md-4">
                <input value="" name="originalRetrefNum" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <br />
            <label class="col-md-4 control-label" for=""> Kur :</label>
            <div class="col-md-4">
                <select name="currency">
                    <option value="949">TL</option>
                    <option value="840">USD</option>
                    <option value="978">EUR</option>
                    <option value="826">GBP</option>
                    <option value="392">JPY</option>
                </select>
            </div>
        </div>

    </fieldset>
    <!-- Button -->
    <div class="form-group">
        <label class="col-md-4 control-label" for=""></label>
        <div class="col-md-4">
            <button type="submit" id="" name="" class="btn btn-danger"> Ödeme Yap</button>
        </div>
    </div>
</form>
<%
	request.setCharacterEncoding("UTF-8");

	if ("POST".equalsIgnoreCase(request.getMethod())) {
	
		/* 
		  DCC Sales servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
              
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		DCCSalesRequest dccSalesRequest = new DCCSalesRequest();  

                dccSalesRequest.Version=settings.Version;
                dccSalesRequest.Mode=settings.Mode;
                
		dccSalesRequest.Terminal=new Terminal();
                dccSalesRequest.Terminal.ProvUserID=terminal.ProvUserID;
                dccSalesRequest.Terminal.UserID=terminal.UserID;
                dccSalesRequest.Terminal.ID="30690133";
                dccSalesRequest.Terminal.MerchantID="3424113";
                
                dccSalesRequest.Customer= new Customer();
                dccSalesRequest.Customer.EmailAddr="fatih@codevist.com";
                dccSalesRequest.Customer.IPAddress="127.0.0.1";
                
                
                dccSalesRequest.Card= new Card();
                dccSalesRequest.Card.CVV2=request.getParameter("cvv");
                dccSalesRequest.Card.ExpireDate=request.getParameter("expireDate");
                dccSalesRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               dccSalesRequest.Order= new Order();
               dccSalesRequest.Order.OrderID=request.getParameter("orderID");
               dccSalesRequest.Order.Description="";
               
               
               dccSalesRequest.Transaction= new Transaction();
               dccSalesRequest.Transaction.Amount=request.getParameter("transactionAmount");
               dccSalesRequest.Transaction.CurrencyCode="949";
               dccSalesRequest.Transaction.Type="sales";
               dccSalesRequest.Transaction.MotoInd="H";
               dccSalesRequest.Transaction.SubType="dcc";
               dccSalesRequest.Transaction.OriginalRetrefNum=request.getParameter("originalRetrefNum");
               
                DCC dcc = new DCC();
               dcc.Currency=request.getParameter("currency");
               dccSalesRequest.Transaction.DCC= dcc;

               
               
               String extrePreauthResponse = DCCSalesRequest.execute(dccSalesRequest,settings); //" DCC Sales servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(extrePreauthResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //" DCC Sales  servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
