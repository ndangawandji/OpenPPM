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
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Project;



/**
 * DAO object for domain model class Documentproject
 * @see es.sm2.openppm.dao.Documentproject
 * @author Hibernate Generator by Javier Hernandez
 */
public class DocumentprojectDAO extends AbstractGenericHibernateDAO<Documentproject, Integer> {


	public DocumentprojectDAO(Session session) {
		super(session);
	}

	/**
	 * Find by type in the project
	 * @param project
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Documentproject findByType(Project project, String type) {
		
		List<Documentproject> list = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Documentproject.PROJECT, project))
			.add(Restrictions.eq(Documentproject.TYPE, type));
		
		list = crit.list();
		return (list != null && !list.isEmpty()?list.get(0):null);
	}
	
	/**
	 * Find documents by type in the project
	 * @param project
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Documentproject> findListByType(Project project, String type) {
		
		List<Documentproject> list = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Documentproject.PROJECT, project))			
			.add(Restrictions.isNotNull(Documentproject.MIME));
		
		if(type != null) {
			crit.add(Restrictions.eq(Documentproject.TYPE, type));
		}
		
		crit.addOrder(Order.asc(Documentproject.TYPE));
		
		list = crit.list();
		return list;
	}
}

