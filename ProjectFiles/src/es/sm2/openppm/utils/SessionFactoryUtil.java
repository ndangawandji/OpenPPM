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
package es.sm2.openppm.utils;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import org.hibernate.cfg.Configuration;

/**
 * @author hennebrueder This class garanties that only one single SessionFactory
 *         is instanciated and that the configuration is done thread safe as
 *         singleton. Actually it only wraps the Hibernate SessionFactory.
 *         You are free to use any kind of JTA or Thread transactionFactories.
 */
public final class SessionFactoryUtil {

  /** The single instance of hibernate SessionFactory */
  private static org.hibernate.SessionFactory sessionFactory;

	/**
	 * disable contructor to guaranty a single instance
	 */
	private SessionFactoryUtil() {
	}

	static{
		// Annotation and XML
	    //sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
		// XML only
		sessionFactory = new Configuration().configure().buildSessionFactory();
  }

	public static SessionFactory getInstance() {
		return sessionFactory;
	}

  /**
   * Opens a session and will not bind it to a session context
   * @return the session
   */
	public Session openSession() {
		return sessionFactory.openSession();
	}

	/**
     * Returns a session from the session context. If there is no session in the context it opens a session,
     * stores it in the context and returns it.
	 * This factory is intended to be used with a hibernate.cfg.xml
	 * including the following property <property
	 * name="current_session_context_class">thread</property> This would return
	 * the current open session or if this does not exist, will create a new
	 * session
	 * 
	 * @return the session
	 */
	public Session getCurrentSession() {
		return sessionFactory.getCurrentSession();
	}

  /**
   * closes the session factory
   */
	public static void close(){
		if (sessionFactory != null)
			sessionFactory.close();
		sessionFactory = null;
	}
}
