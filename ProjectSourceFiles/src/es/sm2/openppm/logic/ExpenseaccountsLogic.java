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

import es.sm2.openppm.dao.ExpenseaccountsDAO;
import es.sm2.openppm.exceptions.ExpenseaccountNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Expenseaccounts;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ExpenseaccountsLogic extends AbstractGenericLogic<Expenseaccounts, Integer> {

	
	/**
	 * Save Expenseaccounts
	 * @param expenseaccounts
	 * @throws Exception 
	 */
	public static void saveExpenseAccount(Expenseaccounts expenseaccounts) throws Exception {

		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ExpenseaccountsDAO expenseaccountsDAO = new ExpenseaccountsDAO(session);
			expenseaccountsDAO.makePersistent(expenseaccounts);
			
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
	 * Delete Expenseaccounts
	 * @param idExpenseAccount
	 * @throws Exception 
	 */
	public static void deleteExpenseAccount(Integer idExpenseAccount) throws Exception {
		if (idExpenseAccount == null || idExpenseAccount == -1) {
			throw new ExpenseaccountNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			ExpenseaccountsDAO expenseaccountsDAO = new ExpenseaccountsDAO(session);
			Expenseaccounts expenseaccounts = expenseaccountsDAO.findById(idExpenseAccount, false);
			
			if (expenseaccounts != null) {
				if (!expenseaccounts.getExpensesheets().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","maintenance.expenseaccounts","expenses.sheet");
				}				
				else {
					expenseaccountsDAO.makeTransient(expenseaccounts);
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
