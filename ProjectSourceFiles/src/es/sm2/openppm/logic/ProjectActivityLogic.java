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
import org.hibernate.criterion.Order;

import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.dao.ProjectActivityDAODVT;
import es.sm2.openppm.exceptions.ImputedHoursException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.exceptions.PlannedDateEndBeforeInitException;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ProjectActivityLogic extends AbstractGenericLogic<Projectactivity, Integer> {
	/**
	 * Determiner si il ya une assignation pour cette activité
	 * @param activity
	 * @return boolean
	 * @throws Exception 
	 * 
	 * Create : Devoteam XAvier de langautier 2015/06/14 user story 15
	 */
	
	public static boolean checkIfActivityInputed (Projectactivity activity) throws Exception {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		boolean existingHours;
		try {
			ProjectActivityDAODVT activityDAO 	= new ProjectActivityDAODVT(session);
			tx = session.beginTransaction();
			existingHours = activityDAO.checkIfActivityInputed(activity);
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
		return existingHours;
	}
	/**
	 * Save activity. If project status is P, actual dates are updated with planned dates.
	 * @param activity
	 * @param projectStatus
	 * @param project 
	 * @throws Exception 
	 */
	public static void savePlanActivity (Projectactivity activity) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectActivityDAO activityDAO 	= new ProjectActivityDAO(session);
			
			Project project = activity.getProject();
			
			if (activity.getIdActivity() == -1) {
				throw new NoDataFoundException();
			}
			if (activity.getPlanEndDate() != null && activity.getPlanInitDate() != null
					&& activity.getPlanEndDate().before(activity.getPlanInitDate())) {
				throw new PlannedDateEndBeforeInitException();
			}
			if (project == null) {
				throw new ProjectNotFoundException();
			}

			if (activityDAO.checkAfterActivityInputed(activity)) {
				// Se han inputado horas en una actividad distinta anterior a la modificada, 
				//por lo que no se puede imputar horas a dÃ­as con las horas ya asignadas
				throw new ImputedHoursException();
			}

			activity = activityDAO.makePersistent(activity);
			
			if (activity.getPoc() != null && activity.getPoc() >= 100 && activity.getActualEndDate() != null) {
				activity.setPlanEndDate(activity.getActualEndDate());
				activity = activityDAO.makePersistent(activity);
			}
			
			Projectactivity rootActivity = activityDAO.consRootActivity(project);
			
			if (activity.getIdActivity() != rootActivity.getIdActivity()) {
				activityDAO.updatePlannedDates(project, rootActivity);
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
	 * Save scope control activity, only save Status Date and EV 
	 * @param activity
	 * @throws Exception 
	 */
	public static void saveScopeControlActivity (Projectactivity activity) throws Exception {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectActivityDAO activityDAO 	= new ProjectActivityDAO(session);
			
			activityDAO.makePersistent(activity);
			
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
	 * Save control activity, only save EV
	 * @param activity
	 * @throws Exception 
	 */
	public static void saveControlActivity (Project project, Projectactivity activity) throws Exception {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectActivityDAO activityDAO 	= new ProjectActivityDAO(session);
			
			activity = activityDAO.makePersistent(activity);
			
			Projectactivity rootActivity = activityDAO.consRootActivity(project);
			
			if (!activity.equals(rootActivity)) {
				activityDAO.updateActualDates(project, rootActivity);
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
	 * Return project activity by id
	 * @param idActivity
	 * @return
	 * @throws Exception 
	 */
	public static Projectactivity consActivity (Integer idActivity) throws Exception {
		
		Projectactivity activity = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectActivityDAO activitiesDAO = new ProjectActivityDAO(session);
			
			if (idActivity != -1) {
				activity =  activitiesDAO.findById(idActivity, false);
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
		return activity;
	}
	
	
	/**
	 * Search activitys by project
	 * @param proj
	 * @return
	 * @throws Exception 
	 */
	public static List<Projectactivity> consActivities(Project proj, List<String> joins) throws Exception {
		
		List<Projectactivity> listActivitys = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			listActivitys = activityDAO.findByProject(proj, joins);
			
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
		return listActivitys;
	}
	
	
	/**
	 * Cons Root Activity By Project
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	public static Projectactivity consRootActivity(Project proj) throws Exception {
		
		Projectactivity activity = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			activity = activityDAO.consRootActivity(proj);
			
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
		return activity;
	}
	
	/**
	 * List not assigned activities to seller
	 * 	
	 * @param seller
	 * @param project
	 * @param order
	 * @return
	 * @throws Exception
	 */
	public static List<Object[]> consNoAssignedActivities(Seller seller, Project project, Order... order) throws Exception {
		
		List<Object[]> listActivitys = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			listActivitys = activityDAO.consNoAssignedActivities(seller, project, order);
			
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
		return listActivitys;
	}

	public static Double calcPoc(Projectactivity projectactivity) throws Exception {
		
		Double poc = null;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
			
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			
			poc = activityDAO.calcPoc(projectactivity);
			
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
		return poc;
	}

	/**
	 * Find By Redmine
	 * @param accountingCode
	 * @param wbsnodeCode
	 * @return
	 * @throws Exception 
	 */
	public Projectactivity findByRedMine(String accountingCode,
			String wbsnodeCode) throws Exception {
		
		Projectactivity activity = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			activity = activityDAO.findByRedMine(accountingCode, wbsnodeCode);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		return activity;
	}


	/**
	 * Update Actual Dates of root activity
	 * @param project
	 * @param rootActivity
	 * @throws Exception 
	 */
	public void updateActualDates(Project project, Projectactivity rootActivity) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			activityDAO.updateActualDates(project, rootActivity);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
	}

}
