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
 * Base Pojo object for domain model class Operationaccount
 * @see es.sm2.openppm.model.base.Operationaccount
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Operationaccount
 */
public class BaseOperationaccount  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "operationaccount";
	
	public static final String IDOPACCOUNT = "idOpAccount";
	public static final String COMPANY = "company";
	public static final String DESCRIPTION = "description";
	public static final String OPERATIONS = "operations";

     private Integer idOpAccount;
     private Company company;
     private String description;
     private Set<Operation> operations = new HashSet<Operation>(0);

    public BaseOperationaccount() {
    }
    
    public BaseOperationaccount(Integer idOpAccount) {
    	this.idOpAccount = idOpAccount;
    }
   
    public Integer getIdOpAccount() {
        return this.idOpAccount;
    }
    
    public void setIdOpAccount(Integer idOpAccount) {
        this.idOpAccount = idOpAccount;
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
    public Set<Operation> getOperations() {
        return this.operations;
    }
    
    public void setOperations(Set<Operation> operations) {
        this.operations = operations;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idOpAccount").append("='").append(getIdOpAccount()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("operations").append("='").append(getOperations()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Operationaccount) )  { result = false; }
		 else if (other != null) {
		 	Operationaccount castOther = (Operationaccount) other;
			if (castOther.getIdOpAccount().equals(this.getIdOpAccount())) { result = true; }
         }
		 return result;
   }


}


