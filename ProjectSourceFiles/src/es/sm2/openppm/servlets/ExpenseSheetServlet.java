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
package es.sm2.openppm.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.ExpenseaccountsLogic;
import es.sm2.openppm.logic.ExpensesheetLogic;
import es.sm2.openppm.logic.ExpensesheetcommentLogic;
import es.sm2.openppm.logic.OperationLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expenseaccounts;
import es.sm2.openppm.model.Expenses;
import es.sm2.openppm.model.Expensesheet;
import es.sm2.openppm.model.Expensesheetcomment;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.Exclusion;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.SettingUtil;
import es.sm2.openppm.utils.StringUtil;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class TimeSheetServlet
 */
public class ExpenseSheetServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	private static final Logger LOGGER		= Logger.getLogger(ExpenseSheetServlet.class);
	public final static String REFERENCE	= "expensesheet";
	
	/***************** Actions ****************/
	public final static String VIEW_EXPENSE_SHEET		= "view-expensesheet";
	public final static String PREV_MONTH_SHEET 		= "previous-month-sheet";
	public final static String NEXT_MONTH_SHEET			= "next-month-sheet";
	public final static String ADD_EXPENSE				= "add-expensesheet";
	public final static String SAVE_ALL_EXPENSESHEET	= "save-all-expensesheet";
	public final static String APPROVE_ALL_EXPENSESHEET	= "approve-all-expensesheet";
	public final static String REJECT_ALL_EXPENSESHEET	= "reject-all-expensesheet";
	public final static String DELETE_ALL_EXPENSESHEET	= "delete-all-expensesheet";
	public final static String APPROVE_SEL_EXPENSESHEET	= "approve-sel-expensesheet";
	public final static String REJECT_SEL_EXPENSESHEET	= "reject-sel-expensesheet";
	
	/************** Actions AJAX **************/
	public final static String JX_SAVE_EXPENSESHEET		= "ajax-save-expensesheet";
	public final static String JX_APPROVE_EXPENSESHEET		= "ajax-approve-expensesheet";
	public final static String JX_DELETE_EXPENSESHEET		= "ajax-delete-expensesheet";
	public final static String JX_VIEW_COMMENTS			= "ajax-view-comments-expensesheet";
    
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1 && SecurityUtil.hasPermission(req, ValidateUtil.isNullCh(accion, VIEW_EXPENSE_SHEET))) {

			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion) || VIEW_EXPENSE_SHEET.equals(accion)) { viewExpenseSheet(req, resp, null); }
			else if (PREV_MONTH_SHEET.equals(accion)){ prevMonthSheet(req, resp); }
			else if (NEXT_MONTH_SHEET.equals(accion)) { nextMonthSheet(req, resp); }
			else if (ADD_EXPENSE.equals(accion)) { addExpenseSheet(req, resp); }
			else if (SAVE_ALL_EXPENSESHEET.equals(accion)) { updateAllExpenseSheet(req, resp, false); }
			else if (APPROVE_ALL_EXPENSESHEET.equals(accion)) {
				if (SecurityUtil.isUserInRole(req, Constants.ROLE_RESOURCE)) { updateAllExpenseSheet(req, resp, true); }
				else { changeALLExpenseSheet(req, resp, true); }
				
			}
			else if (REJECT_ALL_EXPENSESHEET.equals(accion)) { changeALLExpenseSheet(req, resp, false); }
			else if (DELETE_ALL_EXPENSESHEET.equals(accion)) { deleteAllExpenseSheet(req, resp); }
			else if (APPROVE_SEL_EXPENSESHEET.equals(accion)) { changeSellExpenseSheet(req, resp, true); }
			else if (REJECT_SEL_EXPENSESHEET.equals(accion)) { changeSellExpenseSheet(req, resp, false); }
			
			/************** Actions AJAX **************/
			else if (JX_SAVE_EXPENSESHEET.equals(accion)) { updateExpenseSheetJX(req, resp, false); }
			else if (JX_APPROVE_EXPENSESHEET.equals(accion)) { updateExpenseSheetJX(req, resp, true); }
			else if (JX_DELETE_EXPENSESHEET.equals(accion)) { deleteExpenseSheetJX(req, resp); }
			else if (JX_VIEW_COMMENTS.equals(accion)) { viewCommentsJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}

    /**
     * Change selected Expense Sheets
     * @param req
     * @param resp
     * @param approve
     * @throws IOException 
     * @throws ServletException 
     */
    private void changeSellExpenseSheet(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws ServletException, IOException {
		
    	Date sheetDate = ParamUtil.getDate(req, "sheetDate", dateFormat, DateUtil.getCalendar().getTime());
		
    	String idProjectsStr	= ParamUtil.getString(req, "idProjects",null);
    	String idEmployeesStr	= ParamUtil.getString(req, "idEmployees",null);
    	String comments			= ParamUtil.getString(req, "comments");
    	
    	Integer[] idProjects	= StringUtil.splitStrToIntegers(idProjectsStr, null);
    	Integer[] idEmployees	= StringUtil.splitStrToIntegers(idEmployeesStr, null);
    	
    	try {
			
    		if (idEmployees != null && idEmployees.length > 0) {
    			
    			ExpensesheetLogic expensesheetLogic		= new ExpensesheetLogic();
    			ExpensesheetcommentLogic commentLogic	= new ExpensesheetcommentLogic();
    			
    			int approvalRol = SettingUtil.getApprovalRol(req);
    			
    			Employee filterUser = (SecurityUtil.isUserInRole(req, approvalRol)?SecurityUtil.consUser(req):null);
    			
    			// Status for rol
    			String previousStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)?Constants.EXPENSE_STATUS_APP1:Constants.EXPENSE_STATUS_APP2);
	    		String nextStatus	  = null;
	    		
	    		if (approve) {
	    			nextStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM) && approvalRol >0?Constants.EXPENSE_STATUS_APP2:Constants.EXPENSE_STATUS_APP3);
	    		}
	    		else { nextStatus = Constants.EXPENSE_STATUS_APP0; }
    			
    			int i = 0;
    			for (int idEmployee : idEmployees) {
    				
    				Project proj = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)?new Project(idProjects[i]):null);
    	    		
    	    		// Get Expense Sheet for change
    				List<Expensesheet> expenseSheets = expensesheetLogic.findByResource(new Employee(idEmployee), sheetDate, null,
    						proj, previousStatus, previousStatus, filterUser);
    				
    				expenseSheets.addAll(expensesheetLogic.findByResource(new Employee(idEmployee), sheetDate, null,
    						null, previousStatus, previousStatus, null));
    				
    				// Change time Sheets
    				for (Expensesheet expenseSheet : expenseSheets) {
    					
    					Expensesheetcomment expenseSheetComment = new Expensesheetcomment();
    					expenseSheetComment.setContentComment(comments);
    					expenseSheetComment.setActualStatus(nextStatus);
    					expenseSheetComment.setPreviousStatus(previousStatus);
    					expenseSheetComment.setExpensesheet(expenseSheet);
    					expenseSheetComment.setCommentDate(new Date());
    					commentLogic.save(expenseSheetComment);
    					
    					expenseSheet.setStatus(nextStatus);
	    	    			
    					expensesheetLogic.save(expenseSheet);
    				}
    				
    				i++;
    			}
    		}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewExpenseSheet(req, resp, sheetDate);
	}

	/**
     * Change All Expense Sheet
     * @param req
     * @param resp
     * @param approve
     * @throws IOException 
     * @throws ServletException 
     */
    private void changeALLExpenseSheet(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws ServletException, IOException {
    	
    	Integer[] ids	= ParamUtil.getIntegerList(req, "idExpenseSheet");
		String comments	= ParamUtil.getString(req, "comments");
		
		try {
			
			if (ids != null) {
    			
    			ExpensesheetLogic expensesheetLogic		= new ExpensesheetLogic();
    			ExpensesheetcommentLogic commentLogic	= new ExpensesheetcommentLogic();
    			
    			String previousStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)?Constants.EXPENSE_STATUS_APP1:Constants.EXPENSE_STATUS_APP2);
	    		String nextStatus	  = null;
	    		
	    		if (approve) {
	    			nextStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM) && SettingUtil.getApprovalRol(req) > 0?Constants.EXPENSE_STATUS_APP2:Constants.EXPENSE_STATUS_APP3);
	    		}
	    		else { nextStatus = Constants.EXPENSE_STATUS_APP0; }
	    		
    			for (int idExpenseSheet : ids) {
    				
    				Expensesheet expense = expensesheetLogic.findById(idExpenseSheet);
    				
    				if (previousStatus.equals(expense.getStatus())) {
    					
    					Expensesheetcomment expenseSheetComment = new Expensesheetcomment();
    					expenseSheetComment.setContentComment(comments);
    					expenseSheetComment.setActualStatus(nextStatus);
    					expenseSheetComment.setPreviousStatus(previousStatus);
    					expenseSheetComment.setExpensesheet(expense);
    					expenseSheetComment.setCommentDate(new Date());
    					commentLogic.save(expenseSheetComment);
	    				
    					expense.setStatus(nextStatus);
    					
	    				expensesheetLogic.save(expense);
    				}
    			}
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewExpenseSheet(req, resp, null);
	}

	/**
     * Update Expense Sheet
     * @param req
     * @param resp
     * @param approve
     * @throws IOException 
     */
    private void updateExpenseSheetJX(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws IOException {
		
    	Integer idExpenseSheet	= ParamUtil.getInteger(req, "idExpenseSheet");
    	Date expenseDate		= ParamUtil.getDate(req, "expenseDate", dateFormat, new Date());
    	int idExpenseAccount	= ParamUtil.getInteger(req, "idExpenseAccount", -1);
    	int idExpense			= ParamUtil.getInteger(req, "idExpense", -1);
    	boolean reimbursable	= ParamUtil.getBoolean(req, "reimbursable");
    	boolean paidEmployee	= ParamUtil.getBoolean(req, "paidEmployee");
    	int autorizationNumber	= ParamUtil.getInteger(req, "autorizationNumber");
    	String description		= ParamUtil.getString(req, "description");
    	double cost				= ParamUtil.getCurrency(req, "cost", 0);
    	String comments			= ParamUtil.getString(req, "comments");
    	
		PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		ExpensesheetLogic expensesheetLogic		= new ExpensesheetLogic();
    		
			Expensesheet expense = expensesheetLogic.findById(idExpenseSheet);
			
			expense.setExpenseDate(expenseDate);
			expense.setReimbursable(reimbursable);
			expense.setPaidEmployee(paidEmployee);
			expense.setAutorizationNumber(autorizationNumber);
			expense.setDescription(description);
			expense.setCost(cost);
			
			if (idExpenseAccount != -1) { expense.setExpenseaccounts(new Expenseaccounts(idExpenseAccount)); }
			else if (idExpense != -1) { expense.setExpenses(new Expenses(idExpense));  }
			
			JSONObject returnJSON = null;
			
			if (approve) {
				ExpensesheetcommentLogic commentLogic	= new ExpensesheetcommentLogic();
				
				Expensesheetcomment expenseSheetComment = new Expensesheetcomment();
				expenseSheetComment.setContentComment(comments);
				expenseSheetComment.setActualStatus(Constants.TIMESTATUS_APP1);
				expenseSheetComment.setPreviousStatus(expense.getStatus());
				expenseSheetComment.setExpensesheet(expense);
				expenseSheetComment.setCommentDate(new Date());
				commentLogic.save(expenseSheetComment);
				
				expense.setStatus(Constants.EXPENSE_STATUS_APP1);
				
				returnJSON = info("msg.info.status", returnJSON, "expense", "applevel.app1");
			}
			else { returnJSON = infoUpdated(returnJSON, "expense"); }
			
			expensesheetLogic.save(expense);
    		
    		out.print(returnJSON);
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

    /**
     * Delete Expense Sheet
     * @param req
     * @param resp
     * @throws IOException 
     */
	private void deleteExpenseSheetJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		Integer idExpenseSheet	= ParamUtil.getInteger(req, "idExpenseSheet");
		
		PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		ExpensesheetLogic expensesheetLogic = new ExpensesheetLogic();
			
			Expensesheet expense = expensesheetLogic.findById(idExpenseSheet);
			expensesheetLogic.delete(expense);
    		
    		out.print(infoDeleted("expense"));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
	 * View Comments
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	private void viewCommentsJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		int idExpenseSheet = ParamUtil.getInteger(req, "idExpenseSheet",-1);
    	
		PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		ExpensesheetcommentLogic commentLogic	= new ExpensesheetcommentLogic();
    		
    		List<Expensesheetcomment> comments = commentLogic.findByRelation(Expensesheetcomment.EXPENSESHEET, new Expensesheet(idExpenseSheet));
    		
    		out.print(JsonUtil.toJSON(comments, Constants.TIME_PATTERN, new Exclusion(Expensesheet.class)));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Delete all expense sheet
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void deleteAllExpenseSheet(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	Integer[] ids	= ParamUtil.getIntegerList(req, "idExpenseSheet");
    	
		try {
			
			if (ids != null) {
    			
    			ExpensesheetLogic expensesheetLogic = new ExpensesheetLogic();
    			
    			for (int idExpenseSheet : ids) {
    				
    				Expensesheet expense = expensesheetLogic.findById(idExpenseSheet);
    				if (Constants.EXPENSE_STATUS_APP0.equals(expense.getStatus())) {
    					expensesheetLogic.delete(expense);
    				}
    			}
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewExpenseSheet(req, resp, null);
	}

    /**
     * Update all expense sheet
     * @param req
     * @param resp
     * @param approve
     * @throws IOException 
     * @throws ServletException 
     */
	private void updateAllExpenseSheet(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws ServletException, IOException {
		
		Integer[] ids	= ParamUtil.getIntegerList(req, "idExpenseSheet");
		String comments	= ParamUtil.getString(req, "comments");
		
		try {
			
			if (ids != null) {
    			
    			ExpensesheetLogic expensesheetLogic		= new ExpensesheetLogic();
    			ExpensesheetcommentLogic commentLogic	= new ExpensesheetcommentLogic();
    			
    			for (int idExpenseSheet : ids) {
    				
    				Expensesheet expense = expensesheetLogic.findById(idExpenseSheet);
    				
    				if (Constants.EXPENSE_STATUS_APP0.equals(expense.getStatus())) {
    					
	    				Date expenseDate		= ParamUtil.getDate(req, "expenseDate_"+idExpenseSheet, dateFormat, new Date());
	    				int idExpenseAccount	= ParamUtil.getInteger(req, "expensesType_"+idExpenseSheet, -1);
	    				int idExpense			= ParamUtil.getInteger(req, "idExpense_"+idExpenseSheet, -1);
	    				boolean reimbursable	= ParamUtil.getBoolean(req, "reimbursable_"+idExpenseSheet);
	    				boolean paidEmployee	= ParamUtil.getBoolean(req, "paidEmployee_"+idExpenseSheet);
	    				int autorizationNumber	= ParamUtil.getInteger(req, "autorizationNumber_"+idExpenseSheet);
	    				String description		= ParamUtil.getString(req, "description_"+idExpenseSheet);
	    				double cost				= ParamUtil.getCurrency(req, "cost_"+idExpenseSheet, 0);
	    				
	    				expense.setExpenseDate(expenseDate);
	    				expense.setReimbursable(reimbursable);
	    				expense.setPaidEmployee(paidEmployee);
	    				expense.setAutorizationNumber(autorizationNumber);
	    				expense.setDescription(description);
	    				expense.setCost(cost);
	    				
	    				if (idExpenseAccount != -1) { expense.setExpenseaccounts(new Expenseaccounts(idExpenseAccount)); }
	    				else if (idExpense != -1) { expense.setExpenses(new Expenses(idExpense));  }
	    				
	    				if (approve) {
	    					expense.setStatus(Constants.EXPENSE_STATUS_APP1);
	    					
	    					Expensesheetcomment expenseSheetComment = new Expensesheetcomment();
	    					expenseSheetComment.setContentComment(comments);
	    					expenseSheetComment.setActualStatus(Constants.TIMESTATUS_APP1);
	    					expenseSheetComment.setPreviousStatus(expense.getStatus());
	    					expenseSheetComment.setExpensesheet(expense);
	    					expenseSheetComment.setCommentDate(new Date());
	    					commentLogic.save(expenseSheetComment);
	    				}
	    				
	    				expensesheetLogic.save(expense);
    				}
    			}
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewExpenseSheet(req, resp, null);
	}

	/**
     * Add Expense Sheet
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void addExpenseSheet(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	Date sheetDate = ParamUtil.getDate(req, "sheetDate", dateFormat, DateUtil.getCalendar().getTime());
    	
    	int idOperation = ParamUtil.getInteger(req, "idOperation", -1);
    	int idProject	= ParamUtil.getInteger(req, "idProject", -1);
    	
		try {
			
			ExpensesheetLogic expensesheetLogic = new ExpensesheetLogic();
			
			Expensesheet expense = new Expensesheet();
			expense.setEmployee(SecurityUtil.consUser(req));
			expense.setExpenseDate(sheetDate);
			expense.setStatus(Constants.EXPENSE_STATUS_APP0);
			
			if (idOperation != -1) { expense.setOperation(new Operation(idOperation)); }
			else { expense.setProject(new Project(idProject));  }
			
			expensesheetLogic.save(expense);
			
			infoCreated(req, "expense");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewExpenseSheet(req, resp, sheetDate);
	}

	/**
	 * Goto to the next month
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void nextMonthSheet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Date sheetDate		= ParamUtil.getDate(req, "sheetDate", dateFormat, DateUtil.getCalendar().getTime());
		
		Calendar cal = DateUtil.getCalendar();
		cal.setTime(sheetDate);
		cal.add(Calendar.MONTH, +1);
		
		viewExpenseSheet(req, resp, cal.getTime());
	}

	/**
	 * Goto to the previous month
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void prevMonthSheet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Date sheetDate		= ParamUtil.getDate(req, "sheetDate", dateFormat, DateUtil.getCalendar().getTime());
		
		Calendar cal = DateUtil.getCalendar();
		cal.setTime(sheetDate);
		cal.add(Calendar.MONTH, -1);
		
		viewExpenseSheet(req, resp, cal.getTime());
	}

	/**
	 * View Sheet
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void viewExpenseSheet(HttpServletRequest req,
			HttpServletResponse resp, Date sheetDate) throws ServletException, IOException {
		
		if (sheetDate == null) { sheetDate = ParamUtil.getDate(req, "sheetDate", dateFormat, DateUtil.getCalendar().getTime()); }
		
		Calendar cal = DateUtil.getCalendar();
		cal.setTime(sheetDate);
		req.setAttribute("month", (cal.get(Calendar.MONTH)+1));
		
		if (SecurityUtil.isUserInRole(req, Constants.ROLE_RESOURCE)) { viewExpenseSheetEmployee(req, resp, sheetDate); }
		else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) { approveExpenseSheetByProject(req, resp, sheetDate); }
		else if (SecurityUtil.isUserInRole(req, SettingUtil.getApprovalRol(req))) { approveExpenseSheet(req, resp, sheetDate); }
	}

	/**
	 * Approve Expense Sheet
	 * @param req
	 * @param resp
	 * @param sheetDate
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void approveExpenseSheet(HttpServletRequest req,
			HttpServletResponse resp, Date sheetDate) throws ServletException, IOException {

		Integer idEmployee	= ParamUtil.getInteger(req, "idEmployee", null);
    	
    	List<Employee> approvals	= null;
		List<Expensesheet> expenses = null;
		Employee employee			= null;
		
		try {
			
			EmployeeLogic employeeLogic = new EmployeeLogic();
			approvals = employeeLogic.findApprovalsExpense(
					SecurityUtil.consUser(req),
					DateUtil.getFirstMonthDay(sheetDate),
					DateUtil.getLastMonthDay(sheetDate));
			
			if (idEmployee != null) {
				
				ExpensesheetLogic expensesheetLogic = new ExpensesheetLogic();
    			
    			List<String> joins = new ArrayList<String>();
    			joins.add(Expensesheet.PROJECT);
    			joins.add(Expensesheet.OPERATION);
    			joins.add(Expensesheet.EXPENSEACCOUNTS);
    			joins.add(Expensesheet.EXPENSES);
    			joins.add(Expensesheet.EXPENSES+"."+Expenses.BUDGETACCOUNTS);
    			
    			expenses = expensesheetLogic.findByResource(
    					new Employee(idEmployee),
    					sheetDate, joins,
    					null, Constants.TIMESTATUS_APP2, Constants.TIMESTATUS_APP3, SecurityUtil.consUser(req));
    			
    			expenses.addAll(expensesheetLogic.findByResource(
    					new Employee(idEmployee),
    					sheetDate, joins,
    					null, Constants.TIMESTATUS_APP2, Constants.TIMESTATUS_APP3, null));
    			
    			joins = new ArrayList<String>();
    			joins.add(Employee.CONTACT);
    			employee = employeeLogic.findById(idEmployee, joins);
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("approvals", approvals);
		req.setAttribute("expenses", expenses);
		req.setAttribute("sheetDate", sheetDate);
		req.setAttribute("employee", employee);
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.expense_approvals"));
		forward("/index.jsp?nextForm=expensesheet/approve_expensesheet", req, resp);
	}

	/**
	 * Approve Expense Sheet by Project
	 * @param req
	 * @param resp
	 * @param sheetDate
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void approveExpenseSheetByProject(HttpServletRequest req,
			HttpServletResponse resp, Date sheetDate) throws ServletException, IOException {

		Integer idEmployee	= ParamUtil.getInteger(req, "idEmployee", null);
    	Integer idProject 	= ParamUtil.getInteger(req, "idProject", null);
    	
    	List<Object[]> approvals	= null;
		List<Expensesheet> expenses = null;
		Employee employee			= null;
		Project project				= null;
		Set<Project> projects	 	= new HashSet<Project>(0);
		try {
			
			String maxStatus = SettingUtil.getApprovalRol(req) > 0?Constants.EXPENSE_STATUS_APP2:Constants.EXPENSE_STATUS_APP3;
			
			EmployeeLogic employeeLogic = new EmployeeLogic();
			approvals = employeeLogic.findApprovalsExpenseByPM(
					SecurityUtil.consUser(req),
					DateUtil.getFirstMonthDay(sheetDate),
					DateUtil.getLastMonthDay(sheetDate),
					maxStatus);
			
			for (Object[] item :approvals) {
    			
    			Project proj = new Project((Integer)item[2]);
    			proj.setProjectName((String)item[3]);
    			
    			if (!projects.contains(proj)) { projects.add(proj); }
    		}
			
			if (idEmployee != null && idProject != null) {
				
				ExpensesheetLogic expensesheetLogic = new ExpensesheetLogic();
    			ProjectLogic projectLogic			= new ProjectLogic();
    			
    			List<String> joins = new ArrayList<String>();
    			joins.add(Expensesheet.PROJECT);
    			joins.add(Expensesheet.OPERATION);
    			joins.add(Expensesheet.EXPENSEACCOUNTS);
    			joins.add(Expensesheet.EXPENSES);
    			joins.add(Expensesheet.EXPENSES+"."+Expenses.BUDGETACCOUNTS);
    			
    			
    			expenses = expensesheetLogic.findByResource(
    					new Employee(idEmployee),
    					sheetDate, joins,
    					new Project(idProject), Constants.EXPENSE_STATUS_APP1, maxStatus, null);
    			
    			expenses.addAll(expensesheetLogic.findByResource(
    					new Employee(idEmployee),
    					sheetDate, joins,
    					null, Constants.EXPENSE_STATUS_APP1, maxStatus, null));
    			
    			joins = new ArrayList<String>();
    			joins.add(Employee.CONTACT);
    			employee = employeeLogic.findById(idEmployee, joins);
    			
    			project = projectLogic.findById(idProject);
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("approvals", approvals);
		req.setAttribute("expenses", expenses);
		req.setAttribute("projects", projects);
		req.setAttribute("sheetDate", sheetDate);
		req.setAttribute("employee", employee);
		req.setAttribute("project", project);
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.expense_approvals"));
		forward("/index.jsp?nextForm=expensesheet/approve_expensesheet_project", req, resp);
	}

	/**
	 * View the JSP for employee
	 * @param req
	 * @param resp
	 * @param sheetDate
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewExpenseSheetEmployee(HttpServletRequest req, HttpServletResponse resp, Date sheetDate)
		throws ServletException, IOException {
		
		List<Project> projects					= null;
		List<Operation> operations				= null;
		List<Expenseaccounts> expenseAccounts	= null;
		List<Expensesheet> expenseSheets		= null;
		
		try {
			
			OperationLogic operationLogic				= new OperationLogic();
			ExpenseaccountsLogic expenseaccountsLogic	= new ExpenseaccountsLogic();
			ExpensesheetLogic expensesheetLogic			= new ExpensesheetLogic();
			ProjectLogic projectLogic					= new ProjectLogic();

			Employee user	= SecurityUtil.consUser(req);
			Company company	= CompanyLogic.searchByEmployee(user);
			
			List<String> joins = new ArrayList<String>();
			joins.add(Expensesheet.EXPENSEACCOUNTS);
			joins.add(Expensesheet.PROJECT);
			joins.add(Expensesheet.PROJECT+"."+Project.PROJECTCOSTSES);
			joins.add(Expensesheet.PROJECT+"."+Project.PROJECTCOSTSES+"."+Projectcosts.EXPENSESES);
			joins.add(Expensesheet.PROJECT+"."+Project.PROJECTCOSTSES+"."+Projectcosts.EXPENSESES+"."+Expenses.BUDGETACCOUNTS);
			joins.add(Expensesheet.OPERATION);
			joins.add(Expensesheet.EXPENSES);
			joins.add(Expensesheet.EXPENSES+"."+Expenses.BUDGETACCOUNTS);
			
			expenseSheets	= expensesheetLogic.findByResource(user, sheetDate, joins);
			expenseAccounts	= expenseaccountsLogic.findByRelation(Expenseaccounts.COMPANY, company);
			operations		= operationLogic.findByAllCompany(company);
			projects		= projectLogic.findByResourceInProject(user, sheetDate);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("sheetDate", sheetDate);
		req.setAttribute("projects", projects);
		req.setAttribute("operations", operations);
		req.setAttribute("expenseAccounts", expenseAccounts);
		req.setAttribute("expenseSheets", expenseSheets);
		
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.expenses_sheet"));
		forward("/index.jsp?nextForm=expensesheet/expensesheet", req, resp);
	}
}
