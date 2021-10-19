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
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;

public class ProgramDAO extends AbstractGenericHibernateDAO<Program, Integer> {

	public ProgramDAO(Session session) {
		super(session);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<Program> searchByExample(Program exampleInstance,
			Class... joins) {
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.addOrder(Order.asc(Program.PROGRAMNAME));
		
		for (Class c : joins) {
			if (c.equals(Contact.class)) {
				crit.setFetchMode("employee", FetchMode.JOIN);
				crit.setFetchMode("employee.contact", FetchMode.JOIN);
			}
		}
		
		if (exampleInstance.getEmployee() != null) {// Find by Program Mgr.
			crit.add(Restrictions.eq("employee.idEmployee", exampleInstance.getEmployee().getIdEmployee()));
		}		
		
		return crit.list();
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Program> findByPO(Employee user) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.addOrder(Order.asc(Program.PROGRAMNAME))
			.setFetchMode("employee", FetchMode.JOIN)
			.setFetchMode("employee.contact", FetchMode.JOIN)
			.add(Restrictions.eq(Program.PERFORMINGORG, user.getPerformingorg()));
		
		return crit.list();
	}


	/**
	 * Search by PerfOrg
	 * @param budgetYear 
	 * @param user
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Program> searchByPerfOrg(Performingorg perfOrg, Integer budgetYear) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.addOrder(Order.asc(Program.PROGRAMNAME));
		
		if (budgetYear != null) {
			crit.add(Restrictions.disjunction()
					.add(Restrictions.eq(Program.BUDGETYEAR, budgetYear+""))
					.add(Restrictions.isNull(Program.BUDGETYEAR))
					.add(Restrictions.eq(Program.BUDGETYEAR, ""))
			);
		}
		
		crit.createCriteria("employee")
			.add(Restrictions.eq("performingorg",perfOrg));
		
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Program> consByCompany(Company company, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		if (joins != null) {
			for (String join : joins) {
				crit.setFetchMode(join, FetchMode.JOIN);
			}
		}
		crit.createCriteria(Program.PERFORMINGORG)
			.add(Restrictions.eq(Performingorg.COMPANY, company));
		
		return crit.list();
	}
}
