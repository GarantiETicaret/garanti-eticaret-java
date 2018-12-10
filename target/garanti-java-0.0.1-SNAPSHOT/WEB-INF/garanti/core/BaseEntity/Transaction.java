/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.BaseEntity;


import garanti.core.HelperClass.BINInq;
import garanti.core.HelperClass.Cheque;
import garanti.core.HelperClass.CommercialCardExtendedCredit;
import garanti.core.HelperClass.DCC;
import garanti.core.HelperClass.GSMUnitInq;
import garanti.core.HelperClass.GSMUnitSales;
import garanti.core.HelperClass.GarantiPaY;
import garanti.core.HelperClass.GarantiPaYApp;
import garanti.core.HelperClass.GarantiPayv;
import garanti.core.HelperClass.Payment;
import garanti.core.HelperClass.Reward;
import garanti.core.HelperClass.Secure3D;
import garanti.core.HelperClass.UtilityPayment;
import garanti.core.HelperClass.UtilityPaymentInq;
import garanti.core.HelperClass.Verification;
import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;


/**
 *
 * @author Codevist
 */
public class Transaction 
{
    @XmlElement(name = "Type")
     public String Type ;   
    
    @XmlElement(name = "Amount")
        public String Amount ;  
    
    @XmlElement(name = "CurrencyCode")
    public String CurrencyCode ;  
     
    @XmlElement(name = "BINInq")
    public BINInq BINInq ;  
   
      
    @XmlElement(name = "BatchNum")
    public String BatchNum;
       
    @XmlElement(name = "MotoInd")
    public String MotoInd;
    
    @XmlElement(name = "SubType")
    public String SubType;
    
    @XmlElement(name = "CardholderPresentCode")
    public String CardholderPresentCode;
       
    @XmlElement(name = "InstallmentCnt")
    public String InstallmentCnt;
       
    @XmlElement(name = "UtilityPaymentInq") 
    public UtilityPaymentInq UtilityPaymentInq ;
     
    @XmlElement(name = "GSMUnitInq") 
    public GSMUnitInq GSMUnitInq ;
     
    @XmlElement(name = "Verification") 
    public Verification Verification ;
    
    @XmlElement(name = "GSMUnitSales") 
    public GSMUnitSales GSMUnitSales ;
   
    @XmlElement(name = "UtilityPayment") 
    public UtilityPayment UtilityPayment ;
   
    @XmlElement(name = "CommercialCardExtendedCredit") 
    public CommercialCardExtendedCredit CommercialCardExtendedCredit ;
    
    @XmlElement(name = "FirmCardNo")
    public String FirmCardNo;
    
    @XmlElement(name = "OriginalRetrefNum")
    public String OriginalRetrefNum;
    
    @XmlElement(name = "DCC")
    public DCC DCC;
    
    
    @XmlElementWrapper(name = "ChequeList")
    @XmlElement(name = "Cheque")
    public List<Cheque> ChequeList;
    
    @XmlElementWrapper(name = "RewardList")
    @XmlElement(name = "Reward")
    public List<Reward> RewardList;
    
    @XmlElement(name = "DownPaymentRate")
    public String DownPaymentRate;
    
    @XmlElement(name = "DelayDayCount")
    public String DelayDayCount;
    
     @XmlElement(name = "ReturnServerUrl")
      public String ReturnServerUrl ; 
    
   @XmlElement(name = "AuthenticationCode")
        public String AuthenticationCode;
   @XmlElement(name = "SecurityLevel")
        public String SecurityLevel ;
   @XmlElement(name = "TxnID")
        public String TxnID ;
        @XmlElement(name = "Md")
        public String Md ;
        
        @XmlElement(name = "Secure3D")
    public Secure3D Secure3D;
         @XmlElement(name = "GarantiPaY")
   public GarantiPaYApp GarantiPaY;
         
          @XmlElement(name = "GarantiPaY")
   public GarantiPaY GarantiPaYMO;
          
          
    @XmlElement(name = "GarantiPaY")
	public GarantiPayv GarantiPayV;
}
