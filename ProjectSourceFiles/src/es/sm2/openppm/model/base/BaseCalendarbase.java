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
 * Base Pojo object for domain model class Calendarbase
 * @see es.sm2.openppm.model.base.Calendarbase
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Calendarbase
 */
public class BaseCalendarbase  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "calendarbase";
	
	public static final String IDCALENDARBASE = "idCalendarBase";
	public static final String COMPANY = "company";
	public static final String WEEKSTART = "weekStart";
	public static final String FISCALYEARSTART = "fiscalYearStart";
	public static final String STARTTIME1 = "startTime1";
	public static final String STARTTIME2 = "startTime2";
	public static final String ENDTIME1 = "endTime1";
	public static final String ENDTIME2 = "endTime2";
	public static final String HOURSDAY = "hoursDay";
	public static final String HOURSWEEK = "hoursWeek";
	public static final String DAYSMONTH = "daysMonth";
	public static final String NAME = "name";
	public static final String EMPLOYEES = "employees";
	public static final String PROJECTCALENDARS = "projectcalendars";
	public static final String CALENDARBASEEXCEPTIONSES = "calendarbaseexceptionses";

     private Integer idCalendarBase;
     private Company company;
     private Integer weekStart;
     private Integer fiscalYearStart;
     private Double startTime1;
     private Double startTime2;
     private Double endTime1;
     private Double endTime2;
     private Double hoursDay;
     private Double hoursWeek;
     private Integer daysMonth;
     private String name;
     private Set<Employee> employees = new HashSet<Employee>(0);
     private Set<Projectcalendar> projectcalendars = new HashSet<Projectcalendar>(0);
     private Set<Calendarbaseexceptions> calendarbaseexceptionses = new HashSet<Calendarbaseexceptions>(0);

    public BaseCalendarbase() {
    }
    
    public BaseCalendarbase(Integer idCalendarBase) {
    	this.idCalendarBase = idCalendarBase;
    }
   
    public Integer getIdCalendarBase() {
        return this.idCalendarBase;
    }
    
    public void setIdCalendarBase(Integer idCalendarBase) {
        this.idCalendarBase = idCalendarBase;
    }
    public Company getCompany() {
        return this.company;
    }
    
    public void setCompany(Company company) {
        this.company = company;
    }
    public Integer getWeekStart() {
        return this.weekStart;
    }
    
    public void setWeekStart(Integer weekStart) {
        this.weekStart = weekStart;
    }
    public Integer getFiscalYearStart() {
        return this.fiscalYearStart;
    }
    
    public void setFiscalYearStart(Integer fiscalYearStart) {
        this.fiscalYearStart = fiscalYearStart;
    }
    public Double getStartTime1() {
        return this.startTime1;
    }
    
    public void setStartTime1(Double startTime1) {
        this.startTime1 = startTime1;
    }
    public Double getStartTime2() {
        return this.startTime2;
    }
    
    public void setStartTime2(Double startTime2) {
        this.startTime2 = startTime2;
    }
    public Double getEndTime1() {
        return this.endTime1;
    }
    
    public void setEndTime1(Double endTime1) {
        this.endTime1 = endTime1;
    }
    public Double getEndTime2() {
        return this.endTime2;
    }
    
    public void setEndTime2(Double endTime2) {
        this.endTime2 = endTime2;
    }
    public Double getHoursDay() {
        return this.hoursDay;
    }
    
    public void setHoursDay(Double hoursDay) {
        this.hoursDay = hoursDay;
    }
    public Double getHoursWeek() {
        return this.hoursWeek;
    }
    
    public void setHoursWeek(Double hoursWeek) {
        this.hoursWeek = hoursWeek;
    }
    public Integer getDaysMonth() {
        return this.daysMonth;
    }
    
    public void setDaysMonth(Integer daysMonth) {
        this.daysMonth = daysMonth;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public Set<Employee> getEmployees() {
        return this.employees;
    }
    
    public void setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }
    public Set<Projectcalendar> getProjectcalendars() {
        return this.projectcalendars;
    }
    
    public void setProjectcalendars(Set<Projectcalendar> projectcalendars) {
        this.projectcalendars = projectcalendars;
    }
    public Set<Calendarbaseexceptions> getCalendarbaseexceptionses() {
        return this.calendarbaseexceptionses;
    }
    
    public void setCalendarbaseexceptionses(Set<Calendarbaseexceptions> calendarbaseexceptionses) {
        this.calendarbaseexceptionses = calendarbaseexceptionses;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idCalendarBase").append("='").append(getIdCalendarBase()).append("' \n");	
		buffer.append("company").append("='").append(getCompany()).append("' \n");	
		buffer.append("weekStart").append("='").append(getWeekStart()).append("' \n");	
		buffer.append("fiscalYearStart").append("='").append(getFiscalYearStart()).append("' \n");	
		buffer.append("startTime1").append("='").append(getStartTime1()).append("' \n");	
		buffer.append("startTime2").append("='").append(getStartTime2()).append("' \n");	
		buffer.append("endTime1").append("='").append(getEndTime1()).append("' \n");	
		buffer.append("endTime2").append("='").append(getEndTime2()).append("' \n");	
		buffer.append("hoursDay").append("='").append(getHoursDay()).append("' \n");	
		buffer.append("hoursWeek").append("='").append(getHoursWeek()).append("' \n");	
		buffer.append("daysMonth").append("='").append(getDaysMonth()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("employees").append("='").append(getEmployees()).append("' \n");	
		buffer.append("projectcalendars").append("='").append(getProjectcalendars()).append("' \n");	
		buffer.append("calendarbaseexceptionses").append("='").append(getCalendarbaseexceptionses()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Calendarbase) )  { result = false; }
		 else if (other != null) {
		 	Calendarbase castOther = (Calendarbase) other;
			if (castOther.getIdCalendarBase().equals(this.getIdCalendarBase())) { result = true; }
         }
		 return result;
   }


}


