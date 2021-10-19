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
 * Base Pojo object for domain model class Wbsnode
 * @see es.sm2.openppm.model.base.Wbsnode
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Wbsnode
 */
public class BaseWbsnode  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "wbsnode";
	
	public static final String IDWBSNODE = "idWbsnode";
	public static final String WBSNODE = "wbsnode";
	public static final String PROJECT = "project";
	public static final String CODE = "code";
	public static final String NAME = "name";
	public static final String DESCRIPTION = "description";
	public static final String ISCONTROLACCOUNT = "isControlAccount";
	public static final String BUDGET = "budget";
	public static final String WBSNODES = "wbsnodes";
	public static final String CHECKLISTS = "checklists";
	public static final String PROJECTACTIVITIES = "projectactivities";
	public static final String CHANGECONTROLS = "changecontrols";

     private Integer idWbsnode;
     private Wbsnode wbsnode;
     private Project project;
     private String code;
     private String name;
     private String description;
     private Boolean isControlAccount;
     private Double budget;
     private Set<Wbsnode> wbsnodes = new HashSet<Wbsnode>(0);
     private Set<Checklist> checklists = new HashSet<Checklist>(0);
     private Set<Projectactivity> projectactivities = new HashSet<Projectactivity>(0);
     private Set<Changecontrol> changecontrols = new HashSet<Changecontrol>(0);

    public BaseWbsnode() {
    }
    
    public BaseWbsnode(Integer idWbsnode) {
    	this.idWbsnode = idWbsnode;
    }
   
    public Integer getIdWbsnode() {
        return this.idWbsnode;
    }
    
    public void setIdWbsnode(Integer idWbsnode) {
        this.idWbsnode = idWbsnode;
    }
    public Wbsnode getWbsnode() {
        return this.wbsnode;
    }
    
    public void setWbsnode(Wbsnode wbsnode) {
        this.wbsnode = wbsnode;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public String getCode() {
        return this.code;
    }
    
    public void setCode(String code) {
        this.code = code;
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
    public Boolean getIsControlAccount() {
        return this.isControlAccount;
    }
    
    public void setIsControlAccount(Boolean isControlAccount) {
        this.isControlAccount = isControlAccount;
    }
    public Double getBudget() {
        return this.budget;
    }
    
    public void setBudget(Double budget) {
        this.budget = budget;
    }
    public Set<Wbsnode> getWbsnodes() {
        return this.wbsnodes;
    }
    
    public void setWbsnodes(Set<Wbsnode> wbsnodes) {
        this.wbsnodes = wbsnodes;
    }
    public Set<Checklist> getChecklists() {
        return this.checklists;
    }
    
    public void setChecklists(Set<Checklist> checklists) {
        this.checklists = checklists;
    }
    public Set<Projectactivity> getProjectactivities() {
        return this.projectactivities;
    }
    
    public void setProjectactivities(Set<Projectactivity> projectactivities) {
        this.projectactivities = projectactivities;
    }
    public Set<Changecontrol> getChangecontrols() {
        return this.changecontrols;
    }
    
    public void setChangecontrols(Set<Changecontrol> changecontrols) {
        this.changecontrols = changecontrols;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idWbsnode").append("='").append(getIdWbsnode()).append("' \n");	
		buffer.append("wbsnode").append("='").append(getWbsnode()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("code").append("='").append(getCode()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("isControlAccount").append("='").append(getIsControlAccount()).append("' \n");	
		buffer.append("budget").append("='").append(getBudget()).append("' \n");	
		buffer.append("wbsnodes").append("='").append(getWbsnodes()).append("' \n");	
		buffer.append("checklists").append("='").append(getChecklists()).append("' \n");	
		buffer.append("projectactivities").append("='").append(getProjectactivities()).append("' \n");	
		buffer.append("changecontrols").append("='").append(getChangecontrols()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Wbsnode) )  { result = false; }
		 else if (other != null) {
		 	Wbsnode castOther = (Wbsnode) other;
			if (castOther.getIdWbsnode().equals(this.getIdWbsnode())) { result = true; }
         }
		 return result;
   }


}


