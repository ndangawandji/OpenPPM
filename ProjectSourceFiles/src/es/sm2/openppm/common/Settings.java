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
package es.sm2.openppm.common;

import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public final class Settings {

	private static final Logger LOGGER = Logger.getLogger(Settings.class);
	
	public static final ResourceBundle properties = ResourceBundle.getBundle("openppm");

	// STATUS SETTING
	public static final String SETTING_STATUS_VISIBLE		= "visible";
	public static final String SETTING_STATUS_NO_VISIBLE	= "no_visible";
	public static final String SETTING_STATUS_NO_EDITABLE	= "no_editable";
	// SETTINGS FOR COMPANY
	public static final String SETTING_LAST_LEVEL_FOR_APPROVE_SHEET	= "setting.last_level_for_approve_sheet";
	public static final String SETTING_FOLLOWUP_INFORMATION_CSV		= "setting.followup_information_csv";
	public static final String SETTING_STATUS_REPORT_ORDER			= "setting.status_report_order";
	
	
	// Show "sum of external costs"
	public static final boolean SHOW_EXTERNAL_COSTS_FIELD = Boolean.valueOf(notRequired("project.initiating.external_costs.show", "true"));
	
	// MAIL NOTIFICATION
	public static final boolean MAIL_NOTIFICATION = Boolean.valueOf(notRequired("mail.notification", "false"));
	
	// SHOW QUARTERS IN WORKINGCOSTS
	public static final boolean SHOW_QUARTERS = Boolean.valueOf(notRequired("workingcosts.quarters", "false"));
	
	// INTERNAL COSTS IN WORKINGCOSTS
	public static final int INTERNAL_COSTS = Integer.valueOf(notRequired("workingcosts.internal_costs", "30"));
	
	// Working costs departments
	public static final String[] WORKING_COST_DEPARTMENTS = notRequired("workingcosts.deparments", "").split(",");	

	// CONFIGURE COLUMNS FOR SHOW OR HIDE IN PROJECT LIST
	public static final boolean PROJECT_COL_RAG				= Boolean.valueOf(notRequired("project.column.rag", 			"true"));
	public static final boolean PROJECT_COL_STATUS			= Boolean.valueOf(notRequired("project.column.status", 			"true"));
	public static final boolean PROJECT_COL_ACCOUNTING_CODE = Boolean.valueOf(notRequired("project.column.accounting_code", "true"));
	public static final boolean PROJECT_COL_PROJECT_NAME	= Boolean.valueOf(notRequired("project.column.project_name", 	"true"));
	public static final boolean PROJECT_COL_SHORT_NAME		= Boolean.valueOf(notRequired("project.column.short_name", 		"true"));
	public static final boolean PROJECT_COL_BUDGET			= Boolean.valueOf(notRequired("project.column.budget", 			"true"));
	public static final boolean PROJECT_COL_PRIORITY		= Boolean.valueOf(notRequired("project.column.priority", 		"true"));
	public static final boolean PROJECT_COL_POC				= Boolean.valueOf(notRequired("project.column.poc", 			"true"));
	public static final boolean PROJECT_COL_BASELINE_START	= Boolean.valueOf(notRequired("project.column.baseline_start", 	"true"));
	public static final boolean PROJECT_COL_BASELINE_FINISH = Boolean.valueOf(notRequired("project.column.baseline_finish", "true"));
	public static final boolean PROJECT_COL_START			= Boolean.valueOf(notRequired("project.column.start", 			"true"));
	public static final boolean PROJECT_COL_FINISH			= Boolean.valueOf(notRequired("project.column.finish", 			"true"));
	public static final boolean PROJECT_COL_INTERNAL_EFFORT	= Boolean.valueOf(notRequired("project.column.internal_effort",	"true"));
	public static final boolean PROJECT_COL_EXTERNAL_COST	= Boolean.valueOf(notRequired("project.column.external_cost",	"true"));
	public static final boolean PROJECT_COL_AC				= Boolean.valueOf(notRequired("project.column.actual_cost",		"true"));
	
	// CONFIGURE COLUMNS FOR SHOW OR HIDE IN INVESTMENT LIST
	public static final boolean INVESTMENT_COL_STATUS			= Boolean.valueOf(notRequired("investment.column.status",	 		"true"));
	public static final boolean INVESTMENT_COL_ACCOUNTING_CODE	= Boolean.valueOf(notRequired("investment.column.accounting_code",	"true"));
	public static final boolean INVESTMENT_COL_NAME				= Boolean.valueOf(notRequired("investment.column.name",				"true"));
	public static final boolean INVESTMENT_COL_SHORT_NAME		= Boolean.valueOf(notRequired("investment.column.short_name",		"true"));
	public static final boolean INVESTMENT_COL_BUDGET			= Boolean.valueOf(notRequired("investment.column.budget",			"true"));
	public static final boolean INVESTMENT_COL_PRIORITY			= Boolean.valueOf(notRequired("investment.column.priority",			"true"));
	public static final boolean INVESTMENT_COL_PROBABILITY		= Boolean.valueOf(notRequired("investment.column.probability",		"true"));
	public static final boolean INVESTMENT_COL_BASELINE_START	= Boolean.valueOf(notRequired("investment.column.baseline_start",	"true"));
	public static final boolean INVESTMENT_COL_BASELINE_FINISH	= Boolean.valueOf(notRequired("investment.column.baseline_finish",	"true"));
	public static final boolean INVESTMENT_COL_START			= Boolean.valueOf(notRequired("investment.column.start",			"true"));
	public static final boolean INVESTMENT_COL_FINISH			= Boolean.valueOf(notRequired("investment.column.finish",			"true"));
	public static final boolean INVESTMENT_COL_INTERNAL_EFFORT	= Boolean.valueOf(notRequired("investment.column.internal_effort",	"true"));
	public static final boolean INVESTMENT_COL_EXTERNAL_COST	= Boolean.valueOf(notRequired("investment.column.external_cost",	"true"));
	
	// Project Charter Template 
	public static final String PROJECT_CHARTER_CLASSNAME = properties.getString("project.charter.classname");
	
	// Project Charter file extension 
	public static final String PROJECT_CHARTER_EXTENSION = properties.getString("project.charter.extension");
	
	// Project Close file extension 
	public static final String PROJECT_CLOSE_EXTENSION = properties.getString("project.close.extension");
	
	// Project Close Template 
	public static final String PROJECT_CLOSE_CLASSNAME = properties.getString("project.close.classname");
	
	
	// Temp directory for store docs
	public static final String TEMP_DIR_GENERATE_DOCS = notRequired("temp.dir_generate_docs", System.getProperty("java.io.tmpdir"));
	
	// Default Locale language and country
	public static final String LOCALE_LANGUAGE_DEFAULT	= notRequired("locale.language.default", "en");
	public static final String LOCALE_COUNTRY_DEFAULT	= notRequired("locale.country.default", "US");
	public static final String[] LOCALE_AVAILABLES		= notRequired("locale.available", "").split(",");
	
	// Performance
	public static final boolean PERFORMANCE_COMPRESS_HTML	= Boolean.valueOf(notRequired("performance.compress_html",	"false"));
	public static final boolean PERFORMANCE_COMPRESS_JS		= Boolean.valueOf(notRequired("performance.compress_js",	"false"));
	
	private static final String notRequired(String key, String defaultValue) {
		
		String value = null;
		
		try { value = properties.getString(key); }
		catch (Exception e) { value = defaultValue; }
		
		LOGGER.info("Value for key '" + key + "': " + value);

		return value;
	}
	
	// Login 
	public static final boolean LOGIN_LDAP = Boolean.valueOf(notRequired("login.ldap", "false"));
}
