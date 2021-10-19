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

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.OperationaccountDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.OperationaccountNotFoundException;
import es.sm2.openppm.model.Operationaccount;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class OperationaccountLogic extends AbstractGenericLogic<Operationaccount, Integer> {

	
	/**
	 * Save Operationaccount
	 * @param operationaccount
	 * @throws Exception 
	 */
	public static void saveOperationAccount(Operationaccount operationaccount) throws Exception {
			
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			OperationaccountDAO operationaccountDAO = new OperationaccountDAO(session);
			operationaccountDAO.makePersistent(operationaccount);
			
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
	 * Delete Operationaccount
	 * @param idOperationAccount
	 * @throws Exception 
	 */
	public static void deleteOperationAccount(Integer idOperationAccount) throws Exception {
		if (idOperationAccount == null || idOperationAccount == -1) {
			throw new OperationaccountNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			OperationaccountDAO operationaccountDAO = new OperationaccountDAO(session);
			Operationaccount operationaccount = operationaccountDAO.findById(idOperationAccount, false);
			
			if (operationaccount != null) {
				if (!operationaccount.getOperations().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","maintenance.operation.op_account","operation");
				}
				else {
					operationaccountDAO.makeTransient(operationaccount);
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
	
}
