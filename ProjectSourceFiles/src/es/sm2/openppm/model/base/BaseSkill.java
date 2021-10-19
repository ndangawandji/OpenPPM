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
 * Base Pojo object for domain model class Skill
 * @see es.sm2.openppm.model.base.Skill
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Skill
 */
public class BaseSkill  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "skill";
	
	public static final String IDSKILL = "idSkill";
	public static final String COMPANY = "company";
	public static final String NAME = "name";
	public static final String DESCRIPTION = "description";
	public static final String TEAMMEMBERS = "teammembers";
	public static final String SKILLSEMPLOYEES = "skillsemployees";

     private Integer idSkill;
     private Company company;
     private String name;
     private String description;
     private Set<Teammember> teammembers = new HashSet<Teammember>(0);
     private Set<Skillsemployee> skillsemployees = new HashSet<Skillsemployee>(0);

    public BaseSkill() {
    }
    
    public BaseSkill(Integer idSkill) {
    	this.idSkill = idSkill;
    }
   
    public Integer getIdSkill() {
        return this.idSkill;
    }
    
    public void setIdSkill(Integer idSkill) {
        this.idSkill = idSkill;
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
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Set<Teammember> getTeammembers() {
        return this.teammembers;
    }
    
    public void setTeammembers(Set<Teammember> teammembers) {
        this.teammembers = teammembers;
    }
    public Set<Skillsemployee> getSkillsemployees() {
        return this.skillsemployees;
    }
    
    public void setSkillsemployees(Set<Skillsemployee> skillsemployees) {
        this.skillsemployees = skillsemployees;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idSkill").append("='").append(getIdSkill()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("teammembers").append("='").append(getTeammembers()).append("' \n");	
		buffer.append("skillsemployees").append("='").append(getSkillsemployees()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Skill) )  { result = false; }
		 else if (other != null) {
		 	Skill castOther = (Skill) other;
			if (castOther.getIdSkill().equals(this.getIdSkill())) { result = true; }
         }
		 return result;
   }


}


