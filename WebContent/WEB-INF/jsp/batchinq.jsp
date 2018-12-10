<%-- 
    Document   : batchinq
    Created on : Nov 19, 2018, 3:05:16 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.BatchInqRequest"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>

<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Batch Sorgulama</h2>
<br />
<fieldset>
    <legend><label style="font-weight:bold;width:250px;">Terminal Bilgileri</label></legend>
    <label style="font-weight:bold;">Servis Adý &nbsp; :   &nbsp; </label> Sales<br>
    <label style="font-weight:bold;">Terminal ID &nbsp; :&nbsp; </label> 30691297 <br>
    <label style="font-weight:bold;">MerchantID  &nbsp;:   &nbsp;</label> 7000679 <br>
    <label style="font-weight:bold;">ProvUserID &nbsp;:  &nbsp;</label> PROVAUT <br>
    <label style="font-weight:bold;">UserID &nbsp;:  &nbsp;</label> PROVAUT<br>
</fieldset>

<form action="" method="post" class="form-horizontal">
    <fieldset>
        <!-- Form Name -->
        <legend><label style="font-weight:bold;width:250px;">Bilgiler</label></legend>
        <!-- Text input-->
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Batch Numarasý:</label>
            <div class="col-md-4">
                <input value="" name="batchNum" class="form-control input-md">
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
		   Batch Sorgulama servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
               Settings settings = new Settings();
               Terminal terminal= new Terminal();
		
               BatchInqRequest batchInqRequest = new BatchInqRequest(); 
               batchInqRequest.Version=settings.Version;
               batchInqRequest.Mode=settings.Mode;
                
               batchInqRequest.Terminal=new Terminal();
               batchInqRequest.Terminal.ProvUserID=terminal.ProvUserID;
               batchInqRequest.Terminal.UserID=terminal.UserID;
               batchInqRequest.Terminal.ID=terminal.ID;
               batchInqRequest.Terminal.MerchantID=terminal.MerchantID;
                
               batchInqRequest.Customer= new Customer();
               batchInqRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
               batchInqRequest.Customer.IPAddress="127.0.0.1";
                
                
               batchInqRequest.Card= new Card();
               batchInqRequest.Card.CVV2="";
               batchInqRequest.Card.ExpireDate="";
               batchInqRequest.Card.Number="";
               
               batchInqRequest.Order= new Order();
               batchInqRequest.Order.OrderID="";
               batchInqRequest.Order.Description="";
               batchInqRequest.Order.ListPageNum="1";
               
               
               batchInqRequest.Transaction= new Transaction();
               batchInqRequest.Transaction.Amount="100";
               batchInqRequest.Transaction.CurrencyCode="949";
               batchInqRequest.Transaction.Type="batchinq";
               batchInqRequest.Transaction.BatchNum=request.getParameter("batchNum");
               
               String batchQueryResponse = BatchInqRequest.execute(batchInqRequest,settings); //"Batch sorgulama servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(batchQueryResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Batch sorgulama servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />
