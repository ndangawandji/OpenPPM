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
 * Base Pojo object for domain model class Riskregister
 * @see es.sm2.openppm.model.base.Riskregister
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Riskregister
 */
public class BaseRiskregister  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "riskregister";
	
	public static final String IDRISK = "idRisk";
	public static final String RISKCATEGORIES = "riskcategories";
	public static final String PROJECT = "project";
	public static final String RISKCODE = "riskCode";
	public static final String RISKNAME = "riskName";
	public static final String OWNER = "owner";
	public static final String DATERAISED = "dateRaised";
	public static final String POTENTIALCOST = "potentialCost";
	public static final String POTENTIALDELAY = "potentialDelay";
	public static final String RISKTRIGGER = "riskTrigger";
	public static final String DESCRIPTION = "description";
	public static final String PROBABILITY = "probability";
	public static final String IMPACT = "impact";
	public static final String MATERIALIZED = "materialized";
	public static final String MITIGATIONACTIONSREQUIRED = "mitigationActionsRequired";
	public static final String CONTINGENCYACTIONSREQUIRED = "contingencyActionsRequired";
	public static final String ACTUALMATERIALIZATIONCOST = "actualMaterializationCost";
	public static final String ACTUALMATERIALIZATIONDELAY = "actualMaterializationDelay";
	public static final String FINALCOMMENTS = "finalComments";
	public static final String RISKDOC = "riskDoc";
	public static final String RISKTYPE = "riskType";
	public static final String PLANNEDMITIGATIONCOST = "plannedMitigationCost";
	public static final String PLANNEDCONTINGENCYCOST = "plannedContingencyCost";
	public static final String CLOSED = "closed";
	public static final String DATEMATERIALIZATION = "dateMaterialization";
	public static final String DUEDATE = "dueDate";
	public static final String STATUS = "status";
	public static final String RESPONSEDESCRIPTION = "responseDescription";
	public static final String RESIDUALRISK = "residualRisk";
	public static final String RESIDUALCOST = "residualCost";
	public static final String RISKREASSESSMENTLOGS = "riskreassessmentlogs";

     private Integer idRisk;
     private Riskcategories riskcategories;
     private Project project;
     private String riskCode;
     private String riskName;
     private String owner;
     private Date dateRaised;
     private Double potentialCost;
     private Integer potentialDelay;
     private String riskTrigger;
     private String description;
     private Integer probability;
     private Integer impact;
     private Boolean materialized;
     private String mitigationActionsRequired;
     private String contingencyActionsRequired;
     private Double actualMaterializationCost;
     private Integer actualMaterializationDelay;
     private String finalComments;
     private String riskDoc;
     private Integer riskType;
     private Double plannedMitigationCost;
     private Double plannedContingencyCost;
     private Boolean closed;
     private Date dateMaterialization;
     private Date dueDate;
     private String status;
     private String responseDescription;
     private String residualRisk;
     private Double residualCost;
     private Set<Riskreassessmentlog> riskreassessmentlogs = new HashSet<Riskreassessmentlog>(0);

    public BaseRiskregister() {
    }
    
    public BaseRiskregister(Integer idRisk) {
    	this.idRisk = idRisk;
    }
   
    public Integer getIdRisk() {
        return this.idRisk;
    }
    
    public void setIdRisk(Integer idRisk) {
        this.idRisk = idRisk;
    }
    public Riskcategories getRiskcategories() {
        return this.riskcategories;
    }
    
    public void setRiskcategories(Riskcategories riskcategories) {
        this.riskcategories = riskcategories;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public String getRiskCode() {
        return this.riskCode;
    }
    
    public void setRiskCode(String riskCode) {
        this.riskCode = riskCode;
    }
    public String getRiskName() {
        return this.riskName;
    }
    
    public void setRiskName(String riskName) {
        this.riskName = riskName;
    }
    public String getOwner() {
        return this.owner;
    }
    
    public void setOwner(String owner) {
        this.owner = owner;
    }
    public Date getDateRaised() {
        return this.dateRaised;
    }
    
    public void setDateRaised(Date dateRaised) {
        this.dateRaised = dateRaised;
    }
    public Double getPotentialCost() {
        return this.potentialCost;
    }
    
    public void setPotentialCost(Double potentialCost) {
        this.potentialCost = potentialCost;
    }
    public Integer getPotentialDelay() {
        return this.potentialDelay;
    }
    
    public void setPotentialDelay(Integer potentialDelay) {
        this.potentialDelay = potentialDelay;
    }
    public String getRiskTrigger() {
        return this.riskTrigger;
    }
    
    public void setRiskTrigger(String riskTrigger) {
        this.riskTrigger = riskTrigger;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Integer getProbability() {
        return this.probability;
    }
    
    public void setProbability(Integer probability) {
        this.probability = probability;
    }
    public Integer getImpact() {
        return this.impact;
    }
    
    public void setImpact(Integer impact) {
        this.impact = impact;
    }
    public Boolean getMaterialized() {
        return this.materialized;
    }
    
    public void setMaterialized(Boolean materialized) {
        this.materialized = materialized;
    }
    public String getMitigationActionsRequired() {
        return this.mitigationActionsRequired;
    }
    
    public void setMitigationActionsRequired(String mitigationActionsRequired) {
        this.mitigationActionsRequired = mitigationActionsRequired;
    }
    public String getContingencyActionsRequired() {
        return this.contingencyActionsRequired;
    }
    
    public void setContingencyActionsRequired(String contingencyActionsRequired) {
        this.contingencyActionsRequired = contingencyActionsRequired;
    }
    public Double getActualMaterializationCost() {
        return this.actualMaterializationCost;
    }
    
    public void setActualMaterializationCost(Double actualMaterializationCost) {
        this.actualMaterializationCost = actualMaterializationCost;
    }
    public Integer getActualMaterializationDelay() {
        return this.actualMaterializationDelay;
    }
    
    public void setActualMaterializationDelay(Integer actualMaterializationDelay) {
        this.actualMaterializationDelay = actualMaterializationDelay;
    }
    public String getFinalComments() {
        return this.finalComments;
    }
    
    public void setFinalComments(String finalComments) {
        this.finalComments = finalComments;
    }
    public String getRiskDoc() {
        return this.riskDoc;
    }
    
    public void setRiskDoc(String riskDoc) {
        this.riskDoc = riskDoc;
    }
    public Integer getRiskType() {
        return this.riskType;
    }
    
    public void setRiskType(Integer riskType) {
        this.riskType = riskType;
    }
    public Double getPlannedMitigationCost() {
        return this.plannedMitigationCost;
    }
    
    public void setPlannedMitigationCost(Double plannedMitigationCost) {
        this.plannedMitigationCost = plannedMitigationCost;
    }
    public Double getPlannedContingencyCost() {
        return this.plannedContingencyCost;
    }
    
    public void setPlannedContingencyCost(Double plannedContingencyCost) {
        this.plannedContingencyCost = plannedContingencyCost;
    }
    public Boolean getClosed() {
        return this.closed;
    }
    
    public void setClosed(Boolean closed) {
        this.closed = closed;
    }
    public Date getDateMaterialization() {
        return this.dateMaterialization;
    }
    
    public void setDateMaterialization(Date dateMaterialization) {
        this.dateMaterialization = dateMaterialization;
    }
    public Date getDueDate() {
        return this.dueDate;
    }
    
    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public String getResponseDescription() {
        return this.responseDescription;
    }
    
    public void setResponseDescription(String responseDescription) {
        this.responseDescription = responseDescription;
    }
    public String getResidualRisk() {
        return this.residualRisk;
    }
    
    public void setResidualRisk(String residualRisk) {
        this.residualRisk = residualRisk;
    }
    public Double getResidualCost() {
        return this.residualCost;
    }
    
    public void setResidualCost(Double residualCost) {
        this.residualCost = residualCost;
    }
    public Set<Riskreassessmentlog> getRiskreassessmentlogs() {
        return this.riskreassessmentlogs;
    }
    
    public void setRiskreassessmentlogs(Set<Riskreassessmentlog> riskreassessmentlogs) {
        this.riskreassessmentlogs = riskreassessmentlogs;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idRisk").append("='").append(getIdRisk()).append("' \n");	
		buffer.append("riskcategories").append("='").append(getRiskcategories()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("riskCode").append("='").append(getRiskCode()).append("' \n");	
		buffer.append("riskName").append("='").append(getRiskName()).append("' \n");	
		buffer.append("owner").append("='").append(getOwner()).append("' \n");	
		buffer.append("dateRaised").append("='").append(getDateRaised()).append("' \n");	
		buffer.append("potentialCost").append("='").append(getPotentialCost()).append("' \n");	
		buffer.append("potentialDelay").append("='").append(getPotentialDelay()).append("' \n");	
		buffer.append("riskTrigger").append("='").append(getRiskTrigger()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("probability").append("='").append(getProbability()).append("' \n");	
		buffer.append("impact").append("='").append(getImpact()).append("' \n");	
		buffer.append("materialized").append("='").append(getMaterialized()).append("' \n");	
		buffer.append("mitigationActionsRequired").append("='").append(getMitigationActionsRequired()).append("' \n");	
		buffer.append("contingencyActionsRequired").append("='").append(getContingencyActionsRequired()).append("' \n");	
		buffer.append("actualMaterializationCost").append("='").append(getActualMaterializationCost()).append("' \n");	
		buffer.append("actualMaterializationDelay").append("='").append(getActualMaterializationDelay()).append("' \n");	
		buffer.append("finalComments").append("='").append(getFinalComments()).append("' \n");	
		buffer.append("riskDoc").append("='").append(getRiskDoc()).append("' \n");	
		buffer.append("riskType").append("='").append(getRiskType()).append("' \n");	
		buffer.append("plannedMitigationCost").append("='").append(getPlannedMitigationCost()).append("' \n");	
		buffer.append("plannedContingencyCost").append("='").append(getPlannedContingencyCost()).append("' \n");	
		buffer.append("closed").append("='").append(getClosed()).append("' \n");	
		buffer.append("dateMaterialization").append("='").append(getDateMaterialization()).append("' \n");	
		buffer.append("dueDate").append("='").append(getDueDate()).append("' \n");	
		buffer.append("status").append("='").append(getStatus()).append("' \n");	
		buffer.append("responseDescription").append("='").append(getResponseDescription()).append("' \n");	
		buffer.append("residualRisk").append("='").append(getResidualRisk()).append("' \n");	
		buffer.append("residualCost").append("='").append(getResidualCost()).append("' \n");	
		buffer.append("riskreassessmentlogs").append("='").append(getRiskreassessmentlogs()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Riskregister) )  { result = false; }
		 else if (other != null) {
		 	Riskregister castOther = (Riskregister) other;
			if (castOther.getIdRisk().equals(this.getIdRisk())) { result = true; }
         }
		 return result;
   }


}


