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

import es.sm2.openppm.dao.ChangeControlDAO;
import es.sm2.openppm.model.Changecontrol;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ChangeControlLogic extends AbstractGenericLogic<Changecontrol, Integer> {

	/**
	 * List of Changes control
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<Changecontrol> consChangesControl(Project project) throws Exception {
		
		List<Changecontrol> changes = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ChangeControlDAO changesDAO = new ChangeControlDAO(session);
			changes = changesDAO.findByProject(project);

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
		return changes;
	}
	
	
	/**
	 * Return change control
	 * @param idChange
	 * @return
	 * @throws Exception 
	 */
	public static Changecontrol consChangeControl(Changecontrol changeControl) throws Exception {
		
		Changecontrol change = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ChangeControlDAO changesDAO = new ChangeControlDAO(session);
			if (changeControl.getIdChange() != -1) {
				change = changesDAO.findByIdWithData(changeControl);
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
		return change;
	}
	
	
	/**
	 * Save change control 
	 * @param change
	 * @return change control
	 * @throws Exception 
	 */
	public static Changecontrol saveChangeControl (Changecontrol change) throws Exception {
		
		Changecontrol returnChange = null;
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ChangeControlDAO changesDAO = new ChangeControlDAO(session);
			changesDAO.makePersistent(change);
			
			returnChange = changesDAO.findById(change.getIdChange(), false);
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
		return returnChange;
	}
	
}
