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
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Security;

public class SecurityDAO extends AbstractGenericHibernateDAO<Security, Integer> {

	public SecurityDAO(Session session) {
		super(session);
	}
	
	/**
	 * Return Security data of an Employee if login & password are validated
	 * @param login
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Security getByLogin (Security login) {
		Security security = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.setFetchMode("contact", FetchMode.JOIN);
		crit.setFetchMode("contact.employees", FetchMode.JOIN);
		crit.setFetchMode("contact.employees.resourceprofiles", FetchMode.JOIN);
		crit.add(Restrictions.eq("login", login.getLogin()));
		List<Security> list = crit.list();
		
		if (list != null && !list.isEmpty()) {
			security = list.get(0);
		}
		
		return security;
	}
	
	
	/**
	 * Return Username in use
	 * @param login
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Security getByUserName(Security login) {
		Security security = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.setFetchMode("contact", FetchMode.JOIN);
		crit.setFetchMode("contact.employees", FetchMode.JOIN);
		crit.setFetchMode("contact.employees.resourceprofiles", FetchMode.JOIN);
		crit.add(Restrictions.eq("login", login.getLogin()));
		List<Security> list = crit.list();
		
		if (list != null && !list.isEmpty()) {
			security = list.get(0);
		}
		
		return security;
	}
	
	
	/**
	 * Resturn security by contact
	 * @param contact
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Security getByContact (Contact contact) {
		Security security = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.add(Restrictions.eq("contact.idContact", contact.getIdContact()));
		List<Security> list = crit.list();
		
		if (list != null && !list.isEmpty()) {
			security = list.get(0);
		}
		
		return security;
	}
	
	
	/**
	 * Return security by employee
	 * @param employee
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Security getByEmployee (Employee employee) {
		Security security = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		crit.createCriteria(Security.CONTACT)
			.createCriteria(Contact.EMPLOYEES)
			.add(Restrictions.eq(Employee.IDEMPLOYEE, employee.getIdEmployee()));
		
		List<Security> list = crit.list();
		
		if (list != null && !list.isEmpty()) {
			security = list.get(0);
		}
		
		return security;
	}
	
	
	/**
	 * Return data of logged Contact
	 * @param userLogged
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Contact getContactLogger(String userLogged) {
		Contact cont = null;
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.setFetchMode("contact", FetchMode.JOIN);
		crit.setFetchMode("contact.employees", FetchMode.JOIN);
		crit.setFetchMode("contact.employees.resourceprofiles", FetchMode.JOIN);
		crit.add(Restrictions.eq("login", userLogged));
		List<Security> list = crit.list();
		
		if (list != null && !list.isEmpty()) {
			cont = list.get(0).getContact();
		}
		
		return cont;
	}

	/**
	 * User name in use
	 * @param contact
	 * @param login
	 * @return
	 */
	public boolean isUserName(Contact contact, String login) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Security.LOGIN, login))
			.add(Restrictions.ne(Security.CONTACT, contact));
		
		
		return ((Integer)crit.uniqueResult() > 0);
	}

}
