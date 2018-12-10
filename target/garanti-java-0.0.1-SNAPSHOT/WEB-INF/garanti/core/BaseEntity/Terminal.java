/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.BaseEntity;

import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */
public class Terminal 
{
        @XmlElement(name = "ProvUserID")
        public String ProvUserID ="PROVAUT"; //Garanti bankasý tarafýndan saðlanan kendi bilgileriniz ile deðiþtirmelisiniz. 
        @XmlElement(name = "UserID")
        public String UserID ="PROVAUT";//Garanti bankasý tarafýndan saðlanan kendi bilgileriniz ile deðiþtirmelisiniz. 
        @XmlElement(name = "ID")
        public String ID="30691297";// Garanti bankasý tarafýndan saðlanan kendi bilgileriniz ile deðiþtirmelisiniz. 
        @XmlElement(name = "MerchantID")
        public String MerchantID="7000679";//Garanti bankasý tarafýndan saðlanan kendi bilgileriniz ile deðiþtirmelisiniz. 
        @XmlElement(name = "HashData")
        public String HashData="";//Hash data sonradan hesaplanacak.
        
}
