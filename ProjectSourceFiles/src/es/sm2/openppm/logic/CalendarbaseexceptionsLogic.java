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

import es.sm2.openppm.dao.CalendarbaseexceptionsDAO;
import es.sm2.openppm.model.Calendarbaseexceptions;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class CalendarbaseexceptionsLogic extends AbstractGenericLogic<Calendarbaseexceptions, Integer> {

	/**
	 * Save Calendar Base Exception
	 * @param exception
	 * @return
	 * @throws Exception 
	 */
	public static Calendarbaseexceptions saveException(Calendarbaseexceptions exception) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx 				= null;
		Calendarbaseexceptions temp = null;
		
		try {
			tx = session.beginTransaction();
			
			CalendarbaseexceptionsDAO exceptionsDAO = new CalendarbaseexceptionsDAO(session);
			temp = exceptionsDAO.makePersistent(exception);
			
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
		
		return temp;
	}

	
	/**
	 * Delete Calendar Exception
	 * @param calendarbaseexceptions
	 * @throws Exception 
	 */
	public static void deleteException(
			Calendarbaseexceptions exception) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx 				= null;
		
		try {
			tx = session.beginTransaction();
			
			CalendarbaseexceptionsDAO exceptionsDAO = new CalendarbaseexceptionsDAO(session);
			exceptionsDAO.makeTransient(exception);
			
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
	 * Get Base exceptions by employee
	 * @param idEmployee
	 * @return
	 * @throws Exception
	 */
	public List<Calendarbaseexceptions> findByEmployee(Integer idEmployee) throws Exception {
		
		List<Calendarbaseexceptions> exceptions = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			CalendarbaseexceptionsDAO dao = new CalendarbaseexceptionsDAO(session);
			exceptions = dao.findByEmployee(idEmployee);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		return exceptions;
	}

	
}
