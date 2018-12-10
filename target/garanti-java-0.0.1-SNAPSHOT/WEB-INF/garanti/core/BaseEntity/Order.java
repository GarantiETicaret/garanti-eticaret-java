/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.BaseEntity;

import garanti.core.HelperClass.Address;
import garanti.core.HelperClass.Comment;
import garanti.core.HelperClass.Item;
import garanti.core.HelperClass.Recurring;
import garanti.core.HelperClass.Reward;
import java.util.List;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;

/**
 *
 * @author Codevist
 */
public  class Order 
{
    @XmlElement(name = "OrderID")
     public String OrderID ;   
    
     @XmlElement(name = "GroupID")
     public String GroupID ;
     
     
     @XmlElement(name = "Description")
     public String Description ; 
     
     @XmlElement(name = "ListPageNum")
     public String ListPageNum;
     
     @XmlElement(name = "StartDate")
     public String StartDate;
     
     @XmlElement(name = "EndDate")
     public String EndDate;
     
     @XmlElement(name = "Recurring")
     public Recurring Recurring;
     
    @XmlElementWrapper(name = "AddressList")
    @XmlElement(name = "Address")
    public List<Address> AddressList;
     
    @XmlElementWrapper(name = "CommentList")
    @XmlElement(name = "Comment")
    public List<Comment> CommentList;
    
    @XmlElementWrapper(name = "ItemList")
    @XmlElement(name = "Item")
    public List<Item> ItemList;
     
}
