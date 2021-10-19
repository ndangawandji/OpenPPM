/*******************************************************************************
 *  Copyright (C) 2009-2012 SM2 BALEARES
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *  See the GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see http://www.gnu.org/licenses/.
 * 
 *  For more information, please contact SM2 BALEARES.
 *  Mail: info@open-ppm.org
 *  Web: http://www.talaia-openppm.es/
 * 
 *  Authors : Javier Hernandez Castillo, Daniel Casas Lopez
 ******************************************************************************/
package es.sm2.openppm.model.base;
import es.sm2.openppm.model.*;


import java.util.Date;

 /**
 * Base Pojo object for domain model class Checklist
 * @see es.sm2.openppm.model.base.Checklist
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Checklist
 */
public class BaseChecklist  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "checklist";
	
	public static final String IDCHECKLIST = "idChecklist";
	public static final String WBSNODE = "wbsnode";
	public static final String CODE = "code";
	public static final String DESCRIPTION = "description";
	public static final String PERCENTAGECOMPLETE = "percentageComplete";
	public static final String ACTUALIZATIONDATE = "actualizationDate";

     private Integer idChecklist;
     private Wbsnode wbsnode;
     private String code;
     private String description;
     private Integer percentageComplete;
     private Date actualizationDate;

    public BaseChecklist() {
    }
    
    public BaseChecklist(Integer idChecklist) {
    	this.idChecklist = idChecklist;
    }
   
    public Integer getIdChecklist() {
        return this.idChecklist;
    }
    
    public void setIdChecklist(Integer idChecklist) {
        this.idChecklist = idChecklist;
    }
    public Wbsnode getWbsnode() {
        return this.wbsnode;
    }
    
    public void setWbsnode(Wbsnode wbsnode) {
        this.wbsnode = wbsnode;
    }
    public String getCode() {
        return this.code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Integer getPercentageComplete() {
        return this.percentageComplete;
    }
    
    public void setPercentageComplete(Integer percentageComplete) {
        this.percentageComplete = percentageComplete;
    }
    public Date getActualizationDate() {
        return this.actualizationDate;
    }
    
    public void setActualizationDate(Date actualizationDate) {
        this.actualizationDate = actualizationDate;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idChecklist").append("='").append(getIdChecklist()).append("' \n");	
		buffer.append("wbsnode").append("='").append(getWbsnode()).append("' \n");	
		buffer.append("code").append("='").append(getCode()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("percentageComplete").append("='").append(getPercentageComplete()).append("' \n");	
		buffer.append("actualizationDate").append("='").append(getActualizationDate()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Checklist) )  { result = false; }
		 else if (other != null) {
		 	Checklist castOther = (Checklist) other;
			if (castOther.getIdChecklist().equals(this.getIdChecklist())) { result = true; }
         }
		 return result;
   }


}


