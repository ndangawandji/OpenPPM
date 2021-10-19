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
package es.sm2.openppm.dao;

import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Activityseller;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.model.Timesheet;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.StringPool;

public class ProjectActivityDAO extends AbstractGenericHibernateDAO<Projectactivity, Integer> {

	public ProjectActivityDAO(Session session) {
		super(session);
	}

	/**
	 * List of activities by project
	 * @param proj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Projectactivity> findByProject(Project proj, List<String> joins) {
		List<Projectactivity> listado = null;
		if (proj != null) {
			
			Criteria crit = getSession().createCriteria(getPersistentClass())
				.add(Restrictions.eq(Projectactivity.PROJECT, proj));
			
			if (joins != null) {
				
				for (String join : joins) {
			
					crit.setFetchMode(join, FetchMode.JOIN);
				}
			}
		
			listado = crit.list();
		}
		return listado;
	}
	
	
	/**
	 * 
	 * @param proj
	 * @param idWBSnode
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Projectactivity findByWBSnode(Project proj,Integer idWBSnode) {
		
		List<Projectactivity> listActivity = null;
		Projectactivity projAct = null;
		
		if (proj != null) {
			Query query = getSession().createQuery(
					"select activity " +
					"from Projectactivity as activity " + 
					"join activity.project as project " +
					"where project.idProject = :idProject and activity.wbsnode.idWbsnode = :idWBSnode");
			query.setInteger("idProject", proj.getIdProject());
			query.setInteger("idWBSnode", idWBSnode);
			
			listActivity = query.list();
			
			if (!listActivity.isEmpty()) {
				projAct = listActivity.get(0);
			}
		}
		return projAct;
	}
	
	/**
	 * Checks whether an activity with a start date is imputed hours than
	 * @param project
	 * @param activity
	 * @return
	 */
	public boolean checkAfterActivityInputed(Projectactivity activity) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.idEq(activity.getIdActivity()))
			.createCriteria(Projectactivity.TIMESHEETS)
			.add(Restrictions.disjunction()
					.add(Restrictions.ne(Timesheet.HOURSDAY1, 0D))
					.add(Restrictions.ne(Timesheet.HOURSDAY2, 0D))
					.add(Restrictions.ne(Timesheet.HOURSDAY3, 0D))
					.add(Restrictions.ne(Timesheet.HOURSDAY4, 0D))
					.add(Restrictions.ne(Timesheet.HOURSDAY5, 0D))
					.add(Restrictions.ne(Timesheet.HOURSDAY6, 0D))
					.add(Restrictions.ne(Timesheet.HOURSDAY7, 0D))
					)
			.add(Restrictions.le(Timesheet.ENDDATE, activity.getPlanInitDate()));
		
		return ((Integer)crit.uniqueResult() > 0);
	}

	
	/**
	 * Get total EV from project current/realized activities
	 * @param idProject
	 * @return EV
	 */
	public double consCurrentProjectEV(Integer idProject) {
		
		double ev = 0;
		
		Query query = getSession().createQuery(
				"select sum(a.ev) " +
				"from Projectactivity as a " +
				"join a.project as p " +
				"where p.idProject=:idProject and a.actualInitDate<=current_date()");
		query.setInteger("idProject", idProject);
		
		if (query.uniqueResult() != null) {
			ev = (Double) query.uniqueResult();
		}
		return ev;
	}
	
	/**
	 * Get root activity of project
	 * @param proj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Projectactivity consRootActivity(Project proj) {
		
		List<Projectactivity> activities = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Projectactivity.PROJECT, proj));
		
		crit.createCriteria(Projectactivity.WBSNODE)
			.add(Restrictions.isNull(Wbsnode.WBSNODE));
		
		activities = crit.list();
		
		Projectactivity rootActivity = (activities != null && !activities.isEmpty()?activities.get(0):null);
		
		// Create Root Activity if not exist
		if (rootActivity == null) {
			
			Wbsnode wbsRoot = null;
			
			crit = getSession().createCriteria(Wbsnode.class)
				.add(Restrictions.isNull(Wbsnode.WBSNODE))
				.addOrder(Order.asc(Wbsnode.CODE))
				.add(Restrictions.eq(Wbsnode.PROJECT, proj));	
			
			List<Wbsnode> list = crit.list();
			if (!list.isEmpty()) { wbsRoot = list.get(0); }
			
			if (wbsRoot == null) {
				
				crit = getSession().createCriteria(Wbsnode.class)
					.setProjection(Projections.rowCount())
					.add(Restrictions.eq(Wbsnode.PROJECT, proj));
				
				if ((Integer)crit.uniqueResult() == 0) {
					
					WBSNodeDAO nodeDAO = new WBSNodeDAO(getSession());
					wbsRoot = new Wbsnode();
					wbsRoot.setProject(proj);
					wbsRoot.setIsControlAccount(true);
					wbsRoot.setName(proj.getProjectName());
					
					wbsRoot = nodeDAO.makePersistent(wbsRoot);
				}
			}
			
			if (wbsRoot != null) {
				
				rootActivity = new Projectactivity();
				rootActivity.setProject(proj);
				rootActivity.setWbsnode(wbsRoot);
				rootActivity.setWbsdictionary(StringPool.BLANK);
			
				if (wbsRoot.getCode() != null && !StringPool.BLANK.equals(wbsRoot.getCode())) {
					rootActivity.setActivityName(wbsRoot.getCode()+". "+wbsRoot.getName());
				}
				else {
					rootActivity.setActivityName(wbsRoot.getName());
				}
				rootActivity = makePersistent(rootActivity);
				
				updatePlannedDates(proj, rootActivity);
				updateActualDates(proj, rootActivity);
				
				rootActivity = findById(rootActivity.getIdActivity());
			}
		}
		
		return rootActivity;
	}
	
	/**
	 * Filter by project and since until over planned dates
	 * @param project
	 * @param since
	 * @param until
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Projectactivity> findByProject(Project project, Date since,
			Date until) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.disjunction()
						.add(Restrictions.between(Projectactivity.PLANINITDATE, since, until))
						.add(Restrictions.between(Projectactivity.PLANENDDATE, since, until))
						.add(Restrictions.and(
								Restrictions.le(Projectactivity.PLANINITDATE, since),
								Restrictions.ge(Projectactivity.PLANENDDATE, until)
							)
						)
				)
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		return crit.list();
	}
	

	/**
	 * Update Planned Dates of root activity
	 * @param project
	 * @param rootActivity
	 */
	public void updatePlannedDates(Project project, Projectactivity rootActivity) {
		
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
		.setProjection(Projections.projectionList()
				.add(Projections.min(Projectactivity.PLANINITDATE))
				.add(Projections.max(Projectactivity.PLANENDDATE)))
		.add(Restrictions.ne(Projectactivity.IDACTIVITY, rootActivity.getIdActivity()))		
		.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		Object[] row = (Object[]) crit.uniqueResult();
		
		if (row != null && row.length > 0) {
			
			Date planInitDate = (Date)row[0];
			Date planEndDate = (Date)row[1];
			
			rootActivity.setPlanInitDate(planInitDate);
			rootActivity.setPlanEndDate(planEndDate);
			makePersistent(rootActivity);
		}
	}
	
	/**
	 * Update Actual Dates of root activity
	 * @param project
	 * @param rootActivity
	 */
	public void updateActualDates(Project project, Projectactivity rootActivity) {
		
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
		.setProjection(Projections.projectionList()
				.add(Projections.min(Projectactivity.ACTUALINITDATE))
				.add(Projections.max(Projectactivity.ACTUALENDDATE))
			)
		.add(Restrictions.ne(Projectactivity.IDACTIVITY, rootActivity.getIdActivity()))		
		.add(Restrictions.eq(Projectactivity.PROJECT, project));
	
		Object[] row = (Object[]) crit.uniqueResult();
		
		if (row != null && row.length > 0) {
			
			Date actInitDate = (Date)row[0];
			Date actEndDate = (Date)row[1];
			
			rootActivity.setActualInitDate(actInitDate);
			rootActivity.setActualEndDate(actEndDate);
			makePersistent(rootActivity);
		}
	}
	
	/**
	 * List not assigned activities to seller
	 * 
	 * @param seller
	 * @param project
	 * @param order
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> consNoAssignedActivities(Seller seller, Project project, Order... order) {
			
		Criteria usedCrit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.property(Projectactivity.IDACTIVITY))			
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		usedCrit.createCriteria(Projectactivity.ACTIVITYSELLERS)
			.add(Restrictions.eq(Activityseller.SELLER, seller));
		
		List<Projectactivity> lista = usedCrit.list();
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.projectionList()
				.add(Projections.property(Projectactivity.IDACTIVITY))
				.add(Projections.property(Projectactivity.ACTIVITYNAME)))
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		crit.createCriteria(Projectactivity.WBSNODE)
			.add(Restrictions.eq(Wbsnode.ISCONTROLACCOUNT, true));
		
		if (!lista.isEmpty()) {
			crit.add(Restrictions.not(Restrictions.in(Projectactivity.IDACTIVITY, lista)));	
		}

		for (Order o : order) {
			crit.addOrder(o);
		}
		
		return crit.list();
	}
	
	/**
	 * Sum EV
	 * @param proj
	 * @return
	 */
	public double sumEV(Project proj) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.sum(Projectactivity.EV))
			.add(Restrictions.eq(Projectactivity.PROJECT, proj));
		
		crit.createCriteria(Projectactivity.WBSNODE)
			.add(Restrictions.eq(Wbsnode.ISCONTROLACCOUNT, true));
		
		Double value = (Double) crit.uniqueResult();
		return (value == null?0:value);
	}

	public double clacPocBySum(Project project) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Projectactivity.PROJECT, project))
			.setProjection(Projections.projectionList()
					.add(Projections.sum(Projectactivity.POC))
					.add(Projections.rowCount()));
		
		crit.createCriteria(Projectactivity.WBSNODE)
			.add(Restrictions.eq(Wbsnode.ISCONTROLACCOUNT, true));
		
		Object[] value = (Object[]) crit.uniqueResult();
		
		double poc = 0;
		
		if (value != null && value.length == 2) {
			double sumPoc	= (Double)value[0] == null?0:(Double)value[0];
			int rows		= (Integer)value[1];
			
			if (rows > 0) { poc = sumPoc / new Double(rows); }
		}
		
		return poc;
	}

	public Double calcPoc(Projectactivity projectactivity) {
		
		WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(getSession());
		
		Project project = projectactivity.getProject();
		
		Double poc = null;
		
		if (!wbsNodeDAO.isBudgetEmpty(project)) {
			double ev		= sumEV(project);
			double budget	= wbsNodeDAO.getSumBudget(project);
			
			if (budget > 0) { poc = (ev/budget)*100; }
		}
		else {
			poc = clacPocBySum(project);
		}
		return poc;
	}

	@SuppressWarnings("unchecked")
	public Projectactivity findByRedMine(String accountingCode, String wbsnodeCode) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		
		crit.createCriteria(Projectactivity.PROJECT)
			.add(Restrictions.eq(Project.ACCOUNTINGCODE, accountingCode));
		
		crit.createCriteria(Projectactivity.WBSNODE)
			.add(Restrictions.eq(Wbsnode.CODE, wbsnodeCode));
		
		List<Projectactivity> list = crit.list();
		
		return (list.isEmpty()?null:list.get(0));
	}
}
