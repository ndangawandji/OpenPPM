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
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Changecontrol;
import es.sm2.openppm.model.Project;

public class ChangeControlDAO extends AbstractGenericHibernateDAO<Changecontrol, Integer> {

	public ChangeControlDAO(Session session) {
		super(session);
	}
	
	@SuppressWarnings("unchecked")
	public List<Changecontrol> findByProject(Project proj) {
		List<Changecontrol> listado = null;
		
		if (proj != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.setFetchMode("changetype", FetchMode.JOIN);
			crit.setFetchMode("wbsnode", FetchMode.JOIN);
			crit.add(Restrictions.eq("project.idProject", proj.getIdProject()));
			listado = crit.list();
		}
		return listado;
	}
	
	
	/**
	 * Find by Id and return data
	 * @param change
	 * @return
	 */
	public Changecontrol findByIdWithData(Changecontrol change) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.setFetchMode("changetype", FetchMode.JOIN);
		crit.setFetchMode("wbsnode", FetchMode.JOIN);
		crit.add(Restrictions.eq("idChange", change.getIdChange()));
		
		return (Changecontrol) crit.uniqueResult();
	}

}
