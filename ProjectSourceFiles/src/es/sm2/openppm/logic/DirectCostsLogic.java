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

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.DirectCostsDAO;
import es.sm2.openppm.dao.ProjectCostsDAO;
import es.sm2.openppm.model.Directcosts;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class DirectCostsLogic extends AbstractGenericLogic<Directcosts, Integer> {

	/**
	 * Get direct cost
	 * @param idCost
	 * @return
	 * @throws Exception 
	 */
	public static Directcosts consDirectcosts (Integer idCost) throws Exception {
		
		Directcosts cost = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			DirectCostsDAO costDAO = new DirectCostsDAO(session);
			if (idCost != -1) {
				cost = costDAO.findById(idCost, false);
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
		return cost;
	}
	
	
	/**
	 * Save direct cost
	 * @param cost
	 * @param costDate 
	 * @throws Exception 
	 */
	public static void saveDirectcost (Directcosts cost, Date costDate) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			DirectCostsDAO costDAO = new DirectCostsDAO(session);
			cost = costDAO.makePersistent(cost);
			
			if (costDate != null) {
				
				ProjectCostsDAO projectCostsDAO = new ProjectCostsDAO(session);
				
				Projectcosts projCost = cost.getProjectcosts();
				projCost.setCostDate(costDate);
				
				projectCostsDAO.makePersistent(projCost);
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
