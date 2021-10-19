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
 *  Updater : Cédric Ndanga Wandji
 ******************************************************************************/
/*
 * Updater : Cédric Ndanga Wandji
 * Devoteam, 2015/04/09, userstory 13 : adding property workloadInDays and her setter and getter
 * Devoteam, 2015/04/09, userstory 13 : adding constant property WORKLOAD_IN_DAYS
 */

package es.sm2.openppm.model.base;
import es.sm2.openppm.model.*;


import java.util.Date;

 /**
 * Base Pojo object for domain model class Teammember
 * @see es.sm2.openppm.model.base.Teammember
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Teammember
 */
public class BaseTeammember  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "teammember";
	
	public static final String IDTEAMMEMBER = "idTeamMember";
	public static final String PROJECTACTIVITY = "projectactivity";
	public static final String SKILL = "skill";
	public static final String EMPLOYEE = "employee";
	public static final String DATEAPPROVED = "dateApproved";
	public static final String SELLRATE = "sellRate";
	public static final String FTE = "fte";
	public static final String DATEIN = "dateIn";
	public static final String DATEOUT = "dateOut";
	public static final String HOURS = "hours";
	public static final String EXPENSES = "expenses";
	public static final String STATUS = "status";
	public static final String COMMENTSPM = "commentsPm";
	public static final String COMMENTSRM = "commentsRm";
	public static final String WORKLOAD_IN_DAYS = "workloadInDays";

     private Integer idTeamMember;
     private Projectactivity projectactivity;
     private Skill skill;
     private Employee employee;
     private Date dateApproved;
     private Double sellRate;
     private Integer fte;
     private Date dateIn;
     private Date dateOut;
     private Integer hours;
     private Integer expenses;
     private String status;
     private String commentsPm;
     private String commentsRm;
     private Double workloadInDays;  //new column in data base

    public BaseTeammember() {
    }
    
    public BaseTeammember(Integer idTeamMember) {
    	this.idTeamMember = idTeamMember;
    }
   
    public Integer getIdTeamMember() {
        return this.idTeamMember;
    }
    
    public void setIdTeamMember(Integer idTeamMember) {
        this.idTeamMember = idTeamMember;
    }
    public Projectactivity getProjectactivity() {
        return this.projectactivity;
    }
    
    public void setProjectactivity(Projectactivity projectactivity) {
        this.projectactivity = projectactivity;
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
    public Date getDateApproved() {
        return this.dateApproved;
    }
    
    public void setDateApproved(Date dateApproved) {
        this.dateApproved = dateApproved;
    }
    public Double getSellRate() {
        return this.sellRate;
    }
    
    public void setSellRate(Double sellRate) {
        this.sellRate = sellRate;
    }
    public Integer getFte() {
        return this.fte;
    }
    
    public void setFte(Integer fte) {
        this.fte = fte;
    }
    public Date getDateIn() {
        return this.dateIn;
    }
    
    public void setDateIn(Date dateIn) {
        this.dateIn = dateIn;
    }
    public Date getDateOut() {
        return this.dateOut;
    }
    
    public void setDateOut(Date dateOut) {
        this.dateOut = dateOut;
    }
    public Integer getHours() {
        return this.hours;
    }
    
    public void setHours(Integer hours) {
        this.hours = hours;
    }
    public Integer getExpenses() {
        return this.expenses;
    }
    
    public void setExpenses(Integer expenses) {
        this.expenses = expenses;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public String getCommentsPm() {
        return this.commentsPm;
    }
    
    public void setCommentsPm(String commentsPm) {
        this.commentsPm = commentsPm;
    }
    public String getCommentsRm() {
        return this.commentsRm;
    }
    
    public void setCommentsRm(String commentsRm) {
        this.commentsRm = commentsRm;
    }

   /**
	 * @return the workloadInDays
	 */
	public Double getWorkloadInDays() {
		if (this.workloadInDays == null ){ return new Double(0);}; // XL 20150529  transformer la valeur null en base
		return workloadInDays;
	}

	/**
	 * @param workloadInDays the workloadInDays to set
	 */
	public void setWorkloadInDays(Double workloadInDays) {
		this.workloadInDays = workloadInDays;
	}

/**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idTeamMember").append("='").append(getIdTeamMember()).append("' \n");	
		buffer.append("projectactivity").append("='").append(getProjectactivity()).append("' \n");	
		buffer.append("skill").append("='").append(getSkill()).append("' \n");	
		buffer.append("employee").append("='").append(getEmployee()).append("' \n");	
		buffer.append("dateApproved").append("='").append(getDateApproved()).append("' \n");	
		buffer.append("sellRate").append("='").append(getSellRate()).append("' \n");	
		buffer.append("fte").append("='").append(getFte()).append("' \n");	
		buffer.append("dateIn").append("='").append(getDateIn()).append("' \n");	
		buffer.append("dateOut").append("='").append(getDateOut()).append("' \n");	
		buffer.append("hours").append("='").append(getHours()).append("' \n");	
		buffer.append("expenses").append("='").append(getExpenses()).append("' \n");	
		buffer.append("status").append("='").append(getStatus()).append("' \n");	
		buffer.append("commentsPm").append("='").append(getCommentsPm()).append("' \n");	
		buffer.append("commentsRm").append("='").append(getCommentsRm()).append("' \n");
		buffer.append("workloadInDays").append("='").append(getWorkloadInDays()).append("' \n");
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Teammember) )  { result = false; }
		 else if (other != null) {
		 	Teammember castOther = (Teammember) other;
			if (castOther.getIdTeamMember().equals(this.getIdTeamMember())) { result = true; }
         }
		 return result;
   }


}


