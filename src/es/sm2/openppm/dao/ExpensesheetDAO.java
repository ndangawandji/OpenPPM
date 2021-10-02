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
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expenses;
import es.sm2.openppm.model.Expensesheet;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Resourceprofiles;



/**
 * DAO object for domain model class Expensesheet
 * @see es.sm2.openppm.dao.Expensesheet
 * @author Hibernate Generator by Javier Hernandez
 */
public class ExpensesheetDAO extends AbstractGenericHibernateDAO<Expensesheet, Integer> {


	public ExpensesheetDAO(Session session) {
		super(session);
	}

	/**
	 * Find Expense Sheet by resource in month
	 * @param user
	 * @param firstMonthDay
	 * @param lastMonthDay
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Expensesheet> findByResource(Employee user, Date firstMonthDay,
			Date lastMonthDay, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.add(Restrictions.eq(Expensesheet.EMPLOYEE, user))
			.add(Restrictions.between(Expensesheet.EXPENSEDATE, firstMonthDay, lastMonthDay));
		
		addJoins(crit, joins);
		
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Expensesheet> findByResource(Employee employee,
			Date firstMonthDay, Date lastMonthDay, String minStatus,
			String maxStatus, Employee filterUser, Project project,
			List<String> joins) {
		
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.add(Restrictions.eq(Expensesheet.EMPLOYEE, employee))
			.add(Restrictions.between(Expensesheet.EXPENSEDATE, firstMonthDay, lastMonthDay));
		
		if (minStatus != null && maxStatus != null) {
			
			crit.add(Restrictions.or(
					Restrictions.eq(Expensesheet.STATUS, minStatus),
					Restrictions.eq(Expensesheet.STATUS, maxStatus)
				));
		}
		
		if (project != null) {			
			crit.add(Restrictions.eq(Expensesheet.PROJECT, project));
		}
		else if (filterUser != null) {
			
			// Filter by User. Settings by company for last approval.
			
			Criteria critFilter = crit.createCriteria(Expensesheet.PROJECT);
			
			Resourceprofiles profile = filterUser.getResourceprofiles();
			
			if (profile.getIdProfile() == Constants.ROLE_FM) {
				
				critFilter.add(Restrictions.eq(Project.EMPLOYEEBYFUNCTIONALMANAGER, filterUser));
			}
			else if (profile.getIdProfile() == Constants.ROLE_PMO) {
				
				critFilter.add(Restrictions.eq(Project.PERFORMINGORG, filterUser.getPerformingorg()));
			}
		}
		else {
			crit.add(Restrictions.isNotNull(Expensesheet.OPERATION));
		}
		
		addJoins(crit, joins);
		return crit.list();
	}

	public double getCostResource(Integer idEmployee, Integer id,
			Date firstMonthDay, Date lastMonthDay, String minStatus,
			String maxStatus, Employee filterUser) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.sum(Expensesheet.COST))
			.add(Restrictions.or(
					Restrictions.eq(Expensesheet.STATUS, minStatus),
					Restrictions.eq(Expensesheet.STATUS, maxStatus)
					))
			.add(Restrictions.between(Expensesheet.EXPENSEDATE, firstMonthDay, lastMonthDay))
			.add(Restrictions.eq(Expensesheet.EMPLOYEE, new Employee(idEmployee)));
		
		if (Constants.EXPENSE_STATUS_APP1.equals(minStatus)) {
			crit.add(Restrictions.eq(Expensesheet.PROJECT, new Project(id)));
		}
		else if (Constants.EXPENSE_STATUS_APP2.equals(minStatus)) {
			
			// Filter by User. Settings by company for last approval.
			
			Criteria critFilter = crit.createCriteria(Expensesheet.PROJECT);
			
			Resourceprofiles profile = filterUser.getResourceprofiles();
			
			if (profile.getIdProfile() == Constants.ROLE_FM) {
				
				critFilter.add(Restrictions.eq(Project.EMPLOYEEBYFUNCTIONALMANAGER, filterUser));
			}
			else if (profile.getIdProfile() == Constants.ROLE_PMO) {
				
				critFilter.add(Restrictions.eq(Project.PERFORMINGORG, filterUser.getPerformingorg()));
			}
		}
		double cost = (Double) (crit.uniqueResult() == null?0D:crit.uniqueResult());
		
		crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.sum(Expensesheet.COST))
			.add(Restrictions.or(
					Restrictions.eq(Expensesheet.STATUS, minStatus),
					Restrictions.eq(Expensesheet.STATUS, maxStatus)
					))
			.add(Restrictions.between(Expensesheet.EXPENSEDATE, firstMonthDay, lastMonthDay))
			.add(Restrictions.eq(Expensesheet.EMPLOYEE, new Employee(idEmployee)))
			.add(Restrictions.isNotNull(Expensesheet.OPERATION));
		
		cost += (Double) (crit.uniqueResult() == null?0D:crit.uniqueResult());
		
		return cost;
	}

	/**
	 * Is in status
	 * @param idEmployee
	 * @param id
	 * @param firstMonthDay
	 * @param lastMonthDay
	 * @param status
	 * @param filterUser 
	 * @return
	 */
	public boolean isStatusResource(Integer idEmployee, Integer id,
			Date firstMonthDay, Date lastMonthDay, String status, Employee filterUser) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Expensesheet.STATUS, status))
			.add(Restrictions.between(Expensesheet.EXPENSEDATE, firstMonthDay, lastMonthDay))
			.add(Restrictions.eq(Expensesheet.EMPLOYEE, new Employee(idEmployee)));
		
		if (Constants.EXPENSE_STATUS_APP1.equals(status)) {
			crit.add(Restrictions.eq(Expensesheet.PROJECT, new Project(id)));
		}
		else if (Constants.EXPENSE_STATUS_APP2.equals(status)) {
			
			// Filter by User. Settings by company for last approval.
			
			Criteria critFilter = crit.createCriteria(Expensesheet.PROJECT);
			
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
	
	public double getSumExpenseSheet(Expenses expense) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.sum(Expensesheet.COST))
			.add(Restrictions.eq(Expensesheet.STATUS, Constants.EXPENSE_STATUS_APP3))
			.add(Restrictions.eq(Expensesheet.EXPENSES, expense));
		
		double cost = (Double) (crit.uniqueResult() == null ? 0D : crit.uniqueResult());
		
		return cost;
	}
}

