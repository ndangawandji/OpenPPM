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
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Customer;

public class CustomerDAO extends AbstractGenericHibernateDAO<Customer, Integer> {

	public CustomerDAO(Session session) {
		super(session);
	}

	/**
	 * Search Customer by Company
	 * @param company
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> searchByCompany(Company company) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.addOrder(Order.asc(Customer.NAME))
			.add(Restrictions.eq(Customer.COMPANY, company));
		
		return crit.list();
	}

	/**
	 * Find All and order by name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> findAllOrder() {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.addOrder(Order.asc(Customer.NAME));
		
		return crit.list();
	}

	/**
	 * Find customer by company
	 * @param company
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> findByCompany(Company company) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Customer.COMPANY, company))
			.setFetchMode(Customer.CUSTOMERTYPE, FetchMode.JOIN);
		
		return crit.list();
	}
	
	public Customer consCustomer(Integer id) {
		
		String stringQuery = "select cust " +
				 			 "from Customer as cust " +
				 			 "where cust.idCustomer = :idCustomer";
		
		Query query = getSession().createQuery(stringQuery);
		query.setInteger("idCustomer", id);
		
		return (Customer) query.uniqueResult();
	}

}
