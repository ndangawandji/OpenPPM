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
 * Base Pojo object for domain model class Milestones
 * @see es.sm2.openppm.model.base.Milestones
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Milestones
 */
public class BaseMilestones  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "milestones";
	
	public static final String IDMILESTONE = "idMilestone";
	public static final String PROJECTACTIVITY = "projectactivity";
	public static final String PROJECT = "project";
	public static final String DESCRIPTION = "description";
	public static final String LABEL = "label";
	public static final String REPORTTYPE = "reportType";
	public static final String PLANNED = "planned";
	public static final String ACHIEVED = "achieved";
	public static final String ACHIEVEDCOMMENTS = "achievedComments";
	public static final String NOTIFY = "notify";
	public static final String NOTIFYDAYS = "notifyDays";
	public static final String NOTIFICATIONTEXT = "notificationText";
	public static final String NOTIFYDATE = "notifyDate";

     private Integer idMilestone;
     private Projectactivity projectactivity;
     private Project project;
     private String description;
     private String label;
     private Character reportType;
     private Date planned;
     private Date achieved;
     private String achievedComments;
     private Boolean notify;
     private Integer notifyDays;
     private String notificationText;
     private Date notifyDate;

    public BaseMilestones() {
    }
    
    public BaseMilestones(Integer idMilestone) {
    	this.idMilestone = idMilestone;
    }
   
    public Integer getIdMilestone() {
        return this.idMilestone;
    }
    
    public void setIdMilestone(Integer idMilestone) {
        this.idMilestone = idMilestone;
    }
    public Projectactivity getProjectactivity() {
        return this.projectactivity;
    }
    
    public void setProjectactivity(Projectactivity projectactivity) {
        this.projectactivity = projectactivity;
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
    public String getLabel() {
        return this.label;
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    public Character getReportType() {
        return this.reportType;
    }
    
    public void setReportType(Character reportType) {
        this.reportType = reportType;
    }
    public Date getPlanned() {
        return this.planned;
    }
    
    public void setPlanned(Date planned) {
        this.planned = planned;
    }
    public Date getAchieved() {
        return this.achieved;
    }
    
    public void setAchieved(Date achieved) {
        this.achieved = achieved;
    }
    public String getAchievedComments() {
        return this.achievedComments;
    }
    
    public void setAchievedComments(String achievedComments) {
        this.achievedComments = achievedComments;
    }
    public Boolean getNotify() {
        return this.notify;
    }
    
    public void setNotify(Boolean notify) {
        this.notify = notify;
    }
    public Integer getNotifyDays() {
        return this.notifyDays;
    }
    
    public void setNotifyDays(Integer notifyDays) {
        this.notifyDays = notifyDays;
    }
    public String getNotificationText() {
        return this.notificationText;
    }
    
    public void setNotificationText(String notificationText) {
        this.notificationText = notificationText;
    }
    public Date getNotifyDate() {
        return this.notifyDate;
    }
    
    public void setNotifyDate(Date notifyDate) {
        this.notifyDate = notifyDate;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idMilestone").append("='").append(getIdMilestone()).append("' \n");	
		buffer.append("projectactivity").append("='").append(getProjectactivity()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("label").append("='").append(getLabel()).append("' \n");	
		buffer.append("reportType").append("='").append(getReportType()).append("' \n");	
		buffer.append("planned").append("='").append(getPlanned()).append("' \n");	
		buffer.append("achieved").append("='").append(getAchieved()).append("' \n");	
		buffer.append("achievedComments").append("='").append(getAchievedComments()).append("' \n");	
		buffer.append("notify").append("='").append(getNotify()).append("' \n");	
		buffer.append("notifyDays").append("='").append(getNotifyDays()).append("' \n");	
		buffer.append("notificationText").append("='").append(getNotificationText()).append("' \n");	
		buffer.append("notifyDate").append("='").append(getNotifyDate()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Milestones) )  { result = false; }
		 else if (other != null) {
		 	Milestones castOther = (Milestones) other;
			if (castOther.getIdMilestone().equals(this.getIdMilestone())) { result = true; }
         }
		 return result;
   }


}


