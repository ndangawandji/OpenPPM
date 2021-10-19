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
 * Base Pojo object for domain model class Expenses
 * @see es.sm2.openppm.model.base.Expenses
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Expenses
 */
public class BaseExpenses  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "expenses";
	
	public static final String IDEXPENSE = "idExpense";
	public static final String PROJECTCOSTS = "projectcosts";
	public static final String BUDGETACCOUNTS = "budgetaccounts";
	public static final String PLANNED = "planned";
	public static final String ACTUAL = "actual";
	public static final String DESCRIPTION = "description";
	public static final String EXPENSESHEETS = "expensesheets";

     private Integer idExpense;
     private Projectcosts projectcosts;
     private Budgetaccounts budgetaccounts;
     private Double planned;
     private Double actual;
     private String description;
     private Set<Expensesheet> expensesheets = new HashSet<Expensesheet>(0);

    public BaseExpenses() {
    }
    
    public BaseExpenses(Integer idExpense) {
    	this.idExpense = idExpense;
    }
   
    public Integer getIdExpense() {
        return this.idExpense;
    }
    
    public void setIdExpense(Integer idExpense) {
        this.idExpense = idExpense;
    }
    public Projectcosts getProjectcosts() {
        return this.projectcosts;
    }
    
    public void setProjectcosts(Projectcosts projectcosts) {
        this.projectcosts = projectcosts;
    }
    public Budgetaccounts getBudgetaccounts() {
        return this.budgetaccounts;
    }
    
    public void setBudgetaccounts(Budgetaccounts budgetaccounts) {
        this.budgetaccounts = budgetaccounts;
    }
    public Double getPlanned() {
        return this.planned;
    }
    
    public void setPlanned(Double planned) {
        this.planned = planned;
    }
    public Double getActual() {
        return this.actual;
    }
    
    public void setActual(Double actual) {
        this.actual = actual;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Set<Expensesheet> getExpensesheets() {
        return this.expensesheets;
    }
    
    public void setExpensesheets(Set<Expensesheet> expensesheets) {
        this.expensesheets = expensesheets;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idExpense").append("='").append(getIdExpense()).append("' \n");	
		buffer.append("projectcosts").append("='").append(getProjectcosts()).append("' \n");	
		buffer.append("budgetaccounts").append("='").append(getBudgetaccounts()).append("' \n");	
		buffer.append("planned").append("='").append(getPlanned()).append("' \n");	
		buffer.append("actual").append("='").append(getActual()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("expensesheets").append("='").append(getExpensesheets()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Expenses) )  { result = false; }
		 else if (other != null) {
		 	Expenses castOther = (Expenses) other;
			if (castOther.getIdExpense().equals(this.getIdExpense())) { result = true; }
         }
		 return result;
   }


}


