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

import org.hibernate.Query;
import org.hibernate.Session;

import es.sm2.openppm.model.Iwo;
import es.sm2.openppm.model.Project;

public class IwosDAO extends AbstractGenericHibernateDAO<Iwo, Integer> {

	public IwosDAO(Session session) {
		super(session);
	}

	/**
	 * Return Project iwos
	 * @param proj
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Iwo> findByProject(Project proj) {
		List<Iwo> iwos = null;
		if (proj != null) {
			Query query = getSession().createQuery(
					"select iwos " +
					"from Iwo as iwos " + 
					"join fetch iwos.projectcosts as costs " +
					"join costs.project as project " +
					"where project.idProject = :idProject");
			query.setInteger("idProject", proj.getIdProject());
			iwos = query.list();
		}
		return iwos;
	}
	
	/**
	 * Return total Iwos cost of project
	 * @param proj
	 * @return
	 */
	public double getTotal(Project proj) {
		double total = 0;
		if (proj != null) {
			Query query = getSession().createQuery(
					"select sum(iwos.planned) as total " +
					"from Iwo as iwos " + 
					"join iwos.projectcosts as costs " +
					"join costs.project as project " +
					"where project.idProject = :idProject");
			query.setInteger("idProject", proj.getIdProject());
			if (query.uniqueResult() != null) {
				total = (Double) query.uniqueResult(); 
			}
		}
		return  total;
	}
	
	
	/**
	 * Return actual total Iwos cost of project to control it
	 * @param proj
	 * @return
	 */
	public double getActualTotal(Project proj) {
		double total = 0;
		if (proj != null) {
			Query query = getSession().createQuery(
					"select sum(iwos.actual) as total " +
					"from Iwo as iwos " + 
					"join iwos.projectcosts as costs " +
					"join costs.project as project " +
					"where project.idProject = :idProject");
			query.setInteger("idProject", proj.getIdProject());
			if (query.uniqueResult() != null) {
				total = (Double) query.uniqueResult(); 
			}
		}
		return  total;
	}

}
