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

import java.util.Calendar;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.DateUtil;

public class MilestoneDAO extends AbstractGenericHibernateDAO<Milestones, Integer> {

	public MilestoneDAO(Session session) {
		super(session);
	}

	/**
	 * Return all milestones by Project
	 * @param proj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Milestones> findByProject(Project proj) {
		List<Milestones> listado = null;
		if (proj != null) {
			Query query = getSession().createQuery(
					"select milestones " +
					"from Milestones as milestones " + 
					"left join fetch milestones.projectactivity as activity " +
					"join milestones.project as project " +
					"where project.idProject = :idProject");
			query.setInteger("idProject", proj.getIdProject());
			listado = query.list();
		}
		return listado;
	}

	
	/**
	 * Find Milestone with Project Activity
	 * @param milestone
	 * @return
	 */
	public Milestones findMilestone(Milestones milestone) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.setFetchMode("projectactivity", FetchMode.JOIN);
		crit.add(Restrictions.eq("idMilestone", milestone.getIdMilestone()));
		
		return (Milestones) crit.uniqueResult();
	}


	/**
	 * Return Milestones without activity
	 * @param project
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Milestones> findMilestoneWithoutActivity(Project project) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.add(Restrictions.isNull("projectactivity.idActivity"));
		crit.add(Restrictions.eq("project.idProject", project.getIdProject()));
		return crit.list();
	}

	/**
	 * Delete all milestones by project
	 * @param project
	 */
	public void deleteByProject(Project project) {

		Query q = getSession().createQuery(
				"delete from Milestones as m "+ 
				"where m.project.idProject = :idProject"
			);
		
		q.setInteger("idProject", project.getIdProject());
		q.executeUpdate();
	}

	/**
	 * Find milestones for notify
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Milestones> findForNotify() {
		
		Calendar now = DateUtil.getCalendar();
		now.set(Calendar.HOUR, 0);
		now.set(Calendar.MINUTE, 0);
		now.set(Calendar.SECOND, 0);
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Milestones.NOTIFY, true))
			.add(Restrictions.eq(Milestones.NOTIFYDATE, now.getTime()))
			.setFetchMode(Milestones.PROJECT, FetchMode.JOIN)
			.setFetchMode(Milestones.PROJECT+"."+Project.EMPLOYEEBYPROJECTMANAGER, FetchMode.JOIN)
			.setFetchMode(Milestones.PROJECT+"."+Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT, FetchMode.JOIN);
		
		return crit.list();
	}
	
}
