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


import java.util.HashSet;
import java.util.Set;

 /**
 * Base Pojo object for domain model class Changetype
 * @see es.sm2.openppm.model.base.Changetype
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Changetype
 */
public class BaseChangetype  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "changetype";
	
	public static final String IDCHANGETYPE = "idChangeType";
	public static final String COMPANY = "company";
	public static final String DESCRIPTION = "description";
	public static final String CHANGECONTROLS = "changecontrols";

     private Integer idChangeType;
     private Company company;
     private String description;
     private Set<Changecontrol> changecontrols = new HashSet<Changecontrol>(0);

    public BaseChangetype() {
    }
    
    public BaseChangetype(Integer idChangeType) {
    	this.idChangeType = idChangeType;
    }
   
    public Integer getIdChangeType() {
        return this.idChangeType;
    }
    
    public void setIdChangeType(Integer idChangeType) {
        this.idChangeType = idChangeType;
    }
    public Company getCompany() {
        return this.company;
    }
    
    public void setCompany(Company company) {
        this.company = company;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Set<Changecontrol> getChangecontrols() {
        return this.changecontrols;
    }
    
    public void setChangecontrols(Set<Changecontrol> changecontrols) {
        this.changecontrols = changecontrols;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idChangeType").append("='").append(getIdChangeType()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("changecontrols").append("='").append(getChangecontrols()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Changetype) )  { result = false; }
		 else if (other != null) {
		 	Changetype castOther = (Changetype) other;
			if (castOther.getIdChangeType().equals(this.getIdChangeType())) { result = true; }
         }
		 return result;
   }


}


