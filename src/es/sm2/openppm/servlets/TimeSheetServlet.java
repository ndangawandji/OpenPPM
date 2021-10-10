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
/*
 *  Updater : Cédric Ndanga Wandji
 *  Devoteam, 28/05/2015, user story 26 : updating of updateTimeSheetJX(...) java method
 */
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
import es.sm2.openppm.logic.OperationLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.TeamMemberLogic;
import es.sm2.openppm.logic.TimesheetLogic;
import es.sm2.openppm.logic.TimesheetcommentLogic;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Timesheet;
import es.sm2.openppm.model.Timesheetcomment;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.Exclusion;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.NumberUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.SettingUtil;
import es.sm2.openppm.utils.StringUtil;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class TimeSheetServlet
 */
public class TimeSheetServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(TimeSheetServlet.class);
	
	public final static String REFERENCE				= "timesheet";
	
	/***************** Actions ****************/
	public final static String VIEW_TIMESHEET			= "view-timesheet";
	public final static String SAVE_ALL_TIMESHEET		= "save-all-timesheet";
	public final static String APPROVE_ALL_TIMESHEET	= "approve-all-timesheet";
	public final static String APPROVE_SEL_TIMESHEET	= "approve-sel-timesheet";
	public final static String REJECT_SEL_TIMESHEET		= "reject-sel-timesheet";
	public final static String REJECT_ALL_TIMESHEET		= "reject-all-timesheet";
	public final static String NEXT_WEEK_TIMESHEET		= "next-week-time-sheet";
	public final static String PREVIOUS_WEEK_TIMESHEET	= "previous-week-time-sheet";
	public final static String ADD_OPERATION			= "add-operation-time-sheet";
	public final static String DEL_OPERATION			= "del-operation-time-sheet";
	
	/************** Actions AJAX **************/
	public final static String JX_SAVE_TIMESHEET		= "ajax-save-timesheet";
	public final static String JX_APPROVE_TIMESHEET		= "ajax-approve-timesheet";
	public final static String JX_REJECT_TIMESHEET		= "ajax-reject-timesheet";
	public final static String JX_VIEW_COMMENTS			= "ajax-view-comments-timesheet";
	
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1 && SecurityUtil.hasPermission(req, ValidateUtil.isNullCh(accion, VIEW_TIMESHEET))) {
			
			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion) || VIEW_TIMESHEET.equals(accion)) { viewTime(req, resp, null, null); }
			else if (SAVE_ALL_TIMESHEET.equals(accion)) { updateALLTimeSheet(req, resp, false, accion); }
			else if (APPROVE_SEL_TIMESHEET.equals(accion)) { changeSelTimeSheet(req, resp, true); }
			else if (REJECT_SEL_TIMESHEET.equals(accion)) { changeSelTimeSheet(req, resp, false); }
			else if (APPROVE_ALL_TIMESHEET.equals(accion)) {
				if (SecurityUtil.isUserInRole(req, Constants.ROLE_RESOURCE)) { updateALLTimeSheet(req, resp, true, accion); }
				else { changeALLTimeSheet(req, resp, true); }
			}
			else if (REJECT_ALL_TIMESHEET.equals(accion)) { changeALLTimeSheet(req, resp, false); }
			else if (NEXT_WEEK_TIMESHEET.equals(accion)) { changeWeek(req, resp, 7); }
			else if (PREVIOUS_WEEK_TIMESHEET.equals(accion)) { changeWeek(req, resp, -7); }
			else if (ADD_OPERATION.equals(accion) || DEL_OPERATION.equals(accion)) { updateALLTimeSheet(req, resp, false, accion); }
			
			/************** Actions AJAX **************/
			else if (JX_APPROVE_TIMESHEET.equals(accion)) {
				if (SecurityUtil.isUserInRole(req, Constants.ROLE_RESOURCE)) { updateTimeSheetJX(req, resp, true); }
				else { changeTimeSheetJX(req, resp, true); }
			}
			else if (JX_REJECT_TIMESHEET.equals(accion)) { changeTimeSheetJX(req, resp, false); }
			//else if(JX_SAVE_STATEMENT.equals(accion)) {saveStatementJX(req, resp); }				cnw
			else if (JX_SAVE_TIMESHEET.equals(accion)) { updateTimeSheetJX(req, resp, false); }
			else if (JX_VIEW_COMMENTS.equals(accion)) { viewCommentsJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
	/**
     * Change selected time sheets
     * @param req
     * @param resp
     * @param b
     * @throws IOException 
     * @throws ServletException 
     */
    private void changeSelTimeSheet(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws ServletException, IOException {

    	Date initDate	= ParamUtil.getDate(req, "initDate", dateFormat, DateUtil.getFirstWeekDay(new Date()));
		Date endDate	= ParamUtil.getDate(req, "endDate", dateFormat, DateUtil.getLastWeekDay(new Date()));
		
    	String idProjectsStr	= ParamUtil.getString(req, "idProjects",null);
    	String idEmployeesStr	= ParamUtil.getString(req, "idEmployees",null);
    	String comments			= ParamUtil.getString(req, "comments");
    	
    	Integer[] idProjects	= StringUtil.splitStrToIntegers(idProjectsStr, null);
    	Integer[] idEmployees	= StringUtil.splitStrToIntegers(idEmployeesStr, null);
    	
    	try {
			
    		if (idEmployees != null && idEmployees.length > 0) {
    			
    			TimesheetLogic timesheetLogic	= new TimesheetLogic();
    			TimesheetcommentLogic commentLogic = new TimesheetcommentLogic();
    			
    			int approvalRol = SettingUtil.getApprovalRol(req);
    			
    			Employee filterUser = (SecurityUtil.isUserInRole(req, approvalRol)?SecurityUtil.consUser(req):null);
    			
    			// Status for rol
    			String previousStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)?Constants.TIMESTATUS_APP1:Constants.TIMESTATUS_APP2);
    			String nextStatus	  = null;
    			String prevStatusRej  = null;
    				
    			if (approve) {
    				nextStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM) && approvalRol >0?Constants.TIMESTATUS_APP2:Constants.TIMESTATUS_APP3);
    				prevStatusRej = previousStatus;
    			}
    			else {
    				nextStatus = Constants.TIMESTATUS_APP0;
    				
    				if ((SettingUtil.getApprovalRol(req) > 0 && !SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) ||
    						(SettingUtil.getApprovalRol(req) == 0 && SecurityUtil.isUserInRole(req, Constants.ROLE_PM))) {
    					
    					prevStatusRej = Constants.TIMESTATUS_APP3;
    				}
    				else {
    					prevStatusRej = previousStatus;
    				}
    			}
    			
    			int i = 0;
    			for (int idEmployee : idEmployees) {
    				
    				Project proj = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)?new Project(idProjects[i]):null);
    	    		
    	    		// Get Time Sheet for change
    				List<Timesheet> timeSheets = timesheetLogic.findByResource(new Employee(idEmployee), initDate, endDate, null,
    						proj, previousStatus, prevStatusRej, filterUser);
    				
    				timeSheets.addAll(timesheetLogic.findByResourceOperation(new Employee(idEmployee), initDate,
    						endDate, null, previousStatus, prevStatusRej));
    				
    				// Change time Sheets
    				for (Timesheet timesheet : timeSheets) {
    					
    					Timesheetcomment timesheetcomment = new Timesheetcomment();
    					timesheetcomment.setContentComment(comments);
    					timesheetcomment.setActualStatus(nextStatus);
    					timesheetcomment.setPreviousStatus(timesheet.getStatus());
    					timesheetcomment.setTimesheet(timesheet);
    					timesheetcomment.setCommentDate(new Date());
    					commentLogic.save(timesheetcomment);
    					
    					timesheet.setStatus(nextStatus);
	    	    			
	    	    		timesheetLogic.save(timesheet);
    				}
    				
    				i++;
    			}
    			
    		}
    		
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewTime(req, resp, initDate, endDate);
	}

	/**
     * Change state of time Sheet
     * @param req
     * @param resp
     * @param approve
     * @throws IOException
     */
    private void changeTimeSheetJX(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws IOException {
    	
    	PrintWriter out = resp.getWriter();
    	
		int idTimeSheet = ParamUtil.getInteger(req, "idTimeSheet",-1);
		String comments = ParamUtil.getString(req, "comments");
		
    	try {
    		
    		TimesheetLogic timesheetLogic = new TimesheetLogic();
    		TimesheetcommentLogic commentLogic = new TimesheetcommentLogic();
    		
    		Timesheet timesheet = timesheetLogic.findById(idTimeSheet);

    		String nextStatus	  = null;
    		
    		if (approve) {
    			nextStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM) && SettingUtil.getApprovalRol(req) > 0?Constants.TIMESTATUS_APP2:Constants.TIMESTATUS_APP3);
    		}
    		else { nextStatus = Constants.TIMESTATUS_APP0; }
    		
			Timesheetcomment timesheetcomment = new Timesheetcomment();
			timesheetcomment.setContentComment(comments);
			timesheetcomment.setActualStatus(nextStatus);
			timesheetcomment.setPreviousStatus(timesheet.getStatus());
			timesheetcomment.setTimesheet(timesheet);
			timesheetcomment.setCommentDate(new Date());
			commentLogic.save(timesheetcomment);
			
			timesheet.setStatus(nextStatus);
    			
    		timesheetLogic.save(timesheet);
    		
    		out.print(info("msg.info.status", new JSONObject(), "timesheet", "applevel."+nextStatus));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

    /**
     * Change all time sheet state
     * @param req
     * @param resp
     * @param approve
     * @throws ServletException
     * @throws IOException
     */
	private void changeALLTimeSheet(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws ServletException, IOException {
		
    	Integer[] ids	= ParamUtil.getIntegerList(req, "idTimeSheet");
    	String comments = ParamUtil.getString(req, "comments");
    	
    	try {
		
    		if (ids != null) {
    			
    			TimesheetLogic timesheetLogic = new TimesheetLogic();
    			TimesheetcommentLogic commentLogic = new TimesheetcommentLogic();
    			
    			String previousStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)?Constants.TIMESTATUS_APP1:Constants.TIMESTATUS_APP2);
    			String nextStatus	  = null;
    			String prevStatusRej  = null;
    			
    			if (approve) {
    				nextStatus = (SecurityUtil.isUserInRole(req, Constants.ROLE_PM) && SettingUtil.getApprovalRol(req) > 0?Constants.TIMESTATUS_APP2:Constants.TIMESTATUS_APP3);
    				prevStatusRej = previousStatus;
    			}
    			else {
    				nextStatus = Constants.TIMESTATUS_APP0;
    				
    				if ((SettingUtil.getApprovalRol(req) > 0 && !SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) ||
    						(SettingUtil.getApprovalRol(req) == 0 && SecurityUtil.isUserInRole(req, Constants.ROLE_PM))) {
    					
    					prevStatusRej = Constants.TIMESTATUS_APP3;
    				}
    				else {
    					prevStatusRej = previousStatus;
    				}
    			}
    			
    			for (int idTimeSheet : ids) {
    				
    	    		Timesheet timesheet = timesheetLogic.findById(idTimeSheet);
    	    		
    	    		if (timesheet != null && previousStatus.equals(timesheet.getStatus()) || prevStatusRej.equals(timesheet.getStatus())) {
	    	    		
    					Timesheetcomment timesheetcomment = new Timesheetcomment();
    					timesheetcomment.setContentComment(comments);
    					timesheetcomment.setActualStatus(nextStatus);
    					timesheetcomment.setPreviousStatus(timesheet.getStatus());
    					timesheetcomment.setTimesheet(timesheet);
    					timesheetcomment.setCommentDate(new Date());
    					commentLogic.save(timesheetcomment);
    					
    					timesheet.setStatus(nextStatus);
	    	    			
	    	    		timesheetLogic.save(timesheet);
    	    		}
    			}
    		}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewTime(req, resp, null, null);
	}

	/**
     * View
     * @param req
     * @param resp
     * @param initDate
     * @param endDate
     * @throws ServletException
     * @throws IOException
     */
    private void viewTime(HttpServletRequest req, HttpServletResponse resp,
			Date initDate, Date endDate) throws ServletException, IOException {
    	
    	if (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) {
    		
    		viewApprovalsByProject(req, resp, initDate, endDate);
    	}
    	else if (SecurityUtil.isUserInRole(req, SettingUtil.getApprovalRol(req))) {
			
			viewApprovals(req, resp, initDate, endDate);
		}
		else if (SecurityUtil.isUserInRole(req, Constants.ROLE_RESOURCE)) {
			viewTimeSheet(req, resp, initDate, endDate);
		}
	}

	/**
     * View comments of time sheet
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void viewCommentsJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	int idTimeSheet = ParamUtil.getInteger(req, "idTimeSheet",-1);
    	
		PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		TimesheetcommentLogic commentLogic = new TimesheetcommentLogic();
    		
    		List<Timesheetcomment> comments = commentLogic.findByRelation(Timesheetcomment.TIMESHEET, new Timesheet(idTimeSheet));
    		
    		out.print(JsonUtil.toJSON(comments, Constants.TIME_PATTERN, new Exclusion(Timesheet.class)));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

    /**
     * View time approvals
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void viewApprovalsByProject(HttpServletRequest req, HttpServletResponse resp, Date initDate, Date endDate) throws ServletException, IOException {
    	
    	if (initDate == null) { initDate = ParamUtil.getDate(req, "initDate", dateFormat, DateUtil.getFirstWeekDay(new Date())); }
    	if (endDate == null) { endDate	 = ParamUtil.getDate(req, "endDate", dateFormat, DateUtil.getLastWeekDay(new Date())); }
    	
    	Integer idEmployee	= ParamUtil.getInteger(req, "idEmployee", null);
    	Integer idProject 	= ParamUtil.getInteger(req, "idProject", null);
    	
    	List<Timesheet> timeSheets	= new ArrayList<Timesheet>();
    	List<Object[]> approvals	= null;
    	Employee employee	= null;
    	Project project		= null;
    	Set<Project> projects = new HashSet<Project>(0);
    	try {
    		
    		EmployeeLogic employeeLogic = new EmployeeLogic();
    		
    		String maxStatus = SettingUtil.getApprovalRol(req) > 0?Constants.TIMESTATUS_APP2:Constants.TIMESTATUS_APP3;
    		
    		approvals = employeeLogic.findApprovalsTimeByPM(SecurityUtil.consUser(req), initDate, endDate, maxStatus);
    		
    		for (Object[] item :approvals) {
    			
    			Project proj = new Project((Integer)item[2]);
    			proj.setProjectName((String)item[3]);
    			
    			if (proj != null && proj.getIdProject() != null) {
	    			boolean found = false;
	    			for (Project tmpProj : projects) {
	    				if (proj.equals(tmpProj)) { found = true; }
	    			}
	    			
	    			if (!found) { projects.add(proj);  }
    			}
    		}
    		
    		if (idEmployee != null) {
    			
    			TimesheetLogic timesheetLogic	= new TimesheetLogic();
    			ProjectLogic projectLogic		= new ProjectLogic();
    			
    			List<String> joins = new ArrayList<String>();
    			joins.add(Timesheet.PROJECTACTIVITY);
    			joins.add(Timesheet.OPERATION);
    			
    			if (idProject != null) {
	    			
    				timeSheets.addAll(timesheetLogic.findByResource(new Employee(idEmployee), initDate, endDate, joins,
	    					new Project(idProject), Constants.TIMESTATUS_APP1, maxStatus, null));
	    			
	    			project = projectLogic.findById(idProject);
    			}
    			timeSheets.addAll(timesheetLogic.findByResourceOperation(new Employee(idEmployee), initDate,
    					endDate, joins, Constants.TIMESTATUS_APP1, maxStatus));
    			
    			joins = new ArrayList<String>();
    			joins.add(Employee.CONTACT);
    			employee = employeeLogic.findById(idEmployee, joins);
    			
    		}
    		
    	}
    	catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    	
    	
    	req.setAttribute("initDate", dateFormat.format(initDate));
    	req.setAttribute("endDate", dateFormat.format(endDate));
    	req.setAttribute("initTypeDate", initDate);
    	req.setAttribute("endTypeDate", endDate);
    	req.setAttribute("timeSheets", timeSheets);
    	req.setAttribute("approvals", approvals);
    	req.setAttribute("employee", employee);
    	req.setAttribute("project", project);
    	req.setAttribute("projects", projects);
    	
    	req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
    	req.setAttribute("title", idioma.getString("menu.time_approvals"));
    	forward("/index.jsp?nextForm=timesheet/approve_project_timesheet", req, resp);
    }
    
	/**
     * View time approvals
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void viewApprovals(HttpServletRequest req, HttpServletResponse resp, Date initDate, Date endDate) throws ServletException, IOException {
		
    	if (initDate == null) { initDate = ParamUtil.getDate(req, "initDate", dateFormat, DateUtil.getFirstWeekDay(new Date())); }
		if (endDate == null) { endDate	 = ParamUtil.getDate(req, "endDate", dateFormat, DateUtil.getLastWeekDay(new Date())); }
		
		Integer idEmployee	= ParamUtil.getInteger(req, "idEmployee", null);
		
		List<Timesheet> timeSheets	= null;
		List<Employee> approvals	= null;
		Employee employee	= null;
		try {
			
			EmployeeLogic employeeLogic = new EmployeeLogic();
			
			approvals = employeeLogic.findApprovals(SecurityUtil.consUser(req), initDate, endDate);
			
			if (idEmployee != null) {
				
				TimesheetLogic timesheetLogic	= new TimesheetLogic();
				
				List<String> joins = new ArrayList<String>();
				joins.add(Timesheet.PROJECTACTIVITY);
				joins.add(Timesheet.OPERATION);
				
				timeSheets = timesheetLogic.findByResource(new Employee(idEmployee), initDate, endDate, joins,
						null, Constants.TIMESTATUS_APP2, Constants.TIMESTATUS_APP3, SecurityUtil.consUser(req));
				
				timeSheets.addAll(timesheetLogic.findByResourceOperation(new Employee(idEmployee), initDate,
    					endDate, joins, Constants.TIMESTATUS_APP2, Constants.TIMESTATUS_APP3));
				
				joins = new ArrayList<String>();
				joins.add(Employee.CONTACT);
				employee = employeeLogic.findById(idEmployee, joins);
			}
			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("initDate", dateFormat.format(initDate));
		req.setAttribute("endDate", dateFormat.format(endDate));
		req.setAttribute("initTypeDate", initDate);
		req.setAttribute("endTypeDate", endDate);
		req.setAttribute("timeSheets", timeSheets);
		req.setAttribute("approvals", approvals);
		req.setAttribute("employee", employee);
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.time_approvals"));
		forward("/index.jsp?nextForm=timesheet/approve_timesheet", req, resp);
	}
    
    /**
     * Add operation in time sheet
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void addOperation(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
    	int idOperation = ParamUtil.getInteger(req, "idOperation", -1);
    	Date initDate	= ParamUtil.getDate(req, "initDate", dateFormat, DateUtil.getFirstWeekDay(new Date()));
		Date endDate	= ParamUtil.getDate(req, "endDate", dateFormat, DateUtil.getLastWeekDay(new Date()));
		
		try {
			Employee user = SecurityUtil.consUser(req);
			TimesheetLogic timesheetLogic = new TimesheetLogic();
			
			Timesheet timesheet = timesheetLogic.findByOperation(new Operation(idOperation), SecurityUtil.consUser(req), initDate, endDate);
			
			if (timesheet == null) {
			
				timesheet = new Timesheet();
				timesheet.setInitDate(initDate);
				timesheet.setEndDate(endDate);
				
	    		timesheet.setStatus(Constants.TIMESTATUS_APP0);
	    		timesheet.setOperation(new Operation(idOperation));
	    		timesheet.setEmployee(user);
				
	    		timesheetLogic.save(timesheet);
				infoCreated(req, "operation");
			}
			else {
				info(req, "msg.info.operation_exists");
			}
			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
	}

	/**
     * Next Week for Time Sheet
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void changeWeek(HttpServletRequest req, HttpServletResponse resp, int days) throws ServletException, IOException {
    	
    	Date initDate	= ParamUtil.getDate(req, "initDate", dateFormat, DateUtil.getFirstWeekDay(new Date()));
    	Date endDate	= ParamUtil.getDate(req, "endDate", dateFormat, DateUtil.getLastWeekDay(new Date()));
    	
    	Calendar initCal = DateUtil.getCalendar();
    	initCal.setTime(initDate);
    	initCal.add(Calendar.DAY_OF_YEAR, days);
    	
    	Calendar endCal = DateUtil.getCalendar();
    	endCal.setTime(endDate);
    	endCal.add(Calendar.DAY_OF_YEAR, days);
    	
    	viewTime(req, resp, initCal.getTime(), endCal.getTime());
    }
    
	/**
     * Save Time Sheet 
     * @param req
     * @param resp
     * @param b
     * @throws IOException 
     * @throws ServletException 
     */
    private void updateALLTimeSheet(HttpServletRequest req, HttpServletResponse resp,
    		boolean approve, String accion) throws ServletException, IOException {
		
    	Integer[] ids	= ParamUtil.getIntegerList(req, "idTimeSheet");
    	String comments = ParamUtil.getString(req, "comments");
    	
    	try {
		
    		if (ids != null) {
    			
    			TimesheetLogic timesheetLogic = new TimesheetLogic();
    			TimesheetcommentLogic commentLogic = new TimesheetcommentLogic();
    			
    			for (int idTimeSheet : ids) {
    				
    	    		Timesheet timesheet = timesheetLogic.findById(idTimeSheet);
    	    		
    	    		if (Constants.TIMESTATUS_APP0.equals(timesheet.getStatus())) {
	    				Double day1		= ParamUtil.getDouble(req, "day1_"+idTimeSheet,null);
	    				Double day2		= ParamUtil.getDouble(req, "day2_"+idTimeSheet,null);
	    				Double day3		= ParamUtil.getDouble(req, "day3_"+idTimeSheet,null);
	    				Double day4		= ParamUtil.getDouble(req, "day4_"+idTimeSheet,null);
	    				Double day5		= ParamUtil.getDouble(req, "day5_"+idTimeSheet,null);
	    				Double day6		= ParamUtil.getDouble(req, "day6_"+idTimeSheet,null);
	    				Double day7		= ParamUtil.getDouble(req, "day7_"+idTimeSheet,null);
	    				
	    				timesheet.setHoursDay1(day1);
	    	    		timesheet.setHoursDay2(day2);
	    	    		timesheet.setHoursDay3(day3);
	    	    		timesheet.setHoursDay4(day4);
	    	    		timesheet.setHoursDay5(day5);
	    	    		timesheet.setHoursDay6(day6);
	    	    		timesheet.setHoursDay7(day7);
	    	    		
	    	    		double total = 0;
	    	    		total += (day1 != null?day1:0);
	    	    		total += (day2 != null?day2:0);
	    	    		total += (day3 != null?day3:0);
	    	    		total += (day4 != null?day4:0);
	    	    		total += (day5 != null?day5:0);
	    	    		total += (day6 != null?day6:0);
	    	    		total += (day7 != null?day7:0);
	    	    		
	    				if (approve && total > 0) {
	    					
	    					String status = (timesheet.getOperation() != null?Constants.TIMESTATUS_APP2:Constants.TIMESTATUS_APP1);
	    					
	    					Timesheetcomment timesheetcomment = new Timesheetcomment();
	    					timesheetcomment.setContentComment(comments);
	    					timesheetcomment.setActualStatus(status);
	    					timesheetcomment.setPreviousStatus(timesheet.getStatus());
	    					timesheetcomment.setTimesheet(timesheet);
	    					timesheetcomment.setCommentDate(new Date());
	    					commentLogic.save(timesheetcomment);
	    					
	    					timesheet.setStatus(status);
	    				}
	    	    			
	    	    		timesheetLogic.save(timesheet);
    	    		}
    			}
    		}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		if (ADD_OPERATION.equals(accion)) { addOperation(req, resp); }
		else if (DEL_OPERATION.equals(accion)) { delOperation(req, resp); }
		
		viewTimeSheet(req, resp, null, null);
	}

    /**
     * Delete Operation
     * @param req
     * @param resp
     */
	private void delOperation(HttpServletRequest req, HttpServletResponse resp) {
		
		int idTimeSheet = ParamUtil.getInteger(req, "idTimeSheetOperation", -1);
		
		try {
			TimesheetLogic timesheetLogic = new TimesheetLogic();
			
			Timesheet timesheet = timesheetLogic.findById(idTimeSheet);
			
			if (timesheet != null) {
			
				timesheetLogic.delete(timesheet);
				infoDeleted(req, "operation");
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
	}
	
	/**
     * Save TimeSheet
     * @param req
     * @param resp
     * @param approve 
     * @throws IOException 
     * @update 
     */
	private void updateTimeSheetJX(HttpServletRequest req,
			HttpServletResponse resp, boolean approve) throws IOException {
		
		PrintWriter out = resp.getWriter();
    	
		// getting time sheet properties from the AJAX client request
		int idTimeSheet 			= ParamUtil.getInteger(req, "idTimeSheet",-1);
		Integer activityState 		= ParamUtil.getInteger(req, "activity_state", null);		// cnw getting activity state
		//Integer estimatedGap 		= ParamUtil.getInteger(req, "estimated_gap", null);			// cnw getting estimated gap 
		Double estimatedGapValue 	= ParamUtil.getDouble(req, "estimated_gap_value", null);	// cnw getting estimated gap value
		Integer time 				= ParamUtil.getInteger(req, "time", null);					// cnw getting time state
		Double day1					= ParamUtil.getDouble(req, "day1",null);
		Double day2					= ParamUtil.getDouble(req, "day2",null);
		Double day3					= ParamUtil.getDouble(req, "day3",null);
		Double day4					= ParamUtil.getDouble(req, "day4",null);
		Double day5					= ParamUtil.getDouble(req, "day5",null);
		Double day6					= ParamUtil.getDouble(req, "day6",null);
		Double day7					= ParamUtil.getDouble(req, "day7",null);
		String comments 			= ParamUtil.getString(req, "comments");
		
    	try {
    		
    		// building a new time sheet
    		TimesheetLogic timesheetLogic = new TimesheetLogic();
    		
    		Timesheet timesheet = timesheetLogic.findById(idTimeSheet);
    		timesheet.setActivityState(activityState);						// cnw setting activity state
    		//timesheet.setEstimatedGap(estimatedGap);						// cnw setting estimated gap
    		timesheet.setEstimatedGapValue(estimatedGapValue);				// cnw setting estimated gap value
    		timesheet.setTime(time);										// cnw setting time state
    		timesheet.setHoursDay1(day1);
    		timesheet.setHoursDay2(day2);
    		timesheet.setHoursDay3(day3);
    		timesheet.setHoursDay4(day4);
    		timesheet.setHoursDay5(day5);
    		timesheet.setHoursDay6(day6);
    		timesheet.setHoursDay7(day7);

    		JSONObject returnJSON = null;
    		
    		if (approve) {
    			
    			String status = (timesheet.getOperation() != null?Constants.TIMESTATUS_APP2:Constants.TIMESTATUS_APP1);
    			
    			TimesheetcommentLogic commentLogic = new TimesheetcommentLogic();
    			
    			Timesheetcomment timesheetcomment = new Timesheetcomment();
				timesheetcomment.setContentComment(comments);
				timesheetcomment.setActualStatus(status);
				timesheetcomment.setPreviousStatus(timesheet.getStatus());
				timesheetcomment.setTimesheet(timesheet);
				timesheetcomment.setCommentDate(new Date());
			
				commentLogic.save(timesheetcomment);
				
    			timesheet.setStatus(status); // setting time sheet status
    			
    			// setting JSON server response to the AJAX request
    			returnJSON = info("msg.info.status", returnJSON, "timesheet", "applevel."+status);
    			returnJSON.put("status", idioma.getString("applevel."+ status));
    			
    			returnJSON.put("activity_state", activityState);			// cnw return activity state
    			//returnJSON.put("estimated_gap", estimatedGap);				// cnw return estimated gap 
    			returnJSON.put("time", time);								// cnw return time state
    		}
    		else { returnJSON = infoUpdated(returnJSON, "timesheet"); }
    		timesheetLogic.save(timesheet);
    		returnJSON.put("estimated_gap_value", timesheet.getEstimatedGapValue());	// cnw return estimated gap value
    		
    		out.print(returnJSON);
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
	 * View Time Sheet for resources
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 * Updater Cedric Ndanga Wandji
	 * user story 27
	 */
	private void viewTimeSheet(HttpServletRequest req, HttpServletResponse resp, Date initDate, Date endDate) throws ServletException, IOException {
		
		if (initDate == null) { initDate	= ParamUtil.getDate(req, "initDate", dateFormat, DateUtil.getFirstWeekDay(new Date())); }
		if (endDate == null) { endDate	= ParamUtil.getDate(req, "endDate", dateFormat, DateUtil.getLastWeekDay(new Date())); }
		
		List<Timesheet> timeSheets = null;
		List<Operation> operations = null;
		List<Teammember> teamMembers = null;		// cnw us27
		double remaining;							// cnw us27
		double sumRemaining;						// cnw us27
		
		try {
			
			TimesheetLogic timesheetLogic = new TimesheetLogic();
			OperationLogic operationLogic = new OperationLogic();
			TeamMemberLogic teamLogic  = new TeamMemberLogic();		// cnw us27
			List<String> joins = new ArrayList<String>();
			joins.add(Timesheet.PROJECTACTIVITY);
			joins.add(Timesheet.PROJECTACTIVITY + "." + Projectactivity.PROJECT);
			joins.add(Timesheet.OPERATION);
			
			timeSheets = timesheetLogic.findByResource(SecurityUtil.consUser(req), initDate, endDate, joins, null, null, null, null);
			timeSheets.addAll(timesheetLogic.findByResourceOperation(SecurityUtil.consUser(req), initDate,
					endDate, joins, null, null));
			
			/*
			 * cnw us27
			 * Pour chaque time sheet, calcul du reste à faire du team member associé
			 */
			for (Timesheet timesheet : timeSheets) {
				teamMembers = null;
				teamMembers = TeamMemberLogic.consTeamMember(timesheet.getProjectactivity().getIdActivity(), timesheet.getEmployee().getIdEmployee());
				sumRemaining = 0;
				if(timesheet.getStatus().equals(Constants.TIMESTATUS_APP0)) {
					for (Teammember teammember : teamMembers) {
						
						teammember.setDays((teamLogic.workloadInDays(teammember, teammember.getDateIn(), teammember.getDateOut())));
		                
						/* Userstory 9  ajout du reste à faire*/
					    remaining = /*(double) teammember.getDays() -*/ (timesheetLogic.getHoursResource(teammember.getEmployee().getIdEmployee(), 	
																					   teammember.getProjectactivity().getIdActivity(),
																					   DateUtil.getFirstWeekDay(DateUtil.addDay(teammember.getDateIn(), 7)) , 
																					   teammember.getDateOut(), 
																					   Constants.TIMESTATUS_APP0,
																					   Constants.TIMESTATUS_APP0
																	 )/Constants.DEFAULT_HOUR_DAY);
					    
					    remaining = NumberUtil.truncate2decimals(remaining);
					    //LOGGER.debug("remaining" + remaining +  teammember.getProjectactivity().getIdActivity());

					    remaining = (remaining <0 ?0:remaining);  // On ne prend pas en compte le trop consomé.
					    
					    sumRemaining = sumRemaining + remaining;
					}
					timesheet.setEstimatedGapValue(NumberUtil.truncate2decimals(sumRemaining));
				}
			}
			operations = operationLogic.findByAllCompany(CompanyLogic.searchByEmployee(SecurityUtil.consUser(req)));	
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		// Disable next weeks
		Calendar aux = DateUtil.getCalendar();
		aux.setTime(endDate);
		aux.add(Calendar.DAY_OF_MONTH, 1);
		Calendar aux2 = DateUtil.getCalendar();
		aux2.add(Calendar.DAY_OF_MONTH, 1);
		req.setAttribute("nextDisabled", !aux.before(aux2));
		
		// Disable previous weeks
/*
		Calendar edit_time1 = DateUtil.getCalendar();
		edit_time1.setTime(endDate);
		edit_time1.add(Calendar.DATE, +7);
		Calendar edit_time2 = DateUtil.getCalendar();
		req.setAttribute("editDisabled", edit_time1.before(edit_time2));
*/
		req.setAttribute("initDate", dateFormat.format(initDate));
		req.setAttribute("endDate", dateFormat.format(endDate));
		req.setAttribute("timeSheets", timeSheets);
		req.setAttribute("operations", operations);
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("timesheet.time_tracking"));
		forward("/index.jsp?nextForm=timesheet/timesheet", req, resp);
	}
}
