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



 /**
 * Base Pojo object for domain model class Directcosts
 * @see es.sm2.openppm.model.base.Directcosts
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Directcosts
 */
public class BaseDirectcosts  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "directcosts";
	
	public static final String IDDIRECTCOSTS = "idDirectCosts";
	public static final String PROJECTCOSTS = "projectcosts";
	public static final String BUDGETACCOUNTS = "budgetaccounts";
	public static final String PLANNED = "planned";
	public static final String ACTUAL = "actual";
	public static final String DESCRIPTION = "description";

     private Integer idDirectCosts;
     private Projectcosts projectcosts;
     private Budgetaccounts budgetaccounts;
     private Double planned;
     private Double actual;
     private String description;

    public BaseDirectcosts() {
    }
    
    public BaseDirectcosts(Integer idDirectCosts) {
    	this.idDirectCosts = idDirectCosts;
    }
   
    public Integer getIdDirectCosts() {
        return this.idDirectCosts;
    }
    
    public void setIdDirectCosts(Integer idDirectCosts) {
        this.idDirectCosts = idDirectCosts;
    }
    public Projectcosts getProjectcosts() {
        return this.projectcosts;
    }
    
    public void setProjectcosts(Projectcosts projectcosts) {
        this.projectcosts = projectcosts;
    }
    public Budgetaccounts getBudgetaccounts() {
        return this.budgetaccounts;
    }
    
    public void setBudgetaccounts(Budgetaccounts budgetaccounts) {
        this.budgetaccounts = budgetaccounts;
    }
    public Double getPlanned() {
        return this.planned;
    }
    
    public void setPlanned(Double planned) {
        this.planned = planned;
    }
    public Double getActual() {
        return this.actual;
    }
    
    public void setActual(Double actual) {
        this.actual = actual;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idDirectCosts").append("='").append(getIdDirectCosts()).append("' \n");	
		buffer.append("projectcosts").append("='").append(getProjectcosts()).append("' \n");	
		buffer.append("budgetaccounts").append("='").append(getBudgetaccounts()).append("' \n");	
		buffer.append("planned").append("='").append(getPlanned()).append("' \n");	
		buffer.append("actual").append("='").append(getActual()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Directcosts) )  { result = false; }
		 else if (other != null) {
		 	Directcosts castOther = (Directcosts) other;
			if (castOther.getIdDirectCosts().equals(this.getIdDirectCosts())) { result = true; }
         }
		 return result;
   }


}


