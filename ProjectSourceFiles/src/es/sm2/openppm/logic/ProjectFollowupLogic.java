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

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.ProjectFollowupDAO;
import es.sm2.openppm.exceptions.FollowupNotFoundException;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ProjectFollowupLogic extends AbstractGenericLogic<Projectfollowup, Integer> {

		
	/**
	 * Return Project followup
	 * @param idFollowup
	 * @return
	 * @throws Exception 
	 */
	public static Projectfollowup consFollowup (Integer idFollowup) throws Exception {
		
		Projectfollowup followup = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			if (idFollowup != -1) {
				followup = followupDAO.findById(idFollowup, false);
				followup.getProject();
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
		return followup;
	}	
	
	
	/**
	 * Find last followup with general flag
	 * @param project
	 * @return
	 * @throws Exception
	 */
	public static Projectfollowup findLastByProject(Project project) throws Exception {
		
		Projectfollowup followup = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			followup = followupDAO.findLastByProject(project);
			
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
		return followup;
	}	
	
	
	/**
	 * Find last followup
	 * @param project
	 * @return
	 * @throws Exception
	 */
	public Projectfollowup findLast(Project project) throws Exception {
		
		Projectfollowup followup = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			followup = followupDAO.findLast(project);
			
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
		return followup;
	}
	
	
	/**
	 * Find last followup with AC
	 * @param project
	 * @return
	 * @throws Exception
	 */
	public Projectfollowup findLastByProjectWithAC(Project project) throws Exception {
		
		Projectfollowup followup = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			followup = followupDAO.findLastByProjectWithAC(project);
			
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
		return followup;
	}	
	
	
	/**
	 * Find last followup
	 * @param project
	 * @return
	 * @throws Exception
	 */
	public static Projectfollowup findLastWithDataByProject(Project project) throws Exception {
		
		Projectfollowup followup = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			followup = followupDAO.findLastWithDataByProject(project);
			
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
		return followup;
	}
	
	
	/**
	 * List of project followups
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<Projectfollowup> consFollowups (Project project) throws Exception {
		
		List<Projectfollowup> followups = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			followups = followupDAO.findByProject(project, Constants.ASCENDENT);
			
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
		return followups;
	}
	
	
	/**
	 * Save Project followup
	 * @param followup
	 * @throws Exception 
	 */
	public static void saveFollowup (Projectfollowup followup) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			followupDAO.makePersistent(followup);
			
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
	 * Delete Followup by id
	 * @param idFollowup
	 * @throws Exception 
	 */
	public static void deleteFollowup (Integer idFollowup) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			if (idFollowup == -1) {
				throw new FollowupNotFoundException();
			}
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			Projectfollowup followup = followupDAO.findById(idFollowup, false);
			if (followup != null) {
				followupDAO.makeTransient(followup);
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

	public static Projectfollowup consFollowupWithProject(Projectfollowup projectfollowup) throws Exception {
		
		Projectfollowup followup = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			followup = followupDAO.consFollowupWithProject(projectfollowup);
			
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
		return followup;
	}

	
	/**
	 * Find last followup of month
	 * @param project
	 * @param since
	 * @return
	 * @throws Exception 
	 */
	public Projectfollowup findLasInMonth(Project project, Date since) throws Exception {
		
		Projectfollowup followup = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			
			ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
			
			followup = followupDAO.findLasInMonth(
					project,
					DateUtil.getFirstMonthDay(since),
					DateUtil.getLastMonthDay(since));
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return followup;
	}
}
