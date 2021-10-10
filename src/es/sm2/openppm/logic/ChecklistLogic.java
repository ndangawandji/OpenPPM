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

import es.sm2.openppm.dao.ChecklistDAO;
import es.sm2.openppm.exceptions.ChecklistNotFoundException;
import es.sm2.openppm.model.Checklist;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Checklist
 * @see es.sm2.openppm.logic.Checklist
 * @author Hibernate Generator by Javier Hernandez
 */
public final class ChecklistLogic extends AbstractGenericLogic<Checklist, Integer> {

	/**
	 * Create or update Checklist
	 * @param checklist
	 * @throws Exception 
	 */
	public static Checklist saveChecklist(Checklist checklist) throws Exception {
		if (checklist == null) {
			throw new ChecklistNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ChecklistDAO checklistDAO = new ChecklistDAO(session);
			checklist = checklistDAO.makePersistent(checklist);
			
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
		return checklist;
	}
	
	/**
	 * Delete Checklist
	 * @param checklist
	 * @throws Exception 
	 */
	public static void deleteChecklist(Checklist checklist) throws Exception {
		if (checklist == null) {
			throw new ChecklistNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ChecklistDAO checklistDAO = new ChecklistDAO(session);
			
			checklist = checklistDAO.findById(checklist.getIdChecklist(), false);
			checklistDAO.makeTransient(checklist);
			
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
	 * Find by project
	 * @param project
	 * @return
	 * @throws Exception
	 */
	public static List<Checklist> findByProject(Project project) throws Exception {

		List<Checklist> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ChecklistDAO checklistDAO = new ChecklistDAO(session);
			list = checklistDAO.findByProject(project);

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

