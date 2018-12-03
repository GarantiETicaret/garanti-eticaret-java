<%-- 
    Document   : commercialcardextendedcredit
    Created on : Nov 20, 2018, 12:18:11 PM
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
<%@page import="garanti.core.Request.CommercialCardExtendedCreditRequest"%>
<%@page import="garanti.core.HelperClass.CommercialCardExtendedCredit"%>
<%@page import="garanti.core.HelperClass.Payment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Ortak Kart Ýle Satýþ </h2>
<br />
<fieldset>

    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> commercialcardextendedcredit<br>
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
            <label class="col-md-4 control-label" for="">  Ödeme Listesi:</label>
            <div class="col-md-4">
                <table border="1">
                    <tr>
                        <td><label class="col-md-4 control-label" for="">Sýra</label></td>
                        <td><label class="col-md-4 control-label" for="">  Ödeme Zamaný </label></td>
                        <td><label class="col-md-4 control-label" for="">  Tutar</label></td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>20181214</td>
                        <td>1200</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>20190114</td>
                        <td>1200</td>
                    </tr>
                </table>
            </div>
        </div>
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
            <label class="col-md-4 control-label" for="">  OrderID:</label>
            <div class="col-md-4">
                
               <input value= '<%=UUID.randomUUID().toString().replace("-", "")%>'   name="orderID" class="form-control input-md">

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Ýþlem Tutarý:</label>
            <div class="col-md-4">
                <input value="2400" name="transactionAmount" class="form-control input-md" readonly>
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
		  Ortak Kart Ön Otorizasyon çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId =  request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		CommercialCardExtendedCreditRequest commercialCardExtendedCreditRequest = new CommercialCardExtendedCreditRequest();  

                commercialCardExtendedCreditRequest.Version=settings.Version;
                commercialCardExtendedCreditRequest.Mode=settings.Mode;
                
		commercialCardExtendedCreditRequest.Terminal=new Terminal();
                commercialCardExtendedCreditRequest.Terminal.ProvUserID=terminal.ProvUserID;
                commercialCardExtendedCreditRequest.Terminal.UserID=terminal.UserID;
                commercialCardExtendedCreditRequest.Terminal.ID=terminal.ID;
                commercialCardExtendedCreditRequest.Terminal.MerchantID=terminal.MerchantID;
                
                commercialCardExtendedCreditRequest.Customer= new Customer();
                commercialCardExtendedCreditRequest.Customer.EmailAddr="fatih@codevist.com";
                commercialCardExtendedCreditRequest.Customer.IPAddress="127.0.0.1";
                
                
                commercialCardExtendedCreditRequest.Card= new Card();
                commercialCardExtendedCreditRequest.Card.CVV2=request.getParameter("cvv");
                commercialCardExtendedCreditRequest.Card.ExpireDate=request.getParameter("expireDate");
                commercialCardExtendedCreditRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               commercialCardExtendedCreditRequest.Order= new Order();
               commercialCardExtendedCreditRequest.Order.OrderID=orderId;
               commercialCardExtendedCreditRequest.Order.Description="";
               
               commercialCardExtendedCreditRequest.Transaction= new Transaction();
               commercialCardExtendedCreditRequest.Transaction.Amount=request.getParameter("transactionAmount");
               commercialCardExtendedCreditRequest.Transaction.CurrencyCode="949";
               commercialCardExtendedCreditRequest.Transaction.Type="commercialcardextendedcredit";
               commercialCardExtendedCreditRequest.Transaction.MotoInd="N";
               commercialCardExtendedCreditRequest.Transaction.InstallmentCnt="2";
               
               
               commercialCardExtendedCreditRequest.Transaction.CommercialCardExtendedCredit= new CommercialCardExtendedCredit();
               commercialCardExtendedCreditRequest.Transaction.CommercialCardExtendedCredit.Payment=new ArrayList<>();
                
               Payment payment1 = new Payment();
               payment1.Number="1";
               payment1.DueDate="20181214";
               payment1.Amount="1200";
               commercialCardExtendedCreditRequest.Transaction.CommercialCardExtendedCredit.Payment.add(payment1);
               Payment payment2 = new Payment();
               payment2.Number="2";
               payment2.DueDate="20190114";
               payment2.Amount="1200";
               commercialCardExtendedCreditRequest.Transaction.CommercialCardExtendedCredit.Payment.add(payment2);
               
               
               
         
               String commercialCardExtendedCreditResponse= CommercialCardExtendedCreditRequest.execute(commercialCardExtendedCreditRequest,settings); //Ortak Kart Ön Otorizasyon servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(commercialCardExtendedCreditResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ortak Kart Ön Otorizasyon servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />



