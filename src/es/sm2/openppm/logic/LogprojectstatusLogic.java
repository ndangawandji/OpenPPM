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

import es.sm2.openppm.model.Logprojectstatus;



/**
 * Logic object for domain model class Logprojectstatus
 * @see es.sm2.openppm.logic.Logprojectstatus
 * @author Hibernate Generator by Javier Hernandez
 *
 * IMPORTANT! Instantiate the class for use generic methods
 *
 */
public final class LogprojectstatusLogic extends AbstractGenericLogic<Logprojectstatus, Integer> {



	/* Example of implementation
	public Logprojectstatus exampleMethod(Logprojectstatus logprojectstatus) throws Exception {
	
		if (logprojectstatus == null) {
			throw new LogprojectstatusNotFoundException();
		}
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			LogprojectstatusDAO logprojectstatusDAO = new LogprojectstatusDAO(session);
			logprojectstatus = logprojectstatusDAO.exampleMethod(logprojectstatus);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return logprojectstatus;
	}
	*/
}

