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
 * Base Pojo object for domain model class Logprojectstatus
 * @see es.sm2.openppm.model.base.Logprojectstatus
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Logprojectstatus
 */
public class BaseLogprojectstatus  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "logprojectstatus";
	
	public static final String IDLOGPROJECTSTATUS = "idLogProjectStatus";
	public static final String PROJECT = "project";
	public static final String EMPLOYEE = "employee";
	public static final String PROJECTSTATUS = "projectStatus";
	public static final String INVESTMENTSTATUS = "investmentStatus";
	public static final String LOGDATE = "logDate";

     private Integer idLogProjectStatus;
     private Project project;
     private Employee employee;
     private char projectStatus;
     private char investmentStatus;
     private Date logDate;

    public BaseLogprojectstatus() {
    }
    
    public BaseLogprojectstatus(Integer idLogProjectStatus) {
    	this.idLogProjectStatus = idLogProjectStatus;
    }
   
    public Integer getIdLogProjectStatus() {
        return this.idLogProjectStatus;
    }
    
    public void setIdLogProjectStatus(Integer idLogProjectStatus) {
        this.idLogProjectStatus = idLogProjectStatus;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public Employee getEmployee() {
        return this.employee;
    }
    
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
    public char getProjectStatus() {
        return this.projectStatus;
    }
    
    public void setProjectStatus(char projectStatus) {
        this.projectStatus = projectStatus;
    }
    public char getInvestmentStatus() {
        return this.investmentStatus;
    }
    
    public void setInvestmentStatus(char investmentStatus) {
        this.investmentStatus = investmentStatus;
    }
    public Date getLogDate() {
        return this.logDate;
    }
    
    public void setLogDate(Date logDate) {
        this.logDate = logDate;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idLogProjectStatus").append("='").append(getIdLogProjectStatus()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("employee").append("='").append(getEmployee()).append("' \n");	
		buffer.append("projectStatus").append("='").append(getProjectStatus()).append("' \n");	
		buffer.append("investmentStatus").append("='").append(getInvestmentStatus()).append("' \n");	
		buffer.append("logDate").append("='").append(getLogDate()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Logprojectstatus) )  { result = false; }
		 else if (other != null) {
		 	Logprojectstatus castOther = (Logprojectstatus) other;
			if (castOther.getIdLogProjectStatus().equals(this.getIdLogProjectStatus())) { result = true; }
         }
		 return result;
   }


}


