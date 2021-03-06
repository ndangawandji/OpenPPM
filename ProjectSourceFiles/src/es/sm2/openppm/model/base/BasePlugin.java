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
 * Base Pojo object for domain model class Plugin
 * @see es.sm2.openppm.model.base.Plugin
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Plugin
 */
public class BasePlugin  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "plugin";
	
	public static final String IDPLUGIN = "idPlugin";
	public static final String COMPANY = "company";
	public static final String NAME = "name";
	public static final String ENABLED = "enabled";

     private Integer idPlugin;
     private Company company;
     private String name;
     private boolean enabled;

    public BasePlugin() {
    }
    
    public BasePlugin(Integer idPlugin) {
    	this.idPlugin = idPlugin;
    }
   
    public Integer getIdPlugin() {
        return this.idPlugin;
    }
    
    public void setIdPlugin(Integer idPlugin) {
        this.idPlugin = idPlugin;
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
    public boolean isEnabled() {
        return this.enabled;
    }
    
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idPlugin").append("='").append(getIdPlugin()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("enabled").append("='").append(isEnabled()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Plugin) )  { result = false; }
		 else if (other != null) {
		 	Plugin castOther = (Plugin) other;
			if (castOther.getIdPlugin().equals(this.getIdPlugin())) { result = true; }
         }
		 return result;
   }


}


