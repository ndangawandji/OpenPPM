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

import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.model.Operationaccount;

public class OperationDAO extends AbstractGenericHibernateDAO<Operation, Integer> {

	public OperationDAO(Session session) {
		super(session);
	}
	
	/**
	 * Return Operations with operation account
	 * @param operation
	 * @return
	 */
	public Operation findByIdOperation(Operation operation) {
		
		Operation ope = null;
		
		if (operation.getIdOperation() != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.setFetchMode("operationaccount", FetchMode.JOIN);
			crit.add(Restrictions.eq("idOperation", operation.getIdOperation()));
			ope = (Operation) crit.uniqueResult();
		}
		return ope;
	}

	/**
	 * Find all of operations by company
	 * @param company
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Operation> findAllByCompany(Company company) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.createCriteria(Operation.OPERATIONACCOUNT)
			.add(Restrictions.eq(Operationaccount.COMPANY, company));
		
		return crit.list();
	}

}
