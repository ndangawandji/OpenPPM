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
 *  Updater : Cedric Ndanga Wandji
 *  Devoteam 09/06/2015 user story 40 : adding initial workload
 */
package es.sm2.openppm.model.base;
import es.sm2.openppm.model.*;


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

 /**
 * Base Pojo object for domain model class Projectactivity
 * @see es.sm2.openppm.model.base.Projectactivity
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Projectactivity
 */
public class BaseProjectactivity  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "projectactivity";
	
	public static final String IDACTIVITY = "idActivity";
	public static final String WBSNODE = "wbsnode";
	public static final String PROJECT = "project";
	public static final String ACTIVITYNAME = "activityName";
	public static final String WBSDICTIONARY = "wbsdictionary";
	public static final String PLANINITDATE = "planInitDate";
	public static final String ACTUALINITDATE = "actualInitDate";
	public static final String PLANENDDATE = "planEndDate";
	public static final String ACTUALENDDATE = "actualEndDate";
	public static final String INITWORKLOAD = "initWorkload";
	public static final String EV = "ev";
	public static final String PV = "pv";
	public static final String AC = "ac";
	public static final String POC = "poc";
	public static final String ACTIVITYSELLERS = "activitysellers";
	public static final String TEAMMEMBERS = "teammembers";
	public static final String MILESTONESES = "milestoneses";
	public static final String TIMESHEETS = "timesheets";

     private Integer idActivity;
     private Wbsnode wbsnode;
     private Project project;
     private String activityName;
     private String wbsdictionary;
     private Date planInitDate;
     private Date actualInitDate;
     private Date planEndDate;
     private Date actualEndDate;
     private Double initWorkload;						// cnw us40 initial workload
     private Double ev;
     private Double pv;
     private Double ac;
     private Double poc;
     private Set<Activityseller> activitysellers = new HashSet<Activityseller>(0);
     private Set<Teammember> teammembers = new HashSet<Teammember>(0);
     private Set<Milestones> milestoneses = new HashSet<Milestones>(0);
     private Set<Timesheet> timesheets = new HashSet<Timesheet>(0);

    public BaseProjectactivity() {
    }
    
    public BaseProjectactivity(Integer idActivity) {
    	this.idActivity = idActivity;
    }
   
    public Integer getIdActivity() {
        return this.idActivity;
    }
    
    public void setIdActivity(Integer idActivity) {
        this.idActivity = idActivity;
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
    public String getActivityName() {
        return this.activityName;
    }
    
    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }
    public String getWbsdictionary() {
        return this.wbsdictionary;
    }
    
    public void setWbsdictionary(String wbsdictionary) {
        this.wbsdictionary = wbsdictionary;
    }
    public Date getPlanInitDate() {
        return this.planInitDate;
    }
    
    public void setPlanInitDate(Date planInitDate) {
        this.planInitDate = planInitDate;
    }
    public Date getActualInitDate() {
        return this.actualInitDate;
    }
    
    public void setActualInitDate(Date actualInitDate) {
        this.actualInitDate = actualInitDate;
    }
    public Date getPlanEndDate() {
        return this.planEndDate;
    }
    
    public void setPlanEndDate(Date planEndDate) {
        this.planEndDate = planEndDate;
    }
    public Date getActualEndDate() {
        return this.actualEndDate;
    }
    
    public void setActualEndDate(Date actualEndDate) {
        this.actualEndDate = actualEndDate;
    }
    /**
     * @author Cedric Ndanga
     * user story 40
	 * @return the initWorkload.
	 * 
	 */
	public Double getInitWorkload() {
		return this.initWorkload;
	}

	/**
	 * @author Cedric Ndanga
	 * user story 40
	 * @param initWorkload the initWorkload to set
	 */
	public void setInitWorkload(Double initWorkload) {
		this.initWorkload = initWorkload;
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
    public Double getPoc() {
        return this.poc;
    }
    
    public void setPoc(Double poc) {
        this.poc = poc;
    }
    public Set<Activityseller> getActivitysellers() {
        return this.activitysellers;
    }
    
    public void setActivitysellers(Set<Activityseller> activitysellers) {
        this.activitysellers = activitysellers;
    }
    public Set<Teammember> getTeammembers() {
        return this.teammembers;
    }
    
    public void setTeammembers(Set<Teammember> teammembers) {
        this.teammembers = teammembers;
    }
    public Set<Milestones> getMilestoneses() {
        return this.milestoneses;
    }
    
    public void setMilestoneses(Set<Milestones> milestoneses) {
        this.milestoneses = milestoneses;
    }
    public Set<Timesheet> getTimesheets() {
        return this.timesheets;
    }
    
    public void setTimesheets(Set<Timesheet> timesheets) {
        this.timesheets = timesheets;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idActivity").append("='").append(getIdActivity()).append("' \n");	
		buffer.append("wbsnode").append("='").append(getWbsnode()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("activityName").append("='").append(getActivityName()).append("' \n");	
		buffer.append("wbsdictionary").append("='").append(getWbsdictionary()).append("' \n");	
		buffer.append("planInitDate").append("='").append(getPlanInitDate()).append("' \n");	
		buffer.append("actualInitDate").append("='").append(getActualInitDate()).append("' \n");	
		buffer.append("planEndDate").append("='").append(getPlanEndDate()).append("' \n");	
		buffer.append("actualEndDate").append("='").append(getActualEndDate()).append("' \n");	
		buffer.append("ev").append("='").append(getEv()).append("' \n");	
		buffer.append("pv").append("='").append(getPv()).append("' \n");	
		buffer.append("ac").append("='").append(getAc()).append("' \n");	
		buffer.append("poc").append("='").append(getPoc()).append("' \n");	
		buffer.append("activitysellers").append("='").append(getActivitysellers()).append("' \n");	
		buffer.append("teammembers").append("='").append(getTeammembers()).append("' \n");	
		buffer.append("milestoneses").append("='").append(getMilestoneses()).append("' \n");	
		buffer.append("timesheets").append("='").append(getTimesheets()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Projectactivity) )  { result = false; }
		 else if (other != null) {
		 	Projectactivity castOther = (Projectactivity) other;
			if (castOther.getIdActivity().equals(this.getIdActivity())) { result = true; }
         }
		 return result;
   }


}


