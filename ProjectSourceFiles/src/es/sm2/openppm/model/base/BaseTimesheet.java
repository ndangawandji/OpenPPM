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
/*
 *  Updater : Cédric Ndanga Wandji
 *  Devoteam, 28/05/2015, user story 26 : adding mapping java properties and theirs setters and getters
 */
package es.sm2.openppm.model.base;
import es.sm2.openppm.model.*;


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

 /**
 * Base Pojo object for domain model class Timesheet
 * @see es.sm2.openppm.model.base.Timesheet
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Timesheet
 */
public class BaseTimesheet  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "timesheet";
	
	public static final String IDTIMESHEET = "idTimeSheet";
	public static final String OPERATION = "operation";
	public static final String PROJECTACTIVITY = "projectactivity";
	public static final String EMPLOYEE = "employee";
	public static final String INITDATE = "initDate";
	public static final String ENDDATE = "endDate";
	public static final String STATUS = "status";
	public static final String ACTIVITY_STATE = "activityState";			// cnw us26		
	public static final String ESTIMATED_GAP = "estimatedGap";				// cnw us26
	public static final String ESTIMATED_GAP_VALUE = "estimatedGapValue";	// cnw us26
	public static final String TIME = "time";								// cnw us26
	public static final String HOURSDAY1 = "hoursDay1";
	public static final String HOURSDAY2 = "hoursDay2";
	public static final String HOURSDAY3 = "hoursDay3";
	public static final String HOURSDAY4 = "hoursDay4";
	public static final String HOURSDAY5 = "hoursDay5";
	public static final String HOURSDAY6 = "hoursDay6";
	public static final String HOURSDAY7 = "hoursDay7";
	public static final String TIMESHEETCOMMENTS = "timesheetcomments";

     private Integer idTimeSheet;
     private Operation operation;
     private Projectactivity projectactivity;
     private Employee employee;
     private Date initDate;
     private Date endDate;
     private String status;
     private Integer activityState;			// cnw us26 mapping property
     private Integer estimatedGap;			// cnw us26 mapping property
     private Double estimatedGapValue;		// cnw us26 mapping property
     private Integer time;					// cnw us26 mapping property
     private Double hoursDay1;
     private Double hoursDay2;
     private Double hoursDay3;
     private Double hoursDay4;
     private Double hoursDay5;
     private Double hoursDay6;
     private Double hoursDay7;
     private Set<Timesheetcomment> timesheetcomments = new HashSet<Timesheetcomment>(0);

    public BaseTimesheet() {
    }
    
    public BaseTimesheet(Integer idTimeSheet) {
    	this.idTimeSheet = idTimeSheet;
    }
   
    public Integer getIdTimeSheet() {
        return this.idTimeSheet;
    }
    
    public void setIdTimeSheet(Integer idTimeSheet) {
        this.idTimeSheet = idTimeSheet;
    }
    public Operation getOperation() {
        return this.operation;
    }
    
    public void setOperation(Operation operation) {
        this.operation = operation;
    }
    public Projectactivity getProjectactivity() {
        return this.projectactivity;
    }
    
    public void setProjectactivity(Projectactivity projectactivity) {
        this.projectactivity = projectactivity;
    }
    public Employee getEmployee() {
        return this.employee;
    }
    
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
    public Date getInitDate() {
        return this.initDate;
    }
    
    public void setInitDate(Date initDate) {
        this.initDate = initDate;
    }
    public Date getEndDate() {
        return this.endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    /**
     * @author Cédric Ndanga
     * user story 26
	 * @return the activityState
	 */
	public Integer getActivityState() {
		return activityState;
	}

	/**
	 * @author Cédric Ndanga
	 * user story 26
	 * @param activityState the activityState to set
	 */
	public void setActivityState(Integer activityState) {
		this.activityState = activityState;
	}

	/**
	 * @author Cédric Ndanga
	 * user story 26
	 * @return the estimatedGap
	 */
	public Integer getEstimatedGap() {
		return estimatedGap;
	}

	/**
	 * @author Cédric Ndanga
	 * user story 26
	 * @param estimatedGap the estimatedGap to set
	 */
	public void setEstimatedGap(Integer estimatedGap) {
		this.estimatedGap = estimatedGap;
	}

	/**
	 * @author Cédric Ndanga
	 * user story 26
	 * @return the estimatedGapValue
	 */
	public Double getEstimatedGapValue() {
		return estimatedGapValue;
	}

	/**
	 * @author Cédric Ndanga
	 * user story 26
	 * @param estimatedGapValue the estimatedGapValue to set
	 */
	public void setEstimatedGapValue(Double estimatedGapValue) {
		this.estimatedGapValue = estimatedGapValue;
	}

	/**
	 * @author Cédric Ndanga
	 * user story 26
	 * @return the time
	 */
	public Integer getTime() {
		return time;
	}

	/**
	 * @author Cédric Ndanga
	 * user story 26
	 * @param time the time to set
	 */
	public void setTime(Integer time) {
		this.time = time;
	}

	
	public Double getHoursDay1() {
        return this.hoursDay1;
    }
    
    public void setHoursDay1(Double hoursDay1) {
        this.hoursDay1 = hoursDay1;
    }
    public Double getHoursDay2() {
        return this.hoursDay2;
    }
    
    public void setHoursDay2(Double hoursDay2) {
        this.hoursDay2 = hoursDay2;
    }
    public Double getHoursDay3() {
        return this.hoursDay3;
    }
    
    public void setHoursDay3(Double hoursDay3) {
        this.hoursDay3 = hoursDay3;
    }
    public Double getHoursDay4() {
        return this.hoursDay4;
    }
    
    public void setHoursDay4(Double hoursDay4) {
        this.hoursDay4 = hoursDay4;
    }
    public Double getHoursDay5() {
        return this.hoursDay5;
    }
    
    public void setHoursDay5(Double hoursDay5) {
        this.hoursDay5 = hoursDay5;
    }
    public Double getHoursDay6() {
        return this.hoursDay6;
    }
    
    public void setHoursDay6(Double hoursDay6) {
        this.hoursDay6 = hoursDay6;
    }
    public Double getHoursDay7() {
        return this.hoursDay7;
    }
    
    public void setHoursDay7(Double hoursDay7) {
        this.hoursDay7 = hoursDay7;
    }
    public Set<Timesheetcomment> getTimesheetcomments() {
        return this.timesheetcomments;
    }
    
    public void setTimesheetcomments(Set<Timesheetcomment> timesheetcomments) {
        this.timesheetcomments = timesheetcomments;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idTimeSheet").append("='").append(getIdTimeSheet()).append("' \n");	
		buffer.append("operation").append("='").append(getOperation()).append("' \n");	
		buffer.append("projectactivity").append("='").append(getProjectactivity()).append("' \n");	
		buffer.append("employee").append("='").append(getEmployee()).append("' \n");	
		buffer.append("initDate").append("='").append(getInitDate()).append("' \n");	
		buffer.append("endDate").append("='").append(getEndDate()).append("' \n");	
		buffer.append("status").append("='").append(getStatus()).append("' \n");	
		buffer.append("hoursDay1").append("='").append(getHoursDay1()).append("' \n");	
		buffer.append("hoursDay2").append("='").append(getHoursDay2()).append("' \n");	
		buffer.append("hoursDay3").append("='").append(getHoursDay3()).append("' \n");	
		buffer.append("hoursDay4").append("='").append(getHoursDay4()).append("' \n");	
		buffer.append("hoursDay5").append("='").append(getHoursDay5()).append("' \n");	
		buffer.append("hoursDay6").append("='").append(getHoursDay6()).append("' \n");	
		buffer.append("hoursDay7").append("='").append(getHoursDay7()).append("' \n");	
		buffer.append("timesheetcomments").append("='").append(getTimesheetcomments()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Timesheet) )  { result = false; }
		 else if (other != null) {
		 	Timesheet castOther = (Timesheet) other;
			if (castOther.getIdTimeSheet().equals(this.getIdTimeSheet())) { result = true; }
         }
		 return result;
   }


}


