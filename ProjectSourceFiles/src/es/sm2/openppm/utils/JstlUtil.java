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

import java.util.Date;
import java.util.HashMap;

import org.apache.log4j.Logger;

import es.sm2.openppm.logic.ExpensesheetLogic;
import es.sm2.openppm.logic.TimesheetLogic;
import es.sm2.openppm.model.Employee;

public class JstlUtil {

	public final static Logger LOGGER = Logger.getLogger(JstlUtil.class);
	
	private JstlUtil() {}
	
	/**
	 * Get status actual level
	 * @param idEmployee
	 * @param id
	 * @param initDate
	 * @param endDate
	 * @param status
	 * @param approveLevel
	 * @param filterUser
	 * @return
	 */
	public static String getStatusResource(Integer idEmployee, Integer id, Date initDate, Date endDate,
			String status, String approveLevel, Employee filterUser) {
		
		try {
			
			TimesheetLogic timesheetLogic = new TimesheetLogic();
			status = timesheetLogic.getStatusResource(idEmployee, id, initDate, endDate, status, approveLevel, filterUser);
		}
		catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
		
		return status;
	}
	
	/**
	 * Get Hours resource
	 * @param idEmployee
	 * @param id
	 * @param initDate
	 * @param endDate
	 * @param rol
	 * @return
	 */
	public static double getHoursResource(Integer idEmployee, Integer id, Date initDate, Date endDate,
			Employee filterUser, int approveRol) {
		
		double hours = 0;
		
		try {
			
			TimesheetLogic timesheetLogic = new TimesheetLogic();
			
			hours = timesheetLogic.getHoursResource(idEmployee, id, initDate, endDate, filterUser, approveRol);
		}
		catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
		
		return hours;
	}
	
	
	/**
	 * Get Cost resource Expense Sheet
	 * @param idEmployee
	 * @param id
	 * @param sheetDate
	 * @param filterUser
	 * @param approveRol
	 * @return
	 */
	public static double getCostResource(Integer idEmployee, Integer id, Date sheetDate,
			Employee filterUser, int approveRol) {
		
		double cost = 0;
		
		try {
			
			ExpensesheetLogic expensesheetLogic = new ExpensesheetLogic();
			
			cost = expensesheetLogic.getCostResource(idEmployee, id, sheetDate,filterUser, approveRol);
		}
		catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
		
		return cost;
	}
	
	/**
	 * Get status actual level for Expenses
	 * @param idEmployee
	 * @param id
	 * @param sheetDate
	 * @param status
	 * @param approveLevel
	 * @param filterUser
	 * @return
	 */
	public static String getStatusResourceExpense(Integer idEmployee, Integer id, Date sheetDate,
			String status, String approveLevel, Employee filterUser) {
		
		try {
			
			ExpensesheetLogic expensesheetLogic = new ExpensesheetLogic();
			
			status = expensesheetLogic.getStatusResourceExpense(idEmployee, id, sheetDate, status, approveLevel, filterUser);
		}
		catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
		
		return status;
	}
	
	/**
	 * Check if plugin is activated
	 * @param keyPlugin
	 * @param plugins
	 * @return
	 */
	public static boolean isPluginActivated(String keyPlugin, HashMap<String,Boolean> plugins) {
		
		Boolean actived = plugins.get(keyPlugin);
		
		return (actived == null?false:actived);
	}
}
