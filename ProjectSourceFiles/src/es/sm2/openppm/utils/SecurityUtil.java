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

import java.security.MessageDigest;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.servlets.AdministrationServlet;
import es.sm2.openppm.servlets.AssignmentServlet;
import es.sm2.openppm.servlets.ExpenseSheetServlet;
import es.sm2.openppm.servlets.ProgramServlet;
import es.sm2.openppm.servlets.ProjectServlet;
import es.sm2.openppm.servlets.ResourceServlet;
import es.sm2.openppm.servlets.TimeSheetServlet;
import es.sm2.openppm.servlets.UtilServlet;

public final class SecurityUtil {

	private static final Logger LOGGER = Logger.getLogger(SecurityUtil.class);
	
	private SecurityUtil() {
		super();
	}
	
	public static boolean isUserInRole(HttpServletRequest request, int role) {
		
		Integer sessionRol = (Integer)request.getSession().getAttribute("rolPrincipal");
		return (sessionRol == role);
	}
	
	public static int consUserRole(HttpServletRequest request) {
		
		Integer sessionRol = (Integer)request.getSession().getAttribute("rolPrincipal");
		return (sessionRol == null ? -1 : sessionRol);
	}
	
	public static Employee consUser(HttpServletRequest request) {
		
		return (Employee) request.getSession().getAttribute("user");
	}

	public static void unsetUserRole(HttpServletRequest request) {
		
		request.getSession().setAttribute("rolPrincipal",-1);
	}
	
	
	public static boolean hasPermission(Employee user, char status, int tab) {
		
		boolean permission = false;
		
		if (user != null && user.getResourceprofiles() != null) {
			
			int rol = user.getResourceprofiles().getIdProfile();
			
			if ((status == Constants.STATUS_INITIATING || status == Constants.STATUS_PLANNING || status == Constants.STATUS_CONTROL)
					&& (tab == Constants.TAB_INITIATION || tab == Constants.TAB_PLAN || tab == Constants.TAB_RISK)
					&& (rol == Constants.ROLE_PM || rol == Constants.ROLE_PMO)) {
				
				permission = true;
			}
			else if ((status == Constants.STATUS_INITIATING || status == Constants.STATUS_PLANNING || status == Constants.STATUS_CONTROL)
					&& (tab == Constants.TAB_INVESTMENT)
					&& (rol == Constants.ROLE_PMO || rol == Constants.ROLE_IM)) {
				
				permission = true;
			}
			else if ((status == Constants.STATUS_PLANNING || status == Constants.STATUS_CONTROL)
					&& (tab == Constants.TAB_PROCURAMENT)
					&& (rol == Constants.ROLE_PM || rol == Constants.ROLE_PMO)) {
				
				permission = true;
			}
			else if (status == Constants.STATUS_CONTROL
					&& (tab == Constants.TAB_CONTROL || tab == Constants.TAB_CLOSURE)
					&& (rol == Constants.ROLE_PM || rol == Constants.ROLE_PMO)) {
				
				permission = true;
			}
			else if ((tab == Constants.TAB_INVESTMENT)
					&& (rol == Constants.ROLE_PM || rol == Constants.ROLE_PMO)) {
				
				permission = true;
			}
		}
		
		return permission;
	}
	
	public static boolean hasPermission(HttpServletRequest req, String accion) {
		
		boolean permission = false;
		
		Employee user = consUser(req);
		
		if (user != null && user.getResourceprofiles() != null) {
			
			int rol = user.getResourceprofiles().getIdProfile();
			
			if (rol == Constants.ROLE_PMO && (
					accion.equals(ProjectServlet.JX_APPROVE_INVESTMENT) ||
					accion.equals(ProgramServlet.SAVE_PROGRAM) ||
					accion.equals(ProgramServlet.DEL_PROGRAM) ||
					accion.equals(ResourceServlet.JX_VIEW_RESOURCE) ||
					accion.equals(UtilServlet.JX_CHANGE_CLOSED_TO_CONTROL)
			)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_PROGM && (
					accion.equals(ProgramServlet.SAVE_PROGRAM) ||
					accion.equals(ResourceServlet.REFERENCE) ||					
					accion.equals(ResourceServlet.JX_VIEW_RESOURCE))) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_IM && (
					accion.equals(ProjectServlet.JX_APPROVE_INVESTMENT)
			)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_PM && (
					accion.equals(ResourceServlet.JX_VIEW_RESOURCE		) ||
					//Time Sheet Servlet
					accion.equals(TimeSheetServlet.VIEW_TIMESHEET			) ||
					accion.equals(TimeSheetServlet.APPROVE_ALL_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.APPROVE_SEL_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.REJECT_SEL_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.REJECT_ALL_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.NEXT_WEEK_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.PREVIOUS_WEEK_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.JX_APPROVE_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.JX_REJECT_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.JX_VIEW_COMMENTS			) ||
					//Expense Sheet Servlet
					accion.equals(ExpenseSheetServlet.VIEW_EXPENSE_SHEET		) ||
					accion.equals(ExpenseSheetServlet.PREV_MONTH_SHEET 			) ||
					accion.equals(ExpenseSheetServlet.NEXT_MONTH_SHEET			) ||
					accion.equals(ExpenseSheetServlet.APPROVE_ALL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.REJECT_ALL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.APPROVE_SEL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.REJECT_SEL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.JX_VIEW_COMMENTS			)
			)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_RM && (
					accion.equals(ResourceServlet.REFERENCE)				||
					accion.equals(ResourceServlet.VIEW_ASSIGNATIONS)		||
					accion.equals(ResourceServlet.VIEW_RESOURCE_POOL)		||
					accion.equals(ResourceServlet.VIEW_CAPACITY_PLANNING)	||
					accion.equals(ResourceServlet.VIEW_CAPACITY_RUNNING)	||
					accion.equals(ResourceServlet.CAPACITY_PLANNING_TO_CSV)	||
					accion.equals(ResourceServlet.JX_FILTER_ASSIGNATIONS)	||
					accion.equals(ResourceServlet.JX_APPROVE_RESOURCE	)	||
					accion.equals(ResourceServlet.JX_REJECT_RESOURCE	)	||
					accion.equals(ResourceServlet.JX_PROPOPSED_RESOURCE	)	||
					accion.equals(ResourceServlet.JX_VIEW_RESOURCE		)	||
					accion.equals(ResourceServlet.JX_UPDATE_CAPACITY_PLANNING) ||
					accion.equals(ResourceServlet.JX_VIEW_CAPACITY_PLANNING_RESOURCE)
					)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_FM && (
					accion.equals(ResourceServlet.REFERENCE) ||					
					accion.equals(ResourceServlet.JX_VIEW_RESOURCE		)
					)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_SPONSOR && (
					accion.equals(ResourceServlet.REFERENCE) ||					
					accion.equals(ResourceServlet.JX_VIEW_RESOURCE		)
					)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_PORFM && (
					accion.equals(ResourceServlet.REFERENCE) ||					
					accion.equals(ResourceServlet.JX_VIEW_RESOURCE		)
					)) {
				
				permission = true;
			}
			else if (rol == SettingUtil.getApprovalRol(req) && (
					//Time Sheet Servlet
					accion.equals(TimeSheetServlet.VIEW_TIMESHEET			) ||
					accion.equals(TimeSheetServlet.APPROVE_ALL_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.APPROVE_SEL_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.REJECT_SEL_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.REJECT_ALL_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.NEXT_WEEK_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.PREVIOUS_WEEK_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.JX_APPROVE_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.JX_REJECT_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.JX_VIEW_COMMENTS			) ||
					//Expense Sheet Servlet
					accion.equals(ExpenseSheetServlet.VIEW_EXPENSE_SHEET		) ||
					accion.equals(ExpenseSheetServlet.PREV_MONTH_SHEET 			) ||
					accion.equals(ExpenseSheetServlet.NEXT_MONTH_SHEET			) ||
					accion.equals(ExpenseSheetServlet.APPROVE_ALL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.REJECT_ALL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.APPROVE_SEL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.REJECT_SEL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.JX_VIEW_COMMENTS			)
				)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_RESOURCE && (
					//Time Sheet Servlet
					accion.equals(TimeSheetServlet.VIEW_TIMESHEET			) ||
					accion.equals(TimeSheetServlet.SAVE_ALL_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.APPROVE_ALL_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.NEXT_WEEK_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.PREVIOUS_WEEK_TIMESHEET	) ||
					accion.equals(TimeSheetServlet.ADD_OPERATION			) ||
					accion.equals(TimeSheetServlet.DEL_OPERATION			) ||
					accion.equals(TimeSheetServlet.JX_SAVE_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.JX_APPROVE_TIMESHEET		) ||
					accion.equals(TimeSheetServlet.JX_VIEW_COMMENTS			) ||
					//Expense Sheet Servlet
					accion.equals(ExpenseSheetServlet.VIEW_EXPENSE_SHEET		) ||
					accion.equals(ExpenseSheetServlet.PREV_MONTH_SHEET 			) ||
					accion.equals(ExpenseSheetServlet.NEXT_MONTH_SHEET			) ||
					accion.equals(ExpenseSheetServlet.ADD_EXPENSE				) ||
					accion.equals(ExpenseSheetServlet.SAVE_ALL_EXPENSESHEET		) ||
					accion.equals(ExpenseSheetServlet.APPROVE_ALL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.REJECT_ALL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.DELETE_ALL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.APPROVE_SEL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.REJECT_SEL_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.JX_SAVE_EXPENSESHEET		) ||
					accion.equals(ExpenseSheetServlet.JX_APPROVE_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.JX_DELETE_EXPENSESHEET	) ||
					accion.equals(ExpenseSheetServlet.JX_VIEW_COMMENTS			) ||
					// Assignaments Servlet
					accion.equals(AssignmentServlet.VIEW_ASSIGNMENTS			) ||
					accion.equals(AssignmentServlet.FILTER_ASSIGNMENTS			)
			)) {
				
				permission = true;
			}
			else if (rol == Constants.ROLE_ADMIN && (
					accion.equals(AdministrationServlet.REFERENCE) ||
					accion.equals(AdministrationServlet.SAVE_SETTING)
			)) {
				
				permission = true;
			}
		}
		return permission;
	}
	
	/**
	 * Has permission user in these project
	 * @param req
	 * @param project
	 * @param tab
	 * @return
	 * @throws Exception
	 */
	public static boolean hasPermission(HttpServletRequest req, Project project, int tab) throws Exception {
		
		boolean permission = false;
		
		Employee user = consUser(req);
		
		if (user != null && user.getResourceprofiles() != null) {
			
			permission = ProjectLogic.hasPermission(project,user, tab);
			
			if (permission) { req.getSession().setAttribute("idProject", project.getIdProject()); }
		}
		return permission;
	}
	
	/**
	 * Encrypt String
	 * @param clear
	 * @return
	 * @throws Exception
	 */
	public static String md5(String text) throws Exception {
		MessageDigest md = MessageDigest.getInstance("MD5");
		byte[] b = md.digest(text.getBytes());
		int size = b.length;
		StringBuffer encryptStr = new StringBuffer(size);
		for (int i = 0; i < size; i++) {
			int u = b[i] & 255;
			if (u < 16) {
				encryptStr.append("0" + Integer.toHexString(u));
			} else {
				encryptStr.append(Integer.toHexString(u));
			}
		}
		return encryptStr.toString();
	}
	
	/**
	 * Generate a random string
	 * @param length
	 * @return
	 */
	public static String getRandomString(int length){
		String randomStr = "";
		long milis = new java.util.GregorianCalendar().getTimeInMillis();
		Random r = new Random(milis);
		int i = 0;
		while ( i < length){
			char c = (char)r.nextInt(255);
			if ( (c >= '0' && c <='9') || (c >='A' && c <='Z') || (c >='a' && c <='z')){
				randomStr += c;
				i ++;
			}
		}
		return randomStr;
	}

	/**
	 * Get user by token
	 * @param token
	 * @return
	 * @throws Exception 
	 */
	public static Employee consUserByToken(String token) throws Exception {

		if (ValidateUtil.isNull(token)) {
			throw new LogicException("The token is empty");
		}
		
		EmployeeLogic employeeLogic = new EmployeeLogic();
		Employee user = employeeLogic.findByToken(token);
		
		if (user == null) {
			throw new LogicException("Not user found for thesse token: "+token);
		}
		
		LOGGER.debug("Authenticated user for use API");
		
		return user;
	}
}
