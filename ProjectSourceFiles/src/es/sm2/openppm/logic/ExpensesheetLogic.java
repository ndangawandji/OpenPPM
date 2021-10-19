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

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.ExpensesheetDAO;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expensesheet;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Expensesheet
 * @see es.sm2.openppm.logic.Expensesheet
 * @author Hibernate Generator by Javier Hernandez
 */
public final class ExpensesheetLogic  extends AbstractGenericLogic<Expensesheet, Integer>{

	/**
	 * Find Expense Sheet by resource in month
	 * @param user
	 * @param dayMonth
	 * @param joins 
	 * @return
	 * @throws Exception
	 */
	public List<Expensesheet> findByResource(Employee user, Date dayMonth, List<String> joins) throws Exception {
		
		List<Expensesheet> list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			ExpensesheetDAO expensesheetDAO = new ExpensesheetDAO(session);
			list = expensesheetDAO.findByResource(user, DateUtil.getFirstMonthDay(dayMonth), DateUtil.getLastMonthDay(dayMonth), joins);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		return list;
	}

	/**
	 * Find Expense Sheet by resource in month
	 * @param employee
	 * @param dayMonth
	 * @param joins
	 * @param project
	 * @param minStatus
	 * @param maxStatus
	 * @param filterUser
	 * @return
	 * @throws Exception
	 */
	public List<Expensesheet> findByResource(Employee employee,
			Date dayMonth, List<String> joins,
			Project project, String minStatus, String maxStatus,
			Employee filterUser) throws Exception {
		
		List<Expensesheet> list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			ExpensesheetDAO expensesheetDAO = new ExpensesheetDAO(session);
			list = expensesheetDAO.findByResource(
					employee,
					DateUtil.getFirstMonthDay(dayMonth),
					DateUtil.getLastMonthDay(dayMonth),
					minStatus,
					maxStatus,
					filterUser,
					project,
					joins);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		return list;
	}

	/**
	 * Get sum of cost
	 * @param idEmployee
	 * @param id
	 * @param sheetDate
	 * @param filterUser 
	 * @param approveRol
	 * @return
	 * @throws Exception 
	 */
	public double getCostResource(Integer idEmployee, Integer id,
			Date sheetDate, Employee filterUser, int approveRol) throws Exception {
		
		double cost = 0;
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			ExpensesheetDAO expensesheetDAO = new ExpensesheetDAO(session);
			
			int rol = filterUser.getResourceprofiles().getIdProfile();
			
			String minStatus = (rol == Constants.ROLE_PM? Constants.EXPENSE_STATUS_APP1: Constants.EXPENSE_STATUS_APP2);
			String maxStatus = (rol == Constants.ROLE_PM && approveRol > 0? Constants.EXPENSE_STATUS_APP2: Constants.EXPENSE_STATUS_APP3);
			
			cost = expensesheetDAO.getCostResource(idEmployee, id,
					DateUtil.getFirstMonthDay(sheetDate),
					DateUtil.getLastMonthDay(sheetDate),
					minStatus, maxStatus, filterUser);
			
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		return cost;
	}

	/**
	 * Get status actual level for Expenses
	 * @param idEmployee
	 * @param id
	 * @param sheetDate
	 * @param status
	 * @param filterUser 
	 * @param approveLevel 
	 * @return
	 * @throws Exception 
	 */
	public String getStatusResourceExpense(Integer idEmployee, Integer id,
			Date sheetDate, String status, String approveLevel, Employee filterUser) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			ExpensesheetDAO expensesheetDAO = new ExpensesheetDAO(session);

			boolean isStatus = expensesheetDAO.isStatusResource(idEmployee, id,
					DateUtil.getFirstMonthDay(sheetDate),
					DateUtil.getLastMonthDay(sheetDate), status, filterUser);
			
			if (!isStatus) { status = approveLevel; }
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return status;
	}
}

