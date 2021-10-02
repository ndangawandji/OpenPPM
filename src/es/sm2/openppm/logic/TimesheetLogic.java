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

import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.EmployeeDAO;
import es.sm2.openppm.dao.ProjectcalendarDAO;
import es.sm2.openppm.dao.TimesheetDAO;
import es.sm2.openppm.dao.TimesheetDAODVT;
import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectcalendar;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Timesheet;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Timesheet
 * @see es.sm2.openppm.logic.Timesheet
 * @author Hibernate Generator by Javier Hernandez
 *
 */

/*
 * Update : Xavier de Langautier
 * Devoteam, 2015/04/29, userstory 9 : Surcharge de la méthode 
 *           getHoursResource(Integer idEmployee, Integer idActivity, Date initDate, Date endDate, String uniqStatus)          
 * 
 */
public final class TimesheetLogic extends AbstractGenericLogic<Timesheet, Integer>{

	private static final Logger LOGGER = Logger.getLogger(TimesheetLogic.class);
	/**
	 * Find time sheets of the resource
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param joins
	 * @param project
	 * @param minStatus
	 * @param maxStatus
	 * @return
	 * @throws Exception
	 */
	public List<Timesheet> findByResource(Employee employee, Date initDate, Date endDate,
			List<String> joins, Project project, String minStatus, String maxStatus, Employee filterUser) throws Exception {
		
		List<Timesheet> list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
			
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			
			list = timesheetDAO.findByCriteria(employee, initDate, endDate, joins, project, minStatus, maxStatus, filterUser);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}	
	
	/**
	 * Find time sheet
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param activity
	 * @param status
	 * @return
	 * @throws Exception
	 */
	public Timesheet findByResource(Employee employee, Date initDate, Date endDate,
			Projectactivity activity, String status) throws Exception {
		
		Timesheet item = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			
			item = timesheetDAO.findByResource(employee, initDate, endDate, activity, status);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return item;
	}

	/**
	 * Find unique time sheet operation
	 * @param operation
	 * @param consUser
	 * @param initDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	public Timesheet findByOperation(Operation operation, Employee employee,
			Date initDate, Date endDate) throws Exception {
		
		Timesheet item	= null;
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			item = timesheetDAO.findByOperation(operation, employee, initDate, endDate);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return item;
	}

	/**
	 * Find Time Sheets operations
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param joins
	 * @param minStatus
	 * @param maxStatus
	 * @return
	 * @throws Exception
	 */
	public List<Timesheet> findByResourceOperation(Employee employee, Date initDate,
			Date endDate, List<String> joins, String minStatus, String maxStatus) throws Exception {
		
		List<Timesheet> list	= null;
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			list = timesheetDAO.findByOperation(employee, initDate, endDate, joins, minStatus, maxStatus);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}

	/**
	 * Get status actual level
	 * @param idEmployee
	 * @param id
	 * @param initDate
	 * @param endDate
	 * @param status
	 * @param approveLevel 
	 * @param filterUser 
	 * @return
	 * @throws Exception
	 */
	public String getStatusResource(Integer idEmployee, Integer id,
			Date initDate, Date endDate, String status, String approveLevel, Employee filterUser) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			
			boolean isStatus = timesheetDAO.isStatusResource(idEmployee, id, initDate, endDate, status, filterUser);
			
			if (!isStatus) { status = approveLevel; }
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return status;
	}

	/**
	 * Get Hours resource
	 * @param idEmployee
	 * @param id
	 * @param initDate
	 * @param endDate
	 * @param filterUser
	 * @param approveRol
	 * @return
	 * @throws Exception
	 */
	public double getHoursResource(Integer idEmployee, Integer id,
			Date initDate, Date endDate, Employee filterUser, int approveRol) throws Exception {
		
		double hours = 0;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			
			int rol = filterUser.getResourceprofiles().getIdProfile();
			
			String minStatus = (rol == Constants.ROLE_PM? Constants.TIMESTATUS_APP1: Constants.TIMESTATUS_APP2);
			String maxStatus = (rol == Constants.ROLE_PM && approveRol > 0? Constants.TIMESTATUS_APP2: Constants.TIMESTATUS_APP3);
			
			hours = timesheetDAO.getHoursResource(idEmployee, id, initDate, endDate, minStatus, maxStatus, filterUser);
			
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return hours;
	}
	
	/**
	 * Get Hours resource
	 * @param idEmployee
	 * @param idActivity
	 * @param initDate
	 * @param endDate
	 * @param minStatus
	 * @param maxStatus
	 * @return
	 * @throws Exception
	 */
	/*
	 * Create : 2015/04/29 Devoteam : xavier de Langautier  userstory 9 
	 * Recupérere les heures d'une activité pour un employée entre 2 stauts et  entre 2 dates
	 * 
	 * La Methode DAO se trouve dans TimesheetDAODVT.java
	 * 
	 */
	public double getHoursResource(Integer idEmployee, Integer idActivity, Date initDate, Date endDate, String minStatus, String maxStatus) throws Exception {
		
		double hours = 0;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();

		if (session.isOpen()) {
		}
		try {
			tx = session.beginTransaction();
		
			TimesheetDAODVT timesheetDAO = new TimesheetDAODVT(session);
				
			hours = timesheetDAO.getHoursResource(idEmployee, idActivity,initDate, endDate, minStatus, maxStatus);		
			//LOGGER.debug("hhhhhhhhhhhhhhhhhhhhh " +idActivity + " Empl " + idEmployee + " "+ initDate.toString()+ " " + endDate + " resultat en heure" + hours + " "+minStatus + maxStatus);
	
			tx.commit();
		}
		catch (Exception e) { if (tx != null) {System.out.println( "getresource"+e); tx.rollback(); } throw e;}
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return hours;
	}
	
	/**
	 * @author Cedric Ndanga
	 * Devoteam user story 40
	 * @return total hours of activity
	 * @param activity
	 */
	public double getHoursActivity(Projectactivity activity) throws Exception {
		
		double hours = 0;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try{
			tx = session.beginTransaction();
			
			TimesheetDAODVT timesheetDAO = new TimesheetDAODVT(session);
			
			hours = timesheetDAO.getHoursActivity(activity);
			
			tx.commit();
		} catch(Exception e) {
			if(tx != null){
				tx.rollback();
			}
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return hours;
	}

	/**
	 * Calculate Fte for inputed hours in project
	 * @param project 
	 * @param member
	 * @param firstWeekDay
	 * @param lastWeekDay
	 * @return
	 * @throws Exception 
	 */
	public double getFte(Project project, Employee member, Date firstWeekDay, Date lastWeekDay) throws Exception {
		
		double fte = 0;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			ProjectcalendarDAO projectcalendarDAO = new ProjectcalendarDAO(session);
			
			Projectcalendar projCal = projectcalendarDAO.findByProject(project);
			Calendarbase emplCal	= member.getCalendarbase();
			
			double hours = timesheetDAO.getHoursResource(project, member, firstWeekDay, lastWeekDay); 
			
			// Hours by week
			double hourWeek = Constants.DEFAULT_HOUR_WEEK;
			if (emplCal != null && emplCal.getHoursWeek() != null) { hourWeek = emplCal.getHoursWeek(); }
			else if (projCal != null && projCal.getHoursWeek() != null) { hourWeek = projCal.getHoursWeek(); }
			
			// Check exception days
			Calendar tempCal = DateUtil.getCalendar();
			tempCal.setTime(firstWeekDay);
			
			int exceptionDay = 0;
			while (!tempCal.getTime().after(lastWeekDay)) {
				
				if (projectcalendarDAO.isException(tempCal.getTime(), projCal, emplCal)) { exceptionDay++; }
				tempCal.add(Calendar.DAY_OF_WEEK, 1);
			}
			
			if (exceptionDay > 0) {
				
				// Hours by day
				double hoursDay = Constants.DEFAULT_HOUR_DAY;
				if (emplCal != null && emplCal.getHoursDay() != null) { hoursDay = emplCal.getHoursDay(); }
				else if (projCal != null && projCal.getHoursDay() != null) { hoursDay = projCal.getHoursDay(); }

				hourWeek -= hoursDay*exceptionDay;
			}
			
			fte = (hours * 100)/hourWeek;
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return fte;
	}
	
	/**
	 * Calculate Fte for inputed hours in project
	 * @param project 
	 * @param member
	 * @param firstWeekDay
	 * @param lastWeekDay
	 * @return
	 * @throws Exception 
	 */
	public double getFte(Project project, Teammember member, Date firstWeekDay, Date lastWeekDay) throws Exception {
		
		double fte = 0;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TimesheetDAO timesheetDAO = new TimesheetDAO(session);
			ProjectcalendarDAO projectcalendarDAO = new ProjectcalendarDAO(session);
			
			Projectcalendar projCal = projectcalendarDAO.findByProject(project);
			Calendarbase emplCal	= member.getEmployee().getCalendarbase();
			
			double hours = timesheetDAO.getHoursResource(project, member, firstWeekDay, lastWeekDay); 
			
			// Hours by week
			double hourWeek = Constants.DEFAULT_HOUR_WEEK;
			if (emplCal != null && emplCal.getHoursWeek() != null) { hourWeek = emplCal.getHoursWeek(); }
			else if (projCal != null && projCal.getHoursWeek() != null) { hourWeek = projCal.getHoursWeek(); }
			
			// Check exception days
			Calendar tempCal = DateUtil.getCalendar();
			tempCal.setTime(firstWeekDay);
			
			int exceptionDay = 0;
			while (!tempCal.getTime().after(lastWeekDay)) {
				
				if (projectcalendarDAO.isException(tempCal.getTime(), projCal, emplCal)) { exceptionDay++; }
				tempCal.add(Calendar.DAY_OF_WEEK, 1);
			}
			
			if (exceptionDay > 0) {
				
				// Hours by day
				double hoursDay = Constants.DEFAULT_HOUR_DAY;
				if (emplCal != null && emplCal.getHoursDay() != null) { hoursDay = emplCal.getHoursDay(); }
				else if (projCal != null && projCal.getHoursDay() != null) { hoursDay = projCal.getHoursDay(); }
				
				hourWeek -= hoursDay*exceptionDay;
			}
			
			fte = (hours * 100)/hourWeek;
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return fte;
	}
	

	/**
	 * Calc Time Sheet AC
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public Double calcTimeSheetAC(Project project) throws Exception {

		double ac = 0;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO		= new EmployeeDAO(session);
			TimesheetDAO timesheetDAO	= new TimesheetDAO(session);
			
			List<Employee> employees = employeeDAO.findInputedInProject(project, null, null);
			
			for (Employee employee : employees) {
				
				Double cost = (employee.getCostRate() == null?0D:employee.getCostRate());
				Double hours = timesheetDAO.getHoursResource(project, employee, null, null);
				
				ac += new Double(hours==null?0:hours)*cost;
			}
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		return ac;
	}

}

