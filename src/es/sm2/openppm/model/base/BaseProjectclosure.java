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
 * Base Pojo object for domain model class Projectclosure
 * @see es.sm2.openppm.model.base.Projectclosure
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Projectclosure
 */
public class BaseProjectclosure  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "projectclosure";
	
	public static final String IDPROJECTCLOUSE = "idProjectClouse";
	public static final String PROJECT = "project";
	public static final String PROJECTRESULTS = "projectResults";
	public static final String GOALACHIEVEMENT = "goalAchievement";
	public static final String LESSONSLEARNED = "lessonsLearned";

     private Integer idProjectClouse;
     private Project project;
     private String projectResults;
     private String goalAchievement;
     private String lessonsLearned;

    public BaseProjectclosure() {
    }
    
    public BaseProjectclosure(Integer idProjectClouse) {
    	this.idProjectClouse = idProjectClouse;
    }
   
    public Integer getIdProjectClouse() {
        return this.idProjectClouse;
    }
    
    public void setIdProjectClouse(Integer idProjectClouse) {
        this.idProjectClouse = idProjectClouse;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public String getProjectResults() {
        return this.projectResults;
    }
    
    public void setProjectResults(String projectResults) {
        this.projectResults = projectResults;
    }
    public String getGoalAchievement() {
        return this.goalAchievement;
    }
    
    public void setGoalAchievement(String goalAchievement) {
        this.goalAchievement = goalAchievement;
    }
    public String getLessonsLearned() {
        return this.lessonsLearned;
    }
    
    public void setLessonsLearned(String lessonsLearned) {
        this.lessonsLearned = lessonsLearned;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idProjectClouse").append("='").append(getIdProjectClouse()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("projectResults").append("='").append(getProjectResults()).append("' \n");	
		buffer.append("goalAchievement").append("='").append(getGoalAchievement()).append("' \n");	
		buffer.append("lessonsLearned").append("='").append(getLessonsLearned()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Projectclosure) )  { result = false; }
		 else if (other != null) {
		 	Projectclosure castOther = (Projectclosure) other;
			if (castOther.getIdProjectClouse().equals(this.getIdProjectClouse())) { result = true; }
         }
		 return result;
   }


}


