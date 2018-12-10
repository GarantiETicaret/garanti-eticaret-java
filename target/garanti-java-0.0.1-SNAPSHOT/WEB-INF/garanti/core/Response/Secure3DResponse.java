/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.Response;
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */
public class Secure3DResponse {
    
    @XmlElement(name = "authenticationCode")
	public String authenticationCode;
    @XmlElement(name = "orderID")
	public String orderID;
    @XmlElement(name = "securityLevel")
	public String securityLevel;
    @XmlElement(name = "txnID")
	public String txnID;
    @XmlElement(name = "mode")
	public String mode;
    @XmlElement(name = "MD")
	public String MD;
    @XmlElement(name = "apiversion")
	public String apiversion;
    @XmlElement(name = "terminalProvUserID")
	public String terminalProvUserID;
    @XmlElement(name = "installmentCount")
	public String installmentCount;
    @XmlElement(name = "currencyCode")
	public String currencyCode;
    @XmlElement(name = "amount")
	public String amount;
    @XmlElement(name = "terminalUserID")
	public String terminalUserID;
    @XmlElement(name = "terminalID")
	public String terminalID;
    @XmlElement(name = "customerIpAddres")
	public String customerIpAddres;
    @XmlElement(name = "customerEmailAddress")
	public String customerEmailAddress;
    @XmlElement(name = "terminalMerchantID")
	public String terminalMerchantID;
    @XmlElement(name = "txnType")
	public String txnType;
    @XmlElement(name = "authcode")
	public String authcode;
    @XmlElement(name = "procreturnCode")
	public String procreturnCode;
    @XmlElement(name = "response")
	public String response;
    @XmlElement(name = "mdstatus")
	public String mdstatus;
    @XmlElement(name = "rnd")
	public String rnd;
    @XmlElement(name = "xmlResponse")
	public String xmlResponse;

    
    

}
