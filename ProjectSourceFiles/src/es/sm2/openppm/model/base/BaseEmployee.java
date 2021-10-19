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
 * Base Pojo object for domain model class Employee
 * @see es.sm2.openppm.model.base.Employee
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Employee
 */
public class BaseEmployee  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "employee";
	
	public static final String IDEMPLOYEE = "idEmployee";
	public static final String CALENDARBASE = "calendarbase";
	public static final String EMPLOYEE = "employee";
	public static final String PERFORMINGORG = "performingorg";
	public static final String CONTACT = "contact";
	public static final String RESOURCEPROFILES = "resourceprofiles";
	public static final String COSTRATE = "costRate";
	public static final String PROFILEDATE = "profileDate";
	public static final String TOKEN = "token";
	public static final String PROJECTSFORINVESTMENTMANAGER = "projectsForInvestmentManager";
	public static final String PROGRAMS = "programs";
	public static final String PROJECTSFORSPONSOR = "projectsForSponsor";
	public static final String EXPENSESHEETS = "expensesheets";
	public static final String PROJECTSFORFUNCTIONALMANAGER = "projectsForFunctionalManager";
	public static final String TIMESHEETS = "timesheets";
	public static final String PROJECTSFORPROJECTMANAGER = "projectsForProjectManager";
	public static final String TEAMMEMBERS = "teammembers";
	public static final String SKILLSEMPLOYEES = "skillsemployees";
	public static final String PERFORMINGORGS = "performingorgs";
	public static final String LOGPROJECTSTATUSES = "logprojectstatuses";
	public static final String EMPLOYEES = "employees";

     private Integer idEmployee;
     private Calendarbase calendarbase;
     private Employee employee;
     private Performingorg performingorg;
     private Contact contact;
     private Resourceprofiles resourceprofiles;
     private Double costRate;
     private Date profileDate;
     private String token;
     private Set<Project> projectsForInvestmentManager = new HashSet<Project>(0);
     private Set<Program> programs = new HashSet<Program>(0);
     private Set<Project> projectsForSponsor = new HashSet<Project>(0);
     private Set<Expensesheet> expensesheets = new HashSet<Expensesheet>(0);
     private Set<Project> projectsForFunctionalManager = new HashSet<Project>(0);
     private Set<Timesheet> timesheets = new HashSet<Timesheet>(0);
     private Set<Project> projectsForProjectManager = new HashSet<Project>(0);
     private Set<Teammember> teammembers = new HashSet<Teammember>(0);
     private Set<Skillsemployee> skillsemployees = new HashSet<Skillsemployee>(0);
     private Set<Performingorg> performingorgs = new HashSet<Performingorg>(0);
     private Set<Logprojectstatus> logprojectstatuses = new HashSet<Logprojectstatus>(0);
     private Set<Employee> employees = new HashSet<Employee>(0);

    public BaseEmployee() {
    }
    
    public BaseEmployee(Integer idEmployee) {
    	this.idEmployee = idEmployee;
    }
   
    public Integer getIdEmployee() {
        return this.idEmployee;
    }
    
    public void setIdEmployee(Integer idEmployee) {
        this.idEmployee = idEmployee;
    }
    public Calendarbase getCalendarbase() {
        return this.calendarbase;
    }
    
    public void setCalendarbase(Calendarbase calendarbase) {
        this.calendarbase = calendarbase;
    }
    public Employee getEmployee() {
        return this.employee;
    }
    
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
    public Performingorg getPerformingorg() {
        return this.performingorg;
    }
    
    public void setPerformingorg(Performingorg performingorg) {
        this.performingorg = performingorg;
    }
    public Contact getContact() {
        return this.contact;
    }
    
    public void setContact(Contact contact) {
        this.contact = contact;
    }
    public Resourceprofiles getResourceprofiles() {
        return this.resourceprofiles;
    }
    
    public void setResourceprofiles(Resourceprofiles resourceprofiles) {
        this.resourceprofiles = resourceprofiles;
    }
    public Double getCostRate() {
        return this.costRate;
    }
    
    public void setCostRate(Double costRate) {
        this.costRate = costRate;
    }
    public Date getProfileDate() {
        return this.profileDate;
    }
    
    public void setProfileDate(Date profileDate) {
        this.profileDate = profileDate;
    }
    public String getToken() {
        return this.token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
    public Set<Project> getProjectsForInvestmentManager() {
        return this.projectsForInvestmentManager;
    }
    
    public void setProjectsForInvestmentManager(Set<Project> projectsForInvestmentManager) {
        this.projectsForInvestmentManager = projectsForInvestmentManager;
    }
    public Set<Program> getPrograms() {
        return this.programs;
    }
    
    public void setPrograms(Set<Program> programs) {
        this.programs = programs;
    }
    public Set<Project> getProjectsForSponsor() {
        return this.projectsForSponsor;
    }
    
    public void setProjectsForSponsor(Set<Project> projectsForSponsor) {
        this.projectsForSponsor = projectsForSponsor;
    }
    public Set<Expensesheet> getExpensesheets() {
        return this.expensesheets;
    }
    
    public void setExpensesheets(Set<Expensesheet> expensesheets) {
        this.expensesheets = expensesheets;
    }
    public Set<Project> getProjectsForFunctionalManager() {
        return this.projectsForFunctionalManager;
    }
    
    public void setProjectsForFunctionalManager(Set<Project> projectsForFunctionalManager) {
        this.projectsForFunctionalManager = projectsForFunctionalManager;
    }
    public Set<Timesheet> getTimesheets() {
        return this.timesheets;
    }
    
    public void setTimesheets(Set<Timesheet> timesheets) {
        this.timesheets = timesheets;
    }
    public Set<Project> getProjectsForProjectManager() {
        return this.projectsForProjectManager;
    }
    
    public void setProjectsForProjectManager(Set<Project> projectsForProjectManager) {
        this.projectsForProjectManager = projectsForProjectManager;
    }
    public Set<Teammember> getTeammembers() {
        return this.teammembers;
    }
    
    public void setTeammembers(Set<Teammember> teammembers) {
        this.teammembers = teammembers;
    }
    public Set<Skillsemployee> getSkillsemployees() {
        return this.skillsemployees;
    }
    
    public void setSkillsemployees(Set<Skillsemployee> skillsemployees) {
        this.skillsemployees = skillsemployees;
    }
    public Set<Performingorg> getPerformingorgs() {
        return this.performingorgs;
    }
    
    public void setPerformingorgs(Set<Performingorg> performingorgs) {
        this.performingorgs = performingorgs;
    }
    public Set<Logprojectstatus> getLogprojectstatuses() {
        return this.logprojectstatuses;
    }
    
    public void setLogprojectstatuses(Set<Logprojectstatus> logprojectstatuses) {
        this.logprojectstatuses = logprojectstatuses;
    }
    public Set<Employee> getEmployees() {
        return this.employees;
    }
    
    public void setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idEmployee").append("='").append(getIdEmployee()).append("' \n");	
		buffer.append("calendarbase").append("='").append(getCalendarbase()).append("' \n");	
		buffer.append("employee").append("='").append(getEmployee()).append("' \n");	
		buffer.append("performingorg").append("='").append(getPerformingorg()).append("' \n");	
		buffer.append("contact").append("='").append(getContact()).append("' \n");	
		buffer.append("resourceprofiles").append("='").append(getResourceprofiles()).append("' \n");	
		buffer.append("costRate").append("='").append(getCostRate()).append("' \n");	
		buffer.append("profileDate").append("='").append(getProfileDate()).append("' \n");	
		buffer.append("token").append("='").append(getToken()).append("' \n");	
		buffer.append("projectsForInvestmentManager").append("='").append(getProjectsForInvestmentManager()).append("' \n");	
		buffer.append("programs").append("='").append(getPrograms()).append("' \n");	
		buffer.append("projectsForSponsor").append("='").append(getProjectsForSponsor()).append("' \n");	
		buffer.append("expensesheets").append("='").append(getExpensesheets()).append("' \n");	
		buffer.append("projectsForFunctionalManager").append("='").append(getProjectsForFunctionalManager()).append("' \n");	
		buffer.append("timesheets").append("='").append(getTimesheets()).append("' \n");	
		buffer.append("projectsForProjectManager").append("='").append(getProjectsForProjectManager()).append("' \n");	
		buffer.append("teammembers").append("='").append(getTeammembers()).append("' \n");	
		buffer.append("skillsemployees").append("='").append(getSkillsemployees()).append("' \n");	
		buffer.append("performingorgs").append("='").append(getPerformingorgs()).append("' \n");	
		buffer.append("logprojectstatuses").append("='").append(getLogprojectstatuses()).append("' \n");	
		buffer.append("employees").append("='").append(getEmployees()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Employee) )  { result = false; }
		 else if (other != null) {
		 	Employee castOther = (Employee) other;
			if (castOther.getIdEmployee().equals(this.getIdEmployee())) { result = true; }
         }
		 return result;
   }


}


