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

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Budgetaccounts;
import es.sm2.openppm.model.Expenses;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcosts;

public class ExpensesDAO extends AbstractGenericHibernateDAO<Expenses, Integer> {

	public ExpensesDAO(Session session) {
		super(session);
	}

	/**
	 * Return Total expenses of project
	 * @param proj
	 * @return
	 */
	public double getTotal(Project proj) {
		double total = 0;
		if (proj != null) {
			Query query = getSession().createQuery(
					"select sum(expenses.planned) " +
					"from Expenses as expenses " + 
					"join expenses.projectcosts as costs " +
					"join costs.project as project " +
					"where project.idProject = :idProject");
			query.setInteger("idProject", proj.getIdProject());
			if (query.uniqueResult() != null) {
				total = (Double) query.uniqueResult(); 
			}
		}
		return total;
	}

	
	/**
	 * Return Total actual expenses of project to control it
	 * @param proj
	 * @return
	 */
	public double getActualTotal(Project proj) {
		double total = 0;
		if (proj != null) {
			Query query = getSession().createQuery(
					"select sum(expenses.actual) " +
					"from Expenses as expenses " + 
					"join expenses.projectcosts as costs " +
					"join costs.project as project " +
					"where project.idProject = :idProject");
			query.setInteger("idProject", proj.getIdProject());
			if (query.uniqueResult() != null) {
				total = (Double) query.uniqueResult(); 
			}
		}
		return total;
	}
	
	/**
	 * Check if budget account is in use in project and expense
	 * @param project
	 * @param expenses
	 * @param budgetaccounts
	 * @return
	 */
	public boolean isBudgetInUse(Project project, Expenses expenses,
			Budgetaccounts budgetaccounts) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Expenses.BUDGETACCOUNTS, budgetaccounts));
		
		if (expenses.getIdExpense() != -1) {
			crit.add(Restrictions.ne(Expenses.IDEXPENSE, expenses.getIdExpense()));
		}
		
		crit.createCriteria(Expenses.PROJECTCOSTS)
			.add(Restrictions.eq(Projectcosts.PROJECT, project));
		
		Integer count = (Integer) crit.uniqueResult();
		
		return (count != null && count > 0);
	}
}
