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

import es.sm2.openppm.dao.CalendarbaseDAO;
import es.sm2.openppm.dao.CalendarbaseexceptionsDAO;
import es.sm2.openppm.exceptions.CalendarBaseNotFoundException;
import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class CalendarBaseLogic extends AbstractGenericLogic<Calendarbase, Integer> {
	
	
	/**
	 * Save Calendar Base
	 * @param calendarBase
	 * @return
	 * @throws Exception 
	 */
	public static Calendarbase saveCalendar(Calendarbase calendarBase) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx 			= null;
		Calendarbase calendar 	= null;
		
		try {
			tx = session.beginTransaction();
			
			CalendarbaseDAO calendarbaseDAO = new CalendarbaseDAO(session);
			calendar = calendarbaseDAO.makePersistent(calendarBase);
			
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
		
		return calendar;
	}


	/**
	 * Return Calendar Base with Exceptions
	 * @param calendarbase
	 * @return
	 * @throws Exception 
	 */
	public static Calendarbase consCalendarBaseWithExceptions(Calendarbase calendarbase) throws Exception {
		
		if (calendarbase.getIdCalendarBase() == null) { 
			throw new CalendarBaseNotFoundException();
		}
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx 			= null;
		Calendarbase calendar 	= null;
		
		try {
			tx = session.beginTransaction();
			
			CalendarbaseDAO calendarbaseDAO = new CalendarbaseDAO(session);
			calendar = calendarbaseDAO.findByIdWithExceptions(calendarbase);
			
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
		
		return calendar;
	}
	
	
	/**
	 * Return Calendar Base
	 * @param calendarbase
	 * @return
	 * @throws Exception 
	 */
	public static Calendarbase consCalendarBase(Calendarbase calendarbase) throws Exception {
		
		if (calendarbase.getIdCalendarBase() == null) { 
			throw new CalendarBaseNotFoundException();
		}
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx 			= null;
		Calendarbase calendar 	= null;
		
		try {
			tx = session.beginTransaction();
			
			CalendarbaseDAO calendarbaseDAO = new CalendarbaseDAO(session);
			calendar = calendarbaseDAO.findById(calendarbase.getIdCalendarBase(), false);
			
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
		
		return calendar;
	}


	/**
	 * Delete Calendar Base and Exceptions
	 * @param calendarbase
	 * @throws Exception 
	 */
	public static void deleteCalendar(Calendarbase calendarbase) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx 			= null;
		
		try {
			tx = session.beginTransaction();
			
			CalendarbaseexceptionsDAO calendarbaseexceptionsDAO = new CalendarbaseexceptionsDAO(session);
			calendarbaseexceptionsDAO.deleteExceptions(calendarbase);
			
			CalendarbaseDAO calendarbaseDAO = new CalendarbaseDAO(session);
			calendarbaseDAO.makeTransient(calendarbase);
			
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
