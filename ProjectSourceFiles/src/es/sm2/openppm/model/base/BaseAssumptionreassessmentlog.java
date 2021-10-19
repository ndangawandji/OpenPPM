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


import java.util.Date;

 /**
 * Base Pojo object for domain model class Assumptionreassessmentlog
 * @see es.sm2.openppm.model.base.Assumptionreassessmentlog
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Assumptionreassessmentlog
 */
public class BaseAssumptionreassessmentlog  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "assumptionreassessmentlog";
	
	public static final String IDLOG = "idLog";
	public static final String ASSUMPTIONREGISTER = "assumptionregister";
	public static final String ASSUMPTIONDATE = "assumptionDate";
	public static final String ASSUMPTIONCHANGE = "assumptionChange";

     private Integer idLog;
     private Assumptionregister assumptionregister;
     private Date assumptionDate;
     private String assumptionChange;

    public BaseAssumptionreassessmentlog() {
    }
    
    public BaseAssumptionreassessmentlog(Integer idLog) {
    	this.idLog = idLog;
    }
   
    public Integer getIdLog() {
        return this.idLog;
    }
    
    public void setIdLog(Integer idLog) {
        this.idLog = idLog;
    }
    public Assumptionregister getAssumptionregister() {
        return this.assumptionregister;
    }
    
    public void setAssumptionregister(Assumptionregister assumptionregister) {
        this.assumptionregister = assumptionregister;
    }
    public Date getAssumptionDate() {
        return this.assumptionDate;
    }
    
    public void setAssumptionDate(Date assumptionDate) {
        this.assumptionDate = assumptionDate;
    }
    public String getAssumptionChange() {
        return this.assumptionChange;
    }
    
    public void setAssumptionChange(String assumptionChange) {
        this.assumptionChange = assumptionChange;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idLog").append("='").append(getIdLog()).append("' \n");	
		buffer.append("assumptionregister").append("='").append(getAssumptionregister()).append("' \n");	
		buffer.append("assumptionDate").append("='").append(getAssumptionDate()).append("' \n");	
		buffer.append("assumptionChange").append("='").append(getAssumptionChange()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Assumptionreassessmentlog) )  { result = false; }
		 else if (other != null) {
		 	Assumptionreassessmentlog castOther = (Assumptionreassessmentlog) other;
			if (castOther.getIdLog().equals(this.getIdLog())) { result = true; }
         }
		 return result;
   }


}


