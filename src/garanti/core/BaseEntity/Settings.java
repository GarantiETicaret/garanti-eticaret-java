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
public class Settings
{   
        public String Mode="Test";// Kullandýðýnýz ortama göre deðiþtirmelisiniz.       
        public String Version="V0.1";// Sabit Kalmalý  
        public String BaseUrl="https://sanalposprovtest.garanti.com.tr/VPServlet"; //Test Adresi  // Üretim otamýna geçtiðinizde adresi deðiþtirmelisiniz.  
        public String Password="123qweASD/";//Kendi þifreniz ile deðiþtirmelisiniz. 
}
