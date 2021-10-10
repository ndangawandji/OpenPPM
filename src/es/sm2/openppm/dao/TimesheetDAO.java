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
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Timesheet;



/**
 * DAO object for domain model class Timesheet
 * @see es.sm2.openppm.dao.Timesheet
 * @author Hibernate Generator by Javier Hernandez
 */
public class TimesheetDAO extends AbstractGenericHibernateDAO<Timesheet, Integer> {


	public TimesheetDAO(Session session) {
		super(session);
	}

	/**
	 * Find time Sheet of the resource by criteria 
	 * @param employee
	 * @param projectactivity
	 * @param initDate
	 * @param endDate
	 * @return
	 */
	public Timesheet findByCriteria(Employee employee,
			Projectactivity projectactivity, Date initDate, Date endDate) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Timesheet.PROJECTACTIVITY, projectactivity))
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.eq(Timesheet.INITDATE, initDate))
			.add(Restrictions.eq(Timesheet.ENDDATE, endDate));
			
		
		return (Timesheet) crit.uniqueResult();
	}

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
	 */
	@SuppressWarnings("unchecked")
	public List<Timesheet> findByCriteria(Employee employee, Date initDate,
			Date endDate, List<String> joins, Project project, String minStatus, String maxStatus, Employee filterUser) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.eq(Timesheet.INITDATE, initDate))
			.add(Restrictions.eq(Timesheet.ENDDATE, endDate));
		
		if (minStatus != null && maxStatus != null) {
			
			crit.add(Restrictions.or(
					Restrictions.eq(Timesheet.STATUS, minStatus),
					Restrictions.eq(Timesheet.STATUS, maxStatus)
				));
		}
		
		Criteria critActivity = crit.createCriteria(Timesheet.PROJECTACTIVITY);
		
		critActivity.createCriteria(Projectactivity.TEAMMEMBERS)
			.add(Restrictions.eq(Teammember.EMPLOYEE, employee))
			.add(Restrictions.eq(Teammember.STATUS, Constants.RESOURCE_ASSIGNED));
		
		if (project != null) {		
			critActivity.add(Restrictions.eq(Projectactivity.PROJECT, project));
		}
		else if (filterUser != null) {
			// Filter by User. Settings by company for last approval.
			
			Criteria critFilter = critActivity.createCriteria(Projectactivity.PROJECT);
			
			Resourceprofiles profile = filterUser.getResourceprofiles();
			
			if (profile.getIdProfile() == Constants.ROLE_FM) {
				
				critFilter.add(Restrictions.eq(Project.EMPLOYEEBYFUNCTIONALMANAGER, filterUser));
			}
			else if (profile.getIdProfile() == Constants.ROLE_PMO) {
				
				critFilter.add(Restrictions.eq(Project.PERFORMINGORG, filterUser.getPerformingorg()));
			}
		}
		
		addJoins(crit, joins);
		
		return crit.list();
	}
	
	/**
	 * 
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Timesheet> findWithActivityByResource(Employee employee, Date initDate, Date endDate, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())		
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3))
			.add(Restrictions.ge(Timesheet.INITDATE, initDate))
			.add(Restrictions.le(Timesheet.ENDDATE, endDate))
			.createAlias(Timesheet.PROJECTACTIVITY, "pActivity")
			.addOrder(Order.asc("pActivity." + Projectactivity.PROJECT))
			.addOrder(Order.asc(Timesheet.INITDATE));

		addJoins(crit, joins);
		
		return crit.list();
	}
	
	/**
	 * 
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Timesheet> findWithOperationByResource(Employee employee, Date initDate, Date endDate, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())		
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.add(Restrictions.isNull(Timesheet.PROJECTACTIVITY))
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3))
			.add(Restrictions.ge(Timesheet.INITDATE, initDate))
			.add(Restrictions.le(Timesheet.ENDDATE, endDate))			
			.addOrder(Order.asc(Timesheet.OPERATION))
			.addOrder(Order.asc(Timesheet.INITDATE));

		addJoins(crit, joins);
		
		return crit.list();
	}

	/**
	 * Find unique time sheet operation
	 * @param operation
	 * @param consUser
	 * @param initDate
	 * @param endDate
	 * @return
	 */
	public Timesheet findByOperation(Operation operation, Employee employee,
			Date initDate, Date endDate) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.eq(Timesheet.OPERATION, operation))
			.add(Restrictions.eq(Timesheet.INITDATE, initDate))
			.add(Restrictions.eq(Timesheet.ENDDATE, endDate));
		
		return (Timesheet) crit.uniqueResult();
	}

	/**
	 * Find Time Sheets operations
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Timesheet> findByOperation(Employee employee, Date initDate,
			Date endDate, List<String> joins, String minStatus, String maxStatus) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.isNotNull(Timesheet.OPERATION))
			.add(Restrictions.eq(Timesheet.INITDATE, initDate))
			.add(Restrictions.eq(Timesheet.ENDDATE, endDate));
	
		if (minStatus != null && maxStatus != null) {
			
			crit.add(Restrictions.or(
					Restrictions.eq(Timesheet.STATUS, minStatus),
					Restrictions.eq(Timesheet.STATUS, maxStatus)
				));
		}

		addJoins(crit, joins);
		
		return crit.list();
	}

	
	/**
	 * Is in status
	 * @param idEmployee
	 * @param id
	 * @param initDate
	 * @param endDate
	 * @param status
	 * @param filterUser 
	 * @return
	 */
	public boolean isStatusResource(Integer idEmployee, Integer id, Date initDate, Date endDate, String status, Employee filterUser) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Timesheet.STATUS, status))
			.add(Restrictions.eq(Timesheet.INITDATE, initDate))
			.add(Restrictions.eq(Timesheet.ENDDATE, endDate))
			.add(Restrictions.eq(Timesheet.EMPLOYEE, new Employee(idEmployee)));
		
		if (Constants.TIMESTATUS_APP1.equals(status)) {
			
			if (id.equals(0)) {
				crit.add(Restrictions.isNull(Timesheet.PROJECTACTIVITY));
			}
			else {
				crit.createCriteria(Timesheet.PROJECTACTIVITY)
					.add(Restrictions.eq(Projectactivity.PROJECT, new Project(id)));
			}
		}
		else if (Constants.TIMESTATUS_APP2.equals(status)) {
			Criteria critFilter = crit.createCriteria(Timesheet.PROJECTACTIVITY)
				.createCriteria(Projectactivity.PROJECT);
			
			// Filter by User. Settings by company for last approval.
			
			Resourceprofiles profile = filterUser.getResourceprofiles();
			
			if (profile.getIdProfile() == Constants.ROLE_FM) {
				
				critFilter.add(Restrictions.eq(Project.EMPLOYEEBYFUNCTIONALMANAGER, filterUser));
			}
			else if (profile.getIdProfile() == Constants.ROLE_PMO) {
				
				critFilter.add(Restrictions.eq(Project.PERFORMINGORG, filterUser.getPerformingorg()));
			}
		}
		
		Integer count = (Integer) crit.uniqueResult();
		return (count != null && count > 0);
	}


	/**
	 * Get Hours resource
	 * @param idEmployee
	 * @param id
	 * @param initDate
	 * @param endDate
	 * @param minStatus
	 * @param maxStatus
	 * @return
	 */
	public double getHoursResource(Integer idEmployee, Integer id,
			Date initDate, Date endDate, String minStatus, String maxStatus, Employee filterUser) {
		
		ProjectionList proList = Projections.projectionList();
		proList.add(Projections.sum(Timesheet.HOURSDAY1));
		proList.add(Projections.sum(Timesheet.HOURSDAY2));
		proList.add(Projections.sum(Timesheet.HOURSDAY3));
		proList.add(Projections.sum(Timesheet.HOURSDAY4));
		proList.add(Projections.sum(Timesheet.HOURSDAY5));
		proList.add(Projections.sum(Timesheet.HOURSDAY6));
		proList.add(Projections.sum(Timesheet.HOURSDAY7));
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(proList)
			.add(Restrictions.or(
					Restrictions.eq(Timesheet.STATUS, minStatus),
					Restrictions.eq(Timesheet.STATUS, maxStatus)
					))
			.add(Restrictions.eq(Timesheet.INITDATE, initDate))
			.add(Restrictions.eq(Timesheet.ENDDATE, endDate))
			.add(Restrictions.eq(Timesheet.EMPLOYEE, new Employee(idEmployee)));
		
		if (Constants.TIMESTATUS_APP1.equals(minStatus)) {
			crit.createCriteria(Timesheet.PROJECTACTIVITY)
					.add(Restrictions.eq(Projectactivity.PROJECT, new Project(id)));
		}
		else if (Constants.TIMESTATUS_APP2.equals(minStatus)) {
			
			// Filter by User. Settings by company for last approval.
			
			Criteria critFilter = crit.createCriteria(Timesheet.PROJECTACTIVITY)
				.createCriteria(Projectactivity.PROJECT);
			
			Resourceprofiles profile = filterUser.getResourceprofiles();
			
			if (profile.getIdProfile() == Constants.ROLE_FM) {
				
				critFilter.add(Restrictions.eq(Project.EMPLOYEEBYFUNCTIONALMANAGER, filterUser));
			}
			else if (profile.getIdProfile() == Constants.ROLE_PMO) {
				
				critFilter.add(Restrictions.eq(Project.PERFORMINGORG, filterUser.getPerformingorg()));
			}
		}
		Object[] hoursList = (Object[]) crit.uniqueResult();
		
		double hours = 0;
		
		if (hoursList != null) {
			hours += (hoursList[0] == null?0:(Double)hoursList[0]);
			hours += (hoursList[1] == null?0:(Double)hoursList[1]);
			hours += (hoursList[2] == null?0:(Double)hoursList[2]);
			hours += (hoursList[3] == null?0:(Double)hoursList[3]);
			hours += (hoursList[4] == null?0:(Double)hoursList[4]);
			hours += (hoursList[5] == null?0:(Double)hoursList[5]);
			hours += (hoursList[6] == null?0:(Double)hoursList[6]);
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
	 */
	public double getHoursResource(Project project, Employee member, Date firstWeekDay,
			Date lastWeekDay) {
		
		
		ProjectionList proList = Projections.projectionList();
		proList.add(Projections.sum(Timesheet.HOURSDAY1));
		proList.add(Projections.sum(Timesheet.HOURSDAY2));
		proList.add(Projections.sum(Timesheet.HOURSDAY3));
		proList.add(Projections.sum(Timesheet.HOURSDAY4));
		proList.add(Projections.sum(Timesheet.HOURSDAY5));
		proList.add(Projections.sum(Timesheet.HOURSDAY6));
		proList.add(Projections.sum(Timesheet.HOURSDAY7));
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(proList)
			.add(Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3))
			.add(Restrictions.eq(Timesheet.EMPLOYEE, member));
		
		if (firstWeekDay != null && lastWeekDay != null) {
		
			crit.add(Restrictions.eq(Timesheet.INITDATE, firstWeekDay))
			.add(Restrictions.eq(Timesheet.ENDDATE, lastWeekDay));
		}
		crit.createCriteria(Timesheet.PROJECTACTIVITY)
			.add(Restrictions.eq(Projectactivity.PROJECT, project));

		Object[] hoursList = (Object[]) crit.uniqueResult();
		
		double hours = 0;
		
		if (hoursList != null) {
			hours += (hoursList[0] == null?0:(Double)hoursList[0]);
			hours += (hoursList[1] == null?0:(Double)hoursList[1]);
			hours += (hoursList[2] == null?0:(Double)hoursList[2]);
			hours += (hoursList[3] == null?0:(Double)hoursList[3]);
			hours += (hoursList[4] == null?0:(Double)hoursList[4]);
			hours += (hoursList[5] == null?0:(Double)hoursList[5]);
			hours += (hoursList[6] == null?0:(Double)hoursList[6]);
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
	 */
	public double getHoursResource(Project project, Teammember member, Date firstWeekDay,
			Date lastWeekDay) {
		
		ProjectionList proList = Projections.projectionList();
		proList.add(Projections.sum(Timesheet.HOURSDAY1));
		proList.add(Projections.sum(Timesheet.HOURSDAY2));
		proList.add(Projections.sum(Timesheet.HOURSDAY3));
		proList.add(Projections.sum(Timesheet.HOURSDAY4));
		proList.add(Projections.sum(Timesheet.HOURSDAY5));
		proList.add(Projections.sum(Timesheet.HOURSDAY6));
		proList.add(Projections.sum(Timesheet.HOURSDAY7));
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(proList)
			.add(Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3));
		
		crit.createCriteria(Timesheet.EMPLOYEE)
			.createCriteria(Employee.TEAMMEMBERS)
			.add(Restrictions.idEq(member.getIdTeamMember()));
		
		if (firstWeekDay != null && lastWeekDay != null) {
		
			crit.add(Restrictions.eq(Timesheet.INITDATE, firstWeekDay))
			.add(Restrictions.eq(Timesheet.ENDDATE, lastWeekDay));
		}
		crit.createCriteria(Timesheet.PROJECTACTIVITY)
			.add(Restrictions.eq(Projectactivity.PROJECT, project));

		Object[] hoursList = (Object[]) crit.uniqueResult();
		
		double hours = 0;
		
		if (hoursList != null) {
			hours += (hoursList[0] == null?0:(Double)hoursList[0]);
			hours += (hoursList[1] == null?0:(Double)hoursList[1]);
			hours += (hoursList[2] == null?0:(Double)hoursList[2]);
			hours += (hoursList[3] == null?0:(Double)hoursList[3]);
			hours += (hoursList[4] == null?0:(Double)hoursList[4]);
			hours += (hoursList[5] == null?0:(Double)hoursList[5]);
			hours += (hoursList[6] == null?0:(Double)hoursList[6]);
		}
		
		return hours;
	}

	/**
	 * Find time sheet
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param activity
	 * @param status
	 * @return
	 */
	public Timesheet findByResource(Employee employee, Date initDate,
			Date endDate, Projectactivity activity, String status) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Timesheet.PROJECTACTIVITY, activity))
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.eq(Timesheet.INITDATE, initDate))
			.add(Restrictions.eq(Timesheet.ENDDATE, endDate))
			.add(Restrictions.eq(Timesheet.STATUS, status));
			

			return (Timesheet) crit.uniqueResult();
	}
	
	/**
	 * 
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Timesheet> findByProject(Employee employee, Project project, Date initDate, Date endDate, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())		
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)			
			.add(Restrictions.eq(Timesheet.EMPLOYEE, employee))
			.add(Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3))
			.add(Restrictions.ge(Timesheet.INITDATE, initDate))
			.add(Restrictions.le(Timesheet.ENDDATE, endDate))			
			.addOrder(Order.asc(Timesheet.INITDATE));
		
		crit.createCriteria(Timesheet.PROJECTACTIVITY)
			.add(Restrictions.eq(Projectactivity.PROJECT, project))
			.addOrder(Order.asc(Projectactivity.PROJECT));		
		
		if(joins != null) {
			addJoins(crit, joins);	
		}
		
		return crit.list();
	}
}
