/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package garanti.core.HelperClass;

import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Codevist
 */
public class GarantiPayv {
    @XmlElement(name = "GPID")
	public String GPID;
    @XmlElement(name = "Status")
	public String Status;
}
