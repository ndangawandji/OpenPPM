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

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Settings;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.logic.SettingLogic;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Setting;

public class SettingUtil {

public final static Logger LOGGER = Logger.getLogger(SettingUtil.class);
	
	private SettingUtil() {}
	
	public static boolean getBolean(Employee user, String nameSetting) {
		
		boolean value = false;
    	try {
    		value = Boolean.valueOf(getSetting(user, nameSetting));
		}
    	catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
    	
    	return value;
	}
	
	public static int getApprovalRol(HttpServletRequest req) {
		
		int rol = 0;
    	try {
    		Employee user = SecurityUtil.consUser(req);
    		
			rol = Integer.parseInt(getSetting(user, Settings.SETTING_LAST_LEVEL_FOR_APPROVE_SHEET));
		}
    	catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
    	
    	return rol;
	}
	
	public static String getSetting(Employee user, String nameSetting) {
		
		Setting setting = null;
		
    	try {
    		
    		SettingLogic settingLogic = new SettingLogic();
			setting = settingLogic.findSetting(user, nameSetting);
			
			if (setting == null) { throw new LogicException("Setting not found: "+nameSetting); }
		}
    	catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }

    	String value = setting != null ? setting.getValue(): StringPool.BLANK;
    	LOGGER.info("Setting: "+nameSetting+ " Value: "+ value);
    	
    	return value;
	}
}
