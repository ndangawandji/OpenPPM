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
 * Base Pojo object for domain model class Skillsemployee
 * @see es.sm2.openppm.model.base.Skillsemployee
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Skillsemployee
 */
public class BaseSkillsemployee  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "skillsemployee";
	
	public static final String IDSKILLSEMPLOYEE = "idSkillsEmployee";
	public static final String SKILL = "skill";
	public static final String EMPLOYEE = "employee";

     private Integer idSkillsEmployee;
     private Skill skill;
     private Employee employee;

    public BaseSkillsemployee() {
    }
    
    public BaseSkillsemployee(Integer idSkillsEmployee) {
    	this.idSkillsEmployee = idSkillsEmployee;
    }
   
    public Integer getIdSkillsEmployee() {
        return this.idSkillsEmployee;
    }
    
    public void setIdSkillsEmployee(Integer idSkillsEmployee) {
        this.idSkillsEmployee = idSkillsEmployee;
    }
    public Skill getSkill() {
        return this.skill;
    }
    
    public void setSkill(Skill skill) {
        this.skill = skill;
    }
    public Employee getEmployee() {
        return this.employee;
    }
    
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idSkillsEmployee").append("='").append(getIdSkillsEmployee()).append("' \n");	
		buffer.append("skill").append("='").append(getSkill()).append("' \n");	
		buffer.append("employee").append("='").append(getEmployee()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Skillsemployee) )  { result = false; }
		 else if (other != null) {
		 	Skillsemployee castOther = (Skillsemployee) other;
			if (castOther.getIdSkillsEmployee().equals(this.getIdSkillsEmployee())) { result = true; }
         }
		 return result;
   }


}


