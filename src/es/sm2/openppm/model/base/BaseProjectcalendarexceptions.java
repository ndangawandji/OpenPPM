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
 * Base Pojo object for domain model class Projectcalendarexceptions
 * @see es.sm2.openppm.model.base.Projectcalendarexceptions
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Projectcalendarexceptions
 */
public class BaseProjectcalendarexceptions  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "projectcalendarexceptions";
	
	public static final String IDPROJECTCALENDAREXCEPTION = "idProjectCalendarException";
	public static final String PROJECTCALENDAR = "projectcalendar";
	public static final String STARTDATE = "startDate";
	public static final String FINISHDATE = "finishDate";
	public static final String DESCRIPTION = "description";

     private Integer idProjectCalendarException;
     private Projectcalendar projectcalendar;
     private Date startDate;
     private Date finishDate;
     private String description;

    public BaseProjectcalendarexceptions() {
    }
    
    public BaseProjectcalendarexceptions(Integer idProjectCalendarException) {
    	this.idProjectCalendarException = idProjectCalendarException;
    }
   
    public Integer getIdProjectCalendarException() {
        return this.idProjectCalendarException;
    }
    
    public void setIdProjectCalendarException(Integer idProjectCalendarException) {
        this.idProjectCalendarException = idProjectCalendarException;
    }
    public Projectcalendar getProjectcalendar() {
        return this.projectcalendar;
    }
    
    public void setProjectcalendar(Projectcalendar projectcalendar) {
        this.projectcalendar = projectcalendar;
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
		buffer.append("idProjectCalendarException").append("='").append(getIdProjectCalendarException()).append("' \n");	
		buffer.append("projectcalendar").append("='").append(getProjectcalendar()).append("' \n");	
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
		 else if (!(other instanceof Projectcalendarexceptions) )  { result = false; }
		 else if (other != null) {
		 	Projectcalendarexceptions castOther = (Projectcalendarexceptions) other;
			if (castOther.getIdProjectCalendarException().equals(this.getIdProjectCalendarException())) { result = true; }
         }
		 return result;
   }


}


