/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.HelperClass;

import garanti.core.BaseEntity.Transaction;
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */
  public class BINInq extends Transaction
  {
      @XmlElement(name = "Group")
      public String Group ; 
      @XmlElement(name = "CardType")
      public String CardType ; 
  }