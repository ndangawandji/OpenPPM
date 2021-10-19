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

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.OperationDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.OperationNotFoundException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class OperationLogic extends AbstractGenericLogic<Operation, Integer> {

	/**
	 * Save Operation
	 * @param operation
	 * @throws Exception 
	 */
	public static void saveOperation(Operation operation) throws Exception {
			
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			OperationDAO operationDAO = new OperationDAO(session);
			operationDAO.makePersistent(operation);
			
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
	
	
	/**
	 * Delete Operation
	 * @param idOperation
	 * @throws Exception 
	 */
	public static void deleteOperation(Integer idOperation) throws Exception {
		if (idOperation == null || idOperation == -1) {
			throw new OperationNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			OperationDAO operationDAO = new OperationDAO(session);
			Operation operation = operationDAO.findById(idOperation, false);
			
			if (operation != null) {
				if (!operation.getExpensesheets().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","maintenance.expenseaccounts","expenses.sheet");
				}
				else if(!operation.getTimesheets().isEmpty()){
					throw new LogicException("msg.error.delete.this_has","maintenance.expenseaccounts","operation" + " " + "timesheet");
				}
				else {
					operationDAO.makeTransient(operation);
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
	
	
	/**
	 * Return operation by id
	 * @param idOperation
	 * @return
	 * @throws Exception 
	 */
	public static Operation consOperation(Integer idOperation) throws Exception {
		Operation operation = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			OperationDAO operationDAO = new OperationDAO(session);
			if (idOperation != -1) {
				operation = operationDAO.findByIdOperation(new Operation(idOperation));
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
		return operation;
	}
	
	/**
	 * Find Operations by Company
	 * @param company
	 * @return
	 * @throws Exception 
	 */
	public List<Operation> findByAllCompany(Company company) throws Exception {
		
		List<Operation> list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			OperationDAO operationDAO = new OperationDAO(session);
			list = operationDAO.findAllByCompany(company);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}
	
}
