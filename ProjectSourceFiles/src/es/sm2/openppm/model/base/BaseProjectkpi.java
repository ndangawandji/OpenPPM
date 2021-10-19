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
 * Base Pojo object for domain model class Projectkpi
 * @see es.sm2.openppm.model.base.Projectkpi
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Projectkpi
 */
public class BaseProjectkpi  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "projectkpi";
	
	public static final String IDPROJECTKPI = "idProjectKpi";
	public static final String METRICKPI = "metrickpi";
	public static final String PROJECT = "project";
	public static final String UPPERTHRESHOLD = "upperThreshold";
	public static final String LOWERTHRESHOLD = "lowerThreshold";
	public static final String WEIGHT = "weight";
	public static final String VALUE = "value";

     private Integer idProjectKpi;
     private Metrickpi metrickpi;
     private Project project;
     private Integer upperThreshold;
     private Integer lowerThreshold;
     private Integer weight;
     private Integer value;

    public BaseProjectkpi() {
    }
    
    public BaseProjectkpi(Integer idProjectKpi) {
    	this.idProjectKpi = idProjectKpi;
    }
   
    public Integer getIdProjectKpi() {
        return this.idProjectKpi;
    }
    
    public void setIdProjectKpi(Integer idProjectKpi) {
        this.idProjectKpi = idProjectKpi;
    }
    public Metrickpi getMetrickpi() {
        return this.metrickpi;
    }
    
    public void setMetrickpi(Metrickpi metrickpi) {
        this.metrickpi = metrickpi;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public Integer getUpperThreshold() {
        return this.upperThreshold;
    }
    
    public void setUpperThreshold(Integer upperThreshold) {
        this.upperThreshold = upperThreshold;
    }
    public Integer getLowerThreshold() {
        return this.lowerThreshold;
    }
    
    public void setLowerThreshold(Integer lowerThreshold) {
        this.lowerThreshold = lowerThreshold;
    }
    public Integer getWeight() {
        return this.weight;
    }
    
    public void setWeight(Integer weight) {
        this.weight = weight;
    }
    public Integer getValue() {
        return this.value;
    }
    
    public void setValue(Integer value) {
        this.value = value;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idProjectKpi").append("='").append(getIdProjectKpi()).append("' \n");	
		buffer.append("metrickpi").append("='").append(getMetrickpi()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("upperThreshold").append("='").append(getUpperThreshold()).append("' \n");	
		buffer.append("lowerThreshold").append("='").append(getLowerThreshold()).append("' \n");	
		buffer.append("weight").append("='").append(getWeight()).append("' \n");	
		buffer.append("value").append("='").append(getValue()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Projectkpi) )  { result = false; }
		 else if (other != null) {
		 	Projectkpi castOther = (Projectkpi) other;
			if (castOther.getIdProjectKpi().equals(this.getIdProjectKpi())) { result = true; }
         }
		 return result;
   }


}


