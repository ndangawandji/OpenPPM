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

import es.sm2.openppm.dao.IncomesDAO;
import es.sm2.openppm.exceptions.IncomeDeleteException;
import es.sm2.openppm.model.Incomes;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class IncomesLogic extends AbstractGenericLogic<Incomes, Integer> {

	
	/**
	 * Save income
	 * @param idFinancePlan
	 * @param income
	 * @throws Exception 
	 */
	public static void saveIncome (Integer idProject, Incomes income) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			income.setProject(new Project(idProject));
			
			IncomesDAO incomesDAO = new IncomesDAO(session);
			incomesDAO.makePersistent(income);
			
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
	 * Delete income by id
	 * @param idIncome
	 * @throws Exception 
	 */
	public static void deleteIncome (Integer idIncome) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			if (idIncome == -1) {
				throw new IncomeDeleteException();
			}
			IncomesDAO incomesDAO = new IncomesDAO(session);
			Incomes income = incomesDAO.findById(idIncome, false);
			if (income != null) {
				incomesDAO.makeTransient(income);
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
	 * Get income by id
	 * @param idIncome
	 * @return
	 * @throws Exception 
	 */
	public static Incomes consIncome (Integer idIncome) throws Exception {
		
		Incomes income = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			IncomesDAO incomesDAO = new IncomesDAO(session);

			if (idIncome != -1) {
				income =  incomesDAO.findById(idIncome, false);
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
		return income;
	}
	
	
	/**
	 * List incomes by project
	 * @param idProject
	 * @param order 
	 * @return
	 * @throws Exception 
	 */
	public static List<Incomes> consIncomes (Integer idProject, String order) throws Exception {
		
		List<Incomes> incomes = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			IncomesDAO incomesDAO = new IncomesDAO(session);

			if (idProject != -1) {
				incomes = incomesDAO.findByProject(new Project(idProject), order);
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
		return incomes;
	}

	/**
	 * Save or Update Income
	 * @param income
	 * @throws Exception
	 */
	public static Incomes saveIncome(Incomes income) throws Exception {

		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			IncomesDAO incomesDAO	= new IncomesDAO(session);
			
			income = incomesDAO.makePersistent(income);
			
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
		return income;
	}

}
