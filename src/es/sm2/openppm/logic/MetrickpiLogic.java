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
import es.sm2.openppm.dao.MetrickpiDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.MetrickpiNotFoundException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Metrickpi;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Metrickpi
 * @see es.sm2.openppm.logic.Metrickpi
 * @author Hibernate Generator by Javier Hernandez
 */
public final class MetrickpiLogic extends AbstractGenericLogic<Metrickpi, Integer>{

	
	/**
	 * Create or update Metrickpi
	 * @param metrickpi
	 * @throws Exception 
	 */
	public static Metrickpi saveMetrickpi(Metrickpi metrickpi) throws Exception {
		if (metrickpi == null) {
			throw new MetrickpiNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			MetrickpiDAO metrickpiDAO = new MetrickpiDAO(session);
			metrickpi = metrickpiDAO.makePersistent(metrickpi);
			
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
		return metrickpi;
	}
	
	/**
	 * Delete Metrickpi
	 * @param metrickpi
	 * @throws Exception 
	 */
	public static void deleteMetrickpi(Metrickpi metrickpi) throws Exception {
		if (metrickpi == null) {
			throw new MetrickpiNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			MetrickpiDAO metrickpiDAO = new MetrickpiDAO(session);
			metrickpi = metrickpiDAO.findById(metrickpi.getIdMetricKpi(), false);
			
			if (!metrickpi.getProjectkpis().isEmpty()) {
				throw new LogicException("msg.error.delete.this_has","metric","kpi_project");
			}else{
				metrickpiDAO.makeTransient(metrickpi);
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
	 * Find by company of user
	 * @param user
	 * @param joins 
	 * @return
	 * @throws Exception 
	 */
	public static List<Metrickpi> findByCompany(Employee user, List<String> joins) throws Exception {

		List<Metrickpi> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			MetrickpiDAO metrickpiDAO	= new MetrickpiDAO(session);
			CompanyDAO companyDAO		= new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			list = metrickpiDAO.findByCompany(company, joins);

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

