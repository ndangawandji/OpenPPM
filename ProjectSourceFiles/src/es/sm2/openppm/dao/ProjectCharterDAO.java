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
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcharter;

public class ProjectCharterDAO extends AbstractGenericHibernateDAO<Projectcharter, Integer> {

	public ProjectCharterDAO(Session session) {
		super(session);
	}
	
	@SuppressWarnings("rawtypes")
	public Projectcharter findByProject(Project proj) {
		Projectcharter projCharter = null;
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.add(Restrictions.eq("project.idProject", proj.getIdProject()));
			List listado = crit.list();
			if (listado != null && !listado.isEmpty()) {
				projCharter = (Projectcharter) listado.get(0);
			}
		}
		
		return projCharter;
	}

	/**
	 * Delete all project charters
	 * @param project
	 */
	public void deleteByProject(Project project) {

		Query q = getSession().createQuery(
				"delete from Projectcharter as p "+ 
				"where p.project.idProject = :idProject"
			);
		
		q.setInteger("idProject", project.getIdProject());
		q.executeUpdate();
	}
	
	
}
