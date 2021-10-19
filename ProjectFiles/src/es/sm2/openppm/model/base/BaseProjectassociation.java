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
 * Base Pojo object for domain model class Projectassociation
 * @see es.sm2.openppm.model.base.Projectassociation
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Projectassociation
 */
public class BaseProjectassociation  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "projectassociation";
	
	public static final String IDPROJECTASSOCIATION = "idProjectAssociation";
	public static final String PROJECTBYLEAD = "projectByLead";
	public static final String PROJECTBYDEPENDENT = "projectByDependent";

     private Integer idProjectAssociation;
     private Project projectByLead;
     private Project projectByDependent;

    public BaseProjectassociation() {
    }
    
    public BaseProjectassociation(Integer idProjectAssociation) {
    	this.idProjectAssociation = idProjectAssociation;
    }
   
    public Integer getIdProjectAssociation() {
        return this.idProjectAssociation;
    }
    
    public void setIdProjectAssociation(Integer idProjectAssociation) {
        this.idProjectAssociation = idProjectAssociation;
    }
    public Project getProjectByLead() {
        return this.projectByLead;
    }
    
    public void setProjectByLead(Project projectByLead) {
        this.projectByLead = projectByLead;
    }
    public Project getProjectByDependent() {
        return this.projectByDependent;
    }
    
    public void setProjectByDependent(Project projectByDependent) {
        this.projectByDependent = projectByDependent;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idProjectAssociation").append("='").append(getIdProjectAssociation()).append("' \n");	
		buffer.append("projectByLead").append("='").append(getProjectByLead()).append("' \n");	
		buffer.append("projectByDependent").append("='").append(getProjectByDependent()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Projectassociation) )  { result = false; }
		 else if (other != null) {
		 	Projectassociation castOther = (Projectassociation) other;
			if (castOther.getIdProjectAssociation().equals(this.getIdProjectAssociation())) { result = true; }
         }
		 return result;
   }


}


