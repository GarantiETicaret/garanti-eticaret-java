<%-- 
    Document   : saleswithproductinfo
    Created on : Nov 20, 2018, 5:57:35 PM
    Author     : Codevist
--%>
<%@page import="garanti.core.BaseEntity.Settings"%>
<%@page import="garanti.core.BaseEntity.Terminal"%>
<%@page import="garanti.core.BaseEntity.Card"%>
<%@page import="garanti.core.BaseEntity.Customer"%>
<%@page import="garanti.core.BaseEntity.Order"%>
<%@page import="garanti.core.BaseEntity.Transaction"%>
<%@page import="garanti.core.BaseEntity.VPOSRequest"%>
<%@page import="garanti.core.Request.SalesWithProductInfoRequest "%>
<%@page import="garanti.core.HelperClass.Item"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="garanti.core.Helper"%>
<%@page import="javax.xml.bind.JAXB"%>
<%@page import="java.io.StringWriter"%>
<%@page contentType="text/html" pageEncoding="windows-1254"%>
<jsp:include page="layout.jsp" />

<h2>Ürün Bilgileri ile Satýnalma iþlemi </h2>
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
            <label class="col-md-4 control-label" for="">  Ürün Birim Tutarý:</label>
            <div class="col-md-4">
                <input value="" name="price" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Toplam Tutar:</label>
            <div class="col-md-4">
                <input value="" name="totalAmount" class="form-control input-md">
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-4 control-label" for="">  Miktar:</label>
            <div class="col-md-4">
                <input value="" name="quantity" class="form-control input-md">
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
		Ürün Bilgileri ile Satýnalma iþlemi servis çaðrýsýnýn yapýldýðý alaný temsil etmektedir.
		  
		*/
                String orderId =  request.getParameter("orderID");
		Settings settings = new Settings();
		Terminal terminal= new Terminal();
		
		SalesWithProductInfoRequest salesWithProductInfoRequest = new SalesWithProductInfoRequest();  

                salesWithProductInfoRequest.Version=settings.Version;
                salesWithProductInfoRequest.Mode=settings.Mode;
                
		salesWithProductInfoRequest.Terminal=new Terminal();
                salesWithProductInfoRequest.Terminal.ProvUserID=terminal.ProvUserID;
                salesWithProductInfoRequest.Terminal.UserID=terminal.UserID;
                salesWithProductInfoRequest.Terminal.ID=terminal.ID;
                salesWithProductInfoRequest.Terminal.MerchantID=terminal.MerchantID;
                
                salesWithProductInfoRequest.Customer= new Customer();
                salesWithProductInfoRequest.Customer.EmailAddress="eticaret@garanti.com.tr";
                salesWithProductInfoRequest.Customer.IPAddress="127.0.0.1";
                
                
                salesWithProductInfoRequest.Card= new Card();
                salesWithProductInfoRequest.Card.CVV2=request.getParameter("cvv");
                salesWithProductInfoRequest.Card.ExpireDate=request.getParameter("expireDate");
                salesWithProductInfoRequest.Card.Number=request.getParameter("creditCardNo");
                
                
               salesWithProductInfoRequest.Order= new Order();
               salesWithProductInfoRequest.Order.OrderID=orderId;
               salesWithProductInfoRequest.Order.Description="";
               
               salesWithProductInfoRequest.Order.ItemList=new ArrayList<>();
                
               Item item = new Item();
               item.Number="1";
               item.ProductID="1234";
               item.ProductCode="1234";
               item.Quantity=request.getParameter("quantity");
               item.Price=request.getParameter("price");
               item.TotalAmount=request.getParameter("totalAmount");
               item.Description="abcdef";
             
               
               salesWithProductInfoRequest.Order.ItemList.add(item);
              
               
               salesWithProductInfoRequest.Transaction= new Transaction();
               salesWithProductInfoRequest.Transaction.Amount="2000";
               salesWithProductInfoRequest.Transaction.CurrencyCode="949";
               salesWithProductInfoRequest.Transaction.Type="sales";
               salesWithProductInfoRequest.Transaction.MotoInd="N";
               
               String salesWithProductInfoResponse= SalesWithProductInfoRequest.execute(salesWithProductInfoRequest,settings); //ürün Bilgileri ile Satýnalma iþlemi servisi baþlatýlmasý için gerekli servis çaðýrýsýný temsil eder."
               StringWriter sw = new StringWriter();
               JAXB.marshal(salesWithProductInfoResponse, sw);
               out.println("<pre>" + Helper.prettyPrintXml(sw.toString()) + "</pre>"); //"Ürün Bilgileri ile Satýnalma iþlemi servis çaðrýsý sonucunda oluþan servis çýktý parametrelerinin ekranda gösterilmesini saðlar"
	}
%>

<jsp:include page="footer.jsp" />