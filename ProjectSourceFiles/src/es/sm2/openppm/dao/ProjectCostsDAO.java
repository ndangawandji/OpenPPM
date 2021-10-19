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

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcosts;

public class ProjectCostsDAO extends AbstractGenericHibernateDAO<Projectcosts, Integer> {

	public ProjectCostsDAO(Session session) {
		super(session);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Projectcosts> searchByExample(Projectcosts exampleInstance,
			Class... joins) {
		List<Projectcosts> costs = null;
		if (exampleInstance != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.add(Restrictions.eq("project", exampleInstance.getProject()));
			if (exampleInstance.getCostDate() != null) {
				crit.add(Restrictions.eq("costDate", exampleInstance.getCostDate()));
			}
			costs = crit.list();
		}
		return costs;
	}
	
	/**
	 * Return Project costs
	 * @param proj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Projectcosts> findByProject(Project proj) {
		List<Projectcosts> costs = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.setFetchMode("directcostses", FetchMode.JOIN);
			crit.setFetchMode("directcostses.budgetaccounts", FetchMode.JOIN);
			crit.setFetchMode("expenseses", FetchMode.JOIN);
			crit.setFetchMode("expenseses.budgetaccounts", FetchMode.JOIN);			
			crit.add(Restrictions.eq("project", proj));
			crit.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
			costs = crit.list();
		}
		return costs;
	}

	
	/**
	 * Return Project direct costs
	 * @param proj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Projectcosts> findDirectCostsByProject(Project proj) {
		List<Projectcosts> costs = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.setFetchMode("directcostses", FetchMode.JOIN);
			crit.setFetchMode("directcostses.budgetaccounts", FetchMode.JOIN);
			crit.add(Restrictions.eq("project", proj));
			crit.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
			costs = crit.list();
		}
		return costs;
	}
	

	/**
	 * Save project costs and return it for a given date and project 
	 * @param projectCost
	 * @return
	 */
	public Projectcosts saveProjectCost(Projectcosts projectCost) {
		List<Projectcosts> listCosts = this.searchByExample(projectCost);

		if (listCosts == null || listCosts.isEmpty()) {
			this.makePersistent(projectCost);
			listCosts = this.searchByExample(projectCost);
		}
		
		return listCosts.get(0);
	}
	
	/**
	 * Delete all costs
	 * @param project
	 */
	public void deleteByProject(Project project) {

		Query q = getSession().createQuery(
				"delete from Projectcosts as p "+ 
				"where p.project.idProject = :idProject"
			);
		
		q.setInteger("idProject", project.getIdProject());
		q.executeUpdate();
	}
	
}
