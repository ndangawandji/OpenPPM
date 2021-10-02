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

import es.sm2.openppm.dao.ContentFileDAO;
import es.sm2.openppm.model.Contentfile;
import es.sm2.openppm.model.Documentation;
import es.sm2.openppm.utils.SessionFactoryUtil;

/**
 * Logic object for domain model class File
 * @see es.sm2.openppm.logic.File
 * @author Hibernate Generator by Javier Hernandez
 */
public final class ContentFileLogic extends AbstractGenericLogic<Contentfile, Integer>{
	
	/**
	 * Find the content file from documentation
	 * @param doc
	 * @return
	 * @throws Exception
	 */
	public Contentfile findByDocumentation (Documentation doc) throws Exception {
		
		Contentfile content = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try {
			tx = session.beginTransaction();
			ContentFileDAO fileDAO = new ContentFileDAO(session);
			content = fileDAO.findByDocumentation(doc);
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
		return content;
	}

}

