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
 * Base Pojo object for domain model class Chargescosts
 * @see es.sm2.openppm.model.base.Chargescosts
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Chargescosts
 */
public class BaseChargescosts  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "chargescosts";
	
	public static final String IDCHARGESCOSTS = "idChargesCosts";
	public static final String PROJECT = "project";
	public static final String NAME = "name";
	public static final String COST = "cost";
	public static final String IDCHARGETYPE = "idChargeType";

     private Integer idChargesCosts;
     private Project project;
     private String name;
     private Double cost;
     private int idChargeType;

    public BaseChargescosts() {
    }
    
    public BaseChargescosts(Integer idChargesCosts) {
    	this.idChargesCosts = idChargesCosts;
    }
   
    public Integer getIdChargesCosts() {
        return this.idChargesCosts;
    }
    
    public void setIdChargesCosts(Integer idChargesCosts) {
        this.idChargesCosts = idChargesCosts;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Double getCost() {
        return this.cost;
    }
    
    public void setCost(Double cost) {
        this.cost = cost;
    }
    public int getIdChargeType() {
        return this.idChargeType;
    }
    
    public void setIdChargeType(int idChargeType) {
        this.idChargeType = idChargeType;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idChargesCosts").append("='").append(getIdChargesCosts()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("cost").append("='").append(getCost()).append("' \n");	
		buffer.append("idChargeType").append("='").append(getIdChargeType()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Chargescosts) )  { result = false; }
		 else if (other != null) {
		 	Chargescosts castOther = (Chargescosts) other;
			if (castOther.getIdChargesCosts().equals(this.getIdChargesCosts())) { result = true; }
         }
		 return result;
   }


}


