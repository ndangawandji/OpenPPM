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
 * Base Pojo object for domain model class Contact
 * @see es.sm2.openppm.model.base.Contact
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Contact
 */
public class BaseContact  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "contact";
	
	public static final String IDCONTACT = "idContact";
	public static final String COMPANY = "company";
	public static final String FULLNAME = "fullName";
	public static final String JOBTITLE = "jobTitle";
	public static final String FILEAS = "fileAs";
	public static final String BUSINESSPHONE = "businessPhone";
	public static final String MOBILEPHONE = "mobilePhone";
	public static final String BUSINESSADDRESS = "businessAddress";
	public static final String EMAIL = "email";
	public static final String NOTES = "notes";
	public static final String LOCALE = "locale";
	public static final String EMPLOYEES = "employees";
	public static final String SECURITIES = "securities";

     private Integer idContact;
     private Company company;
     private String fullName;
     private String jobTitle;
     private String fileAs;
     private String businessPhone;
     private String mobilePhone;
     private String businessAddress;
     private String email;
     private String notes;
     private String locale;
     private Set<Employee> employees = new HashSet<Employee>(0);
     private Set<Security> securities = new HashSet<Security>(0);

    public BaseContact() {
    }
    
    public BaseContact(Integer idContact) {
    	this.idContact = idContact;
    }
   
    public Integer getIdContact() {
        return this.idContact;
    }
    
    public void setIdContact(Integer idContact) {
        this.idContact = idContact;
    }
    public Company getCompany() {
        return this.company;
    }
    
    public void setCompany(Company company) {
        this.company = company;
    }
    public String getFullName() {
        return this.fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public String getJobTitle() {
        return this.jobTitle;
    }
    
    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }
    public String getFileAs() {
        return this.fileAs;
    }
    
    public void setFileAs(String fileAs) {
        this.fileAs = fileAs;
    }
    public String getBusinessPhone() {
        return this.businessPhone;
    }
    
    public void setBusinessPhone(String businessPhone) {
        this.businessPhone = businessPhone;
    }
    public String getMobilePhone() {
        return this.mobilePhone;
    }
    
    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }
    public String getBusinessAddress() {
        return this.businessAddress;
    }
    
    public void setBusinessAddress(String businessAddress) {
        this.businessAddress = businessAddress;
    }
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    public String getNotes() {
        return this.notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
    public String getLocale() {
        return this.locale;
    }
    
    public void setLocale(String locale) {
        this.locale = locale;
    }
    public Set<Employee> getEmployees() {
        return this.employees;
    }
    
    public void setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }
    public Set<Security> getSecurities() {
        return this.securities;
    }
    
    public void setSecurities(Set<Security> securities) {
        this.securities = securities;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idContact").append("='").append(getIdContact()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("fullName").append("='").append(getFullName()).append("' \n");	
		buffer.append("jobTitle").append("='").append(getJobTitle()).append("' \n");	
		buffer.append("fileAs").append("='").append(getFileAs()).append("' \n");	
		buffer.append("businessPhone").append("='").append(getBusinessPhone()).append("' \n");	
		buffer.append("mobilePhone").append("='").append(getMobilePhone()).append("' \n");	
		buffer.append("businessAddress").append("='").append(getBusinessAddress()).append("' \n");	
		buffer.append("email").append("='").append(getEmail()).append("' \n");	
		buffer.append("notes").append("='").append(getNotes()).append("' \n");	
		buffer.append("locale").append("='").append(getLocale()).append("' \n");	
		buffer.append("employees").append("='").append(getEmployees()).append("' \n");	
		buffer.append("securities").append("='").append(getSecurities()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Contact) )  { result = false; }
		 else if (other != null) {
		 	Contact castOther = (Contact) other;
			if (castOther.getIdContact().equals(this.getIdContact())) { result = true; }
         }
		 return result;
   }


}


