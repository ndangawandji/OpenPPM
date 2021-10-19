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
/******************************************************************************
 * Update : Devoteam XL 2015-04-17  user story 23  tri des ressources
 *                                   Fundingsource, category
 *
  ******************************************************************************/
package es.sm2.openppm.logic;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.CompanyDAO;
import es.sm2.openppm.dao.FundingsourceDAO;
import es.sm2.openppm.exceptions.FundingsourceNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Fundingsource;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Fundingsource
 * @see es.sm2.openppm.logic.Fundingsource
 * @author Hibernate Generator by Javier Hernandez
 */
public final class FundingsourceLogic extends AbstractGenericLogic<Fundingsource, Integer>{

	/**
	 * Create or update Fundingsource
	 * @param fundingsource
	 * @throws Exception 
	 */
	public static Fundingsource saveFundingsource(Fundingsource fundingsource) throws Exception {
		if (fundingsource == null) {
			throw new FundingsourceNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			FundingsourceDAO fundingsourceDAO = new FundingsourceDAO(session);
			fundingsource = fundingsourceDAO.makePersistent(fundingsource);
			
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
		return fundingsource;
	}
	
	/**
	 * Delete Fundingsource
	 * @param fundingsource
	 * @throws Exception 
	 */
	public static void deleteFundingsource(Fundingsource fundingsource) throws Exception {
		if (fundingsource == null) {
			throw new FundingsourceNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			FundingsourceDAO fundingsourceDAO = new FundingsourceDAO(session);
			fundingsource = fundingsourceDAO.findById(fundingsource.getIdFundingSource(), false);
			
			if(!fundingsource.getProjects().isEmpty()){
				throw new LogicException("msg.error.delete.this_has","maintenance.fundingsource","project");
			}
			else{
				fundingsourceDAO.makeTransient(fundingsource);
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
	 * 
	 * @param fundingsource
	 * @throws Exception
	 */
	public static List<Fundingsource> findByCompany(Employee user) throws Exception {

		List<Fundingsource> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			FundingsourceDAO fundingsourceDAO = new FundingsourceDAO(session);
			CompanyDAO companyDAO = new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
//         XL 2015-04-17  Trier la liste remontée			
		//list = fundingsourceDAO.findByRelation(Fundingsource.COMPANY, company);
			list = fundingsourceDAO.findByRelation(Fundingsource.COMPANY, company,Fundingsource.NAME, Constants.ASCENDENT);
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

