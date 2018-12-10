/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.HelperClass;

import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;

/**
 *
 * @author Codevist
 */
public class GarantiPaYApp {
     @XmlElement(name = "bnsuseflag")
      public String bnsuseflag ; 
 
    @XmlElement(name = "fbbuseflag")
      public String fbbuseflag ; 
    @XmlElement(name = "chequeuseflag")
      public String chequeuseflag ; 
 
    @XmlElement(name = "mileuseflag")
      public String mileuseflag ; 
    @XmlElement(name = "CompanyName")
      public String CompanyName ; 
 
   
    @XmlElement(name = "TxnTimeOutPeriod")
      public String TxnTimeOutPeriod ; 
 
    @XmlElement(name = "NotifSendInd")
      public String NotifSendInd ; 
    @XmlElement(name = "ReturnUrl")
      public String ReturnUrl ; 
 
    @XmlElement(name = "TCKN")
      public String TCKN ; 
    @XmlElement(name = "GSMNumber")
      public String GSMNumber ; 
 
    @XmlElement(name = "InstallmentOnlyForCommercialCard")
      public String InstallmentOnlyForCommercialCard ; 
    @XmlElement(name = "TotalInstallmentCount")
      public String TotalInstallmentCount ; 
 
    @XmlElementWrapper(name = "GPInstallments")
    @XmlElement(name = "Installment")
    public List<GPInstallments> GPInstallmentsList;
}
