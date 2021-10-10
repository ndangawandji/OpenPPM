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

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.CompanyDAO;
import es.sm2.openppm.exceptions.CompanyNotFoundException;
import es.sm2.openppm.exceptions.EmployeeNotFoundException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class CompanyLogic extends AbstractGenericLogic<Company, Integer> {

	/**
	 * Delete company
	 * @param idCompany
	 * @throws Exception 
	 */
	public static void deleteCompany(Integer idCompany) throws Exception {
		if (idCompany == null || idCompany == -1) {
			throw new CompanyNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			CompanyDAO companyDAO = new CompanyDAO(session);
			Company company = companyDAO.findById(idCompany, false);
			if (company != null) {
				companyDAO.makeTransient(company);
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

	public static Company searchByEmployee(Employee employee) throws Exception {
		
		if (employee == null) {
			throw new EmployeeNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx	= null;
		Company company = null;
		try{
			tx = session.beginTransaction();
			
			CompanyDAO companyDAO = new CompanyDAO(session);
			company = companyDAO.searchByEmployee(employee);
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
		return company;
	}
}
