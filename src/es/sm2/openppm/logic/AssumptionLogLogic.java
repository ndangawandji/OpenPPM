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

import es.sm2.openppm.dao.AssumptionLogDAO;
import es.sm2.openppm.exceptions.AssumptionLogDeleteException;
import es.sm2.openppm.exceptions.AssumptionNotFoundException;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.model.Assumptionreassessmentlog;
import es.sm2.openppm.model.Assumptionregister;
import es.sm2.openppm.utils.SessionFactoryUtil;

public class AssumptionLogLogic extends AbstractGenericLogic<Assumptionreassessmentlog, Integer> {

	/**
	 * Cons assumption logs for a assumption register
	 * @param project
	 * @return
	 * @throws ProjectNotFoundException 
	 */
	public static List<Assumptionreassessmentlog> consAssumptions(Assumptionregister assumption) throws Exception {
		if (assumption == null) {
			throw new AssumptionNotFoundException();
		}
		List<Assumptionreassessmentlog> assumptionLogs = null;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			Assumptionreassessmentlog assumptionLog = new Assumptionreassessmentlog();
			assumptionLog.setAssumptionregister(assumption);
			
			AssumptionLogDAO assumptionLogDAO = new AssumptionLogDAO(session);
			assumptionLogs = assumptionLogDAO.searchByExample(assumptionLog);
			
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
		
		return assumptionLogs;
	}

	
	/**
	 * Save assumption log
	 * @param assumptionLog
	 * @throws Exception
	 */
	public static void saveAssumptionLog(Assumptionreassessmentlog assumptionLog) throws Exception {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			AssumptionLogDAO assumptionLogDAO = new AssumptionLogDAO(session);
			assumptionLogDAO.makePersistent(assumptionLog);
			
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
	 * Delete an assumption log
	 * @param idLog
	 * @throws Exception 
	 */
	public static void deleteAssumptionLog(Integer idLog) throws Exception {
		if (idLog == -1) {
			throw new AssumptionLogDeleteException();
		}
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			AssumptionLogDAO assumptionLogDAO = new AssumptionLogDAO(session);
			Assumptionreassessmentlog log = assumptionLogDAO.findById(idLog, false);
			if (log != null) {
				assumptionLogDAO.makeTransient(log);
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
}
