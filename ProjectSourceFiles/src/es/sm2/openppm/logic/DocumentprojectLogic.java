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

import es.sm2.openppm.dao.DocumentprojectDAO;
import es.sm2.openppm.exceptions.DocumentprojectNotFoundException;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Documentproject
 * @see es.sm2.openppm.logic.Documentproject
 * @author Hibernate Generator by Javier Hernandez
 */
public final class DocumentprojectLogic extends AbstractGenericLogic<Documentproject, Integer>{

	/**
	 * Create or update Documentproject
	 * @param documentproject
	 * @throws Exception 
	 */
	public static Documentproject saveDocumentproject(Documentproject documentproject) throws Exception {
		if (documentproject == null) {
			throw new DocumentprojectNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			DocumentprojectDAO documentprojectDAO = new DocumentprojectDAO(session);
			documentproject = documentprojectDAO.makePersistent(documentproject);
			
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
		return documentproject;
	}
	
	/**
	 * Delete Documentproject
	 * @param documentproject
	 * @throws Exception 
	 */
	public static void deleteDocumentproject(Documentproject documentproject) throws Exception {
		if (documentproject == null) {
			throw new DocumentprojectNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			DocumentprojectDAO documentprojectDAO = new DocumentprojectDAO(session);
			documentprojectDAO.makeTransient(documentproject);
			
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
	 * Save or update document project
	 * @param idDocumentProject
	 * @param idProject
	 * @param type
	 * @param link
	 * @return 
	 * @throws Exception
	 */
	public static Documentproject saveDocumentproject(int idDocumentProject,
			int idProject, String type, String link) throws Exception {
		
		if (type == null || idProject == -1) { throw new DocumentprojectNotFoundException(); }

		Session session = SessionFactoryUtil.getInstance().getCurrentSession();

		Transaction tx		= null;
		Documentproject doc = null;
		
		try {
			tx = session.beginTransaction();
			
			DocumentprojectDAO documentprojectDAO = new DocumentprojectDAO(session);
			
			if (idDocumentProject == -1) {
				doc = new Documentproject();
				doc.setProject(new Project(idProject));
				doc.setType(type);
			}
			else {
				doc = documentprojectDAO.findById(idDocumentProject, false);
			}
			doc.setLink(link);
			
			doc = documentprojectDAO.makePersistent(doc);
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
		return doc;
	}

	/**
	 * Find by type in the project
	 * @param project
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public static Documentproject findByType(Project project,
			String type) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();

		Transaction tx		= null;
		Documentproject doc = null;
		
		try {
			tx = session.beginTransaction();
			
			DocumentprojectDAO documentprojectDAO = new DocumentprojectDAO(session);
			doc = documentprojectDAO.findByType(project,type);
			
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
		return doc;
	}
	
	/**
	 * Find documents by type in the project
	 * @param project
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public static List<Documentproject> findListByType(Project project,
			String type) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();

		Transaction tx		= null;
		List<Documentproject> docs = null;
		
		try {
			tx = session.beginTransaction();
			
			DocumentprojectDAO documentprojectDAO = new DocumentprojectDAO(session);
			docs = documentprojectDAO.findListByType(project,type);
			
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
		return docs;
	}
}

