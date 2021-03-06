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

 /**
 * Base Pojo object for domain model class Changecontrol
 * @see es.sm2.openppm.model.base.Changecontrol
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Changecontrol
 */
public class BaseChangecontrol  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "changecontrol";
	
	public static final String IDCHANGE = "idChange";
	public static final String CHANGETYPE = "changetype";
	public static final String WBSNODE = "wbsnode";
	public static final String PROJECT = "project";
	public static final String DESCRIPTION = "description";
	public static final String PRIORITY = "priority";
	public static final String CHANGEDATE = "changeDate";
	public static final String ORIGINATOR = "originator";
	public static final String RECOMMENDEDSOLUTION = "recommendedSolution";
	public static final String IMPACTDESCRIPTION = "impactDescription";
	public static final String ESTIMATEDEFFORT = "estimatedEffort";
	public static final String ESTIMATEDCOST = "estimatedCost";
	public static final String RESOLUTION = "resolution";
	public static final String RESOLUTIONREASON = "resolutionReason";
	public static final String RESOLUTIONDATE = "resolutionDate";
	public static final String CHANGEDOCLINK = "changeDocLink";

     private Integer idChange;
     private Changetype changetype;
     private Wbsnode wbsnode;
     private Project project;
     private String description;
     private Character priority;
     private Date changeDate;
     private String originator;
     private String recommendedSolution;
     private String impactDescription;
     private Integer estimatedEffort;
     private Double estimatedCost;
     private Boolean resolution;
     private String resolutionReason;
     private Date resolutionDate;
     private String changeDocLink;

    public BaseChangecontrol() {
    }
    
    public BaseChangecontrol(Integer idChange) {
    	this.idChange = idChange;
    }
   
    public Integer getIdChange() {
        return this.idChange;
    }
    
    public void setIdChange(Integer idChange) {
        this.idChange = idChange;
    }
    public Changetype getChangetype() {
        return this.changetype;
    }
    
    public void setChangetype(Changetype changetype) {
        this.changetype = changetype;
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
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Character getPriority() {
        return this.priority;
    }
    
    public void setPriority(Character priority) {
        this.priority = priority;
    }
    public Date getChangeDate() {
        return this.changeDate;
    }
    
    public void setChangeDate(Date changeDate) {
        this.changeDate = changeDate;
    }
    public String getOriginator() {
        return this.originator;
    }
    
    public void setOriginator(String originator) {
        this.originator = originator;
    }
    public String getRecommendedSolution() {
        return this.recommendedSolution;
    }
    
    public void setRecommendedSolution(String recommendedSolution) {
        this.recommendedSolution = recommendedSolution;
    }
    public String getImpactDescription() {
        return this.impactDescription;
    }
    
    public void setImpactDescription(String impactDescription) {
        this.impactDescription = impactDescription;
    }
    public Integer getEstimatedEffort() {
        return this.estimatedEffort;
    }
    
    public void setEstimatedEffort(Integer estimatedEffort) {
        this.estimatedEffort = estimatedEffort;
    }
    public Double getEstimatedCost() {
        return this.estimatedCost;
    }
    
    public void setEstimatedCost(Double estimatedCost) {
        this.estimatedCost = estimatedCost;
    }
    public Boolean getResolution() {
        return this.resolution;
    }
    
    public void setResolution(Boolean resolution) {
        this.resolution = resolution;
    }
    public String getResolutionReason() {
        return this.resolutionReason;
    }
    
    public void setResolutionReason(String resolutionReason) {
        this.resolutionReason = resolutionReason;
    }
    public Date getResolutionDate() {
        return this.resolutionDate;
    }
    
    public void setResolutionDate(Date resolutionDate) {
        this.resolutionDate = resolutionDate;
    }
    public String getChangeDocLink() {
        return this.changeDocLink;
    }
    
    public void setChangeDocLink(String changeDocLink) {
        this.changeDocLink = changeDocLink;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idChange").append("='").append(getIdChange()).append("' \n");	
		buffer.append("changetype").append("='").append(getChangetype()).append("' \n");	
		buffer.append("wbsnode").append("='").append(getWbsnode()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("priority").append("='").append(getPriority()).append("' \n");	
		buffer.append("changeDate").append("='").append(getChangeDate()).append("' \n");	
		buffer.append("originator").append("='").append(getOriginator()).append("' \n");	
		buffer.append("recommendedSolution").append("='").append(getRecommendedSolution()).append("' \n");	
		buffer.append("impactDescription").append("='").append(getImpactDescription()).append("' \n");	
		buffer.append("estimatedEffort").append("='").append(getEstimatedEffort()).append("' \n");	
		buffer.append("estimatedCost").append("='").append(getEstimatedCost()).append("' \n");	
		buffer.append("resolution").append("='").append(getResolution()).append("' \n");	
		buffer.append("resolutionReason").append("='").append(getResolutionReason()).append("' \n");	
		buffer.append("resolutionDate").append("='").append(getResolutionDate()).append("' \n");	
		buffer.append("changeDocLink").append("='").append(getChangeDocLink()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Changecontrol) )  { result = false; }
		 else if (other != null) {
		 	Changecontrol castOther = (Changecontrol) other;
			if (castOther.getIdChange().equals(this.getIdChange())) { result = true; }
         }
		 return result;
   }


}


