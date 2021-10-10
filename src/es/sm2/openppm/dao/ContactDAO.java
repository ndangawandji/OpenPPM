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
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Resourceprofiles;

public class ContactDAO extends AbstractGenericHibernateDAO<Contact, Integer> {

	public ContactDAO(Session session) {
		super(session);
	}
	
	/**
	 * Return contact with company
	 * @param contact
	 * @return
	 */
	public Contact findByIdContact(Contact contact) {
		Contact cont = null;
		if (contact.getIdContact() != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.setFetchMode("company", FetchMode.JOIN);
			crit.add(Restrictions.eq("idContact", contact.getIdContact()));
			cont = (Contact) crit.uniqueResult();
		}
		return cont;
	}

	
	/**
	 * Search Contacts by filter
	 * @param fullName
	 * @param fileAs
	 * @param performingorg
	 * @param company 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Contact> searchByFilter(String fullName, String fileAs,
			Performingorg performingorg, Company company) {
		
		Contact example = new Contact();
		example.setFileAs(fileAs);
		example.setFullName(fullName);
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
			.add(Example.create(example)
					.ignoreCase()
					.enableLike(MatchMode.ANYWHERE)
				);
		
		crit.createCriteria(Contact.COMPANY).add(Restrictions.idEq(company.getIdCompany()));
		
		if (performingorg.getIdPerfOrg() != -1) {
			crit.createCriteria(Contact.EMPLOYEES)
				.createCriteria(Employee.PERFORMINGORG)
					.add(Restrictions.idEq(performingorg.getIdPerfOrg()));
		}
		
		return crit.list();
	}

	public Contact findByUser(String remoteUser) {
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.createCriteria("securities")
			.add(Restrictions.eq("login", remoteUser));
		
		return (Contact)crit.uniqueResult();
	}
	
	/**
	 * These contact has profile in company
	 * @param company
	 * @param contact
	 * @param profile
	 * @return
	 */
	public boolean hasProfile (Performingorg perfOrg, Contact contact, Resourceprofiles profile) {
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.idEq(contact.getIdContact()));
			
		crit.createCriteria(Contact.EMPLOYEES)
			.add(Restrictions.eq(Employee.RESOURCEPROFILES, profile))
			.add(Restrictions.eq(Employee.PERFORMINGORG, perfOrg));	
		
		return ((Integer)crit.uniqueResult() > 0);
	}
}
