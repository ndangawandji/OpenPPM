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

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.dao.SecurityDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.LoginMaxAttemptsException;
import es.sm2.openppm.exceptions.LoginUserExpiredException;
import es.sm2.openppm.exceptions.LoginUsernameException;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Security;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.utils.ValidateUtil;

public final class SecurityLogic extends AbstractGenericLogic<Security, Integer> {

	
	/**
	 * Validate logged User
	 * @param req
	 * @return
	 * @throws Exception 
	 */
	public static Employee validateLoggedUser(HttpServletRequest req) throws Exception {
		
		Integer selIdEmployee 	= (Integer) req.getSession().getAttribute("selIdEmployee");
		Employee aux 			= (Employee) req.getSession().getAttribute("user");
    	Employee user 			= null;
    	
    	if (aux == null) {
    		try {
    			
    			boolean invalidate = false;
				
    			if (selIdEmployee == null) {
    				invalidate = true;
				}
				else {
					user = EmployeeLogic.consEmployee(selIdEmployee);
					if (user == null) {
						invalidate = true;
					}
					else { 
						req.getSession().setAttribute("user", user);
						req.getSession().setAttribute("rolPrincipal", user.getResourceprofiles().getIdProfile());
					}
				}
    			if (invalidate) { req.getSession().invalidate(); }
    			
	    	}
	    	catch (LogicException e) {
	    		user = null;
	    	}
    	}
    	else {
    		user = aux;
    	}
    	
    	return user;
	}
	
	/**
	 * Return Username in use
	 * @param security
	 * @return
	 * @throws Exception 
	 */
	public static boolean isUserName(Security security) throws Exception {
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Security secure = null;
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
		
			SecurityDAO securityDAO = new SecurityDAO(session);
			secure = securityDAO.getByUserName(security);
			
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
		return (secure != null);
	}

	
	/**
	 * Change password of employee
	 * @param idEmployee
	 * @return
	 * @throws Exception 
	 */
	public static Security changePassword(Contact contact, String password) throws Exception {
		
		Security security = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
		
			SecurityDAO securityDAO = new SecurityDAO(session);
			
			security = securityDAO.getByContact(contact);
			if(!ValidateUtil.isNull(password)) {
				security.setPassword(SecurityUtil.md5(password));
			}
			else {
				security.setPassword(SecurityUtil.md5(security.getLogin()));	
			}			
			securityDAO.makePersistent(security);
			
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
		return security;
	}
	
	
	/**
	 * Get Security By Contact
	 * @param contact
	 * @return
	 * @throws Exception 
	 */
	public static Security getByContact(Contact contact) throws Exception {
		
		Security security = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
		
			SecurityDAO securityDAO = new SecurityDAO(session);
			security = securityDAO.getByContact(contact);
			
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
		return security;
	}
	
	
	/**
	 * Get Security By Employee
	 * @param employee
	 * @return
	 * @throws Exception 
	 */
	public static Security getByEmployee (Employee employee) throws Exception {
		
		Security security = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();

			SecurityDAO securityDAO = new SecurityDAO(session);
			security = securityDAO.getByEmployee(employee);

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
		return security;
	}


	/**
	 * Determine if an user can login
	 * @param security
	 * @return
	 * @throws Exception 
	 */
	public static Security preLogin(Security security) throws Exception {
		Security sec = null;
		boolean maxAttempted = false;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
		
			SecurityDAO securityDAO = new SecurityDAO(session);
			sec = securityDAO.getByUserName(security);
			
			if (sec == null) {
				throw new LoginUsernameException();
			}
			else if (!Settings.LOGIN_LDAP) {
				
				SimpleDateFormat dateFormat = new SimpleDateFormat(Constants.TIME_PATTERN, Constants.DEF_LOCALE_NUMBER);
				
				// User account is expired
				if (sec.getDateLapsed() != null) {
					throw new LoginUserExpiredException(dateFormat.format(sec.getDateLapsed()));
				}
				
				if (sec.getAttempts() != null && (sec.getAttempts()+1) >= Constants.MAX_LOGIN_ATTEMPS){
					
					Calendar dateLapsed = Calendar.getInstance();
					dateLapsed.add(Calendar.MINUTE, Constants.BLOCK_WAIT_TIME);
					
					sec.setDateLapsed(dateLapsed.getTime());
					sec.setAttempts((sec.getAttempts() != null ? sec.getAttempts():0)+1);
					
					maxAttempted = true;
				}
				else {
					sec.setDateLapsed(null);
					sec.setAttempts((sec.getAttempts() != null ? sec.getAttempts():0)+1);
				}
				
				securityDAO.makePersistent(sec);
			}
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }

		if (maxAttempted) {
			throw new LoginMaxAttemptsException(Constants.BLOCK_WAIT_TIME);
		}
		
		return sec;
	}

	/**
	 * Update security
	 * @param security
	 * @throws Exception
	 */
	public static void updateSecurity(Security security) throws Exception {
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			SecurityDAO securityDAO = new SecurityDAO(session);
			securityDAO.makePersistent(security);
			
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
	 * Check if user name is in use
	 * @param contact
	 * @param login
	 * @return
	 * @throws Exception 
	 */
	public boolean isUserName(Contact contact, String login) throws Exception {
		
		boolean inUse = false;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			SecurityDAO securityDAO = new SecurityDAO(session);
			inUse = securityDAO.isUserName(contact, login);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return inUse;
	}
}
