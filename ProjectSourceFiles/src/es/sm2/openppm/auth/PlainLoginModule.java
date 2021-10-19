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
package es.sm2.openppm.auth;

import java.security.Principal;
import java.util.Date;
import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.login.FailedLoginException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.SecurityDAO;
import es.sm2.openppm.model.Security;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.utils.ValidateUtil;



public class PlainLoginModule implements LoginModule {

	 /** Callback handler to store between initialization and authentication. */
    private CallbackHandler handler;

    /** Subject to store. */
    private Subject subject;

    /** Login name. */
    Security security = null;

    /**
     * This implementation always return <code>false</code>.
     * 
     * @see javax.security.auth.spi.LoginModule#abort()
     */
    public boolean abort() throws LoginException {
        return false;
    }

    /**
     * This is where, should the entire authentication process succeeds,
     * principal would be set.
     * 
     * @see javax.security.auth.spi.LoginModule#commit()
     */
    public boolean commit() {
        	
        assignPrincipal(new PlainUserPrincipal(security.getLogin()));
        assignPrincipal(new PlainRolePrincipal(Constants.APLICATION_ROL));
        
        return true;
    }
    
    private void assignPrincipal(Principal p) {
        // Make sure we dont add duplicate principals
        if (!subject.getPrincipals().contains(p)) {
            subject.getPrincipals().add(p);
        }
    }

    /**
     * This implementation ignores both state and options.
     * 
     * @see javax.security.auth.spi.LoginModule#initialize(javax.security.auth.Subject,
     *      javax.security.auth.callback.CallbackHandler, java.util.Map,
     *      java.util.Map)
     */
    public void initialize(Subject aSubject, CallbackHandler aCallbackHandler, Map<String, ?> aSharedState,
            Map<String, ?> aOptions) {
        handler = aCallbackHandler;
        subject = aSubject;
    }

    /**
     * This method checks whether the name and the password are the same.
     * 
     * @see javax.security.auth.spi.LoginModule#login()
     */
    public boolean login() throws LoginException {
        
        Callback[] callbacks = new Callback[2];
        callbacks[0] = new NameCallback("login");
        callbacks[1] = new PasswordCallback("password", true);
        
        Session session = SessionFactoryUtil.getInstance().getCurrentSession();
        try {
        	Transaction tx = session.beginTransaction();
        	SecurityDAO securityDAO = new SecurityDAO(session);
        	
            handler.handle(callbacks);

            String name = ((NameCallback) callbacks[0]).getName();
            String password = String.valueOf(((PasswordCallback) callbacks[1]).getPassword());

            // Authentication
            security = new Security();
            security.setLogin(name);
            //security.setPassword(SecurityUtil.md5(password));
            
            security = securityDAO.getByLogin(security);

            Date actualDate = new Date();
            
            if (security != null && !ValidateUtil.isNull(password) &&
            		SecurityUtil.md5(password).equals(security.getPassword()) &&
            		(security.getDateLapsed() == null || actualDate.after(security.getDateLapsed()))
            		) {
            	
            	security.setAttempts(0);
            	security.setDateLapsed(null);
            	security.setDateLastAttempt(null);
            	securityDAO.makePersistent(security);
            	
            	tx.commit();
            }
            else {
            	security.setDateLastAttempt(actualDate);
            	tx.commit();
            	throw new FailedLoginException("Authentication failed!");
            }
            
            return true;
        } catch (Exception e) {
        	throw new LoginException(e.getMessage());
		}
    }

    /**
     * Clears subject from principal and credentials.
     * 
     * @see javax.security.auth.spi.LoginModule#logout()
     */
    public boolean logout() throws LoginException {
        try {
            PlainUserPrincipal user = new PlainUserPrincipal(security.getLogin());
            PlainRolePrincipal role = new PlainRolePrincipal("admin");

            subject.getPrincipals().remove(user);
            subject.getPrincipals().remove(role);

            return true;
        } catch (Exception e) {
            throw new LoginException(e.getMessage());
        }
    }

}
