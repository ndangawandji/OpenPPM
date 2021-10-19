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
package es.sm2.openppm.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.model.Calendarbaseexceptions;

public class CalendarbaseexceptionsDAO extends AbstractGenericHibernateDAO<Calendarbaseexceptions, Integer> {

	public CalendarbaseexceptionsDAO(Session session) {
		super(session);
	}
	
	/**
	 * Delete all Exceptions of Calendar Base
	 * @param calendarbase
	 */
	public void deleteExceptions(Calendarbase calendarbase) {
		
		Query query = getSession().createQuery(
				"delete from Calendarbaseexceptions where calendarbase.idCalendarBase = :idCalendar");

		query.setInteger("idCalendar", calendarbase.getIdCalendarBase());
		
		query.executeUpdate();
		
	}

	/**
	 * Get Base exceptions by employee
	 * @param idEmployee
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Calendarbaseexceptions> findByEmployee(Integer idEmployee) {		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.createCriteria(Calendarbaseexceptions.CALENDARBASE)
			.createCriteria(Calendarbase.EMPLOYEES)
			.add(Restrictions.idEq(idEmployee));
		
		return crit.list();
	}
	
	/**
	 * 	
	 * @param base
	 * @param idEmployee
	 * @param initDate
	 * @param endDate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Calendarbaseexceptions> findByCalendarBase(Calendarbase base, Integer idEmployee, Date initDate, Date endDate) {
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Calendarbaseexceptions.CALENDARBASE, base))
			.add(Restrictions.ge(Calendarbaseexceptions.STARTDATE, initDate))
			.add(Restrictions.le(Calendarbaseexceptions.FINISHDATE, endDate))
			.createCriteria(Calendarbaseexceptions.CALENDARBASE)
			.createCriteria(Calendarbase.EMPLOYEES)
			.add(Restrictions.idEq(idEmployee));			
		
		return crit.list();
	}

}
