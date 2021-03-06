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
import java.util.HashSet;
import java.util.Set;

 /**
 * Base Pojo object for domain model class Projectcosts
 * @see es.sm2.openppm.model.base.Projectcosts
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Projectcosts
 */
public class BaseProjectcosts  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "projectcosts";
	
	public static final String IDPROJECTCOSTS = "idProjectCosts";
	public static final String PROJECT = "project";
	public static final String COSTDATE = "costDate";
	public static final String EXPENSESES = "expenseses";
	public static final String IWOS = "iwos";
	public static final String DIRECTCOSTSES = "directcostses";

     private Integer idProjectCosts;
     private Project project;
     private Date costDate;
     private Set<Expenses> expenseses = new HashSet<Expenses>(0);
     private Set<Iwo> iwos = new HashSet<Iwo>(0);
     private Set<Directcosts> directcostses = new HashSet<Directcosts>(0);

    public BaseProjectcosts() {
    }
    
    public BaseProjectcosts(Integer idProjectCosts) {
    	this.idProjectCosts = idProjectCosts;
    }
   
    public Integer getIdProjectCosts() {
        return this.idProjectCosts;
    }
    
    public void setIdProjectCosts(Integer idProjectCosts) {
        this.idProjectCosts = idProjectCosts;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public Date getCostDate() {
        return this.costDate;
    }
    
    public void setCostDate(Date costDate) {
        this.costDate = costDate;
    }
    public Set<Expenses> getExpenseses() {
        return this.expenseses;
    }
    
    public void setExpenseses(Set<Expenses> expenseses) {
        this.expenseses = expenseses;
    }
    public Set<Iwo> getIwos() {
        return this.iwos;
    }
    
    public void setIwos(Set<Iwo> iwos) {
        this.iwos = iwos;
    }
    public Set<Directcosts> getDirectcostses() {
        return this.directcostses;
    }
    
    public void setDirectcostses(Set<Directcosts> directcostses) {
        this.directcostses = directcostses;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idProjectCosts").append("='").append(getIdProjectCosts()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("costDate").append("='").append(getCostDate()).append("' \n");	
		buffer.append("expenseses").append("='").append(getExpenseses()).append("' \n");	
		buffer.append("iwos").append("='").append(getIwos()).append("' \n");	
		buffer.append("directcostses").append("='").append(getDirectcostses()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Projectcosts) )  { result = false; }
		 else if (other != null) {
		 	Projectcosts castOther = (Projectcosts) other;
			if (castOther.getIdProjectCosts().equals(this.getIdProjectCosts())) { result = true; }
         }
		 return result;
   }


}


