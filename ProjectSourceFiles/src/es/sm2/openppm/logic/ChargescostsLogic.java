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

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.ChargescostsDAO;
import es.sm2.openppm.exceptions.ChargescostsNotFoundException;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.model.Chargescosts;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Chargescosts
 * @see es.sm2.openppm.logic.Chargescosts
 * @author Hibernate Generator by Javier Hernandez
 */
public final class ChargescostsLogic extends AbstractGenericLogic<Chargescosts, Integer>{

	/**
	 * Create or update Chargescosts
	 * @param chargescosts
	 * @throws Exception 
	 */
	public static Chargescosts saveChargescosts(Chargescosts chargescosts) throws Exception {
		if (chargescosts == null) {
			throw new ChargescostsNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ChargescostsDAO chargescostsDAO = new ChargescostsDAO(session);
			chargescosts = chargescostsDAO.makePersistent(chargescosts);
			
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
		return chargescosts;
	}
	
	/**
	 * Delete Chargescosts
	 * @param chargescosts
	 * @throws Exception 
	 */
	public static void deleteChargescosts(Chargescosts chargescosts) throws Exception {
		if (chargescosts == null) {
			throw new ChargescostsNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ChargescostsDAO chargescostsDAO = new ChargescostsDAO(session);
			chargescosts = chargescostsDAO.findById(chargescosts.getIdChargesCosts(), false);
			
			chargescostsDAO.makeTransient(chargescosts);
			
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
	 * Cons Charge Costs by project and type
	 * @param proj
	 * @param type
	 * @throws Exception
	 */
	public static List<Chargescosts> consChargescostsByProject(Project proj, int type) 
	throws Exception {
		
		List<Chargescosts> list = null;
		if (proj == null) {
			throw new ProjectNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ChargescostsDAO chargescostsDAO = new ChargescostsDAO(session);
			list = chargescostsDAO.consChargescostsByProject(proj, type);
			
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
	
	/**
	 * 
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	public static double consExternalCostByProject(Project proj) 
	throws Exception {
			
		double result = 0;
		List<Chargescosts> list = null;
		if (proj == null) {
			throw new ProjectNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ChargescostsDAO chargescostsDAO = new ChargescostsDAO(session);
			list = new ArrayList<Chargescosts>();
			list.addAll(chargescostsDAO.consChargescostsByProject(proj, Constants.SELLER_CHARGE_COST));
			list.addAll(chargescostsDAO.consChargescostsByProject(proj, Constants.INFRASTRUCTURE_CHARGE_COST));
			list.addAll(chargescostsDAO.consChargescostsByProject(proj, Constants.LICENSE_CHARGE_COST));
			
			if(!list.isEmpty()) {
				for(Chargescosts cost : list) {
					result += cost.getCost();
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
		return result;
	}
}

