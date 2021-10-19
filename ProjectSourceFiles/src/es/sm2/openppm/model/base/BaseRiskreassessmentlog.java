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
 * Base Pojo object for domain model class Riskreassessmentlog
 * @see es.sm2.openppm.model.base.Riskreassessmentlog
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Riskreassessmentlog
 */
public class BaseRiskreassessmentlog  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "riskreassessmentlog";
	
	public static final String IDLOG = "idLog";
	public static final String RISKREGISTER = "riskregister";
	public static final String RISKDATE = "riskDate";
	public static final String RISKCHANGE = "riskChange";

     private Integer idLog;
     private Riskregister riskregister;
     private Date riskDate;
     private String riskChange;

    public BaseRiskreassessmentlog() {
    }
    
    public BaseRiskreassessmentlog(Integer idLog) {
    	this.idLog = idLog;
    }
   
    public Integer getIdLog() {
        return this.idLog;
    }
    
    public void setIdLog(Integer idLog) {
        this.idLog = idLog;
    }
    public Riskregister getRiskregister() {
        return this.riskregister;
    }
    
    public void setRiskregister(Riskregister riskregister) {
        this.riskregister = riskregister;
    }
    public Date getRiskDate() {
        return this.riskDate;
    }
    
    public void setRiskDate(Date riskDate) {
        this.riskDate = riskDate;
    }
    public String getRiskChange() {
        return this.riskChange;
    }
    
    public void setRiskChange(String riskChange) {
        this.riskChange = riskChange;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idLog").append("='").append(getIdLog()).append("' \n");	
		buffer.append("riskregister").append("='").append(getRiskregister()).append("' \n");	
		buffer.append("riskDate").append("='").append(getRiskDate()).append("' \n");	
		buffer.append("riskChange").append("='").append(getRiskChange()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Riskreassessmentlog) )  { result = false; }
		 else if (other != null) {
		 	Riskreassessmentlog castOther = (Riskreassessmentlog) other;
			if (castOther.getIdLog().equals(this.getIdLog())) { result = true; }
         }
		 return result;
   }


}


