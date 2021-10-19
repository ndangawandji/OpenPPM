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

import es.sm2.openppm.model.Checklist;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Wbsnode;



/**
 * DAO object for domain model class Checklist
 * @see es.sm2.openppm.dao.Checklist
 * @author Hibernate Generator by Javier Hernandez
 */
public class ChecklistDAO extends AbstractGenericHibernateDAO<Checklist, Integer> {


	public ChecklistDAO(Session session) {
		super(session);
	}

	/**
	 * Find By Project
	 * @param project
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Checklist> findByProject(Project project) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.createCriteria(Checklist.WBSNODE)
				.add(Restrictions.eq(Wbsnode.PROJECT, project))
				.addOrder(Order.desc(Wbsnode.DESCRIPTION));
		
		return crit.list();
	}

}

