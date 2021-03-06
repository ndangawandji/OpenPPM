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
 * Base Pojo object for domain model class Expenseaccounts
 * @see es.sm2.openppm.model.base.Expenseaccounts
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Expenseaccounts
 */
public class BaseExpenseaccounts  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "expenseaccounts";
	
	public static final String IDEXPENSEACCOUNT = "idExpenseAccount";
	public static final String COMPANY = "company";
	public static final String DESCRIPTION = "description";
	public static final String EXPENSESHEETS = "expensesheets";

     private Integer idExpenseAccount;
     private Company company;
     private String description;
     private Set<Expensesheet> expensesheets = new HashSet<Expensesheet>(0);

    public BaseExpenseaccounts() {
    }
    
    public BaseExpenseaccounts(Integer idExpenseAccount) {
    	this.idExpenseAccount = idExpenseAccount;
    }
   
    public Integer getIdExpenseAccount() {
        return this.idExpenseAccount;
    }
    
    public void setIdExpenseAccount(Integer idExpenseAccount) {
        this.idExpenseAccount = idExpenseAccount;
    }
    public Company getCompany() {
        return this.company;
    }
    
    public void setCompany(Company company) {
        this.company = company;
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
		buffer.append("idExpenseAccount").append("='").append(getIdExpenseAccount()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
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
		 else if (!(other instanceof Expenseaccounts) )  { result = false; }
		 else if (other != null) {
		 	Expenseaccounts castOther = (Expenseaccounts) other;
			if (castOther.getIdExpenseAccount().equals(this.getIdExpenseAccount())) { result = true; }
         }
		 return result;
   }


}


