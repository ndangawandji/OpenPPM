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
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.utils.DateUtil;

public class ProjectFollowupDAO extends AbstractGenericHibernateDAO<Projectfollowup, Integer> {

	public ProjectFollowupDAO(Session session) {
		super(session);
	}

	/**
	 * Return Project Followups
	 * @param proj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Projectfollowup> findByProject(Project proj, String order) {
		List<Projectfollowup> followups = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass())
				.setFetchMode(Projectfollowup.PROJECT, FetchMode.JOIN);
			
			crit.add(Restrictions.eq("project.idProject", proj.getIdProject()));
			if(order.equals(Constants.ASCENDENT)) {
				crit.addOrder(Order.asc("followupDate"));	
			}
			else if(order.equals(Constants.DESCENDENT)) {
				crit.addOrder(Order.desc("followupDate"));
			}
			
			followups = crit.list();
		}
		return followups;
	}
	
	
	/**
	 * Return Last Projectfollowup with general flag
	 * @param proj
	 * @return
	 */
	public Projectfollowup findLastByProject(Project proj) {
		Projectfollowup followup = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass())
				.add(Restrictions.eq(Projectfollowup.PROJECT, proj))
				.add(Restrictions.isNotNull(Projectfollowup.GENERALFLAG))
				.addOrder(Order.desc(Projectfollowup.FOLLOWUPDATE))
				.setMaxResults(1);
			
			followup = (Projectfollowup) crit.uniqueResult();
		}
		return followup;
	}
	
	
	/**
	 * Return Last Followup
	 * @param proj
	 * @return
	 */
	public Projectfollowup findLast(Project proj) {
		Projectfollowup followup = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass())
				.add(Restrictions.eq(Projectfollowup.PROJECT, proj))
				.add(Restrictions.isNotNull(Projectfollowup.PV))
				.addOrder(Order.desc(Projectfollowup.FOLLOWUPDATE))
				.setMaxResults(1);
			
			followup = (Projectfollowup) crit.uniqueResult();
		}
		return followup;
	}
	
	
	/**
	 * Return Last Projectfollowup with AC
	 * @param proj
	 * @return
	 */
	public Projectfollowup findLastByProjectWithAC(Project proj) {
		Projectfollowup followup = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass())
				.add(Restrictions.eq(Projectfollowup.PROJECT, proj))
				.add(Restrictions.isNotNull(Projectfollowup.AC))
				.addOrder(Order.desc(Projectfollowup.FOLLOWUPDATE))
				.setMaxResults(1);
			
			followup = (Projectfollowup) crit.uniqueResult();
		}
		return followup;
	}
	
	/**
	 * Return Last Projectfollowup with risk flag
	 * @param proj
	 * @return
	 */
	public Projectfollowup findLastByProjectRisk(Project proj) {
		Projectfollowup followup = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass())
				.add(Restrictions.eq(Projectfollowup.PROJECT, proj))
				.add(Restrictions.isNotNull(Projectfollowup.RISKFLAG))
				.addOrder(Order.desc(Projectfollowup.FOLLOWUPDATE))
				.setMaxResults(1);
			
			followup = (Projectfollowup) crit.uniqueResult();
		}
		return followup;
	}
	
	
	public Projectfollowup findLastWithDataByProject(Project proj) {
		Projectfollowup followup = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.add(Restrictions.eq("project.idProject", proj.getIdProject()))
				.add(Restrictions.disjunction()
					.add(Restrictions.isNotNull("generalFlag"))
					.add(Restrictions.isNotNull("riskFlag"))
					.add(Restrictions.isNotNull("costFlag"))
					.add(Restrictions.isNotNull("scheduleFlag"))
				)
				.addOrder(Order.desc("followupDate"))
				.setMaxResults(1);
				
			followup = (Projectfollowup) crit.uniqueResult();
		}
		return followup;
	}

	
	/**
	 * Get EV from program projects until a date
	 * @param program
	 * @param tempDate
	 * @return
	 */
	public Double getProgramEV(Program program, Date date) {
		Double ev = 0D;
		
		if (program != null) {
			ProjectDAO projectDAO = new ProjectDAO(getSession());
			List<Project> projects = projectDAO.findByProgram(program);
			
			for (Project p : projects) {
				Criteria crit = getSession().createCriteria(getPersistentClass());
				crit.add(Restrictions.eq("project.idProject", p.getIdProject()));
				crit.add(Restrictions.lt("followupDate", date));
				crit.add(Restrictions.isNotNull("ev"));
				crit.addOrder(Order.desc("followupDate"));
				crit.setMaxResults(1);
				
				Projectfollowup followup = (Projectfollowup) crit.uniqueResult();
				if (followup != null) {
					ev += followup.getEv();
				}
			}
		}
		
		return ev;
	}

	
	/**
	 * Consult backlog for a program in a month
	 * CurrentMonth is for calculate number of months of a project to end
	 * @param program
	 * @param date
	 * @return
	 */
	public Double getProgramBacklog(Program program, Date date, Date currentMonth) {
		Double backlog = 0D;
		
		if (program != null) {
			ProjectDAO projectDAO = new ProjectDAO(getSession());
			List<Project> projects = projectDAO.findByProgram(program);
			
			for (Project p : projects) {
				if (p.getPlannedFinishDate() != null && p.getPlannedFinishDate().after(date)) {
					Integer months = DateUtil.monthsBetween(currentMonth, p.getPlannedFinishDate());
					if (months <= 0) months = 1;
					
					Criteria crit = getSession().createCriteria(getPersistentClass());
					crit.add(Restrictions.eq("project.idProject", p.getIdProject()));
					crit.add(Restrictions.lt("followupDate", date));
					crit.add(Restrictions.isNotNull("ev"));
					crit.addOrder(Order.desc("followupDate"));
					crit.setMaxResults(1);
					
					Projectfollowup followup = (Projectfollowup) crit.uniqueResult();
					
					if (followup != null) {
						//Extra is project pending incomes divided by months pending to close project
						double netIncome = (p.getNetIncome() == null?0:p.getNetIncome());
						backlog += (netIncome-followup.getEv())/months;
					}
				}
			}
		}
		
		return backlog;
	}

	/**
	 * Delete all project followup by project 
	 * @param project
	 */
	public void deleteByProject(Project project) {
		
		Query query = getSession().createQuery(
				"delete from Projectfollowup as fo " +
				"where fo.project.idProject = :idProject "
			);
		query.setInteger("idProject", project.getIdProject());
		query.executeUpdate();
	}

	/**
	 * Cons followup with project
	 * @param projectfollowup
	 * @return
	 */
	public Projectfollowup consFollowupWithProject(
			Projectfollowup projectfollowup) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setFetchMode(Projectfollowup.PROJECT, FetchMode.JOIN)
			.add(Restrictions.idEq(projectfollowup.getIdProjectFollowup()));
		
		return (Projectfollowup) crit.uniqueResult();
	}

	/**
	 * Find last followup of month
	 * @param project
	 * @param firstMonthDay
	 * @param lastMonthDay
	 * @return
	 */
	public Projectfollowup findLasInMonth(Project project, Date firstMonthDay,
			Date lastMonthDay) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Projectfollowup.PROJECT, project))
			.add(Restrictions.between(Projectfollowup.FOLLOWUPDATE, firstMonthDay, lastMonthDay))
			.add(Restrictions.isNotNull(Projectfollowup.PV))
			.setMaxResults(1)
			.addOrder(Order.desc(Projectfollowup.FOLLOWUPDATE));
		
		return (Projectfollowup) crit.uniqueResult();
	}
	
}
