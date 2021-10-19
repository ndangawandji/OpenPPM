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
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Metrickpi;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectkpi;

public class ProjectKpiDAO extends AbstractGenericHibernateDAO<Projectkpi, Integer> {

	public ProjectKpiDAO(Session session) {
		super(session);
	}
	
	public double getTotalWeight(Project project) {
		double total = 0;
		
		if (project != null) {
			Query q = getSession().createQuery(
					"select sum(kpi.weight) " +
					"from Projectkpi as kpi " + 
					"join kpi.project as project " +
					"where project.idProject = :idProject");
			q.setInteger("idProject", project.getIdProject());
			
			if (q.uniqueResult() != null) {
				total = (Long) q.uniqueResult(); 
			}
			else {
				// Not KPI setted
				total = 100; 
			}
		}
			
		return total;
	}

	
	/**
	 * Score = sum (kpi.weight * (kpi.adjustedValue/100))
	 * adjustedValue = 
	 * @param project
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Double calcScore(Project project) {
		Double score = null;
		
		if (project != null) {
			Query q = getSession().createQuery(
					"select kpi " +
					"from Projectkpi as kpi " + 
					"where project.idProject = :idProject"
					);
			q.setInteger("idProject", project.getIdProject());
			
			List<Projectkpi> kpis = q.list();
			if (!kpis.isEmpty()) {
				score = 0D;
				for (Projectkpi kpi : kpis) {
					Double kpiScore = new Double(kpi.getWeight() * (new Double(kpi.getAdjustedValue())/100));
					score += kpiScore;
				}
			}
		}
		
		return score;
	}

	/**
	 * Check if metric is assigned in other project KPI
	 * @param project
	 * @param idProjectKPI
	 * @param metrickpi
	 * @return
	 */
	public boolean metricExist(Project project, int idProjectKPI, Metrickpi metrickpi) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Projectkpi.PROJECT, project))
			.add(Restrictions.eq(Projectkpi.METRICKPI, metrickpi));
		
		if (idProjectKPI != -1) {
			crit.add(Restrictions.ne(Projectkpi.IDPROJECTKPI, idProjectKPI));
		}
		Integer count = (Integer) crit.uniqueResult();
		
		return (count != null && count > 0);
	}

}
