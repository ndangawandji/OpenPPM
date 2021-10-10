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
 * Base Pojo object for domain model class Metrickpi
 * @see es.sm2.openppm.model.base.Metrickpi
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Metrickpi
 */
public class BaseMetrickpi  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "metrickpi";
	
	public static final String IDMETRICKPI = "idMetricKpi";
	public static final String BSCDIMENSION = "bscdimension";
	public static final String COMPANY = "company";
	public static final String NAME = "name";
	public static final String DEFINITION = "definition";
	public static final String PROJECTKPIS = "projectkpis";

     private Integer idMetricKpi;
     private Bscdimension bscdimension;
     private Company company;
     private String name;
     private String definition;
     private Set<Projectkpi> projectkpis = new HashSet<Projectkpi>(0);

    public BaseMetrickpi() {
    }
    
    public BaseMetrickpi(Integer idMetricKpi) {
    	this.idMetricKpi = idMetricKpi;
    }
   
    public Integer getIdMetricKpi() {
        return this.idMetricKpi;
    }
    
    public void setIdMetricKpi(Integer idMetricKpi) {
        this.idMetricKpi = idMetricKpi;
    }
    public Bscdimension getBscdimension() {
        return this.bscdimension;
    }
    
    public void setBscdimension(Bscdimension bscdimension) {
        this.bscdimension = bscdimension;
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
    public String getDefinition() {
        return this.definition;
    }
    
    public void setDefinition(String definition) {
        this.definition = definition;
    }
    public Set<Projectkpi> getProjectkpis() {
        return this.projectkpis;
    }
    
    public void setProjectkpis(Set<Projectkpi> projectkpis) {
        this.projectkpis = projectkpis;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idMetricKpi").append("='").append(getIdMetricKpi()).append("' \n");	
		buffer.append("bscdimension").append("='").append(getBscdimension()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("definition").append("='").append(getDefinition()).append("' \n");	
		buffer.append("projectkpis").append("='").append(getProjectkpis()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Metrickpi) )  { result = false; }
		 else if (other != null) {
		 	Metrickpi castOther = (Metrickpi) other;
			if (castOther.getIdMetricKpi().equals(this.getIdMetricKpi())) { result = true; }
         }
		 return result;
   }


}


