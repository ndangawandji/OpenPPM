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
import es.sm2.openppm.dao.CustomertypeDAO;
import es.sm2.openppm.exceptions.CustomertypeNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Customertype;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Customertype
 * @see es.sm2.openppm.logic.Customertype
 * @author Hibernate Generator by Javier Hernandez
 */
public final class CustomertypeLogic extends AbstractGenericLogic<Customertype, Integer>{

	
	/**
	 * Create or update Customertype
	 * @param customertype
	 * @throws Exception 
	 */
	public static Customertype saveCustomertype(Customertype customertype) throws Exception {
		if (customertype == null) {
			throw new CustomertypeNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CustomertypeDAO customertypeDAO = new CustomertypeDAO(session);
			customertype = customertypeDAO.makePersistent(customertype);
			
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
		return customertype;
	}
	
	/**
	 * Delete Customertype
	 * @param customertype
	 * @throws Exception 
	 */
	public static void deleteCustomertype(Customertype customertype) throws Exception {
		if (customertype == null) {
			throw new CustomertypeNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CustomertypeDAO customertypeDAO = new CustomertypeDAO(session);
			customertype = customertypeDAO.findById(customertype.getIdCustomerType(), false);
			
			if (!customertype.getCustomers().isEmpty()) {
				throw new LogicException("msg.error.delete.this_has","customer_type","customer");
			}else{
				customertypeDAO.makeTransient(customertype);
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
	 * Find customer types by company of user
	 * @param user
	 * @return
	 * @throws Exception
	 */
	public static List<Customertype> findByCompany(Employee user) throws Exception {
		List<Customertype> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			CustomertypeDAO customertypeDAO = new CustomertypeDAO(session);
			CompanyDAO companyDAO			= new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			
			list = customertypeDAO.findByCompany(company);

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
	
			

}

