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
package es.sm2.openppm.logic;

import java.util.Calendar;
import java.util.Date;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.EmployeeDAO;
import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.dao.ProjectcalendarDAO;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectcalendar;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ProjectcalendarLogic extends AbstractGenericLogic<Projectcalendar, Integer> {

	/**
	 * Return ProjectCalendar By Project
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static Projectcalendar consCalendarByProject(Project project) throws Exception {
		
		Projectcalendar calendar = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectcalendarDAO projectcalendarDAO = new ProjectcalendarDAO(session);
			calendar = projectcalendarDAO.findByProject(project);
			
			tx.commit();
			
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return calendar;
	}

	
	/**
	 * Save Project Calendar
	 * @param calendar
	 * @return
	 * @throws Exception 
	 */
	public static Projectcalendar saveCalendar(Projectcalendar calendar) throws Exception {
		
		Projectcalendar calendarTemp = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectcalendarDAO projectcalendarDAO = new ProjectcalendarDAO(session);
			calendarTemp = projectcalendarDAO.makePersistent(calendar);
			
			tx.commit();
			
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return calendarTemp;
	}

	/**
	 * Check if is Exception day in project
	 * @param initDate
	 * @param dayOfWeek
	 * @param idActivity
	 * @return
	 * @throws Exception
	 */
	public Boolean isException(Date initDate, Integer dayOfWeek, Integer idActivity, Integer idEmployee) throws Exception {
		
		boolean isException = false;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			Calendar exceptionDate = DateUtil.getCalendar();
			exceptionDate.setTime(initDate);
			exceptionDate.add(Calendar.DAY_OF_WEEK, dayOfWeek);
			
			ProjectcalendarDAO projectcalendarDAO = new ProjectcalendarDAO(session);
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			
			Projectactivity activity = activityDAO.findById(idActivity);
			Project project = activity.getProject();
			Employee employee = employeeDAO.findById(idEmployee);
			
			isException = projectcalendarDAO.isException(exceptionDate.getTime(), project.getProjectcalendar(), employee.getCalendarbase());
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return isException;
	}
}
