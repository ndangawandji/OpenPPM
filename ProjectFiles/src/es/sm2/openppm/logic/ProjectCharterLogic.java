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

import es.sm2.openppm.dao.ProjectCharterDAO;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ProjectCharterLogic {

	private ProjectCharterLogic() {
		super();
	}
	
	/**
	 * Get Project Charter by Id
	 * @param idProjectCharter
	 * @return
	 * @throws Exception 
	 */
	public static Projectcharter consProjectCharter (Integer idProjectCharter) throws Exception {
		if (idProjectCharter == -1) {
			throw new NoDataFoundException();
		}
		Projectcharter projCharter = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectCharterDAO charterDAO = new ProjectCharterDAO(session);
			projCharter = charterDAO.findById(idProjectCharter, false);
			
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
		return projCharter;
	}
	

	/**
	 * Get project charter by project
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	public static Projectcharter findByProject(Project proj) throws Exception {
		
		Projectcharter projCharter = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectCharterDAO charterDAO = new ProjectCharterDAO(session);
			projCharter = charterDAO.findByProject(proj);
			
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
		return projCharter;
	}
}
