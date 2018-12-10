<%-- 
    Document   : saleswith_addressinfo
    Created on : Nov 20, 2018, 5:43:09 PM
    Author     : Codevist
--%>

<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.SalesWithCommentInfoRequest "%>
<%@page import="garanti.core.HelperClass.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />
<h2>Özel Alan Bilgileri ile Satýnalma iþlemi </h2>
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
            <label class="col-md-4 control-label" for="">  OrderID:</label>
            <div class="col-md-4">
                
               <input value= '<%=UUID.randomUUID().toString().replace("-", "")%>'   name="orderID" class="form-control input-md">

            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Tutar:</label>
            <div class="col-md-4">
                <input value="" name="transactionAmount" class="form-control input-md">
            </div>
        </div>
               <div class="form-group">
            <label class="col-md-4 control-label" for="">  Bilgi Numarasý:</label>
            <div class="col-md-4">
                <input value="" name="number" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Bilgi text:</label>
            <div class="col-md-4">
                <input value="" name="text" class="form-control input-md">
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
		Adres Bilgileri ile Satýnalma iþlemi servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId =  request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		SalesWithCommentInfoRequest salesWithCommentInfoRequest = new SalesWithCommentInfoRequest();  

                salesWithCommentInfoRequest.Version=settings.Version;
                salesWithCommentInfoRequest.Mode=settings.Mode;
                
		salesWithCommentInfoRequest.Terminal=new Terminal();
                salesWithCommentInfoRequest.Terminal.ProvUserID=terminal.ProvUserID;
                salesWithCommentInfoRequest.Terminal.UserID=terminal.UserID;
                salesWithCommentInfoRequest.Terminal.ID=terminal.ID;
                salesWithCommentInfoRequest.Terminal.MerchantID=terminal.MerchantID;
                
                salesWithCommentInfoRequest.Customer= new Customer();
                salesWithCommentInfoRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                salesWithCommentInfoRequest.Customer.IPAddress="127.0.0.1";
                
                
                salesWithCommentInfoRequest.Card= new Card();
                salesWithCommentInfoRequest.Card.CVV2=request.getParameter("cvv");
                salesWithCommentInfoRequest.Card.ExpireDate=request.getParameter("expireDate");
                salesWithCommentInfoRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               salesWithCommentInfoRequest.Order= new Order();
               salesWithCommentInfoRequest.Order.OrderID=orderId;
               salesWithCommentInfoRequest.Order.Description="";
               
               

               
               salesWithCommentInfoRequest.Order.CommentList=new ArrayList<>();
                
               Comment comment = new Comment();
               comment.Number=Integer.parseInt(request.getParameter("number"));
               comment.Text=request.getParameter("text");
               
               salesWithCommentInfoRequest.Order.CommentList.add(comment);
              
               
               salesWithCommentInfoRequest.Transaction= new Transaction();
               salesWithCommentInfoRequest.Transaction.Amount=request.getParameter("transactionAmount");
               salesWithCommentInfoRequest.Transaction.CurrencyCode="949";
               salesWithCommentInfoRequest.Transaction.Type="sales";
               salesWithCommentInfoRequest.Transaction.MotoInd="N";
               
               
               
         
               String salesWithCommentInfoResponse= SalesWithCommentInfoRequest.execute(salesWithCommentInfoRequest,settings); //Özel Alan Bilgileri ile Satýnalma iþlemi servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(salesWithCommentInfoResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Özel Alan ile Satýnalma iþlemi servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />