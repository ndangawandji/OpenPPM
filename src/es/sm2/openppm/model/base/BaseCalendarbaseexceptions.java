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
 * Base Pojo object for domain model class Calendarbaseexceptions
 * @see es.sm2.openppm.model.base.Calendarbaseexceptions
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Calendarbaseexceptions
 */
public class BaseCalendarbaseexceptions  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "calendarbaseexceptions";
	
	public static final String IDCALENDARBASEEXCEPTION = "idCalendarBaseException";
	public static final String CALENDARBASE = "calendarbase";
	public static final String STARTDATE = "startDate";
	public static final String FINISHDATE = "finishDate";
	public static final String DESCRIPTION = "description";

     private Integer idCalendarBaseException;
     private Calendarbase calendarbase;
     private Date startDate;
     private Date finishDate;
     private String description;

    public BaseCalendarbaseexceptions() {
    }
    
    public BaseCalendarbaseexceptions(Integer idCalendarBaseException) {
    	this.idCalendarBaseException = idCalendarBaseException;
    }
   
    public Integer getIdCalendarBaseException() {
        return this.idCalendarBaseException;
    }
    
    public void setIdCalendarBaseException(Integer idCalendarBaseException) {
        this.idCalendarBaseException = idCalendarBaseException;
    }
    public Calendarbase getCalendarbase() {
        return this.calendarbase;
    }
    
    public void setCalendarbase(Calendarbase calendarbase) {
        this.calendarbase = calendarbase;
    }
    public Date getStartDate() {
        return this.startDate;
    }
    
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public Date getFinishDate() {
        return this.finishDate;
    }
    
    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }
    public String getDescription() {
        return this.description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idCalendarBaseException").append("='").append(getIdCalendarBaseException()).append("' \n");	
		buffer.append("calendarbase").append("='").append(getCalendarbase()).append("' \n");	
		buffer.append("startDate").append("='").append(getStartDate()).append("' \n");	
		buffer.append("finishDate").append("='").append(getFinishDate()).append("' \n");	
		buffer.append("description").append("='").append(getDescription()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Calendarbaseexceptions) )  { result = false; }
		 else if (other != null) {
		 	Calendarbaseexceptions castOther = (Calendarbaseexceptions) other;
			if (castOther.getIdCalendarBaseException().equals(this.getIdCalendarBaseException())) { result = true; }
         }
		 return result;
   }


}


