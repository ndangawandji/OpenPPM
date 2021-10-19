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
 * Base Pojo object for domain model class Projectfollowup
 * @see es.sm2.openppm.model.base.Projectfollowup
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Projectfollowup
 */
public class BaseProjectfollowup  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "projectfollowup";
	
	public static final String IDPROJECTFOLLOWUP = "idProjectFollowup";
	public static final String PROJECT = "project";
	public static final String FOLLOWUPDATE = "followupDate";
	public static final String EV = "ev";
	public static final String PV = "pv";
	public static final String AC = "ac";
	public static final String GENERALCOMMENTS = "generalComments";
	public static final String RISKSCOMMENTS = "risksComments";
	public static final String COSTCOMMENTS = "costComments";
	public static final String SCHEDULECOMMENTS = "scheduleComments";
	public static final String GENERALFLAG = "generalFlag";
	public static final String RISKFLAG = "riskFlag";
	public static final String COSTFLAG = "costFlag";
	public static final String SCHEDULEFLAG = "scheduleFlag";
	public static final String PERFORMANCEDOC = "performanceDoc";

     private Integer idProjectFollowup;
     private Project project;
     private Date followupDate;
     private Double ev;
     private Double pv;
     private Double ac;
     private String generalComments;
     private String risksComments;
     private String costComments;
     private String scheduleComments;
     private Character generalFlag;
     private Character riskFlag;
     private Character costFlag;
     private Character scheduleFlag;
     private String performanceDoc;

    public BaseProjectfollowup() {
    }
    
    public BaseProjectfollowup(Integer idProjectFollowup) {
    	this.idProjectFollowup = idProjectFollowup;
    }
   
    public Integer getIdProjectFollowup() {
        return this.idProjectFollowup;
    }
    
    public void setIdProjectFollowup(Integer idProjectFollowup) {
        this.idProjectFollowup = idProjectFollowup;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public Date getFollowupDate() {
        return this.followupDate;
    }
    
    public void setFollowupDate(Date followupDate) {
        this.followupDate = followupDate;
    }
    public Double getEv() {
        return this.ev;
    }
    
    public void setEv(Double ev) {
        this.ev = ev;
    }
    public Double getPv() {
        return this.pv;
    }
    
    public void setPv(Double pv) {
        this.pv = pv;
    }
    public Double getAc() {
        return this.ac;
    }
    
    public void setAc(Double ac) {
        this.ac = ac;
    }
    public String getGeneralComments() {
        return this.generalComments;
    }
    
    public void setGeneralComments(String generalComments) {
        this.generalComments = generalComments;
    }
    public String getRisksComments() {
        return this.risksComments;
    }
    
    public void setRisksComments(String risksComments) {
        this.risksComments = risksComments;
    }
    public String getCostComments() {
        return this.costComments;
    }
    
    public void setCostComments(String costComments) {
        this.costComments = costComments;
    }
    public String getScheduleComments() {
        return this.scheduleComments;
    }
    
    public void setScheduleComments(String scheduleComments) {
        this.scheduleComments = scheduleComments;
    }
    public Character getGeneralFlag() {
        return this.generalFlag;
    }
    
    public void setGeneralFlag(Character generalFlag) {
        this.generalFlag = generalFlag;
    }
    public Character getRiskFlag() {
        return this.riskFlag;
    }
    
    public void setRiskFlag(Character riskFlag) {
        this.riskFlag = riskFlag;
    }
    public Character getCostFlag() {
        return this.costFlag;
    }
    
    public void setCostFlag(Character costFlag) {
        this.costFlag = costFlag;
    }
    public Character getScheduleFlag() {
        return this.scheduleFlag;
    }
    
    public void setScheduleFlag(Character scheduleFlag) {
        this.scheduleFlag = scheduleFlag;
    }
    public String getPerformanceDoc() {
        return this.performanceDoc;
    }
    
    public void setPerformanceDoc(String performanceDoc) {
        this.performanceDoc = performanceDoc;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idProjectFollowup").append("='").append(getIdProjectFollowup()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("followupDate").append("='").append(getFollowupDate()).append("' \n");	
		buffer.append("ev").append("='").append(getEv()).append("' \n");	
		buffer.append("pv").append("='").append(getPv()).append("' \n");	
		buffer.append("ac").append("='").append(getAc()).append("' \n");	
		buffer.append("generalComments").append("='").append(getGeneralComments()).append("' \n");	
		buffer.append("risksComments").append("='").append(getRisksComments()).append("' \n");	
		buffer.append("costComments").append("='").append(getCostComments()).append("' \n");	
		buffer.append("scheduleComments").append("='").append(getScheduleComments()).append("' \n");	
		buffer.append("generalFlag").append("='").append(getGeneralFlag()).append("' \n");	
		buffer.append("riskFlag").append("='").append(getRiskFlag()).append("' \n");	
		buffer.append("costFlag").append("='").append(getCostFlag()).append("' \n");	
		buffer.append("scheduleFlag").append("='").append(getScheduleFlag()).append("' \n");	
		buffer.append("performanceDoc").append("='").append(getPerformanceDoc()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Projectfollowup) )  { result = false; }
		 else if (other != null) {
		 	Projectfollowup castOther = (Projectfollowup) other;
			if (castOther.getIdProjectFollowup().equals(this.getIdProjectFollowup())) { result = true; }
         }
		 return result;
   }


}


