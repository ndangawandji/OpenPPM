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
import es.sm2.openppm.dao.ActivitysellerDAO;
import es.sm2.openppm.model.Activityseller;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.exceptions.ActivitysellerNotFoundException;
import es.sm2.openppm.exceptions.ProjectNotFoundException;



/**
 * Logic object for domain model class Activityseller
 * @see es.sm2.openppm.logic.Activityseller
 * @author Hibernate Generator by Javier Hernandez
 */
public final class ActivitysellerLogic {

	/**
	* ActivitysellerLogic is a singleton class
	*/
	private ActivitysellerLogic() {
		super();
	}

	/**
	 * Return Activityseller
	 * @param idActivityseller
     * @param lock
	 * @return
	 * @throws Exception 
	 */
	public static Activityseller findById(Integer idActivityseller, boolean lock) throws Exception {
		if (idActivityseller == null || idActivityseller == -1) {
     		throw new NoDataFoundException();
		}
		Activityseller activityseller = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ActivitysellerDAO activitysellerDAO = new ActivitysellerDAO(session);
			activityseller = activitysellerDAO.findById(idActivityseller, lock);
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
		return activityseller;
	}
	
	/**
	 * Create or update Activityseller
	 * @param activityseller
	 * @throws Exception 
	 */
	public static Activityseller saveActivityseller(Activityseller activityseller) throws Exception {
		if (activityseller == null) {
			throw new ActivitysellerNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ActivitysellerDAO activitysellerDAO = new ActivitysellerDAO(session);
			activityseller = activitysellerDAO.makePersistent(activityseller);
			
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
		return activityseller;
	}
	
	/**
	 * Delete Activityseller
	 * @param activityseller
	 * @throws Exception 
	 */
	public static void deleteActivityseller(Activityseller activityseller) throws Exception {
		if (activityseller == null) {
			throw new ActivitysellerNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ActivitysellerDAO activitysellerDAO = new ActivitysellerDAO(session);
			activitysellerDAO.makeTransient(activityseller);
			
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
	 * Get Activity sellers from Project
	 * 
	 * @param proj
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public static List<Activityseller> consActivitySellerByProject(Project proj, List<String> joins) throws Exception {
		if (proj == null) {
			throw new ProjectNotFoundException();
		}
		
		List<Activityseller> listActSeller = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ActivitysellerDAO activitysellerDAO = new ActivitysellerDAO(session);
			listActSeller = activitysellerDAO.consActivitySellerByProject(proj, joins);
			
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
		return listActSeller;
	}
}

