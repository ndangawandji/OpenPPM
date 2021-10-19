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

import es.sm2.openppm.model.Incomes;
import es.sm2.openppm.model.Project;

public class IncomesDAO extends AbstractGenericHibernateDAO<Incomes, Integer> {

	public IncomesDAO(Session session) {
		super(session);
	}

	/**
	 * Return Project Incomes
	 * @param proj
	 * @param order 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Incomes> findByProject(Project proj, String order) {
		List<Incomes> incomes = null;
		if (proj != null) {		
			Query query = getSession().createQuery(
					"select incomes " +
					"from Incomes as incomes " +
					"join incomes.project as project " + 
					"where project.idProject = :idProject " +
					"order by incomes."+order);
			
			query.setInteger("idProject", proj.getIdProject());
			incomes = query.list();
		}
		return incomes;
	}

	/**
	 * Calculate Actual Bill Ammount of a project
	 * @param idProject
	 * @return
	 */
	public double consActualBillAmmount(Integer idProject) {
		double actualBillAmmount = 0;
		
		Query query = getSession().createQuery(
				"select sum(i.actualBillAmmount) " +
				"from Incomes as i " +
				"join i.project as p " +
				"where p.idProject=:idProject");
		query.setInteger("idProject", idProject);
		
		if (query.uniqueResult() != null) {
			actualBillAmmount = (Double) query.uniqueResult();
		}
		return actualBillAmmount;
	}

}
