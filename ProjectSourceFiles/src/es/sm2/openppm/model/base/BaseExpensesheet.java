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
 * Base Pojo object for domain model class Expensesheet
 * @see es.sm2.openppm.model.base.Expensesheet
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Expensesheet
 */
public class BaseExpensesheet  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "expensesheet";
	
	public static final String IDEXPENSESHEET = "idExpenseSheet";
	public static final String OPERATION = "operation";
	public static final String EXPENSEACCOUNTS = "expenseaccounts";
	public static final String PROJECT = "project";
	public static final String EXPENSES = "expenses";
	public static final String EMPLOYEE = "employee";
	public static final String COST = "cost";
	public static final String REIMBURSABLE = "reimbursable";
	public static final String PAIDEMPLOYEE = "paidEmployee";
	public static final String EXPENSEDATE = "expenseDate";
	public static final String AUTORIZATIONNUMBER = "autorizationNumber";
	public static final String DESCRIPTION = "description";
	public static final String STATUS = "status";
	public static final String EXPENSESHEETCOMMENTS = "expensesheetcomments";

     private Integer idExpenseSheet;
     private Operation operation;
     private Expenseaccounts expenseaccounts;
     private Project project;
     private Expenses expenses;
     private Employee employee;
     private Double cost;
     private Boolean reimbursable;
     private Boolean paidEmployee;
     private Date expenseDate;
     private Integer autorizationNumber;
     private String description;
     private String status;
     private Set<Expensesheetcomment> expensesheetcomments = new HashSet<Expensesheetcomment>(0);

    public BaseExpensesheet() {
    }
    
    public BaseExpensesheet(Integer idExpenseSheet) {
    	this.idExpenseSheet = idExpenseSheet;
    }
   
    public Integer getIdExpenseSheet() {
        return this.idExpenseSheet;
    }
    
    public void setIdExpenseSheet(Integer idExpenseSheet) {
        this.idExpenseSheet = idExpenseSheet;
    }
    public Operation getOperation() {
        return this.operation;
    }
    
    public void setOperation(Operation operation) {
        this.operation = operation;
    }
    public Expenseaccounts getExpenseaccounts() {
        return this.expenseaccounts;
    }
    
    public void setExpenseaccounts(Expenseaccounts expenseaccounts) {
        this.expenseaccounts = expenseaccounts;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public Expenses getExpenses() {
        return this.expenses;
    }
    
    public void setExpenses(Expenses expenses) {
        this.expenses = expenses;
    }
    public Employee getEmployee() {
        return this.employee;
    }
    
    public void setEmployee(Employee employee) {
        this.employee = employee;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
    }
    public Boolean getReimbursable() {
        return this.reimbursable;
    }
    
    public void setReimbursable(Boolean reimbursable) {
        this.reimbursable = reimbursable;
    }
    public Boolean getPaidEmployee() {
        return this.paidEmployee;
    }
    
    public void setPaidEmployee(Boolean paidEmployee) {
        this.paidEmployee = paidEmployee;
    }
    public Date getExpenseDate() {
        return this.expenseDate;
    }
    
    public void setExpenseDate(Date expenseDate) {
        this.expenseDate = expenseDate;
    }
    public Integer getAutorizationNumber() {
        return this.autorizationNumber;
    }
    
    public void setAutorizationNumber(Integer autorizationNumber) {
        this.autorizationNumber = autorizationNumber;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Set<Expensesheetcomment> getExpensesheetcomments() {
        return this.expensesheetcomments;
    }
    
    public void setExpensesheetcomments(Set<Expensesheetcomment> expensesheetcomments) {
        this.expensesheetcomments = expensesheetcomments;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idExpenseSheet").append("='").append(getIdExpenseSheet()).append("' \n");	
		buffer.append("operation").append("='").append(getOperation()).append("' \n");	
		buffer.append("expenseaccounts").append("='").append(getExpenseaccounts()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("expenses").append("='").append(getExpenses()).append("' \n");	
		buffer.append("employee").append("='").append(getEmployee()).append("' \n");	
		buffer.append("cost").append("='").append(getCost()).append("' \n");	
		buffer.append("reimbursable").append("='").append(getReimbursable()).append("' \n");	
		buffer.append("paidEmployee").append("='").append(getPaidEmployee()).append("' \n");	
		buffer.append("expenseDate").append("='").append(getExpenseDate()).append("' \n");	
		buffer.append("autorizationNumber").append("='").append(getAutorizationNumber()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("status").append("='").append(getStatus()).append("' \n");	
		buffer.append("expensesheetcomments").append("='").append(getExpensesheetcomments()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Expensesheet) )  { result = false; }
		 else if (other != null) {
		 	Expensesheet castOther = (Expensesheet) other;
			if (castOther.getIdExpenseSheet().equals(this.getIdExpenseSheet())) { result = true; }
         }
		 return result;
   }


}


