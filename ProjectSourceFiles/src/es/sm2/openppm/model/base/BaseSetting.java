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



 /**
 * Base Pojo object for domain model class Setting
 * @see es.sm2.openppm.model.base.Setting
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Setting
 */
public class BaseSetting  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "setting";
	
	public static final String IDSETTING = "idSetting";
	public static final String COMPANY = "company";
	public static final String NAME = "name";
	public static final String VALUE = "value";
	public static final String STATUS = "status";
	public static final String INFORMATION = "information";

     private Integer idSetting;
     private Company company;
     private String name;
     private String value;
     private String status;
     private String information;

    public BaseSetting() {
    }
    
    public BaseSetting(Integer idSetting) {
    	this.idSetting = idSetting;
    }
   
    public Integer getIdSetting() {
        return this.idSetting;
    }
    
    public void setIdSetting(Integer idSetting) {
        this.idSetting = idSetting;
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
    public String getValue() {
        return this.value;
    }
    
    public void setValue(String value) {
        this.value = value;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public String getInformation() {
        return this.information;
    }
    
    public void setInformation(String information) {
        this.information = information;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idSetting").append("='").append(getIdSetting()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("value").append("='").append(getValue()).append("' \n");	
		buffer.append("status").append("='").append(getStatus()).append("' \n");	
		buffer.append("information").append("='").append(getInformation()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Setting) )  { result = false; }
		 else if (other != null) {
		 	Setting castOther = (Setting) other;
			if (castOther.getIdSetting().equals(this.getIdSetting())) { result = true; }
         }
		 return result;
   }


}


