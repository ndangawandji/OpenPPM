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

import es.sm2.openppm.dao.CompanyDAO;
import es.sm2.openppm.dao.CustomerDAO;
import es.sm2.openppm.exceptions.CustomerNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class CustomerLogic extends GenericLogic {

	private CustomerLogic() {
		super();
	}
	
	/**
	 * Save new customer on new project screen 
	 * @param customer
	 * @throws Exception 
	 */
	public static Customer saveCustomer(Customer customer) throws Exception {
		
		Customer cust = null;
		
		if (customer == null) {
			throw new CustomerNotFoundException();
		}
		// Start transaction to save customer
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CustomerDAO customerDAO = new CustomerDAO(session);
			cust = customerDAO.makePersistent(customer);
			
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
		return cust;
	}

	public static List<Customer> findAll() throws Exception {
		List<Customer> customers = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CustomerDAO customerDAO = new CustomerDAO(session);
			customers = customerDAO.findAll();
			
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
		return customers;
	}

	/**
	 * Search Customer by Company
	 * @param company
	 * @return
	 * @throws Exception
	 */
	public static List<Customer> searchByCompany(Company company) throws Exception {
		
		List<Customer> customers = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CustomerDAO customerDAO = new CustomerDAO(session);
			customers = customerDAO.searchByCompany(company);
			
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
		return customers;
	}	
	
	/**
	 * Delete Customer
	 * @param customer
	 * @throws Exception
	 */
	public static void deleteCustomer(Customer customer) throws Exception {
		if (customer == null) {
			throw new CustomerNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CustomerDAO customerDAO = new CustomerDAO(session);
			customer = customerDAO.findById(customer.getIdCustomer(), false);
			
			if(!customer.getProjects().isEmpty()){
				throw new LogicException("msg.error.delete.this_has","customer","project");
			}
			else{
				customerDAO.makeTransient(customer);
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
	 * Find All and order by name
	 * @return
	 * @throws Exception 
	 */
	public static List<Customer> findAllOrder() throws Exception {
		List<Customer> customers = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CustomerDAO customerDAO = new CustomerDAO(session);
			customers = customerDAO.findAllOrder();
			
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
		return customers;
	}

	/**
	 * Find customer by company of user
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public static List<Customer> findByCompany(Employee user) throws Exception {
		List<Customer> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			CustomerDAO customerDAO = new CustomerDAO(session);
			CompanyDAO companyDAO	= new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			
			list = customerDAO.findByCompany(company);

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
		return list;
	}

	/**
	 * @param idCustomer
	 * @param lock
	 * @return
	 * @throws Exception
	 */
	public static Customer findById(Integer idCustomer, boolean lock) throws Exception {
		if (idCustomer == null || idCustomer == -1) {
     		throw new NoDataFoundException();
		}
		Customer customer = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			CustomerDAO customerDAO = new CustomerDAO(session);
			customer = customerDAO.findById(idCustomer, lock);
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
		return customer;
	}
	
}
