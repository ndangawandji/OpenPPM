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
/**
 *  Updater : Cédric Ndanga Wandji
 *  Devoteam, 28/05/2015, user story 26 : adding of 4 news constants to give value at the choices in the select lists of the assignment statement.
 *  Devoteam, 22/06/2015, user story 4 : adding default value for the project's priority.
 */
package es.sm2.openppm.common;

import java.util.Locale;
import java.util.ResourceBundle;

/**
 * @author juanma.lopez
 *
 */
public class Constants {
	
	public static final int ROLE_RESOURCE 	= 1; // Resource
	public static final int ROLE_PM 		= 2; // Project Manager
	public static final int ROLE_IM 		= 3; // Investment Manager
	public static final int ROLE_FM 		= 4; // Functional Managers
	public static final int ROLE_PROGM		= 5; // Program Managers
	public static final int ROLE_RM 		= 6; // Resource Managers
	public static final int ROLE_PMO 		= 7; // PMO
	public static final int ROLE_SPONSOR	= 8; // Sponsor
	public static final int ROLE_PORFM		= 9; // Porfolio Managers
	public static final int ROLE_ADMIN		= 10; // Administrator of company
	
	// PROJECTS TABS
	public static final int TAB_INITIATION	= 1;
	public static final int TAB_PLAN		= 2;
	public static final int TAB_RISK		= 3;
	public static final int TAB_CONTROL		= 4;
	public static final int TAB_PROCURAMENT	= 5;
	public static final int TAB_CLOSURE		= 6;
	public static final int TAB_INVESTMENT	= 7;
	
	// Plugins
	public static final String PLUGIN_REDMINE 		= "redmine";
	public static final String PLUGIN_MSPROJECT 	= "msproject";
	public static final String PLUGIN_SHEET 		= "sheet";
	
	// Project or Investment
	public static final char TYPE_PROJECT 		= 'P';
	public static final char TYPE_INVESTMENT 	= 'I';
	
	// Status for Project
	public static final char STATUS_INITIATING 	= 'I';
	public static final char STATUS_PLANNING 	= 'P';
	public static final char STATUS_CONTROL 	= 'C';
	public static final char STATUS_CLOSED		= 'X';	
	
	// Status for investment
	public static final Character INVESTMENT_IN_PROCESS	 = 'P';
	public static final Character INVESTMENT_APPROVED	 = 'A';
	public static final Character INVESTMENT_CLOSED		 = 'C';
	public static final Character INVESTMENT_INACTIVATED = 'I';
	public static final Character INVESTMENT_REJECTED	 = 'R';
	
	// Type for costs
	public static final int COST_TYPE_EXPENSE	= 1;
	public static final int COST_TYPE_DIRECT	= 2;

	// Manteniment type
	public static final int MANT_COMPANY 		  = 1;
	public static final int MANT_PERFORMING_ORG   = 2;
	public static final int MANT_PROGRAM 		  = 3;
	public static final int MANT_SKILL 			  = 4;
	public static final int MANT_CONTACT 		  = 5;
	public static final int MANT_RESOURCE 		  = 6;
	public static final int MANT_BUDGETACCOUNTS   = 7;
	public static final int MANT_CONTRACTTYPE     = 8;
	public static final int MANT_EXPENSEACCOUNTS  = 9;
	public static final int MANT_CATEGORY		  = 10;
	public static final int MANT_GEOGRAPHY		  = 11;
	public static final int MANT_OPERATIONACCOUNT = 12;
	public static final int MANT_OPERATION		  = 13;
	public static final int MANT_CUSTOMERS	  	  = 14;
	public static final int MANT_SELLERS	  	  = 15;
	public static final int MANT_METRIC_KPI	  	  = 16;
	public static final int MANT_CUSTOMER_TYPE	  = 17;
	public static final int MANT_FUNDINGSOURCE	  = 18;
	public static final int MANT_DOCUMENTATION	  = 19;
	public static final int MANT_CHANGETYPE		  = 20;

	// Level for time and expense sheet
	public static final char APP0 		= '0';
	public static final char APP1 		= '1';
	public static final char APP2 		= '2';
	public static final char APP3 		= '3';
	public static final char APP4 		= '4';
	public static final char APPREJECT  = 'R';
	
	//TIME SHEET STATUS
	public static final String TIMESTATUS_APP0  = "app0";
	public static final String TIMESTATUS_APP1  = "app1";
	public static final String TIMESTATUS_APP2  = "app2";
	public static final String TIMESTATUS_APP3  = "app3";
	
	//TIME SHEET STATUT SUPPLEMENT
	public static final int ACTIVITYSTATUT_INPROGRESS 	= 1;	// Value for the "Activity in progress" option cnw us26
	public static final int ACTIVITYSTATUT_NOTSTARTED 	= 0;	// Value for the "Activity not started" option cnw us26
	public static final int ACTIVITYSTATUT_FINISHED   	= 2;	// Value for the "Activity finished"    option cnw us26
	public static final int TIMESTATE_INADVANCE      	= 1;	// Value for the "Activity in advance"  option cnw us26
	public static final int TIMESTATE_LATE           	= 2;	// Value for the "Activity late"        option cnw us26
	public static final int TIMESTATE_ONTIME         	= 0;	// Value for the "Activity on time"     option cnw us26
	public static final int ESTIMATEDGAPSTATUT_RIGHT  	= 0;	// Value for the "Activity right"       option cnw us26
	public static final int ESTIMATEDGAPSTATUT_EXCEEDED = 1;	// Value for the "Activity exceeded"    option cnw us26
	public static final int ESTIMATEDGAPSTATUT_OVERFLOW = 2;	// Value for the "Activity overflow"    option cnw us26
	
	//EXPENSE SHEET STATUS
	public static final String EXPENSE_STATUS_APP0  = "app0";
	public static final String EXPENSE_STATUS_APP1  = "app1";
	public static final String EXPENSE_STATUS_APP2  = "app2";
	public static final String EXPENSE_STATUS_APP3  = "app3";
	

	/**
	 * Only used in GenericServlet and DateUtil to generate Calendar
	 */
	public static Locale DEF_LOCALE 			= new Locale("en", "US");
	public static Locale DEF_LOCALE_NUMBER 		= new Locale("es", "ES");
	public static final String DATE_PATTERN 	= "dd/MM/yyyy";
	public static final String TIME_PATTERN 	= "dd/MM/yyyy HH:mm:ss";
	
	public static final int MAX_NUM_REG_PER_PAGE = 10;
	
	public static final char STRATEGIC_LOW			= '1';
	public static final char STRATEGIC_MEDIUM_LOW	= '2';
	public static final char STRATEGIC_MEDIUM		= '3';
	public static final char STRATEGIC_MEDIUM_HIGH	= '4';
	public static final char STRATEGIC_HIGH			= '5';
	
	public static final char RISK_LOW		= 'L';
	public static final char RISK_MEDIUM	= 'M';
	public static final char RISK_NORMAL	= 'N';
	public static final char RISK_HIGH		= 'H';
	
	// STATUS RESOURCE
	public static final String RESOURCE_ASSIGNED		= "assigned";
	public static final String RESOURCE_PRE_ASSIGNED	= "preassigned";
	public static final String RESOURCE_TURNED_DOWN		= "turneddown";
	public static final String RESOURCE_PROPOSED		= "proposed";
	public static final String RESOURCE_RELEASED		= "released";
	
	public static final Integer EXCEPTION_DAY_ID = -1;
	public static final Integer WEEKEND_DAY_ID = -2;
	public static final Integer NOT_ASSIGNED_DAY_ID = -3;
	
	public static final char FORMAT_DECIMAL = ',';
	public static final char FORMAT_SEPARATOR = '.';
	
	public static final char SEPARATOR_CSV = ';';
	
	// Mail properties
	public static final ResourceBundle properties = ResourceBundle.getBundle("openppm");
	public static final String EMAIL_NO_REPLY = properties.getString("mail.smtp.no_reply");
	public static final String EMAIL_HOST = properties.getString("mail.smtp.host");
	public static final String EMAIL_USER = properties.getString("mail.smtp.user");
	public static final String EMAIL_PASS = properties.getString("mail.smtp.pass");
	public static final String EMAIL_PORT = properties.getString("mail.smtp.port");
	public static final String EMAIL_TLS = properties.getString("mail.smtp.tls");
	
	public static final String VERSION_APP = properties.getString("openppm.version");
	
	public static final String CONTROL_ACCOUNT = "CA";
	
	public static final String DEFAULT_ERROR_EXCEPTION = "msg.error.unxepected_error";
	
	// Level of the bubble for chart
	public static final double BUBBLE_MAX		= 20;
	public static final double BUBBLE_DEFAULT	= 10;
	public static final double BUBBLE_MIN		= 1;
	
	//Classification Stakeholder
	public static final char CLASS_STAKEHOLDER_INTERNAL = 'I';
	public static final char CLASS_STAKEHOLDER_EXTERNAL = 'E';
	
	//Type Stakeholder
	public static final char TYPE_STAKEHOLDER_SUPPORTER = 'S';
	public static final char TYPE_STAKEHOLDER_NEUTRAL 	= 'N';
	public static final char TYPE_STAKEHOLDER_OPPONENT 	= 'O';
	
	// Project default budget accounts
	public static final Integer PROJECT_EXPENSES_ACCOUNT	= 1;
	public static final Integer PROJECT_COSTS_ACCOUNT		= 4;
	
	// Login options
	public static final Integer MAX_LOGIN_ATTEMPS	= Integer.parseInt(properties.getString("login.max_login_attempts"));
	public static final int BLOCK_WAIT_TIME			= Integer.parseInt(properties.getString("login.block_wait_time")); // Minutes
	public static final String APLICATION_ROL		= properties.getString("login.openppm.rol");
	
	
	// Issue Priority
	public static final Character PRIORITY_HIGH		= 'H';
	public static final Character PRIORITY_MEDIUM	= 'M';
	public static final Character PRIORITY_LOW		= 'L';
	
	// Priority value
	public static final Integer PRIORITY_DEFAULT	= 99;		// cnw us4, default value
	
	// Risk probability (Percentage)
	public static final Integer PROBABILITY_TRIVIAL = 10;
	public static final Integer PROBABILITY_MINOR 	= 30;
	public static final Integer PROBABILITY_MODERATE= 50;
	public static final Integer PROBABILITY_HIGH 	= 70;
	public static final Integer PROBABILITY_SEVERE	= 90;
	
	// Risk analysis (Status)
	public static final String CHAR_CLOSED 	= "C";
	public static final String CHAR_OPEN 	= "O";
	public static final String CLOSED 	= "Closed";
	public static final String OPEN 	= "Open";
	
	// Risk Impact (Percentage)
	public static final Integer IMPACT_TRIVIAL 	= 5;
	public static final Integer IMPACT_MINOR 	= 10;
	public static final Integer IMPACT_MODERATE = 20;
	public static final Integer IMPACT_HIGH 	= 40;
	public static final Integer IMPACT_SEVERE	= 80;
	
	// Risk types
	public static final Integer RISK_OPPORTUNITY = 0;
	public static final Integer RISK_THREAT = 1;
	
	// Types documents of project
	public static final String DOCUMENT_INITIATING	= "initiating";
	public static final String DOCUMENT_RISK		= "risk";
	public static final String DOCUMENT_PLANNING	= "planning";
	public static final String DOCUMENT_CONTROL		= "control";
	public static final String DOCUMENT_PROCUREMENT	= "procurement";
	public static final String DOCUMENT_CLOSURE		= "closure";
	public static final String DOCUMENT_INVESTMENT	= "investment";
	
	// Charge Cost
	public static final int SELLER_CHARGE_COST			= 1;
	public static final int INFRASTRUCTURE_CHARGE_COST	= 2;
	public static final int LICENSE_CHARGE_COST			= 3;
	
	// Boolean
	public static final boolean SELECTED					= true;
	public static final boolean UNSELECTED					= false;
	
	// Time show for information message by default (in seconds)
	public static final int INFO_TIME_DEFAULT = Integer.parseInt(properties.getString("time.info_default"));
	
	// Time for close session (in minutes)
	public static final int TIME_SESSION		= Integer.parseInt(properties.getString("time.session"));
	public static final int TIME_SESSION_ADVISE	= Integer.parseInt(properties.getString("time.session.advise"));
	
	// Probability default Values (0-99)
	public static final String[] PROBABILITY_DEFAULT = notRequired("project.probability", "").split(",");
	
	// Document storage default values (link, filesystem)
	public static final String DOCUMENT_STORAGE		= properties.getString("project.document.storage");
	public static final String LINK = "link";
	public static final String FILE_SYSTEM = "filesystem";	
	
	// Document folder
	public static final String DOCUMENT_FOLDER		= properties.getString("project.document.folder");
	
	// Default FTE (Workload) for Project Manager resource assignation on create project REQUIRED
	public static final int RESOURCE_ASSIGNATION = Integer.parseInt(properties.getString("project.fte"));

	// MAXLENGTH FOR NUMBERS
	public static final int MAX_CURRENCY = 14;
	
	// Yes or no
	public static final String YES = "Y";
	public static final String NO = "N";
	
	public static final String ASCENDENT = "asc";
	public static final String DESCENDENT = "desc";

	public static final double DEFAULT_HOUR_WEEK	= 40;
	public static final double DEFAULT_HOUR_DAY		= 8;
	
	public static final long MILLSECS_PER_DAY = 24 * 60 * 60 * 1000;
	
	private static final String notRequired(String key, String defaultValue) {
		
		String value = null;
		
		try { value = properties.getString(key); }
		catch (Exception e) { value = defaultValue; }
		
		return value;
	}
	
	// Weeks days
	public static final String SATURDAY = "S";
	public static final String SUNDAY = "D";
	
	// Sheet Info
	public static final int MONTH_YEAR_AREA_COLUMN = 22;
	public static final int MONTH_ROW = 1;
	public static final int YEAR_ROW = 3;
	public static final int AREA_ROW = 5;
	public static final int NAME_SURNAME_COLUMN = 33;
	public static final int NAME_ROW = 1;
	public static final int SURNAME_ROW = 3;
	public static final int DATE_ROW = 7;
	public static final int DATE_COLUMN = 35;
	public static final int WORKING_DAY = 8;
	
	// Time Sheet
	public static final int INIT_DAYS_ROW = 15;	
	public static final int INIT_CF_ROW = 8;
	public static final int INIT_TIMESHEET_COLUMN = 2;
	public static final int CF_COLUMN_INCREMENT = 2;
	public static final int CALCULATED_ROW = 52;
	public static final int INIT_CALCULATED_ROW = 4;
	public static final int START_CALCUL = 16;
	public static final int END_CALCUL = 52;
	public static final int NUMBER_WEEK_DAYS = 7;
	public static final int INTERN_PROJECT_COLUMN = 16;
	public static final int OPERATION_PROSPECCION = 1;
	public static final int OPERATION_PROPUESTAS = 2;
	public static final int OPERATION_GESTION = 3;
	public static final int OPERATION_FORMACION = 4;
	public static final int OPERATION_VACACIONES = 5;
	public static final int OPERATION_ENFERMEDAD = 6;
	public static final int OPERATION_OTROS = 7;
	public static final int OPERATION_ESPERA = 8;	
	public static final int OPERATION_PROSPECCION_COLUMN = 18;
	public static final int OPERATION_PROPUESTAS_COLUMN = 20;
	public static final int OPERATION_GESTION_COLUMN = 22;
	public static final int OPERATION_FORMACION_COLUMN = 24;
	public static final int OPERATION_VACACIONES_COLUMN = 28;
	public static final int OPERATION_ENFERMEDAD_COLUMN = 29;
	public static final int OPERATION_OTROS_COLUMN = 30;
	public static final int OPERATION_ESPERA_COLUMN = 26;
	public static final int INIT_PERSONAL_COLUMN = 28;
	
	// Expenses Sheet
	public static final int EXPENSE_INIT_ROW = 64;
	public static final int EXPENSE_DATE_COLMUMN = 0;
	public static final int EXPENSE_DESC_COLMUMN = 4;
	public static final int EXPENSE_INCREMENT = 8;
	public static final int EXPENSE_GENERAL_COLUMN = 13;
	public static final int EXPENSE_PROJECT_COLUMN = 21;
	public static final int EXPENSE_CF_ROW = 60;
	public static final int EXPENSE_CF_COLUMN = 22;
	public static final int EXPENSE_CF_INCREMENT = 8;
	
	// Monthly Info
	public static final int CLIENT_ROW = 6;
	public static final int CLIENT_COLUMN = 0;
	public static final String CLIENT_TEXT = "Cliente: ";
	public static final int TECNICO_ROW = 8;
	public static final int TECNICO_COLUMN = 0;
	public static final String TECNICO_TEXT = "TÃ©cnico SM2 BALEARES: ";
	public static final int MONTHLY_MONTH_ROW = 10;
	public static final int MONTHLY_MONTH_COLUMN = 6;
	public static final int MONTHLY_YEAR_ROW = 10;
	public static final int MONTHLY_YEAR_COLUMN = 9;
	
	// Monthly Sheet	
	public static final int MONTHLY_INIT_DAYS_ROW = 13;
	public static final int MONTHLY_START_TIME_1_COLUMN = 2;
	public static final int MONTHLY_START_TIME_2_COLUMN = 4;
	public static final int MONTHLY_END_TIME_1_COLUMN = 3;
	public static final int MONTHLY_END_TIME_2_COLUMN = 5;
	public static final int MONTHLY_TOTAL_COLUMN = 6;
}
