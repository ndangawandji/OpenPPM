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
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.IwosDAO;
import es.sm2.openppm.dao.ProjectCostsDAO;
import es.sm2.openppm.exceptions.NoIwoDeleteException;
import es.sm2.openppm.model.Iwo;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class IwosLogic extends AbstractGenericLogic<Iwo, Integer> {

	/**
	 * List iwos of the project
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<Iwo> consIwos (Project project) throws Exception {
		
		List<Iwo> iwos = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			IwosDAO iwosDAO = new IwosDAO(session);
			
			if (project.getIdProject() != -1) {
				iwos = iwosDAO.findByProject(project);
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
		return iwos;
	}
	
	
	/**
	 * Get iwo by id
	 * @param idIwo
	 * @return
	 * @throws Exception 
	 */
	public static Iwo consIwo (Integer idIwo) throws Exception {
		
		Iwo iwo = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			IwosDAO iwosDAO = new IwosDAO(session);
			
			if (idIwo != -1) {
				iwo = iwosDAO.findById(idIwo, false);
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
		return iwo;
	}
	
	
	/**
	 * Save iwo
	 * @param iwo
	 * @param iwoDate 
	 * @throws Exception 
	 */
	public static void saveIwo (Iwo iwo, Date iwoDate) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			IwosDAO iwosDAO = new IwosDAO(session);
			iwo = iwosDAO.makePersistent(iwo);
			
			if (iwoDate != null) {
				
				ProjectCostsDAO projectCostsDAO = new ProjectCostsDAO(session);
				
				Projectcosts projCost = iwo.getProjectcosts();
				projCost.setCostDate(iwoDate);
				
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
	
	
	/**
	 * Delete iwo by id
	 * @param idIwo
	 * @throws Exception 
	 */
	public static void deleteIwo (Integer idIwo) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			if (idIwo == -1) {
				throw new NoIwoDeleteException();
			}
			IwosDAO iwosDAO = new IwosDAO(session);
			Iwo iwo = iwosDAO.findById(idIwo, false);
			if (iwo != null) {
				iwosDAO.makeTransient(iwo);
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
