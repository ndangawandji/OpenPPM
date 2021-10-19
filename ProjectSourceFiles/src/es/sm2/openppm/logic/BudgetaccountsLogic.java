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

import es.sm2.openppm.dao.BudgetaccountsDAO;
import es.sm2.openppm.exceptions.BudgetAccountNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Budgetaccounts;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class BudgetaccountsLogic extends AbstractGenericLogic<Budgetaccounts, Integer> {

	/**
	 * Save BudgetAccounts
	 * @param budgetaccounts
	 * @throws Exception
	 */
	public static void saveBudgetAccounts(Budgetaccounts budgetaccounts) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			BudgetaccountsDAO budgetaccountsDAO = new BudgetaccountsDAO(session);
			budgetaccountsDAO.makePersistent(budgetaccounts);
			
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
	 * Delete Budget Account
	 * @param idBudgetAccount
	 * @throws Exception
	 */
	public static void deleteBudgetAccounts(Integer idBudgetAccount) throws Exception {
		if (idBudgetAccount == null || idBudgetAccount == -1) {
			throw new BudgetAccountNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			BudgetaccountsDAO budgetaccountsDAO = new BudgetaccountsDAO(session);
			Budgetaccounts budgetaccounts = budgetaccountsDAO.findById(idBudgetAccount, false);
			
			if (budgetaccounts != null) {
				if(!budgetaccounts.getExpenseses().isEmpty()){
					throw new LogicException("msg.error.delete.this_has","maintenance.budgetaccounts","expenses");
				}
				else if(!budgetaccounts.getDirectcostses().isEmpty()){
					throw new LogicException("msg.error.delete.this_has","maintenance.budgetaccounts","direct_costs");
				}				
				else{
					budgetaccountsDAO.makeTransient(budgetaccounts);
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
	 * Return list of all budget accounts
	 * @return
	 * @throws Exception
	 */
	public static List<Budgetaccounts> consBudgetaccounts () throws Exception {
		
		List<Budgetaccounts> budgetaccounts = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			BudgetaccountsDAO budgetaccountsDAO = new BudgetaccountsDAO(session);
			budgetaccounts = budgetaccountsDAO.findAll();
			
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
		return budgetaccounts;
	}
}
