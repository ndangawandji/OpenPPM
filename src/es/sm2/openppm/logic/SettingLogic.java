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

import es.sm2.openppm.dao.CompanyDAO;
import es.sm2.openppm.dao.SettingDAO;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Setting;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Setting
 * @see es.sm2.openppm.logic.Setting
 * @author Hibernate Generator by Javier Hernandez
 *
 * IMPORTANT! Instantiate the class for use generic methods
 *
 */
public final class SettingLogic extends AbstractGenericLogic<Setting, Integer> {

	/**
	 * Find setting
	 * @param user
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public Setting findSetting(Employee user, String name) throws Exception {
		
		Setting setting = null;
		Transaction tx	= null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			CompanyDAO companyDAO = new CompanyDAO(session);
			SettingDAO settingDAO = new SettingDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			
			setting = settingDAO.findSetting(company, name);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return setting;
	}

	/**
	 * Find all Settings for company
	 * @param user
	 * @return
	 * @throws Exception 
	 */
	public List<Setting> findByCompany(Employee user) throws Exception {
		
		List<Setting> settings = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			CompanyDAO companyDAO = new CompanyDAO(session);
			SettingDAO settingDAO = new SettingDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			
			settings = settingDAO.findByCompany(company);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return settings;
	}
}

