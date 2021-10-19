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
package es.sm2.openppm.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.common.Settings;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Setting;



/**
 * DAO object for domain model class Setting
 * @see es.sm2.openppm.dao.Setting
 * @author Hibernate Generator by Javier Hernandez
 */
public class SettingDAO extends AbstractGenericHibernateDAO<Setting, Integer> {


	public SettingDAO(Session session) {
		super(session);
	}
	
	/**
	 * Find setting
	 * @param company
	 * @param name
	 * @return
	 */
	public Setting findSetting(Company company, String name) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Setting.COMPANY, company))
			.add(Restrictions.eq(Setting.NAME, name));
		
		return (Setting)crit.uniqueResult();
	}

	/**
	 * Find all Settings for company
	 * @param company
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Setting> findByCompany(Company company) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Setting.COMPANY, company))
			.add(Restrictions.ne(Setting.STATUS, Settings.SETTING_STATUS_NO_VISIBLE));
		
		return crit.list();
	}
}

