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
 * Base Pojo object for domain model class Resourceprofiles
 * @see es.sm2.openppm.model.base.Resourceprofiles
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Resourceprofiles
 */
public class BaseResourceprofiles  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "resourceprofiles";
	
	public static final String IDPROFILE = "idProfile";
	public static final String PROFILENAME = "profileName";
	public static final String DESCRIPTION = "description";
	public static final String EMPLOYEES = "employees";

     private int idProfile;
     private String profileName;
     private String description;
     private Set<Employee> employees = new HashSet<Employee>(0);

    public BaseResourceprofiles() {
    }
    
    public BaseResourceprofiles(int idProfile) {
    	this.idProfile = idProfile;
    }
   
    public int getIdProfile() {
        return this.idProfile;
    }
    
    public void setIdProfile(int idProfile) {
        this.idProfile = idProfile;
    }
    public String getProfileName() {
        return this.profileName;
    }
    
    public void setProfileName(String profileName) {
        this.profileName = profileName;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Set<Employee> getEmployees() {
        return this.employees;
    }
    
    public void setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idProfile").append("='").append(getIdProfile()).append("' \n");	
		buffer.append("profileName").append("='").append(getProfileName()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("employees").append("='").append(getEmployees()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Resourceprofiles) )  { result = false; }
		 else if (other != null) {
		 	Resourceprofiles castOther = (Resourceprofiles) other;
			if (castOther.getIdProfile() == this.getIdProfile()) { result = true; }
         }
		 return result;
   }


}


