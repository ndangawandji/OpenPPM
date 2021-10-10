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
 * Base Pojo object for domain model class Workingcosts
 * @see es.sm2.openppm.model.base.Workingcosts
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Workingcosts
 */
public class BaseWorkingcosts  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "workingcosts";
	
	public static final String IDWORKINGCOSTS = "idWorkingCosts";
	public static final String PROJECT = "project";
	public static final String RESOURCENAME = "resourceName";
	public static final String RESOURCEDEPARTMENT = "resourceDepartment";
	public static final String EFFORT = "effort";
	public static final String RATE = "rate";
	public static final String WORKCOST = "workCost";
	public static final String Q1 = "q1";
	public static final String Q2 = "q2";
	public static final String Q3 = "q3";
	public static final String Q4 = "q4";
	public static final String REALEFFORT = "realEffort";

     private Integer idWorkingCosts;
     private Project project;
     private String resourceName;
     private String resourceDepartment;
     private Integer effort;
     private Double rate;
     private Double workCost;
     private Integer q1;
     private Integer q2;
     private Integer q3;
     private Integer q4;
     private Integer realEffort;

    public BaseWorkingcosts() {
    }
    
    public BaseWorkingcosts(Integer idWorkingCosts) {
    	this.idWorkingCosts = idWorkingCosts;
    }
   
    public Integer getIdWorkingCosts() {
        return this.idWorkingCosts;
    }
    
    public void setIdWorkingCosts(Integer idWorkingCosts) {
        this.idWorkingCosts = idWorkingCosts;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public String getResourceName() {
        return this.resourceName;
    }
    
    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }
    public String getResourceDepartment() {
        return this.resourceDepartment;
    }
    
    public void setResourceDepartment(String resourceDepartment) {
        this.resourceDepartment = resourceDepartment;
    }
    public Integer getEffort() {
        return this.effort;
    }
    
    public void setEffort(Integer effort) {
        this.effort = effort;
    }
    public Double getRate() {
        return this.rate;
    }
    
    public void setRate(Double rate) {
        this.rate = rate;
    }
    public Double getWorkCost() {
        return this.workCost;
    }
    
    public void setWorkCost(Double workCost) {
        this.workCost = workCost;
    }
    public Integer getQ1() {
        return this.q1;
    }
    
    public void setQ1(Integer q1) {
        this.q1 = q1;
    }
    public Integer getQ2() {
        return this.q2;
    }
    
    public void setQ2(Integer q2) {
        this.q2 = q2;
    }
    public Integer getQ3() {
        return this.q3;
    }
    
    public void setQ3(Integer q3) {
        this.q3 = q3;
    }
    public Integer getQ4() {
        return this.q4;
    }
    
    public void setQ4(Integer q4) {
        this.q4 = q4;
    }
    public Integer getRealEffort() {
        return this.realEffort;
    }
    
    public void setRealEffort(Integer realEffort) {
        this.realEffort = realEffort;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idWorkingCosts").append("='").append(getIdWorkingCosts()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("resourceName").append("='").append(getResourceName()).append("' \n");	
		buffer.append("resourceDepartment").append("='").append(getResourceDepartment()).append("' \n");	
		buffer.append("effort").append("='").append(getEffort()).append("' \n");	
		buffer.append("rate").append("='").append(getRate()).append("' \n");	
		buffer.append("workCost").append("='").append(getWorkCost()).append("' \n");	
		buffer.append("q1").append("='").append(getQ1()).append("' \n");	
		buffer.append("q2").append("='").append(getQ2()).append("' \n");	
		buffer.append("q3").append("='").append(getQ3()).append("' \n");	
		buffer.append("q4").append("='").append(getQ4()).append("' \n");	
		buffer.append("realEffort").append("='").append(getRealEffort()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Workingcosts) )  { result = false; }
		 else if (other != null) {
		 	Workingcosts castOther = (Workingcosts) other;
			if (castOther.getIdWorkingCosts().equals(this.getIdWorkingCosts())) { result = true; }
         }
		 return result;
   }


}


