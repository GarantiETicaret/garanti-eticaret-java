<%@page import="java.util.UUID"%>
<%@page import="java.io.PrintWriter"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@page
	contentType="text/html"
	pageEncoding="UTF-8"
%>
<title>Garanti Developer Portal</title>
<link
	href="<%=request.getContextPath()%>/Content/css/bootstrap.min.css"
	rel="stylesheet"
	type="text/css"
/>
<link
	href="<%=request.getContextPath()%>/Content/css/jquery.mCustomScrollbar.min.css"
	rel="stylesheet"
	type="text/css"
/>
<link
	href="<%=request.getContextPath()%>/Content/css/style.css"
	rel="stylesheet"
	type="text/css"
/>
</head>
<body>
        
    
    <div class="wrapper">
           <nav id="sidebar">
            <div class="sidebar-header">
                <a href="/garanti-java/index.htm"><img 
                        src="<%=request.getContextPath()%>/Content/img/logo.png"
                        width="165" height="90" /></a>
                
            </div>
            <ul class="list-unstyled components">
                <li>
                    <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false">İşlem Servisleri</a>
                    <ul class="collapse list-unstyled" id="homeSubmenu">
                      <li><a href="index.htm">Satış (Sales)</a></li>
                       <li><a href="saleswithproductinfo.htm">Ürün Bilgisi ile Satış İşlemi</a></li>
                       <li><a href="saleswith_addressinfo.htm">Adres Bilgisi ile Satış İşlemi</a></li>
                       <li><a href="saleswithcommentinfo.htm">Özel Alan Bilgisi ile Satış İşlemi</a></li>
                      <li><a href="installment_sales.htm">Taksitli Satış</a></li>
                       <li><a href="void.htm">İptal (Void)</a></li>
                       <li><a href="refund.htm">İade (Refund)</a></li>
                       <li><a href="delaysales.htm">Ötemeli Satış</a></li>
                       <li><a href="downpayment_sales.htm">Peşinatlı Satış</a></li>
                       <li><a href="rewardsales.htm">Bonus Kullanım</a></li>
                       <li><a href="firmrewardsales.htm">Firma Bonus</a></li>
                       <li><a href="playerchequesales.htm">Player Çek</a></li>
                        <li><a href="productcheque.htm">Sözünüze Ürün Çek</a></li>
                        <li><a href="preauth.htm">Ön Otorizasyon (preauth)</a></li>
                        <li><a href="postauth.htm">Ön Otorizasyon Kapama (postauth)</a></li>
                        <li><a href="extented_creditsales.htm">Tüketici Kredisi (extentedcredit)</a></li>
                        <li><a href="dcc_sales.htm">DCC Satış (DCC)</a></li>
                        <li><a href="extrepreauth.htm">Ekstre Doğrulama/Ön Otorizasyon</a></li>
                        <li><a href="extrepostauth.htm">Ekstre Doğrulama/Otorizasyon Kapama</a></li>
                        <li><a href="firmcardrel.htm">Firma Kart Eşleştirme (firmcardrel)</a></li>
                        <li><a href="firmcardsales.htm">Firma Kart İle Satış (firmcardsales)</a></li>
                        <li><a href="firmcardpreauth.htm">Firma Ön otorizasyon (firmcardpreauth)</a></li>
                        <li><a href="commercialcardextendedcredit.htm">Ortak Kart Satış (commercialcardextendedcredit)</a></li>
                        <li><a href="commercialcardpreauth.htm">Ortak Kart Ön Otorizasyon (commercialcardpreauth)</a></li>
                        <li><a href="sms_preauth.htm">Sms Doğrulama/Ön Otorizasyon</a></li>
                        <li><a href="sms_postauth.htm">Sms Doğrulama/Otorizasyon Kapama</a></li>
                        <li><a href="recurring_sales.htm">Sabit Tekrarlayan Satış</a></li>
                        <li><a href="vrecurring_sales.htm">Değişken Tekrarlayan Satış</a></li>
                        <li><a href="recurring_void.htm">Tekrarlayan İptal</a></li>
                        <li><a href="recurring_update.htm">Tekrarlayan Update</a></li>
                        <li><a href="utility_payment.htm">Fatura Ödeme (utilitypayment)</a></li>
                        <li><a href="gsmunit_sales.htm">GSM TL Yükleme (gsmunitsales)</a></li>
                        
                    </ul>
                </li>
                  <li>
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false">Host Sorgu Servisleri</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">

                        <li><a href="rewardinquiry.htm">Bonus Sorgulama</a></li>
                        <li><a href="extended_creditinquiry.htm">Tüketici Kredisi Sorgulama</a></li>
                        <li><a href="commercial_cardlimitinq.htm">Ortak Kart Limit Sorgulama</a></li>
                        <li><a href="dcc_inquiry.htm">DCC Doğrulama</a></li>
                        <li><a href="utility_paymentinq.htm">Fatura Sorgu</a></li>
                        <li><a href="gsm_unitinq.htm">GSM TL Sorgu</a></li>
                        <li><a href="identityinq.htm">TCKN Doğrulama</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#pageSubmenu2" data-toggle="collapse" aria-expanded="false">Sanal POS Sorgulamaları</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu2">

                        <li><a href="orderinq.htm">Sipariş Sorgu</a></li>
                        <li><a href="orderhistoryinq.htm">Sipariş Detay Sorgu</a></li>
                        <li><a href="orderlistinq.htm">Tarih Aralığı İşlem Sorgu</a></li>
                        <li><a href="batchinq.htm">Batch Sorgulama</a></li>
                        <li><a href="bininq.htm">BIN Sorgulama</a></li>
                        <li><a href="orderiteminq.htm">Ürün Sorgulama</a></li>
                        <li><a href="cardtxnlistinq.htm">KartNo ile İşlem Sorgulama</a></li>
                        <li><a href="settlementinq.htm">Gün Sonu Sorgulama (settlementinq)</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#pageSubmenu3" data-toggle="collapse" aria-expanded="false">3D Secure İşlemler</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu3">
                        <li><a href="sale3dsecure.htm">3D Secure İşlem</a></li>
                        <li><a href="sale3doospay.htm">3D OOS Ödeme</a></li>
                        <li><a href="sale3dpay.htm">3D Pay Ödeme</a></li>
                        <li><a href="saleoospay.htm">OOS Pay Ödeme</a></li>
                        <li><a href="garantipay.htm">Garanti Pay Ödeme</a></li>
                        <li><a href="garantipaymo.htm">Garanti Pay Mail Order ile Ödeme</a></li>
                        <li><a href="garantipayvoid.htm">Garanti Pay İşlem İptali</a></li>
                        <li><a href="garantipayapp.htm">Garanti Pay App ile Ödeme</a></li>
                    </ul>
                </li>
            </ul>  
        </nav>
     <div id="content">
            <nav class="navbar navbar-default">
                <div class="container-fluid">

                    <div class="navbar-header">
                        <button type="button" id="sidebarCollapse" class="btn btn-info navbar-btn">
                            <i class="glyphicon glyphicon-align-left"></i>
                        </button>
                    </div>
                </div>
            </nav>
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
