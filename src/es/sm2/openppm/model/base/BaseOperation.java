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
 * Base Pojo object for domain model class Operation
 * @see es.sm2.openppm.model.base.Operation
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Operation
 */
public class BaseOperation  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "operation";
	
	public static final String IDOPERATION = "idOperation";
	public static final String OPERATIONACCOUNT = "operationaccount";
	public static final String OPERATIONNAME = "operationName";
	public static final String OPERATIONCODE = "operationCode";
	public static final String EXPENSESHEETS = "expensesheets";
	public static final String TIMESHEETS = "timesheets";

     private Integer idOperation;
     private Operationaccount operationaccount;
     private String operationName;
     private String operationCode;
     private Set<Expensesheet> expensesheets = new HashSet<Expensesheet>(0);
     private Set<Timesheet> timesheets = new HashSet<Timesheet>(0);

    public BaseOperation() {
    }
    
    public BaseOperation(Integer idOperation) {
    	this.idOperation = idOperation;
    }
   
    public Integer getIdOperation() {
        return this.idOperation;
    }
    
    public void setIdOperation(Integer idOperation) {
        this.idOperation = idOperation;
    }
    public Operationaccount getOperationaccount() {
        return this.operationaccount;
    }
    
    public void setOperationaccount(Operationaccount operationaccount) {
        this.operationaccount = operationaccount;
    }
    public String getOperationName() {
        return this.operationName;
    }
    
    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }
    public String getOperationCode() {
        return this.operationCode;
    }
    
    public void setOperationCode(String operationCode) {
        this.operationCode = operationCode;
    }
    public Set<Expensesheet> getExpensesheets() {
        return this.expensesheets;
    }
    
    public void setExpensesheets(Set<Expensesheet> expensesheets) {
        this.expensesheets = expensesheets;
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
		buffer.append("idOperation").append("='").append(getIdOperation()).append("' \n");	
		buffer.append("operationaccount").append("='").append(getOperationaccount()).append("' \n");	
		buffer.append("operationName").append("='").append(getOperationName()).append("' \n");	
		buffer.append("operationCode").append("='").append(getOperationCode()).append("' \n");	
		buffer.append("expensesheets").append("='").append(getExpensesheets()).append("' \n");	
		buffer.append("timesheets").append("='").append(getTimesheets()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Operation) )  { result = false; }
		 else if (other != null) {
		 	Operation castOther = (Operation) other;
			if (castOther.getIdOperation().equals(this.getIdOperation())) { result = true; }
         }
		 return result;
   }


}


