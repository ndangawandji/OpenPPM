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

import java.util.HashMap;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.PluginDAO;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Plugin;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Plugin
 * @see es.sm2.openppm.logic.Plugin
 * @author Hibernate Generator by Javier Hernandez
 *
 * IMPORTANT! Instantiate the class for use generic methods
 *
 */
public final class PluginLogic extends AbstractGenericLogic<Plugin, Integer> {

	
	public HashMap<String,Boolean> getPlugins(Contact contact) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		HashMap<String,Boolean> plugins = new HashMap<String, Boolean>();
		
		try {
			tx = session.beginTransaction();
		
			PluginDAO pluginDAO		= new PluginDAO(session);
			
			List<Plugin> items = pluginDAO.findByContact(contact);
			
			for (Plugin plugin : items) { plugins.put(plugin.getName(), plugin.isEnabled()); }
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return plugins;
	}
}

