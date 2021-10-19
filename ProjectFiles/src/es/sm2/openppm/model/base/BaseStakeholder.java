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
 * Base Pojo object for domain model class Stakeholder
 * @see es.sm2.openppm.model.base.Stakeholder
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Stakeholder
 */
public class BaseStakeholder  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "stakeholder";
	
	public static final String IDSTAKEHOLDER = "idStakeholder";
	public static final String PROJECT = "project";
	public static final String PROJECTROLE = "projectRole";
	public static final String REQUIREMENTS = "requirements";
	public static final String EXPECTATIONS = "expectations";
	public static final String INFLUENCE = "influence";
	public static final String MGTSTRATEGY = "mgtStrategy";
	public static final String CLASSIFICATION = "classification";
	public static final String TYPE = "type";
	public static final String CONTACTNAME = "contactName";
	public static final String DEPARTMENT = "department";
	public static final String ORDERTOSHOW = "orderToShow";

     private Integer idStakeholder;
     private Project project;
     private String projectRole;
     private String requirements;
     private String expectations;
     private String influence;
     private String mgtStrategy;
     private Character classification;
     private Character type;
     private String contactName;
     private String department;
     private Integer orderToShow;

    public BaseStakeholder() {
    }
    
    public BaseStakeholder(Integer idStakeholder) {
    	this.idStakeholder = idStakeholder;
    }
   
    public Integer getIdStakeholder() {
        return this.idStakeholder;
    }
    
    public void setIdStakeholder(Integer idStakeholder) {
        this.idStakeholder = idStakeholder;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public String getProjectRole() {
        return this.projectRole;
    }
    
    public void setProjectRole(String projectRole) {
        this.projectRole = projectRole;
    }
    public String getRequirements() {
        return this.requirements;
    }
    
    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }
    public String getExpectations() {
        return this.expectations;
    }
    
    public void setExpectations(String expectations) {
        this.expectations = expectations;
    }
    public String getInfluence() {
        return this.influence;
    }
    
    public void setInfluence(String influence) {
        this.influence = influence;
    }
    public String getMgtStrategy() {
        return this.mgtStrategy;
    }
    
    public void setMgtStrategy(String mgtStrategy) {
        this.mgtStrategy = mgtStrategy;
    }
    public Character getClassification() {
        return this.classification;
    }
    
    public void setClassification(Character classification) {
        this.classification = classification;
    }
    public Character getType() {
        return this.type;
    }
    
    public void setType(Character type) {
        this.type = type;
    }
    public String getContactName() {
        return this.contactName;
    }
    
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }
    public String getDepartment() {
        return this.department;
    }
    
    public void setDepartment(String department) {
        this.department = department;
    }
    public Integer getOrderToShow() {
        return this.orderToShow;
    }
    
    public void setOrderToShow(Integer orderToShow) {
        this.orderToShow = orderToShow;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idStakeholder").append("='").append(getIdStakeholder()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("projectRole").append("='").append(getProjectRole()).append("' \n");	
		buffer.append("requirements").append("='").append(getRequirements()).append("' \n");	
		buffer.append("expectations").append("='").append(getExpectations()).append("' \n");	
		buffer.append("influence").append("='").append(getInfluence()).append("' \n");	
		buffer.append("mgtStrategy").append("='").append(getMgtStrategy()).append("' \n");	
		buffer.append("classification").append("='").append(getClassification()).append("' \n");	
		buffer.append("type").append("='").append(getType()).append("' \n");	
		buffer.append("contactName").append("='").append(getContactName()).append("' \n");	
		buffer.append("department").append("='").append(getDepartment()).append("' \n");	
		buffer.append("orderToShow").append("='").append(getOrderToShow()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Stakeholder) )  { result = false; }
		 else if (other != null) {
		 	Stakeholder castOther = (Stakeholder) other;
			if (castOther.getIdStakeholder().equals(this.getIdStakeholder())) { result = true; }
         }
		 return result;
   }


}


