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

import es.sm2.openppm.dao.MilestoneDAO;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class MilestoneLogic extends AbstractGenericLogic<Milestones, Integer> {

	/**
	 * Return Milestone
	 * @param milestone
	 * @return
	 * @throws Exception 
	 */
	public static Milestones consMilestone(Milestones milestone) throws Exception {
		
		Milestones mileston = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			MilestoneDAO milestoneDAO = new MilestoneDAO(session);
			mileston = milestoneDAO.findMilestone(milestone);

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
		return mileston;
	}
	
	
	/**
	 * Save Milestone
	 * @param milestone
	 * @throws Exception 
	 */
	public static Milestones saveMilestone(Milestones milestone) throws Exception {
		
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			MilestoneDAO milestoneDAO = new MilestoneDAO(session);
			milestone = milestoneDAO.makePersistent(milestone);
			
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
		return milestone;
	}
	
	
	/**
	 *  Return Milestones
	 * @param idProject
	 * @return
	 * @throws Exception 
	 */
	public static List<Milestones> consMilestones(Integer idProject) throws Exception {
		
		List<Milestones> milestones = null;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			MilestoneDAO milestoneDAO = new MilestoneDAO(session);
			if (idProject != -1) {
				milestones = milestoneDAO.findByProject(new Project(idProject));
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
		return milestones;
	}
	
	
	/**
	 * Delete Milestone by id
	 * @param idMilestone
	 * @throws Exception 
	 */
	public static void deleteMilestone (Integer idMilestone) throws Exception {
		
		Milestones milestone = null;
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			if (idMilestone == -1) {
				throw new NoDataFoundException();
			}
			MilestoneDAO milestoneDAO = new MilestoneDAO(session);
			milestone = milestoneDAO.findById(idMilestone, false);
			milestoneDAO.makeTransient(milestone);
			
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
	 * Check Milestone Errors
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static boolean checkMilestones(Project project) throws Exception {
		
		Transaction tx		= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		boolean errors = false;
		try {
			tx = session.beginTransaction();
			
			MilestoneDAO milestoneDAO = new MilestoneDAO(session);
			List <Milestones> milestones = milestoneDAO.findMilestoneWithoutActivity(project);
			
			if (!milestones.isEmpty()) {
				errors = true;
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
		return errors;
	}


	/**
	 * Find milestone for notify
	 * @return
	 * @throws Exception 
	 */
	public static List<Milestones> findForNotify() throws Exception {
		List<Milestones> milestones = null;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			MilestoneDAO milestoneDAO = new MilestoneDAO(session);
			milestones = milestoneDAO.findForNotify();
			
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
		return milestones;
	}
	
	
}
