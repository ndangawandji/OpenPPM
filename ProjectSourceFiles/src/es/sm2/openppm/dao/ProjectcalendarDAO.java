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
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.model.Calendarbaseexceptions;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcalendar;

public class ProjectcalendarDAO extends AbstractGenericHibernateDAO<Projectcalendar, Integer> {

	public ProjectcalendarDAO(Session session) {
		super(session);
	}

	/**
	 * Find ProjectCalendar By Project
	 * @param project
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Projectcalendar findByProject(Project project) {

		Projectcalendar projCal = null;
		
		Query query = getSession().createQuery(
				"select calendar " +
				"from Projectcalendar as calendar " + 
				"left join fetch calendar.projectcalendarexceptionses as exceptions " +
				"left join fetch calendar.calendarbase as calendarbase " +
				"left join fetch calendarbase.calendarbaseexceptionses as cbexceptions " +
				"join calendar.projects as project " +
				"where project.idProject = :idProject");
		query.setInteger("idProject", project.getIdProject());
		
		List<Projectcalendar> list = query.list();
		
		if (!list.isEmpty()) {
			projCal = list.get(0);
		}
		return projCal;
	}

	/**
	 * Check if is Exception day in project
	 * @param time
	 * @param idActivity
	 * @return
	 */
	public boolean isException(Date day, Projectcalendar projCal, Calendarbase calBase) {
		
		boolean isException = false;
		
		if (calBase != null) {
			
			Criteria crit = getSession().createCriteria(Calendarbase.class)
				.setProjection(Projections.rowCount())
				.add(Restrictions.idEq(calBase.getIdCalendarBase()))
				.createCriteria(Calendarbase.CALENDARBASEEXCEPTIONSES)
					.add(Restrictions.and(
						Restrictions.le(Calendarbaseexceptions.STARTDATE, day),
						Restrictions.ge(Calendarbaseexceptions.FINISHDATE, day)
					));
			
			isException = ((Integer)crit.uniqueResult()) > 0;
		}
		
		if (!isException && projCal != null) {
			Query query = getSession().createQuery(
					"select count(calendar) " +
					"from Projectcalendar as calendar " +
					"left join calendar.projectcalendarexceptionses as exceptionsp " +
					"left join calendar.calendarbase as calendarb " +
					"left join calendarb.calendarbaseexceptionses as exceptionsb " +
					"where calendar.idProjectCalendar = :idProjectCalendar " +
						"and (:day between exceptionsp.startDate and exceptionsp.finishDate " +
						"or :day between exceptionsb.startDate and exceptionsb.finishDate)"
				);
			
			query.setInteger("idProjectCalendar", projCal.getIdProjectCalendar());
			query.setDate("day", day);
			
			Long count = (Long) query.uniqueResult();
			
			isException = (count > 0);
		}
		return isException;
	}

}
