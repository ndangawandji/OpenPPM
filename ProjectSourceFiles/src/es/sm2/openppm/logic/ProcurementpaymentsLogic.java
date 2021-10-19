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

import es.sm2.openppm.dao.ProcurementpaymentsDAO;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.javabean.ProcurementBudget;
import es.sm2.openppm.model.Procurementpayments;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Procurementpayments
 * @see es.sm2.openppm.logic.Procurementpayments
 * @author Hibernate Generator by Javier Hernandez
 */
public final class ProcurementpaymentsLogic extends AbstractGenericLogic<Procurementpayments, Integer>{

	
	/**
	 * Get Procurement Payments from Project
	 * 
	 * @param proj
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public static List<Procurementpayments> consProcurementPaymentsByProject(Project proj, List<String> joins) throws Exception {
		if (proj == null) {
			throw new ProjectNotFoundException();
		}
		
		List<Procurementpayments> listProcPay = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProcurementpaymentsDAO procPayDAO = new ProcurementpaymentsDAO(session);
			listProcPay = procPayDAO.consProcurementPaymentsByProject(proj, joins);
			
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
		return listProcPay;
	}	
	
	/**
	 * Get Procurement Budgets from Project
	 * 
	 * @param proj
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public static List<ProcurementBudget> consProcurementBudgetsByProject(Project proj, List<String> joins) throws Exception {
		if (proj == null) {
			throw new ProjectNotFoundException();
		}
		
		List<ProcurementBudget> lista = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProcurementpaymentsDAO procPayDAO = new ProcurementpaymentsDAO(session);
			lista = procPayDAO.consProcurementBudgetsByProject(proj, joins);
			
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
		return lista;
	}	
}

