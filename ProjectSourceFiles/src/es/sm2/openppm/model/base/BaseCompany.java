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
 * Base Pojo object for domain model class Company
 * @see es.sm2.openppm.model.base.Company
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Company
 */
public class BaseCompany  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "company";
	
	public static final String IDCOMPANY = "idCompany";
	public static final String NAME = "name";
	public static final String SELLERS = "sellers";
	public static final String EXPENSEACCOUNTSES = "expenseaccountses";
	public static final String OPERATIONACCOUNTS = "operationaccounts";
	public static final String CATEGORIES = "categories";
	public static final String CONTACTS = "contacts";
	public static final String CUSTOMERTYPES = "customertypes";
	public static final String GEOGRAPHIES = "geographies";
	public static final String SETTINGS = "settings";
	public static final String PERFORMINGORGS = "performingorgs";
	public static final String CONTRACTTYPES = "contracttypes";
	public static final String METRICKPIS = "metrickpis";
	public static final String CALENDARBASES = "calendarbases";
	public static final String PLUGINS = "plugins";
	public static final String DOCUMENTATIONS = "documentations";
	public static final String SKILLS = "skills";
	public static final String BSCDIMENSIONS = "bscdimensions";
	public static final String CUSTOMERS = "customers";
	public static final String CHANGETYPES = "changetypes";
	public static final String FUNDINGSOURCES = "fundingsources";
	public static final String BUDGETACCOUNTSES = "budgetaccountses";

     private Integer idCompany;
     private String name;
     private Set<Seller> sellers = new HashSet<Seller>(0);
     private Set<Expenseaccounts> expenseaccountses = new HashSet<Expenseaccounts>(0);
     private Set<Operationaccount> operationaccounts = new HashSet<Operationaccount>(0);
     private Set<Category> categories = new HashSet<Category>(0);
     private Set<Contact> contacts = new HashSet<Contact>(0);
     private Set<Customertype> customertypes = new HashSet<Customertype>(0);
     private Set<Geography> geographies = new HashSet<Geography>(0);
     private Set<Setting> settings = new HashSet<Setting>(0);
     private Set<Performingorg> performingorgs = new HashSet<Performingorg>(0);
     private Set<Contracttype> contracttypes = new HashSet<Contracttype>(0);
     private Set<Metrickpi> metrickpis = new HashSet<Metrickpi>(0);
     private Set<Calendarbase> calendarbases = new HashSet<Calendarbase>(0);
     private Set<Plugin> plugins = new HashSet<Plugin>(0);
     private Set<Documentation> documentations = new HashSet<Documentation>(0);
     private Set<Skill> skills = new HashSet<Skill>(0);
     private Set<Bscdimension> bscdimensions = new HashSet<Bscdimension>(0);
     private Set<Customer> customers = new HashSet<Customer>(0);
     private Set<Changetype> changetypes = new HashSet<Changetype>(0);
     private Set<Fundingsource> fundingsources = new HashSet<Fundingsource>(0);
     private Set<Budgetaccounts> budgetaccountses = new HashSet<Budgetaccounts>(0);

    public BaseCompany() {
    }
    
    public BaseCompany(Integer idCompany) {
    	this.idCompany = idCompany;
    }
   
    public Integer getIdCompany() {
        return this.idCompany;
    }
    
    public void setIdCompany(Integer idCompany) {
        this.idCompany = idCompany;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set<Seller> getSellers() {
        return this.sellers;
    }
    
    public void setSellers(Set<Seller> sellers) {
        this.sellers = sellers;
    }
    public Set<Expenseaccounts> getExpenseaccountses() {
        return this.expenseaccountses;
    }
    
    public void setExpenseaccountses(Set<Expenseaccounts> expenseaccountses) {
        this.expenseaccountses = expenseaccountses;
    }
    public Set<Operationaccount> getOperationaccounts() {
        return this.operationaccounts;
    }
    
    public void setOperationaccounts(Set<Operationaccount> operationaccounts) {
        this.operationaccounts = operationaccounts;
    }
    public Set<Category> getCategories() {
        return this.categories;
    }
    
    public void setCategories(Set<Category> categories) {
        this.categories = categories;
    }
    public Set<Contact> getContacts() {
        return this.contacts;
    }
    
    public void setContacts(Set<Contact> contacts) {
        this.contacts = contacts;
    }
    public Set<Customertype> getCustomertypes() {
        return this.customertypes;
    }
    
    public void setCustomertypes(Set<Customertype> customertypes) {
        this.customertypes = customertypes;
    }
    public Set<Geography> getGeographies() {
        return this.geographies;
    }
    
    public void setGeographies(Set<Geography> geographies) {
        this.geographies = geographies;
    }
    public Set<Setting> getSettings() {
        return this.settings;
    }
    
    public void setSettings(Set<Setting> settings) {
        this.settings = settings;
    }
    public Set<Performingorg> getPerformingorgs() {
        return this.performingorgs;
    }
    
    public void setPerformingorgs(Set<Performingorg> performingorgs) {
        this.performingorgs = performingorgs;
    }
    public Set<Contracttype> getContracttypes() {
        return this.contracttypes;
    }
    
    public void setContracttypes(Set<Contracttype> contracttypes) {
        this.contracttypes = contracttypes;
    }
    public Set<Metrickpi> getMetrickpis() {
        return this.metrickpis;
    }
    
    public void setMetrickpis(Set<Metrickpi> metrickpis) {
        this.metrickpis = metrickpis;
    }
    public Set<Calendarbase> getCalendarbases() {
        return this.calendarbases;
    }
    
    public void setCalendarbases(Set<Calendarbase> calendarbases) {
        this.calendarbases = calendarbases;
    }
    public Set<Plugin> getPlugins() {
        return this.plugins;
    }
    
    public void setPlugins(Set<Plugin> plugins) {
        this.plugins = plugins;
    }
    public Set<Documentation> getDocumentations() {
        return this.documentations;
    }
    
    public void setDocumentations(Set<Documentation> documentations) {
        this.documentations = documentations;
    }
    public Set<Skill> getSkills() {
        return this.skills;
    }
    
    public void setSkills(Set<Skill> skills) {
        this.skills = skills;
    }
    public Set<Bscdimension> getBscdimensions() {
        return this.bscdimensions;
    }
    
    public void setBscdimensions(Set<Bscdimension> bscdimensions) {
        this.bscdimensions = bscdimensions;
    }
    public Set<Customer> getCustomers() {
        return this.customers;
    }
    
    public void setCustomers(Set<Customer> customers) {
        this.customers = customers;
    }
    public Set<Changetype> getChangetypes() {
        return this.changetypes;
    }
    
    public void setChangetypes(Set<Changetype> changetypes) {
        this.changetypes = changetypes;
    }
    public Set<Fundingsource> getFundingsources() {
        return this.fundingsources;
    }
    
    public void setFundingsources(Set<Fundingsource> fundingsources) {
        this.fundingsources = fundingsources;
    }
    public Set<Budgetaccounts> getBudgetaccountses() {
        return this.budgetaccountses;
    }
    
    public void setBudgetaccountses(Set<Budgetaccounts> budgetaccountses) {
        this.budgetaccountses = budgetaccountses;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idCompany").append("='").append(getIdCompany()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("sellers").append("='").append(getSellers()).append("' \n");	
		buffer.append("expenseaccountses").append("='").append(getExpenseaccountses()).append("' \n");	
		buffer.append("operationaccounts").append("='").append(getOperationaccounts()).append("' \n");	
		buffer.append("categories").append("='").append(getCategories()).append("' \n");	
		buffer.append("contacts").append("='").append(getContacts()).append("' \n");	
		buffer.append("customertypes").append("='").append(getCustomertypes()).append("' \n");	
		buffer.append("geographies").append("='").append(getGeographies()).append("' \n");	
		buffer.append("settings").append("='").append(getSettings()).append("' \n");	
		buffer.append("performingorgs").append("='").append(getPerformingorgs()).append("' \n");	
		buffer.append("contracttypes").append("='").append(getContracttypes()).append("' \n");	
		buffer.append("metrickpis").append("='").append(getMetrickpis()).append("' \n");	
		buffer.append("calendarbases").append("='").append(getCalendarbases()).append("' \n");	
		buffer.append("plugins").append("='").append(getPlugins()).append("' \n");	
		buffer.append("documentations").append("='").append(getDocumentations()).append("' \n");	
		buffer.append("skills").append("='").append(getSkills()).append("' \n");	
		buffer.append("bscdimensions").append("='").append(getBscdimensions()).append("' \n");	
		buffer.append("customers").append("='").append(getCustomers()).append("' \n");	
		buffer.append("changetypes").append("='").append(getChangetypes()).append("' \n");	
		buffer.append("fundingsources").append("='").append(getFundingsources()).append("' \n");	
		buffer.append("budgetaccountses").append("='").append(getBudgetaccountses()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Company) )  { result = false; }
		 else if (other != null) {
		 	Company castOther = (Company) other;
			if (castOther.getIdCompany().equals(this.getIdCompany())) { result = true; }
         }
		 return result;
   }


}


