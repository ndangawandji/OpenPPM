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
 * Base Pojo object for domain model class Riskcategories
 * @see es.sm2.openppm.model.base.Riskcategories
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Riskcategories
 */
public class BaseRiskcategories  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "riskcategories";
	
	public static final String IDRISKCATEGORY = "idRiskCategory";
	public static final String DESCRIPTION = "description";
	public static final String RISKTYPE = "riskType";
	public static final String MITIGATE = "mitigate";
	public static final String ACCEPT = "accept";
	public static final String RISKREGISTERS = "riskregisters";

     private int idRiskCategory;
     private String description;
     private int riskType;
     private boolean mitigate;
     private boolean accept;
     private Set<Riskregister> riskregisters = new HashSet<Riskregister>(0);

    public BaseRiskcategories() {
    }
    
    public BaseRiskcategories(int idRiskCategory) {
    	this.idRiskCategory = idRiskCategory;
    }
   
    public int getIdRiskCategory() {
        return this.idRiskCategory;
    }
    
    public void setIdRiskCategory(int idRiskCategory) {
        this.idRiskCategory = idRiskCategory;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public int getRiskType() {
        return this.riskType;
    }
    
    public void setRiskType(int riskType) {
        this.riskType = riskType;
    }
    public boolean isMitigate() {
        return this.mitigate;
    }
    
    public void setMitigate(boolean mitigate) {
        this.mitigate = mitigate;
    }
    public boolean isAccept() {
        return this.accept;
    }
    
    public void setAccept(boolean accept) {
        this.accept = accept;
    }
    public Set<Riskregister> getRiskregisters() {
        return this.riskregisters;
    }
    
    public void setRiskregisters(Set<Riskregister> riskregisters) {
        this.riskregisters = riskregisters;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idRiskCategory").append("='").append(getIdRiskCategory()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("riskType").append("='").append(getRiskType()).append("' \n");	
		buffer.append("mitigate").append("='").append(isMitigate()).append("' \n");	
		buffer.append("accept").append("='").append(isAccept()).append("' \n");	
		buffer.append("riskregisters").append("='").append(getRiskregisters()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Riskcategories) )  { result = false; }
		 else if (other != null) {
		 	Riskcategories castOther = (Riskcategories) other;
			if (castOther.getIdRiskCategory() == this.getIdRiskCategory()) { result = true; }
         }
		 return result;
   }


}


