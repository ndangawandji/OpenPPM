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
 * Base Pojo object for domain model class Performingorg
 * @see es.sm2.openppm.model.base.Performingorg
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Performingorg
 */
public class BasePerformingorg  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "performingorg";
	
	public static final String IDPERFORG = "idPerfOrg";
	public static final String EMPLOYEE = "employee";
	public static final String COMPANY = "company";
	public static final String ONSAAS = "onSaaS";
	public static final String NAME = "name";
	public static final String PROJECTS = "projects";
	public static final String PROGRAMS = "programs";
	public static final String EMPLOYEES = "employees";

     private Integer idPerfOrg;
     private Employee employee;
     private Company company;
     private Boolean onSaaS;
     private String name;
     private Set<Project> projects = new HashSet<Project>(0);
     private Set<Program> programs = new HashSet<Program>(0);
     private Set<Employee> employees = new HashSet<Employee>(0);

    public BasePerformingorg() {
    }
    
    public BasePerformingorg(Integer idPerfOrg) {
    	this.idPerfOrg = idPerfOrg;
    }
   
    public Integer getIdPerfOrg() {
        return this.idPerfOrg;
    }
    
    public void setIdPerfOrg(Integer idPerfOrg) {
        this.idPerfOrg = idPerfOrg;
    }
    public Employee getEmployee() {
        return this.employee;
    }
    
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
    public Company getCompany() {
        return this.company;
    }
    
    public void setCompany(Company company) {
        this.company = company;
    }
    public Boolean getOnSaaS() {
        return this.onSaaS;
    }
    
    public void setOnSaaS(Boolean onSaaS) {
        this.onSaaS = onSaaS;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set<Project> getProjects() {
        return this.projects;
    }
    
    public void setProjects(Set<Project> projects) {
        this.projects = projects;
    }
    public Set<Program> getPrograms() {
        return this.programs;
    }
    
    public void setPrograms(Set<Program> programs) {
        this.programs = programs;
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
		buffer.append("idPerfOrg").append("='").append(getIdPerfOrg()).append("' \n");	
		buffer.append("employee").append("='").append(getEmployee()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("onSaaS").append("='").append(getOnSaaS()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("projects").append("='").append(getProjects()).append("' \n");	
		buffer.append("programs").append("='").append(getPrograms()).append("' \n");	
		buffer.append("employees").append("='").append(getEmployees()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Performingorg) )  { result = false; }
		 else if (other != null) {
		 	Performingorg castOther = (Performingorg) other;
			if (castOther.getIdPerfOrg().equals(this.getIdPerfOrg())) { result = true; }
         }
		 return result;
   }


}


