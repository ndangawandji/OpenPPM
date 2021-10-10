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
 * Base Pojo object for domain model class Fundingsource
 * @see es.sm2.openppm.model.base.Fundingsource
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Fundingsource
 */
public class BaseFundingsource  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "fundingsource";
	
	public static final String IDFUNDINGSOURCE = "idFundingSource";
	public static final String COMPANY = "company";
	public static final String NAME = "name";
	public static final String PROJECTS = "projects";

     private Integer idFundingSource;
     private Company company;
     private String name;
     private Set<Project> projects = new HashSet<Project>(0);

    public BaseFundingsource() {
    }
    
    public BaseFundingsource(Integer idFundingSource) {
    	this.idFundingSource = idFundingSource;
    }
   
    public Integer getIdFundingSource() {
        return this.idFundingSource;
    }
    
    public void setIdFundingSource(Integer idFundingSource) {
        this.idFundingSource = idFundingSource;
    }
    public Company getCompany() {
        return this.company;
    }
    
    public void setCompany(Company company) {
        this.company = company;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set<Project> getProjects() {
        return this.projects;
    }
    
    public void setProjects(Set<Project> projects) {
        this.projects = projects;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idFundingSource").append("='").append(getIdFundingSource()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("projects").append("='").append(getProjects()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Fundingsource) )  { result = false; }
		 else if (other != null) {
		 	Fundingsource castOther = (Fundingsource) other;
			if (castOther.getIdFundingSource().equals(this.getIdFundingSource())) { result = true; }
         }
		 return result;
   }


}


