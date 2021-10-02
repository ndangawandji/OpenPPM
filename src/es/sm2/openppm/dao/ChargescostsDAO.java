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
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Chargescosts;
import es.sm2.openppm.model.Project;



/**
 * DAO object for domain model class Chargescosts
 * @see es.sm2.openppm.dao.Chargescosts
 * @author Hibernate Generator by Javier Hernandez
 */
public class ChargescostsDAO extends AbstractGenericHibernateDAO<Chargescosts, Integer> {


	public ChargescostsDAO(Session session) {
		super(session);
	}

	/**
	 * Cons Charge Costs by project and type
	 * @param proj
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Chargescosts> consChargescostsByProject(Project proj, int type) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Chargescosts.PROJECT, proj))
			.add(Restrictions.eq(Chargescosts.IDCHARGETYPE, type));	
		
		return crit.list();
	}

	public double getSumCosts(Project project, int type) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.sum(Chargescosts.COST))
			.add(Restrictions.eq(Chargescosts.PROJECT, project))
			.add(Restrictions.eq(Chargescosts.IDCHARGETYPE, type));	
		
		Double cost = (Double)crit.uniqueResult();
		return (cost == null?0:cost);
	}
}

