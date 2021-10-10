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
 *  Updater : C�dric Ndanga Wandji
 ******************************************************************************/
/*
 * Updater : C�dric Ndanga Wandji
 * Devoteam, 24/04/2015, user story 13 : adding method workDaysInPeriod().
 * Devoteam, 24/04/2015, user story 13 : adding method nonWorkingDays().
 * Devoteam, 24/04/2015, user story 13 : adding method fteInDays().
 * Devoteam, 24/04/2015, user story 13 : adding method daysInFte().
 * Devoteam, 24/04/2015, user story 13 : adding method workloadInDays().
 * Devoteam, 04/06/2015, user story 27 : adding java method consTeamMember(Integer idProjectActivity, Integer idEmployee)
 * Devoteam, 02/07/2015, user story 40 : adding of workloadInDaysByActivity(Projectactivity activity)
 * 
 * Updater :  Xavier de Langautier 
 * Devoteam, 05/06/2015, userstory 15 :  ajout du constructeur de list de teammember consTeamMembers : recherche � partir d'un id d'activit�
 *
 */
package es.sm2.openppm.logic;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.ProjectcalendarDAO;
import es.sm2.openppm.dao.TeamMemberDAO;
import es.sm2.openppm.dao.TimesheetDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.javabean.DatoColumna;
import es.sm2.openppm.javabean.FiltroTabla;
import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectcalendar;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Timesheet;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.utils.ValidateUtil;

public final class TeamMemberLogic extends AbstractGenericLogic<Teammember, Integer> {
	
	public final static Logger LOGGER = Logger.getLogger(TeamMemberLogic.class);
	/**
	 * Return Team members
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<Teammember> consStaffinFtes(Project project, Date since, Date until) throws Exception {

		List<Teammember> teammembers 	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			teammembers = memberDAO.consStaffinFtes(project, since, until);
		
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
		return teammembers;
	}
	
	/**
	 * Search Team Members by Project with actuals FTEs
	 * @param project
	 * @param since
	 * @param until
	 * @return
	 * @throws Exception
	 */
	public List<Teammember> consStaffinActualsFtes(Project project, Date since, Date until) throws Exception {

		List<Teammember> teammembers 	= null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx	= null;
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			teammembers = memberDAO.consStaffinActualsFtes(project, since, until);
		
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return teammembers;
	}

	/**
	 * Consult staff of a project
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<Teammember> consTeamMembers(Project project) throws Exception {
		List<Teammember> team = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO teamDAO = new TeamMemberDAO(session);
			if (project.getIdProject() != -1) {
				team = teamDAO.consTeamMembers(project);
			}

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
		return team;
	}
	/**
	 * Members dedicated at projectactivity
	 * @param projectactivity
	 * @return members
	 * Author : Devoteam Xavier de Langautier 2015/06/05
	 */
	public static List<Teammember> consTeamMembers(Projectactivity projectactivity) throws Exception {
		List<Teammember> team = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO teamDAO = new TeamMemberDAO(session);
			if (projectactivity.getIdActivity() != -1) {
				team = teamDAO.consTeamMembers(projectactivity);
			}

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
		return team;
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * user story 27
	 * @param idActivity
	 * @param idEmployee
	 * @return
	 * @throws Exception
	 */
	public static List<Teammember> consTeamMember(Integer idProjectActivity, Integer idEmployee) throws Exception {
		
		List<Teammember> teammembers = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO teamDAO = new TeamMemberDAO(session);
			if(idProjectActivity != -1 && idEmployee != -1) {
				teammembers = teamDAO.consTeamMember(idProjectActivity, idEmployee);
			}
			tx.commit();
		} catch (Exception e) {
			if(tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		
		return teammembers;	
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * user story 40
	 * Sum of workload by activity
	 * @param project activity
	 * @return
	 */
	public static Double workloadInDaysByActivity(Projectactivity activity) throws Exception {
		
		Double sumWorkloadInDays = (double) 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO teamDAO = new TeamMemberDAO(session);
			if(activity.getIdActivity() != -1) {
				sumWorkloadInDays = teamDAO.workloadInDaysByActivity(activity);
			}
			tx.commit();
		} catch (Exception e) {
			if(tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		
		return sumWorkloadInDays;
		
	}


	/**
	 * Approve team member
	 * @param idTeamMember
	 * @param atomticTimeSheet
	 * @throws Exception 
	 */
	public static void approveTeamMember(Integer idTeamMember, String commentsRm) throws Exception {
		
		Transaction tx = null;

		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO teamDAO			= new TeamMemberDAO(session);
			TimesheetDAO timesheetDAO		= new TimesheetDAO(session);
			ProjectcalendarDAO projCalDAO	= new ProjectcalendarDAO(session);
			
			Teammember teammember = teamDAO.findById(idTeamMember, false);
			
			if (teammember != null) {
				
				teammember.setStatus(Constants.RESOURCE_ASSIGNED);
				teammember.setDateApproved(new Date());
				if(commentsRm != null) {
					teammember.setCommentsRm(commentsRm);	
				}				
				teamDAO.makePersistent(teammember);
				
				
				Calendar initDate = DateUtil.getCalendar();
				initDate.setTime(DateUtil.getFirstWeekDay(teammember.getDateIn()));
				
				Calendar endDate = DateUtil.getCalendar();
				endDate.setTime(DateUtil.getLastWeekDay(teammember.getDateOut()));
				
				// Hours for day
				double maxHours = Constants.DEFAULT_HOUR_DAY;
				
				Projectcalendar projCal	= teammember.getProjectactivity().getProject().getProjectcalendar();
				Calendarbase emplCal	= teammember.getEmployee().getCalendarbase();
				
				if (emplCal != null && emplCal.getHoursDay() != null) {
					
					maxHours = emplCal.getHoursDay();
				}
				else if (projCal != null && projCal.getHoursDay() != null) {
					
					maxHours = projCal.getHoursDay();
				}
				
				double hourDay = maxHours /100 * new Double((teammember.getFte() == null?0:teammember.getFte()));
				
				while (endDate.after(initDate)) {
					
					Timesheet timesheet = timesheetDAO.findByCriteria(
							teammember.getEmployee(),
							teammember.getProjectactivity(),
							DateUtil.getFirstWeekDay(initDate.getTime()),
							DateUtil.getLastWeekDay(initDate.getTime()));
					
					if (timesheet == null) {
						timesheet = new Timesheet();
						timesheet.setProjectactivity(teammember.getProjectactivity());
						timesheet.setEmployee(teammember.getEmployee());
						timesheet.setInitDate(DateUtil.getFirstWeekDay(initDate.getTime()));
						timesheet.setEndDate(DateUtil.getLastWeekDay(initDate.getTime()));
						timesheet.setStatus(Constants.TIMESTATUS_APP0);
					}
					
					if (timesheet.getHoursDay1() == null && setHours(timesheet, teammember, initDate, projCalDAO, projCal, emplCal, 0)) { timesheet.setHoursDay1(hourDay); }
					if (timesheet.getHoursDay2() == null && setHours(timesheet, teammember, initDate, projCalDAO, projCal, emplCal, 1)) { timesheet.setHoursDay2(hourDay); }
					if (timesheet.getHoursDay3() == null && setHours(timesheet, teammember, initDate, projCalDAO, projCal, emplCal, 2)) { timesheet.setHoursDay3(hourDay); }
					if (timesheet.getHoursDay4() == null && setHours(timesheet, teammember, initDate, projCalDAO, projCal, emplCal, 3)) { timesheet.setHoursDay4(hourDay); }
					if (timesheet.getHoursDay5() == null && setHours(timesheet, teammember, initDate, projCalDAO, projCal, emplCal, 4)) { timesheet.setHoursDay5(hourDay); }
					if (timesheet.getHoursDay6() == null && setHours(timesheet, teammember, initDate, projCalDAO, projCal, emplCal, 5)) { timesheet.setHoursDay6(hourDay); }
					if (timesheet.getHoursDay7() == null && setHours(timesheet, teammember, initDate, projCalDAO, projCal, emplCal, 6)) { timesheet.setHoursDay7(hourDay); }
					
					
					timesheetDAO.makePersistent(timesheet);
					
					initDate.add(Calendar.DAY_OF_MONTH, 7);
				}
			}

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
	}
	
	private static boolean setHours(Timesheet timesheet, Teammember teammember,
			Calendar initDate, ProjectcalendarDAO projCalDAO,
			Projectcalendar projCal, Calendarbase calBase, int day) {
		
		Calendar dayCal = DateUtil.getCalendar();
		dayCal.setTime(initDate.getTime());
		dayCal.add(Calendar.DAY_OF_WEEK, day);
		
		boolean validDate = (!DateUtil.isWeekend(dayCal)
				&& DateUtil.between(teammember.getDateIn(), teammember.getDateOut(), dayCal.getTime())
				&& !projCalDAO.isException(dayCal.getTime(), projCal, calBase));
		
		return validDate;
	}
	
	/**
	 * Save Project Team member
	 * @param member
	 * @param project 
	 * @param newFte 
	 * @throws Exception 
	 */
	public static Teammember saveResource(Teammember member) throws Exception {

		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO memberDAO			 = new TeamMemberDAO(session);
			
			if (member.getIdTeamMember() == null && memberDAO.isAssigned(member)) {
				throw new LogicException("msg.error.resource_already_assigned");
			}
			
			member = memberDAO.makePersistent(member);
			
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
		return member;
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * return number of works days in a period concerning a team member
	 * @param member
	 * @param dateIn
	 * @param dateOut
	 * @return
	 * @throws Exception 
	 * @usage es/sm2/openppm/servlets/ProjectPlanServlet.java
	 */
	public static float workDaysInPeriod(Teammember member, Date since, Date until) throws Exception {
    	
    	float daysInPeriod = 0;
		float freeDaysInPeriod = 0;
		try {
			Integer idActivity = member.getProjectactivity().getIdActivity();
			Integer idEmployee = member.getEmployee().getIdEmployee();
			
			daysInPeriod = member.daysByPeriod(since, until);
			
			freeDaysInPeriod = nonWorkingDays(since, until, idActivity, idEmployee);
		//LOGGER.debug( " "+daysInPeriod + "free periode" + freeDaysInPeriod );
			
		} catch (Exception e) {
			throw e;
		}
		
    	return (daysInPeriod - freeDaysInPeriod) ;
    }
	
	/**
	 * @author Cedric Ndanga Wandji
	 * return number of exceptions days and weekends in a period concerning an employee for an activity
	 * @param dateIn
	 * @param dateOut
	 * @param idActivity
	 * @param idEmployee
	 * @return
	 * @throws Exception
	 */
	public static int nonWorkingDays(Date since, Date until, Integer idActivity, Integer idEmployee) 
	throws Exception {
		
		int freeDays = 0;
		try {
			Calendar initDate = DateUtil.getCalendar();
			initDate.setTime(since);
			
			Calendar endDate = DateUtil.getCalendar();
			endDate.setTime(until);
			
			while (!endDate.before(initDate)) 
			{
				if (DateUtil.isWeekend(initDate) || ValidateUtil.isExceptionDay(initDate.getTime(), 0, idActivity, idEmployee)) { freeDays++; }
				initDate.add(Calendar.DAY_OF_WEEK, 1);
			}
			
		} catch (Exception e) {
			throw e;
		}
		
    	return freeDays;
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * Convert FTE in days
	 * @param fte
	 * @param Number of works days in the assignement period
	 * @return
	 * @throws Exception
	 * @usage es/sm2/openppm/servlets/ProjectPlanServlet.java
	 */
	public static float fteInDays(Integer workload, float workDaysInAssignementPeriod) throws Exception {
		
		return ( workDaysInAssignementPeriod * workload ) / 100f ;
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * Convert days in FTE
	 * @param days of assignement
	 * @param Number of works days in the assignement period
	 * @return
	 * @usage es/sm2/openppm/servlets/ProjectPlanServlet.java
	 */
	public static Integer daysInFte(Double assignementDays, Double workDaysInAssignementPeriod) {
		
		Double daysInFte = (assignementDays / workDaysInAssignementPeriod) * 100f ;
		return daysInFte.intValue();
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * return FTE in days for one activity of a team member
	 * @param member
	 * @param begin of period
	 * @param end of period
	 * @return
	 * @throws
	 * @usage es/sm2/openppm/servlets/AssignementServlet.java
	 */
	public float workloadInDays(Teammember member, Date since, Date until) throws Exception {
		
		return ( (workDaysInPeriod(member, since, until) * member.getFte()) / 100f);
	}
	
	/**
	 * Return Team Member by id
	 * @param idTeamMember
	 * @return
	 * @throws Exception 
	 */
	public static Teammember consTeamMember(Integer idTeamMember) throws Exception {
		
		Teammember teamMember = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO teamDAO = new TeamMemberDAO(session);
			if (idTeamMember != -1) {
				teamMember = teamDAO.findById(idTeamMember, false);
			}

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
		return teamMember;
	}
	
	
	/**
	 * Return TeamMember with relations
	 * @param member
	 * @return
	 * @throws Exception 
	 */
	public static Teammember consTeamMember(Teammember member) throws Exception {
		Teammember teamMember = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO teamDAO = new TeamMemberDAO(session);
			teamMember = teamDAO.searchMember(member);

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
		return teamMember;
	}
	
	
	public static List<Teammember> filter(FiltroTabla filter, ArrayList<String> joins, Employee user) throws Exception {
		
		List<Teammember> members	= null;
		Transaction tx				= null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			members = memberDAO.filter(filter, joins, user);
			
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
		return members;
	}

	public static int findTotal(List<DatoColumna> filtrosExtras, Employee user) throws Exception {
		int total = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			total = memberDAO.findTotal(filtrosExtras, user);

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
		return total;
	}

	public static int findTotalFiltered(FiltroTabla filtro, Employee user) throws Exception {
		int total = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			total = memberDAO.findTotalFiltered(filtro, user);

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
		return total;
	}

	/**
	 * Check if employee is assigned in these day on the project activity
	 * @param initDate
	 * @param dayOfWeek
	 * @param idActivity
	 * @param employee
	 * @return
	 * @throws Exception 
	 */
	public boolean isWorkDay(Date initDate, Integer dayOfWeek,
			Integer idActivity, Employee employee) throws Exception {

		boolean isWorkDay = false;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			
			Calendar exceptionDate = DateUtil.getCalendar();
			exceptionDate.setTime(initDate);
			exceptionDate.add(Calendar.DAY_OF_WEEK, dayOfWeek);
			
			isWorkDay = memberDAO.isWorkDay(exceptionDate.getTime(), new Projectactivity(idActivity), employee);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return isWorkDay;
	}
	
	/**
	 * 
	 * @param employee
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public List<Teammember> findByEmployeeOrderByProject(Employee employee, Date since, Date until, List<String> joins) throws Exception {
		
		List<Teammember> members	= null;
		Transaction tx				= null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			members = memberDAO.findByEmployeeOrderByProject(employee, since, until, joins);
			
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
		return members;
	}

	/**
	 * Search Team Members by filter
	 * @param idProjects
	 * @param idPMs
	 * @param idSkills
	 * @param statusList
	 * @param fullName
	 * @param since
	 * @param until
	 * @param nameOrder 
	 * @param order 
	 * @param idEmployee 
	 * @return
	 * @throws Exception 
	 */
	public List<Teammember> consStaffinFtes(Integer[] idProjects,
			Integer[] idPMs, Integer[] idSkills, String[] statusList,
			String fullName, Date since, Date until, String nameOrder, String order, Integer idEmployee) throws Exception {
		
		List<Teammember> members = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			TeamMemberDAO memberDAO = new TeamMemberDAO(session);
			members = memberDAO.consStaffinFtes(idProjects, idPMs, idSkills, statusList, fullName, since, until, nameOrder, order, idEmployee);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return members;
	}
	
}
