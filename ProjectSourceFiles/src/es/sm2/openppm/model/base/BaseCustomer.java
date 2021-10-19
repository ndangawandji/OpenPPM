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
 * Base Pojo object for domain model class Customer
 * @see es.sm2.openppm.model.base.Customer
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Customer
 */
public class BaseCustomer  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "customer";
	
	public static final String IDCUSTOMER = "idCustomer";
	public static final String CUSTOMERTYPE = "customertype";
	public static final String COMPANY = "company";
	public static final String NAME = "name";
	public static final String DESCRIPTION = "description";
	public static final String PROJECTS = "projects";

     private Integer idCustomer;
     private Customertype customertype;
     private Company company;
     private String name;
     private String description;
     private Set<Project> projects = new HashSet<Project>(0);

    public BaseCustomer() {
    }
    
    public BaseCustomer(Integer idCustomer) {
    	this.idCustomer = idCustomer;
    }
   
    public Integer getIdCustomer() {
        return this.idCustomer;
    }
    
    public void setIdCustomer(Integer idCustomer) {
        this.idCustomer = idCustomer;
    }
    public Customertype getCustomertype() {
        return this.customertype;
    }
    
    public void setCustomertype(Customertype customertype) {
        this.customertype = customertype;
    }
    public Company getCompany() {
        return this.company;
    }
    
    public void setCompany(Company company) {
        this.company = company;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public Set<Project> getProjects() {
        return this.projects;
    }
    
    public void setProjects(Set<Project> projects) {
        this.projects = projects;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idCustomer").append("='").append(getIdCustomer()).append("' \n");	
		buffer.append("customertype").append("='").append(getCustomertype()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("projects").append("='").append(getProjects()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Customer) )  { result = false; }
		 else if (other != null) {
		 	Customer castOther = (Customer) other;
			if (castOther.getIdCustomer().equals(this.getIdCustomer())) { result = true; }
         }
		 return result;
   }


}


