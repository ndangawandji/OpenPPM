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
import org.hibernate.criterion.Order;

import es.sm2.openppm.dao.StakeholderDAO;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Stakeholder;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class StakeholderLogic extends AbstractGenericLogic<Stakeholder, Integer> {

	/**
	 * Save new stakeholder at new project screen
	 * @param stakeholder
	 * @throws Exception 
	 */
	public static void saveStakeholder(Stakeholder stakeholder) throws Exception {
		if (stakeholder == null) {
			throw new NoDataFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			StakeholderDAO stakeholderDAO = new StakeholderDAO(session);
			stakeholderDAO.makePersistent(stakeholder);			
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
	 * Delete stakeholder at new project screen
	 * @param stakeholder
	 * @throws Exception 
	 */
	public static void deleteStakeholder(Stakeholder stakeholder) throws Exception {
		if (stakeholder == null) {
			throw new NoDataFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			StakeholderDAO stakeholderDAO = new StakeholderDAO(session);
			
			stakeholder = stakeholderDAO.findById(stakeholder.getIdStakeholder(), false); 
			stakeholderDAO.makeTransient(stakeholder);
			
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
	 * Find Stakeholders by order
	 * @param proj
	 * @param order
	 * @return
	 * @throws Exception
	 */
	public List<Stakeholder> findByProject(Project proj, Order... order) throws Exception {
		if (proj == null) {
			throw new NoDataFoundException();
		}
		
		List<Stakeholder> list = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			StakeholderDAO stakeholderDAO = new StakeholderDAO(session);
			list = stakeholderDAO.findByProject(proj, order);
			
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
		return list;
	}
}
