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
        public String Mode="Test";// Kulland���n�z ortama g�re de�i�tirmelisiniz.       
        public String Version="V0.1";// Sabit Kalmal�  
        public String BaseUrl="https://sanalposprovtest.garanti.com.tr/VPServlet"; //Test Adresi  // �retim otam�na ge�ti�inizde adresi de�i�tirmelisiniz.  
        public String Password="123qweASD/";//Kendi �ifreniz ile de�i�tirmelisiniz. 
}
