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

import es.sm2.openppm.dao.GeographyDAO;
import es.sm2.openppm.exceptions.GeographyNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Geography;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class GeographyLogic extends AbstractGenericLogic<Geography, Integer> {

	/**
	 * Save Geography
	 * @param geography
	 * @throws Exception 
	 */
	public static void saveGeography(Geography geography) throws Exception {
			
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			GeographyDAO geographyDAO = new GeographyDAO(session);
			geographyDAO.makePersistent(geography);
			
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
	 * Delete Geography
	 * @param idGeography
	 * @throws Exception 
	 */
	public static void deleteGeography(Integer idGeography) throws Exception {
		if (idGeography == null || idGeography == -1) {
			throw new GeographyNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			GeographyDAO geographyDAO = new GeographyDAO(session);
			Geography geography = geographyDAO.findById(idGeography, false);
			
			if (geography != null) {
				if(!geography.getProjects().isEmpty()){
					throw new LogicException("msg.error.delete.this_has","geography","project");
				}
				else{
					geographyDAO.makeTransient(geography);
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
