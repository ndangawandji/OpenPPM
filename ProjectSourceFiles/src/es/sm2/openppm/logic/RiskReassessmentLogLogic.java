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

import es.sm2.openppm.dao.RiskReassessmentLogDAO;
import es.sm2.openppm.exceptions.ReassessmentLogDeleteException;
import es.sm2.openppm.exceptions.RiskNotFoundException;
import es.sm2.openppm.model.Riskreassessmentlog;
import es.sm2.openppm.model.Riskregister;
import es.sm2.openppm.utils.SessionFactoryUtil;

public class RiskReassessmentLogLogic extends AbstractGenericLogic<Riskreassessmentlog, Integer> {
	
	
	/**
	 * Cons risk reassessments logs for a risk register
	 * @param project
	 * @return
	 * @throws RiskNotFoundException 
	 */
	public static List<Riskreassessmentlog> consReassessments(Riskregister risk) throws Exception {
		if (risk == null) {
			throw new RiskNotFoundException();
		}
		List<Riskreassessmentlog> riskLogs = null;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			Riskreassessmentlog riskLog = new Riskreassessmentlog();
			riskLog.setRiskregister(risk);
			
			RiskReassessmentLogDAO riskLogDAO = new RiskReassessmentLogDAO(session);
			riskLogs = riskLogDAO.searchByExample(riskLog);
			
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
		
		return riskLogs;
	}

	
	/**
	 * Save risk log
	 * @param riskLog
	 * @throws Exception
	 */
	public static void saveReassessmentLog(Riskreassessmentlog riskLog) throws Exception {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			RiskReassessmentLogDAO riskLogDAO = new RiskReassessmentLogDAO(session);
			riskLogDAO.makePersistent(riskLog);
			
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
	 * Delete an risk reassessment log
	 * @param idLog
	 * @throws Exception 
	 */
	public static void deleteReassessmentLog(Integer idLog) throws Exception {
		if (idLog == -1) {
			throw new ReassessmentLogDeleteException();
		}
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			RiskReassessmentLogDAO riskLogDAO = new RiskReassessmentLogDAO(session);
			Riskreassessmentlog log = riskLogDAO.findById(idLog, false);
			if (log != null) {
				riskLogDAO.makeTransient(log);
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
