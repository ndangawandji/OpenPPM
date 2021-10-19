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
package es.sm2.openppm.logic;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.ContactDAO;
import es.sm2.openppm.dao.SecurityDAO;
import es.sm2.openppm.exceptions.ContactNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Security;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ContactLogic extends AbstractGenericLogic<Contact, Integer> {

	/**
	 * Save new contact at new project screen
	 * @param contact
	 * @throws Exception 
	 */
	public static void saveContact(Contact contact) throws Exception {
		if (contact == null) {
			throw new ContactNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ContactDAO contactDAO = new ContactDAO(session);
			contactDAO.makePersistent(contact);
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
	}
	
	
	/**
	 * Save new contact 
	 * @param contact
	 * @param secutiry
	 * @throws Exception 
	 */
	public static void saveContact(Contact contact, Security secutiry) throws Exception {
		if (contact == null) {
			throw new ContactNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		Contact item = null;
		
		try {
			tx = session.beginTransaction();
			
			ContactDAO contactDAO = new ContactDAO(session);
			item = contactDAO.makePersistent(contact);
			
			secutiry.setContact(item);
			
			SecurityDAO securityDAO = new SecurityDAO(session);
			securityDAO.makePersistent(secutiry);
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
	}
	
	/**
	 * Delete Contact
	 * @param idCntact
	 * @throws Exception 
	 */
	public static void deleteContact(Integer idContact) throws Exception {
		if (idContact == null || idContact == -1) {
			throw new ContactNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			ContactDAO contactDAO = new ContactDAO(session);
			Contact contact = contactDAO.findById(idContact, false);
			
			if (!contact.getEmployees().isEmpty()) {
				throw new LogicException("msg.error.delete.this_has","contact","maintenance.resources");
			}			
			else {
				contactDAO.makeTransient(contact);
			}
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
	}

	
	/**
	 * Consulting Contact with a specified id
	 * @param idContact
	 * @return
	 * @throws Exception 
	 */
	public static Contact consultContact(int idContact) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		Contact contact = new Contact();
		try {
			
			tx = session.beginTransaction();
			
			ContactDAO contactDAO = new ContactDAO(session);
			contact = contactDAO.findByIdContact(new Contact(idContact));
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return contact;
	}

	
	/**
	 * Search Contacts by filter
	 * @param fullName
	 * @param fileAs
	 * @param company 
	 * @param idCompany
	 * @return
	 * @throws Exception 
	 */
	public static List<Contact> searchContacts(String fullName, String fileAs,
			Performingorg performingorg, Company company) throws Exception {
		
		List<Contact> contacts = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ContactDAO contactDAO = new ContactDAO(session);
			contacts = contactDAO.searchByFilter(fullName, fileAs, performingorg, company);
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return contacts;
	}

	/**
	 * 
	 * @param remoteUser
	 * @return
	 * @throws Exception
	 */
	public static Contact findByUser(String remoteUser) throws Exception {
		
		Contact contact = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ContactDAO contactDAO = new ContactDAO(session);
			contact = contactDAO.findByUser(remoteUser);
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return contact;
	}
	
	/**
	 * These contact has profile in company
	 * @param perfOrg
	 * @param contact
	 * @param profile
	 * @return
	 * @throws Exception
	 */
	public static boolean hasProfile(Performingorg perfOrg, Contact contact, Resourceprofiles profile) throws Exception {
		
		boolean has = false;
		
		Transaction tx = null;		
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ContactDAO contactDAO = new ContactDAO(session);
			has = contactDAO.hasProfile(perfOrg, contact, profile);
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		
		return has;
	} 
}
