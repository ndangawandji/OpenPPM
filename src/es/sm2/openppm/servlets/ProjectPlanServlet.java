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
 * Update : Devoteam XL 2015-04-22  user story 23  tri des ressources
 *                 fonction :  viewProjectPlanning  tri des listes skil et Performingorg
 */
/*
 * Updater : Cedric Ndanga Wandji
 * Devoteam, 22/04/2015, user story 13 : adding of 2 news AJAX actions.
 * Devoteam, 24/04/2015, user story 13 : adding action method verifyDaysJX().
 * Devoteam, 24/04/2015, user story 13 : adding action method verifyFteJX().
 * Devoteam, 24/04/2015, user story 13 : updating action verifyDaysJX()
 * 
 * Devoteam, 09/06/2015, user story 40 : updating saveActivity() java action
 */
package es.sm2.openppm.servlets;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;

import es.sm2.openppm.charts.ChartDataSetPL;
import es.sm2.openppm.charts.ChartFinancePlan;
import es.sm2.openppm.charts.ChartFinancePlanValues;
import es.sm2.openppm.charts.ChartGantt;
import es.sm2.openppm.charts.ChartLine;
import es.sm2.openppm.charts.ChartStacked;
import es.sm2.openppm.charts.ChartWBS;
import es.sm2.openppm.charts.PlChartInfo;
import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.javabean.ParamResourceBundle;
import es.sm2.openppm.javabean.TeamCalendar;
import es.sm2.openppm.javabean.TeamMembersFTEs;
import es.sm2.openppm.logic.BudgetaccountsLogic;
import es.sm2.openppm.logic.CalendarBaseLogic;
import es.sm2.openppm.logic.CalendarbaseexceptionsLogic;
import es.sm2.openppm.logic.ChartLogic;
import es.sm2.openppm.logic.ChecklistLogic;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.DirectCostsLogic;
import es.sm2.openppm.logic.DocumentprojectLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.ExpensesLogic;
import es.sm2.openppm.logic.IncomesLogic;
import es.sm2.openppm.logic.IwosLogic;
import es.sm2.openppm.logic.MetrickpiLogic;
import es.sm2.openppm.logic.MilestoneLogic;
import es.sm2.openppm.logic.PerformingOrgLogic;
import es.sm2.openppm.logic.ProgramLogic;
import es.sm2.openppm.logic.ProjectActivityLogic;
import es.sm2.openppm.logic.ProjectCalendarExceptionsLogic;
import es.sm2.openppm.logic.ProjectCostsLogic;
import es.sm2.openppm.logic.ProjectFollowupLogic;
import es.sm2.openppm.logic.ProjectKpiLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.ProjectcalendarLogic;
import es.sm2.openppm.logic.ResourceProfilesLogic;
import es.sm2.openppm.logic.SkillLogic;
import es.sm2.openppm.logic.TeamMemberLogic;
import es.sm2.openppm.logic.WBSNodeLogic;
import es.sm2.openppm.model.Budgetaccounts;
import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.model.Calendarbaseexceptions;
import es.sm2.openppm.model.Checklist;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Directcosts;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expenses;
import es.sm2.openppm.model.Incomes;
import es.sm2.openppm.model.Iwo;
import es.sm2.openppm.model.Metrickpi;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectcalendar;
import es.sm2.openppm.model.Projectcalendarexceptions;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Projectkpi;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.EmailUtil;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JSONModelUtil;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.NumberUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class ProjectServer
 */
public class ProjectPlanServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(ProjectPlanServlet.class);
	
	public final static String REFERENCE = "projectplan";
	
	/***************** Actions ****************/
	public final static String SAVE_PROJECT 		= "save-project";
	public final static String APPROVE_PROJECT 		= "approve-project";
	public final static String DELETE_WBSNODE 		= "delete-wbsnode";
	public final static String EDIT_WBSNODE 		= "edit-wbsnode";
	public final static String SAVE_WBSNODE 		= "save-wbsnode";
	public final static String SAVE_ACTIVITY 		= "save-activity";
	//Cost Actions
	public final static String DEL_INCOME 				= "delete-income";
	public final static String DEL_FOLLOWUP 			= "delete-followup";
	public final static String DEL_COST 				= "delete_cost";
	public final static String DEL_IWO 					= "delete_iwo";
	public final static String FINANCE_CHART_IMG 		= "finance-chart-image";
	// Calendar
	public final static String CHANGE_CALENDAR_BASE		= "change-calendar-base";
	
	/************** Actions AJAX **************/
	public final static String JX_CONS_WBSNODES 	= "ajax-cons-wbsnodes";
	public final static String JX_SAVE_MILESTONE 	= "ajax-save-milestone";
	public final static String JX_DELETE_MILESTONE 	= "ajax-delete-milestone";
	public final static String JX_PLAN_GANTT_CHART 	= "ajax-update-chart-gantt-planning";
	public final static String JX_WBS_CHART 		= "ajax-generate-chart-wbs";
	public final static String JX_WBS_VALIDATE 		= "ajax-wbs-validate";
	public final static String JX_SAVE_CHECKLIST 	= "ajax-save-checklist";
	public final static String JX_DELETE_CHECKLIST 	= "ajax-delete-checklist";
	// Cost Actions AJAX
	public final static String JX_SAVE_INCOME 			= "ajax-save-income";
	public final static String JX_SAVE_FOLLOWUP 		= "ajax-save-followup";
	public final static String JX_SAVE_COST 			= "ajax-save-cost";
	public final static String JX_SAVE_IWO 				= "ajax-save-iwo";		
	public final static String JX_PROJECT_COSTS_CHART 	= "ajax-update-chart-project-costs";
	public final static String JX_PL_CHART 				= "ajax-update-chartPL";
	// Plan HR Actions AJAX
	public final static String JX_SAVE_MEMBER 			= "ajax-save-team-member";
	public final static String JX_UPDATE_MEMBER			= "ajax-update-team-member";
	public final static String JX_FIND_MEMBER 			= "ajax-find-team-member";
	public final static String JX_UPDATE_STAFFING_TABLE	= "ajax-update-staffing-table";
	public final static String JX_RELEASED_RESOURCE		= "ajax-released-resource";
	public static final String JX_VERIFY_DAYS			= "ajax-verify-days";				// cnw
	public static final String JX_VERIFY_FTE			= "ajax-verify-fte";				// cnw
	// Calendar
	public final static String JX_SAVE_CALENDAR 			= "ajax-save-calendar";
	public final static String JX_SAVE_CALENDAR_EXCEPTION	= "ajax-save-calendar-exception";
	public final static String JX_DELETE_CALENDAR_EXCEPTION = "ajax-delete-calendar-exception";
	public final static String JX_UPDATE_TEAM_CALENDAR		= "ajax-update-team-calendar";
	// KPI
	public final static String JX_SAVE_KPI			= "ajax-save-kpi";
	public final static String JX_DELETE_KPI		= "ajax-delete-kpi";
	public final static String JX_UPDATE_THRESHOLD	= "ajax-update-threshold";
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @SuppressWarnings("rawtypes")
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		Hashtable<String, FileItem> reqFields = null;
		
		if (SecurityUtil.consUserRole(req) != -1) {
			if(ServletFileUpload.isMultipartContent(req) && StringPool.BLANK.equals(accion)) {	
				
				try {
					
					ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
					List fileItemList = servletFileUpload.parseRequest(req);
					reqFields = parseFields(fileItemList);
					accion = (reqFields.get("accion") != null?reqFields.get("accion").getString():StringPool.BLANK);
					
				}
				catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
			}
			
			LOGGER.debug("Accion: " + accion);
			
			// Consult projects of logged project manager
			//
			if (accion == null || StringPool.BLANK.equals(accion) 
					|| DELETE_WBSNODE.equals(accion) || EDIT_WBSNODE.equals(accion)
					|| SAVE_PROJECT.equals(accion) || DEL_INCOME.equals(accion)
					|| DEL_COST.equals(accion) || DEL_FOLLOWUP.equals(accion)
					|| SAVE_WBSNODE.equals(accion) || EDIT_WBSNODE.equals(accion)
					|| DEL_IWO.equals(accion)) 
			{ projectActions(req, resp, accion); }
			else if (SAVE_ACTIVITY.equals(accion)) { saveActivity(req, resp); }
			else if (CHANGE_CALENDAR_BASE.equals(accion)) { changeCalendarBase(req, resp); }
			else if (APPROVE_PROJECT.equals(accion)) { approveProject(req, resp);  }
			
			/************** Actions AJAX **************/
			else if (JX_WBS_VALIDATE.equals(accion)) { validateWBS(req, resp); }
			else if (JX_SAVE_MILESTONE.equals(accion)) { saveMilestoneJX(req, resp); }
			else if (JX_SAVE_CHECKLIST.equals(accion)) { saveCheckListJX(req, resp); }
			else if (JX_DELETE_CHECKLIST.equals(accion)) { deleteCheckListJX(req, resp); }
			else if (JX_SAVE_CALENDAR.equals(accion)) { saveCalendarJX(req, resp); }
			else if (JX_SAVE_CALENDAR_EXCEPTION.equals(accion)) { saveCalendarExceptionJX(req, resp); }
			else if (JX_DELETE_CALENDAR_EXCEPTION.equals(accion)) { deleteCalendarExceptionJX(req, resp); }
			else if (JX_UPDATE_TEAM_CALENDAR.equals(accion)) { updateTeamCalendarJX(req, resp); }
			else if (JX_SAVE_MEMBER.equals(accion)) { saveMemberJX(req, resp); }
			else if (JX_UPDATE_MEMBER.equals(accion)) { updateMemberJX(req, resp); }
			else if (JX_FIND_MEMBER.equals(accion)) { findMemberJX(req, resp); }
			else if (JX_SAVE_KPI.equals(accion)) { saveKpiJX(req, resp); }
			else if (JX_DELETE_KPI.equals(accion)) { deleteKpiJX(req, resp); }
			else if (JX_UPDATE_THRESHOLD.equals(accion)) { updateThresholdJX(req, resp); }
			else if (JX_UPDATE_STAFFING_TABLE.equals(accion)) { updateStaffingTableJX(req, resp); }
			else if (JX_RELEASED_RESOURCE.equals(accion)) { releasedResourceJX(req, resp); }
			else if (JX_CONS_WBSNODES.equals(accion)) { consWbsNodesJX(req, resp); }			
			else if (JX_DELETE_MILESTONE.equals(accion)) { deleteMilestoneJX(req, resp); }
			else if (JX_PLAN_GANTT_CHART.equals(accion)) { planGanttChartJX(req, resp); }
			else if (JX_WBS_CHART.equals(accion)) { wbsChartJX(req, resp); }
			else if (JX_SAVE_INCOME.equals(accion)) { saveIncomeJX(req, resp); }
			else if (JX_SAVE_FOLLOWUP.equals(accion)) { saveFollowupJX(req, resp); }
			else if (JX_SAVE_COST.equals(accion)) { saveCostJX(req, resp); }
			else if (JX_SAVE_IWO.equals(accion)) { saveIwoJX(req, resp); }	
			else if (JX_PROJECT_COSTS_CHART.equals(accion)) { updateProjectCostChartJX(req, resp); }
			else if (FINANCE_CHART_IMG.equals(accion)) {	financeChartImageJX(req, resp); }
			else if (JX_PL_CHART.equals(accion)) { updatePlChartJX(req, resp); }
			else if(JX_VERIFY_DAYS.equals(accion)) { verifyDaysJX(req, resp); }
			else if(JX_VERIFY_FTE.equals(accion)) { verifyFteJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE + "?accion=403", req, resp);
		}
	}

    /**
     * Cons WBS Nodes
     * @param req
     * @param resp
     * @throws IOException
     */
    private void consWbsNodesJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    	PrintWriter out = resp.getWriter();
		Integer idProject = ParamUtil.getInteger(req, "id");
		int idNode		= ParamUtil.getInteger(req, "idNode", -1);
		
		try {
			List<Wbsnode> wbsnodes = WBSNodeLogic.consWBSNodes(new Project(idProject));
			
			JSONArray array = new JSONArray();
			for (Wbsnode wbs : wbsnodes) {
				if (wbs.getIdWbsnode() != idNode) {
					JSONObject obj = JSONModelUtil.wbsnodeTOJSON(wbs);
					array.add(obj);
				}
			}
			
			out.print(array);
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
    
    /**
     * Delete milestone
     * @param req
     * @param resp
     * @throws IOException
     */
    private void deleteMilestoneJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	Integer idMilestone = ParamUtil.getInteger(req, "milestone_id", -1);
		PrintWriter out = resp.getWriter();
		
		try {
			
			MilestoneLogic.deleteMilestone(idMilestone);
			
			if (idMilestone == -1) {
				throw new NoDataFoundException();
			}
			JSONObject milestoneJSON = new JSONObject();
			milestoneJSON.put("id", idMilestone);
			
			out.print(milestoneJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
    }

    /**
     * Update chart Gantt planning
     * @param req
     * @param resp
     * @throws IOException
     */
    private void planGanttChartJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	PrintWriter out = resp.getWriter();
		
		Integer idProject	= ParamUtil.getInteger(req, "id");
		Date since			= ParamUtil.getDate(req, "filter_start", dateFormat,null);
		Date until			= ParamUtil.getDate(req, "filter_finish", dateFormat,null);
		
		String numTasks	= null;
		String textXML	= StringPool.BLANK;
		
		try {	
			
			Project project = ProjectLogic.consProject(idProject);
			ChartGantt chartGantt = ChartLogic.consChartGantt(idioma, project, false, false, since, until);
			
			textXML = chartGantt.generateXML();
			numTasks = chartGantt.getNumTasks();
			
			JSONObject updateJSON = new JSONObject();
			if (Integer.parseInt(numTasks) > 0) {
				updateJSON.put("xml", textXML);
				updateJSON.put("tasks", numTasks);
			}
			out.print(updateJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
    }
    
    /**
     * Generate chart WBS Planning-Scope
     * @param req
     * @param resp
     * @throws IOException
     */
    private void wbsChartJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	PrintWriter out = resp.getWriter();
		Integer idProject = ParamUtil.getInteger(req, "id");
		String textHtml = null;
		
		try {	
			Project project = ProjectLogic.consProject(idProject);
			
			Wbsnode wbsNodeParent = WBSNodeLogic.findFirstWBSnode(project);
			ChartWBS chartWBS = new ChartWBS(wbsNodeParent, false);
			
			textHtml = chartWBS.generateHTML();
			
			JSONObject updateJSON = new JSONObject();
			updateJSON.put("chart_code", textHtml);
			out.print(updateJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
    }
    
    /**
     * Save Income (Planning costs)
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveIncomeJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	Integer idIncome = ParamUtil.getInteger(req, "income_id", -1);
		Incomes income = null;
		IncomesLogic logic = null;
		PrintWriter out = resp.getWriter();
		
		try {
			logic = new IncomesLogic();					
			income =  logic.findById(idIncome);
			if (income == null) {
				income = new Incomes();
			}
			
			setIncomeFromRequest(req, income);
			logic.save(income);
			
			JSONObject incomeJSON = JSONModelUtil.incomeToJSON(idioma, income);
			out.print(incomeJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
    }
    
    /**
     * Save Followup (Planning costs - Cost baseline plan)
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveFollowupJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	Integer idProject = ParamUtil.getInteger(req, "id", -1);
		Projectfollowup followup = null;
		
		PrintWriter out = resp.getWriter();
		try {
			if (idProject == -1) {
				throw new Exception(idioma.getString("msg.error.data"));
			}
			Integer idFollowup = ParamUtil.getInteger(req, "followup_id", -1);
			
			followup = ProjectFollowupLogic.consFollowup(idFollowup);
			if (followup == null) {
				followup = new Projectfollowup();
			}
			setFollowupFromRequest(req, followup);
			followup.setProject(new Project(idProject));
			
			ProjectFollowupLogic.saveFollowup(followup);
			
			JSONObject followupJSON = JSONModelUtil.followupToJSON(idioma, followup, null);

			out.print(followupJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}    	
    }
    
	/**
     * Approve Project
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void approveProject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    	boolean error = false;
		
		Integer idProject = ParamUtil.getInteger(req, "id");
		String scopeStatement = ParamUtil.getString(req, "scope_statement", StringPool.BLANK);
		
		Project project			= null;		
		List<ParamResourceBundle> errors = new ArrayList<ParamResourceBundle>();
		
		try {
			project = ProjectLogic.consProject(idProject);
			
			ProjectKpiLogic kpiLogic = new ProjectKpiLogic();
			List<Projectkpi> kpis = kpiLogic.findByRelation(Projectkpi.PROJECT, project);
			 
			if (kpis != null && !kpis.isEmpty()) {
				
				int weight = 0;
				for (Projectkpi kpi : kpis) {
					
					weight += (kpi.getWeight() == null ?0:kpi.getWeight());
				}
				if (weight != 100) { throw new LogicException("msg.error.kpi_total_weight"); }
			}
			
			project.setScopeStatement(scopeStatement);
			ProjectLogic.saveProject(project);
			
			errors = WBSNodeLogic.checkErrorsWBS(project);
			
			Double budget = WBSNodeLogic.consTotalBudget(project);
			if (project.getBac() == null || budget == null || budget.doubleValue()!= project.getBac().doubleValue()) {
				info(req, "msg.info.bac_equals_budget");
			}
			
			if (MilestoneLogic.checkMilestones(project)) {
				errors.add(new ParamResourceBundle("msg.error.milestones_without_activity"));
			}
			if (!errors.isEmpty()) {
				error = true;
			}
			
		}
		catch (Exception e) {
			error = true;
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		if (!error) {
			try {
				ProjectLogic.approveProject(project, getUser(req));
			}
			catch (Exception e) {
				error = true;
				ExceptionUtil.evalueException(req, idioma, LOGGER, e);
			}
		}
		
		if (error) {
			if (!errors.isEmpty()) {
				StringBuilder infoMsg = new StringBuilder();
				for (ParamResourceBundle er : errors) {
					infoMsg.append(er.toString(idioma) + "<br>");
				}
				req.setAttribute(StringPool.ERROR, infoMsg.toString());
			}
			
			viewProjectPlanning(req, resp, idProject);
		}
		else {
			forwardServlet(ProjectControlServlet.REFERENCE+"?accion=", req, resp);
		}
	}

	/**
     * Save Cost (Planning costs - Detailed cost plan)
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void saveCostJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    	Integer idProject = ParamUtil.getInteger(req, "id", -1);
		Projectcosts costs = null;
		
		PrintWriter out = resp.getWriter();
		try {
			if (idProject == -1) {
				throw new Exception(idioma.getString("msg.error.project"));
			}
			costs = new Projectcosts();
			costs.setProject(new Project(idProject));
			
			costs = ProjectCostsLogic.saveCosts(costs);

			// Determine what kind of cost detail is
			Integer costType = ParamUtil.getInteger(req, "cost_type", -1);
			
			JSONObject costJSON = new JSONObject();
			if (costType == Constants.COST_TYPE_DIRECT) {
				Directcosts cost = saveDirectCostFromRequest(req, costs);
				
				costJSON.put("id", cost.getIdDirectCosts());
				costJSON.put("actual", cost.getActual());
				costJSON.put("planned", cost.getPlanned());
				costJSON.put("desc", cost.getDescription());
				costJSON.put("budgetaccount", cost.getBudgetaccounts().getIdBudgetAccount());
			}
			else if (costType == Constants.COST_TYPE_EXPENSE) {
				Expenses cost = saveExpenseCostFromRequest(req, costs);
				
				costJSON.put("id", cost.getIdExpense());
				costJSON.put("actual", cost.getActual());
				costJSON.put("planned", cost.getPlanned());
				costJSON.put("desc", cost.getDescription());
				costJSON.put("budgetaccount", cost.getBudgetaccounts().getIdBudgetAccount());
			}
			else {
				throw new Exception(idioma.getString("msg.error.cost_type"));
			}
			
			costJSON.put("type", costType);
			
			out.print(costJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

    /**
     * Save IWO (Planning costs - IWO's)
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveIwoJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	Integer idProject = ParamUtil.getInteger(req, "id", -1);
		Projectcosts costs = null;
		
		PrintWriter out = resp.getWriter();
		
		try {
		
			if (idProject == -1) {
				throw new Exception(idioma.getString("msg.error.project"));
			}
			costs = new Projectcosts();
			costs.setProject(new Project(idProject));
			
			costs = ProjectCostsLogic.saveCosts(costs);
			
			Iwo iwo = saveIwoFromRequest(req, costs);
			
			JSONObject costJSON = new JSONObject();
			costJSON.put("id", iwo.getIdIwo());
			costJSON.put("planned", iwo.getPlanned());
			costJSON.put("desc", iwo.getDescription());
			
			out.print(costJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
    }
    
    /**
     * Update project-costs chart
     * @param req
     * @param resp
     * @throws IOException
     */
    private void updateProjectCostChartJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	PrintWriter out = resp.getWriter();
    	
		Integer idProject = ParamUtil.getInteger(req, "id");

		try {
			Project project = ProjectLogic.consProject(idProject); 
			List<Projectfollowup> projectFollowups = ProjectFollowupLogic.consFollowups(project);
			
			ChartLine chart = new ChartLine(idioma);
			
			for (Projectfollowup item : projectFollowups) {
				
				if (item.getPv() != null) {
					
					Integer daysToDate = item.getDaysToDate();
					String daysToDateStr = (daysToDate == null?StringPool.BLANK:daysToDate.toString());
					
					chart.addElement(daysToDateStr, item.getPv().toString());
				}
			}
			
			JSONObject updateJSON = new JSONObject();
			updateJSON.put("xml", chart.generateXML());
			out.print(updateJSON);

		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}    	
    }
    
    /**
     * Generate chart finance image
     * @param req
     * @param resp
     * @throws IOException
     */
    private void financeChartImageJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	Integer idProject = ParamUtil.getInteger(req, "id");
		
		List<Incomes> incomes = null;
		
		try {
			incomes = IncomesLogic.consIncomes(idProject, Incomes.PLANNEDBILLDATE); 
			
			ChartFinancePlanValues values = null;
			
			ChartFinancePlan chartFinancePlan = new ChartFinancePlan();
			
			OutputStream out = resp.getOutputStream();
			
			for (Incomes item : incomes) {
				 
				 values = new ChartFinancePlanValues();
					
				 values.setPlannedAmount(Double.toString(item.getPlannedBillAmmount() /1000));
				 values.setValue(item.getPlanDaysToDate()+StringPool.BLANK);	
				 
				 chartFinancePlan.addFinancePlan(values);				 
			}				
			if (!incomes.isEmpty()){
				JFreeChart chart = chartFinancePlan.generateChart(idioma);
				 
				resp.setContentType("image/jpeg");					
													
				ChartUtilities.writeChartAsJPEG(out, chart, 800, 480);					
				out.close();
				 					 
			 }
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
    /**
     * Update project-costs chart P&L
     * @param req
     * @param resp
     * @throws IOException
     */
    private void updatePlChartJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	PrintWriter out = resp.getWriter();
		ChartDataSetPL dataSetPL = null;
		
		try {
			Integer idProject = ParamUtil.getInteger(req, "id");
			Project project = ProjectLogic.consProject(idProject);
			PlChartInfo plChartInfo = ChartLogic.consInfoPlChart(project);
			
			double sumIwos			= plChartInfo.getSumIwos();
			double sumExpenses		= plChartInfo.getSumExpenses();
			double sumDirectCost	= plChartInfo.getSumDirectCost();
			double dm				= plChartInfo.getDirectMargin();
			double dmPer			= Math.round(plChartInfo.getDirectMarginPercent());
			double tcv				= plChartInfo.getTcv();
			double netIncome		= plChartInfo.getCalculatedNetIncome();
			
			ChartStacked chartPL = new ChartStacked(idioma.getString("project_pl.thousands"), "");
			chartPL.addCategory(idioma.getString("tcv"));
			chartPL.addCategory(idioma.getString("project_pl.expenses"));
			chartPL.addCategory(idioma.getString("iwo"));
			chartPL.addCategory(idioma.getString("project_pl.net_income"));
			chartPL.addCategory(idioma.getString("project_pl.direct_costs"));
			chartPL.addCategory(idioma.getString("project_pl.dm")+" "+dmPer+"%");
			
			double divDouble	= new Double(1000);
			
			dataSetPL = new ChartDataSetPL(StringPool.BLANK, "BDBDBD",
					Double.toString(tcv/divDouble), 
					Double.toString(netIncome/divDouble),
					StringPool.BLANK, 1);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(StringPool.BLANK, "FFFFFF",
					Double.toString((tcv-sumExpenses)/divDouble),
					Double.toString((tcv-sumExpenses-sumIwos)/divDouble),
					Double.toString((netIncome-sumDirectCost)/divDouble),
					2);
			dataSetPL.setAlpha("0");
			dataSetPL.setShowValues("0");
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.direct_costs"), 
					"B40404",
					Double.toString(sumDirectCost/divDouble),
					StringPool.BLANK, StringPool.BLANK, 3);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.expenses"), 
					"688BB4",
					Double.toString(sumExpenses/divDouble),
					StringPool.BLANK, StringPool.BLANK, 4);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.iwo"), 
					"FFFF00",
					Double.toString(sumIwos/divDouble),
					StringPool.BLANK, StringPool.BLANK, 5);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.dm")+" "+dmPer+"%", 
					"7E7E7E",
					Double.toString(dm/divDouble),
					StringPool.BLANK, StringPool.BLANK, 6);
			chartPL.addDataSet(dataSetPL);
			
			chartPL.setShowLegend("0");
			String textXML = chartPL.generateXML(netIncome/divDouble);
			
			JSONObject updateJSON = new JSONObject();
			if (netIncome != (project.getNetIncome() == null?0:project.getNetIncome())) {
				updateJSON.put("warning", true);
			}
			updateJSON.put("xml", textXML);
			out.print(updateJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
    }
    
	/**
     * Released Resource
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void releasedResourceJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {

    	int idResource		= ParamUtil.getInteger(req, "idResource",-1);
    	String commentsPm	= ParamUtil.getString(req, "commentsPm");
		
		PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		TeamMemberLogic memberLogic = new TeamMemberLogic();
    		
    		Teammember member = memberLogic.findById(idResource);
    		member.setStatus(Constants.RESOURCE_RELEASED);
    		member.setCommentsPm(commentsPm);
    		
    		memberLogic.save(member);
    		
    		out.print(info("resource.is_released", null));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Update Threshold of project
     * @param req
     * @param resp
     * @throws IOException
     */
    private void updateThresholdJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idProject	= ParamUtil.getInteger(req, Project.IDPROJECT);
    	int lower		= ParamUtil.getInteger(req, Project.LOWERTHRESHOLD, 0);
    	int upper		= ParamUtil.getInteger(req, Project.UPPERTHRESHOLD, 0);
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			Project proj = ProjectLogic.consProject(idProject);
			proj.setLowerThreshold(lower);
			proj.setUpperThreshold(upper);
			
			ProjectLogic.saveProject(proj);
			
			out.print(info("msg.info.saved_upper_and_lower_threshold", null));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Update Staffing Table
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void updateStaffingTableJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	int idProject	= ParamUtil.getInteger(req, Project.IDPROJECT);
    	Date since		= ParamUtil.getDate(req, "since", dateFormat);
    	Date until		= ParamUtil.getDate(req, "until", dateFormat);
    	
    	List<TeamMembersFTEs> ftEs 	= null;
		List<String> listDates		= new ArrayList<String>();
		
    	try {
    		SimpleDateFormat dfYear = new SimpleDateFormat("yy");
    		
    		Calendar sinceCal		= DateUtil.getCalendar();
			Calendar untilCal		= DateUtil.getCalendar();
			
    		sinceCal.setTime(DateUtil.getFirstWeekDay(since));
			untilCal.setTime(DateUtil.getLastWeekDay(until));
			
			List<Teammember> teammembers = TeamMemberLogic.consStaffinFtes(new Project(idProject), since, until);
			
			ftEs = generateFTEsMembersByProject(teammembers, sinceCal.getTime(), untilCal.getTime());
			
			while (!sinceCal.after(untilCal)) {

				int sinceDay = sinceCal.get(Calendar.DAY_OF_MONTH);
				Calendar calWeek = DateUtil.getLastWeekDay(sinceCal);
				int untilDay = calWeek.get(Calendar.DAY_OF_MONTH);
				
				listDates.add(sinceDay+"-"+untilDay +" "+idioma.getString("month.min_"+(calWeek.get(Calendar.MONTH)+1))+" "+dfYear.format(calWeek.getTime()));
				
				sinceCal.add(Calendar.WEEK_OF_MONTH, 1);
			}
    	}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("listDates", listDates);
		req.setAttribute("ftEs", ftEs);
		
		forward("/project/common/staffing_table.ajax.jsp", req, resp);
	}
    
    /**
	 * Generate Team Members Ftes by Project
	 * @param teammembers
	 * @param sinceDate
	 * @param untilDate
	 * @return
	 * @throws LogicException 
	 */
	private List<TeamMembersFTEs> generateFTEsMembersByProject(List<Teammember> teammembers, Date sinceDate, Date untilDate) throws Exception {
		
		List<TeamMembersFTEs> listMembers 	= new ArrayList<TeamMembersFTEs>();
		Calendar sinceCal			= DateUtil.getCalendar();
		Calendar untilCal			= DateUtil.getCalendar();
		int idEmploye				= -1;
		TeamMembersFTEs memberFtes	= null;
		int[] listFTES				= null;
		
		if (sinceDate != null || untilDate != null) {
			sinceCal.setTime(sinceDate);
			untilCal.setTime(untilDate);
			
			int weeks = 0;
			while (!sinceCal.after(untilCal)) {
				weeks++;
				sinceCal.add(Calendar.DAY_OF_MONTH, +7);
			}
			
			for (Teammember member : teammembers) {
				
				if (memberFtes == null || !(idEmploye == member.getEmployee().getIdEmployee())) {
					 
					if (memberFtes != null) {
						memberFtes.setFtes(listFTES);
						listMembers.add(memberFtes);
					}
					
					listFTES	= new int[weeks];
					memberFtes	= new TeamMembersFTEs(member);
					idEmploye	= member.getEmployee().getIdEmployee();
				}
				
				int i = 0;
				sinceCal.setTime(sinceDate);
				
				Calendar dayCal		= null;
				Calendar weekCal	= null;
				
				while (!sinceCal.after(untilCal)) {
					
					dayCal	= DateUtil.getCalendar();
					dayCal.setTime(sinceCal.getTime());
					weekCal = DateUtil.getLastWeekDay(dayCal);
					
					int fte			= 0;
					int workDays	= 5;
					
					while (!dayCal.after(weekCal)) {
					
						if (DateUtil.between(member.getDateIn(), member.getDateOut(), dayCal.getTime()) && !DateUtil.isWeekend(dayCal)) {
							fte += (member.getFte() == null?0:member.getFte());
						}
						
						dayCal.add(Calendar.DAY_OF_MONTH, 1);
					}
					
					listFTES[i] +=  (workDays > 0?fte/workDays:0);
					
					i++;
					sinceCal.add(Calendar.DAY_OF_MONTH, +7);
				}
			}
			if (memberFtes != null) {
				memberFtes.setFtes(listFTES);
				listMembers.add(memberFtes);
			}
		}
		return listMembers;
	}
	
    /**
     * Delete Project Kpi
     * @param req
     * @param resp
     * @throws IOException
     */
    private void deleteKpiJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    	int idProjectKPI	= ParamUtil.getInteger(req, Projectkpi.IDPROJECTKPI,-1);
		
		PrintWriter out = resp.getWriter();
		
		try {
			ProjectKpiLogic kpiLogic = new ProjectKpiLogic();
			kpiLogic.delete(new Projectkpi(idProjectKPI));
			
			out.print(infoDeleted("kpi"));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Save Project KPI
     * @param req
     * @param resp
     * @throws IOException 
     */
	private void saveKpiJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		int idProject		= ParamUtil.getInteger(req, Project.IDPROJECT);
		int idProjectKPI	= ParamUtil.getInteger(req, Projectkpi.IDPROJECTKPI,-1);
		int idMetricKpi		= ParamUtil.getInteger(req, Metrickpi.IDMETRICKPI,-1);
		int upperThreshold	= ParamUtil.getInteger(req, Projectkpi.UPPERTHRESHOLD,0);
		int lowerThreshold	= ParamUtil.getInteger(req, Projectkpi.LOWERTHRESHOLD,0);
		int weight			= ParamUtil.getInteger(req, Projectkpi.WEIGHT,0);
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			Projectkpi projKpi = null;
			
			JSONObject returnJSON = null;
			
			if (ProjectKpiLogic.metricExist(new Project(idProject), idProjectKPI, new Metrickpi(idMetricKpi))) {
				throw new LogicException("msg.error.metric_is_in_use");
			}
			
			if (idProjectKPI == -1) {
				projKpi = new Projectkpi();
				projKpi.setProject(new Project(idProject));
				
				returnJSON = infoCreated(returnJSON, "kpi");
			}
			else {
				projKpi = ProjectKpiLogic.findProjectKpi(idProjectKPI);
				
				returnJSON = infoUpdated(returnJSON, "kpi");
			}

			projKpi.setMetrickpi(new Metrickpi(idMetricKpi));
			
			projKpi.setUpperThreshold(upperThreshold);
			projKpi.setLowerThreshold(lowerThreshold);
			projKpi.setWeight(weight);
			
			projKpi = ProjectKpiLogic.saveProjectKpi(projKpi);
			
			returnJSON.put(Projectkpi.IDPROJECTKPI, projKpi.getIdProjectKpi());
			
			out.print(returnJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Update Team Calendar
     * @param req
     * @param resp
     * @throws IOException 
	 * @throws ServletException 
     */
    private void updateTeamCalendarJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException, ServletException {
		
    	int idProject	= ParamUtil.getInteger(req, Project.IDPROJECT);
    	Date since		= ParamUtil.getDate(req, "since", dateFormat);
    	Date until		= ParamUtil.getDate(req, "until", dateFormat);
    	
    	try {
    		
    		Projectcalendar calendar = ProjectcalendarLogic.consCalendarByProject(new Project(idProject));
    		
    		List<Teammember> members = TeamMemberLogic.consStaffinFtes(new Project(idProject), since, until); 
    		
    		List<TeamCalendar> teamCalendars = new ArrayList<TeamCalendar>();
    		
    		Contact contact				= null;
    		TeamCalendar teamCalendar	= null;
    		
    		for (Teammember member : members) {
    			
    			if (contact == null || contact.getIdContact() != member.getEmployee().getContact().getIdContact()) {
    				
    				if (teamCalendar != null) { teamCalendars.add(teamCalendar); }
    				
    				teamCalendar = new TeamCalendar(member.getEmployee());
    				contact		 = member.getEmployee().getContact();
    			}
    			
    			Calendar sinceCal = DateUtil.getCalendar();
        		sinceCal.setTime(member.getDateIn());
        		
        		Calendar untilCal = DateUtil.getCalendar();
        		untilCal.setTime(member.getDateOut());
        		
        		while (!sinceCal.after(untilCal)) {
        			
        			teamCalendar.addWork(sinceCal.getTime());
        			sinceCal.add(Calendar.DAY_OF_MONTH, 1);
        		}
    		}
    		if (teamCalendar != null) { teamCalendars.add(teamCalendar); }
    		
    		List<String> dates = new ArrayList<String>();
    		
    		boolean isCreateDates = false;
    		
    		for (TeamCalendar teamCal : teamCalendars) {
    			
    			JSONObject teamJSON = new JSONObject();
    			teamJSON.put("name", teamCal.getName());
    			
	    		Calendar sinceCal = DateUtil.getCalendar();
	    		sinceCal.setTime(since);
	    		
	    		Calendar untilCal = DateUtil.getCalendar();
	    		untilCal.setTime(until);
	    		
	    		while (!sinceCal.after(untilCal)) {
	    			
	    			if (!isCreateDates) {
	    				dates.add(sinceCal.get(Calendar.DAY_OF_MONTH)+"-"+(sinceCal.get(Calendar.MONTH)+1));
	    			}
	    			
	    			boolean isException = false;
	    			if (calendar != null) {
		    			for (Projectcalendarexceptions exception : calendar.getProjectcalendarexceptionses()) {
		    				
		    				if (DateUtil.between(exception.getStartDate(), exception.getFinishDate(),sinceCal.getTime())) {
		    					
		    					teamCal.addValue("exceptionDay");
		    					isException = true;
		    					break;
		    				}
		    			}
		    			if (!isException) {
			    			for (Calendarbaseexceptions exception : calendar.getCalendarbase().getCalendarbaseexceptionses()) {
			    				
			    				if (DateUtil.between(exception.getStartDate(), exception.getFinishDate(),sinceCal.getTime())) {
			    					
			    					teamCal.addValue("exceptionDay");
			    					isException = true;
			    					break;
			    				}
			    			}
		    			}
		    			if (!isException) {
		    				
		    				CalendarbaseexceptionsLogic exceptionsLogic = new CalendarbaseexceptionsLogic();
		    				List<Calendarbaseexceptions> exceptions = exceptionsLogic.findByEmployee(teamCal.getIdEmployee());
		    				
			    			for (Calendarbaseexceptions exception : exceptions) {
			    				
			    				if (DateUtil.between(exception.getStartDate(), exception.getFinishDate(),sinceCal.getTime())) {
			    					
			    					teamCal.addValue("exceptionDay");
			    					isException = true;
			    					break;
			    				}
			    			}
		    			}
	    			}
	    			
	    			if (!isException) {
	    				
	    				if (DateUtil.isWeekend(sinceCal)) { teamCal.addValue("nonWorkingDay"); }
	    				else if (teamCal.getWork().contains(sinceCal.getTime())) { teamCal.addValue("workDay"); }
	    				else { teamCal.addValue("notWorkDay"); }
	    			}
	    			
	    			sinceCal.add(Calendar.DAY_OF_MONTH, 1);
	    		}
	    		
	    		isCreateDates = true;
    		}
    		
    		req.setAttribute("dates", dates);
    		req.setAttribute("teamCalendars", teamCalendars);
    	}
    	catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    	
    	req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
    	forward("/project/plan/plan_team_calendar.ajax.jsp", req, resp);
	}

	/**
     * Find Members
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void findMemberJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		
		String idSkills	 = ParamUtil.getString(req, "idSkill", null);
		int idPerfOrg 	 = ParamUtil.getInteger(req, Performingorg.IDPERFORG, -1);
		int idResManager = ParamUtil.getInteger(req, "idResourceManager", -1);
		
		try {
			
			Employee user = (Employee) req.getSession().getAttribute("user");
			Company company = CompanyLogic.searchByEmployee(user);
			
			List<Employee> employees = EmployeeLogic.searchEmployees(
					Constants.ROLE_RESOURCE, idSkills,
					new Performingorg(idPerfOrg), company, idResManager);
			
			JSONArray employeesJSONArray = new JSONArray();
			for (Employee employee: employees) {
				JSONObject memberJSON = JSONModelUtil.employeeToJSON(idioma, employee);
				employeesJSONArray.add(memberJSON);
			}
			
			out.print(employeesJSONArray);
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
    
    /**
     * @author Cedric Ndanga
     * Verify that workload in days is valid, and generate JSONObject workload in percentage
     * @param req
     * @param resp
     * usage jsp/project/plan/edit_teammember_popup.jsp
     */
    private void verifyDaysJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	
    	PrintWriter out = resp.getWriter();
    	Integer idMember = ParamUtil.getInteger(req, "member_id", -1);
    	Teammember member = null;
    	try {
			if(idMember == -1) {
				member = new Teammember();
				//LOGGER.debug("New team member created");;
			}
			else {
				member = TeamMemberLogic.consTeamMember(idMember);
				//LOGGER.debug("Team member already exist");
			}
			
			member = setMemberFromRequest(req, member);
			
			// Compute workload in days
			float workDays = TeamMemberLogic.workDaysInPeriod(member, member.getDateIn(), member.getDateOut());
			// CNA adding Json communication
			JSONObject data = new JSONObject();
			
			//throw new LogicException("msg.error.days_more_big_than_work_days_free");
			data.put("number_works_days", workDays);
			data.put("workload_in_days", member.getWorkloadInDays());
			member.setFte(0);
			if(workDays > 0) {
				member.setFte(TeamMemberLogic.daysInFte(member.getWorkloadInDays(), new Double(workDays)));
			}
			data.put("member_fte", member.getFte());
			
			out.print(data);
		} catch (Exception e) {
			LOGGER.fatal(e);
			ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e);
		} 
    	finally {
    		out.close();
    		//LOGGER.info("Finally");
		}
    }
    
    /**
     * @author Cedric Ndanga
     * Generate JSONObject workload in days
     * @param req
     * @param resp
     * usage jsp/project/plan/edit_teammember_popup.jsp
     */
    private void verifyFteJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	
    	PrintWriter out = resp.getWriter();
    	Integer idMember = ParamUtil.getInteger(req, "member_id", -1);
    	Teammember member = null;
		try {
			if(idMember == -1) {
				member = new Teammember();
				//LOGGER.debug("New team member created");
			}
			else {
				member = TeamMemberLogic.consTeamMember(idMember);
				//LOGGER.debug("Team member already exist");
			}
			
			member = setMemberFromRequest(req, member);
			
			float workDays = TeamMemberLogic.workDaysInPeriod(member, member.getDateIn(), member.getDateOut());
			
			member.setWorkloadInDays(new Double( TeamMemberLogic.fteInDays( member.getFte(), workDays ) ) );
			JSONObject data = new JSONObject();
			data.put("member_days", NumberUtil.truncate2decimals(member.getWorkloadInDays().doubleValue()));
			data.put("number_works_days", workDays);
			out.print(data);
		} catch (Exception e) {
			LOGGER.fatal(e);
		}
		finally {
			out.close();
		}
    }
    
    /**
     * Save Team Member
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveMemberJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		
		Integer idProject		= ParamUtil.getInteger(req, "id", -1);
		Integer idTeamMember 	= ParamUtil.getInteger(req, "member_id", -1);
		
		Teammember member = null;			
		
		try {
		
			if (idTeamMember == -1) { 
				member = new Teammember();
			}
			else {
				member = TeamMemberLogic.consTeamMember(idTeamMember);
			}
			
			member.setStatus(Constants.RESOURCE_PRE_ASSIGNED);
			
			member = setMemberFromRequest(req,member);
			
			member = TeamMemberLogic.saveResource(member);
			member = TeamMemberLogic.consTeamMember(member);
			
			JSONObject memberJSON = JSONModelUtil.memberToJSON(idioma, member);
			
			if (Settings.MAIL_NOTIFICATION) {
				String to = null;
				if (member.getEmployee().getEmployee() != null) {
					to = member.getEmployee().getEmployee().getContact().getEmail();
				}
				if (ValidateUtil.isNull(to)) {
					
					memberJSON = info("msg.error.rm_email", memberJSON, member.getEmployee().getEmployee().getContact().getFullName());
				}
				Employee user	= SecurityUtil.consUser(req);
				String from		= user.getContact().getEmail();
				
				if (ValidateUtil.isNull(from)) {
					
					memberJSON = info("msg.error.pm_email", memberJSON, user.getContact().getFullName());
				}
				
				try {
					Project project = ProjectLogic.consProject(idProject);
					
					EmailUtil email = new EmailUtil(from, to);
					email.setSubject("[OpenPPM] - Team Member assigned");
					email.setBodyText(user.getContact().getFullName()+" has assigned "+member.getEmployee().getContact().getFullName()+" to project "+project.getProjectName());
					email.send();
				}
				catch (Exception e) {
					memberJSON = info("msg.info.mail_account", memberJSON);
					ExceptionUtil.sendToLogger(LOGGER, e, null);
				}
			}
			if (idTeamMember == -1) { memberJSON = info("msg.info.preassign", memberJSON, "team_member");}
			else { memberJSON = infoUpdated(memberJSON, "team_member"); }
			
			out.print(memberJSON);
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     */
    private void updateMemberJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		
		Integer idProject		= ParamUtil.getInteger(req, "id", -1);
		Integer idTeamMember 	= ParamUtil.getInteger(req, "member_id", -1);
		Date dateOut			= ParamUtil.getDate(req, "member_dateout", dateFormat, null);	
		Double days				= ParamUtil.getCurrency(req, "member_days", 0);                // Containing new workload in days
		
		Teammember member = null;
		
		try {
		
			member = TeamMemberLogic.consTeamMember(idTeamMember);
			if(dateOut.before(member.getDateOut())) {
				throw new LogicException(idioma.getString("msg.error.date_before"));
			}			
			
			member.setDateOut(dateOut);
			member.setWorkloadInDays(days);  //Updating of workloadInDays if already setting or not.
			
			member = TeamMemberLogic.saveResource(member);
			member = TeamMemberLogic.consTeamMember(member);
			
			TeamMemberLogic.approveTeamMember(member.getIdTeamMember(), null);
			
			JSONObject memberJSON = JSONModelUtil.memberToJSON(idioma, member);
			
			if (Settings.MAIL_NOTIFICATION) {
				String to = null;
				if (member.getEmployee().getEmployee() != null) {
					to = member.getEmployee().getEmployee().getContact().getEmail();
				}
				if (ValidateUtil.isNull(to)) {
					
					memberJSON = info("msg.error.rm_email", memberJSON, member.getEmployee().getEmployee().getContact().getFullName());
				}
				Employee user	= SecurityUtil.consUser(req);
				String from		= user.getContact().getEmail();
				
				if (ValidateUtil.isNull(from)) {
					
					memberJSON = info("msg.error.pm_email", memberJSON, user.getContact().getFullName());
				}
				
				try {
					Project project = ProjectLogic.consProject(idProject);
					
					EmailUtil email = new EmailUtil(from, to);
					email.setSubject("[OpenPPM] - Team Member updated");
					email.setBodyText("The assignment of " + member.getEmployee().getContact().getFullName() + "has been updated by " + user.getContact().getFullName() + " to project " + project.getProjectName());
					email.send();
				}
				catch (Exception e) {
					memberJSON = info("msg.info.mail_account", memberJSON);
					ExceptionUtil.sendToLogger(LOGGER, e, null);
				}
			}
			if (idTeamMember == -1) { memberJSON = infoCreated(memberJSON, "team_member"); }
			else { memberJSON = infoUpdated(memberJSON, "team_member"); }
			
			out.print(memberJSON);
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

    /**
     * Delete Calendar Exception
     * @param req
     * @param resp
     * @throws IOException 
     */
	private void deleteCalendarExceptionJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out			= resp.getWriter();		
		
		int idProjectCalendarException = ParamUtil.getInteger(req, Projectcalendarexceptions.IDPROJECTCALENDAREXCEPTION,-1);
		
		try {	
			
			ProjectCalendarExceptionsLogic.deleteException(new Projectcalendarexceptions(idProjectCalendarException));

			out.print(infoDeleted("calendar.exceptions"));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}


	/**
	 * Save Project Calendar Exception
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	private void saveCalendarExceptionJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		int idProject			= ParamUtil.getInteger(req, Project.IDPROJECT, -1);
		int idProjectException	= ParamUtil.getInteger(req, "idExceptionWork", -1);
		Date startDate 			= ParamUtil.getDate(req, "calendar_start", dateFormat);
		Date finishDate			= ParamUtil.getDate(req, "calendar_end", dateFormat);
		String description		= ParamUtil.getString(req, "calendar_name");
		
		PrintWriter out	= resp.getWriter();		
		
		try {	
	    	
			JSONObject outJSON = null;
			
			Projectcalendar calendar = ProjectcalendarLogic.consCalendarByProject(new Project(idProject));
			
			if (calendar == null) {
				calendar = new Projectcalendar();
				calendar = ProjectcalendarLogic.saveCalendar(calendar);

				Project proj = ProjectLogic.consProject(idProject);
				proj.setProjectcalendar(calendar);
					
				ProjectLogic.saveProject(proj);
				
				outJSON = infoCreated(outJSON, "project.calendar");
			}
			
			
	    	Projectcalendarexceptions exception = null;
	    	
	    	if (idProjectException != -1) {
	    		
	    		exception = ProjectCalendarExceptionsLogic.findById(new Projectcalendarexceptions(idProjectException));
	    		outJSON = infoUpdated(outJSON, "calendar.exceptions");
	    	}
	    	else {
	    		
	    		exception = new Projectcalendarexceptions();
	    		exception.setProjectcalendar(calendar);
	    		outJSON = infoCreated(outJSON, "calendar.exceptions");
	    	}
	    	
	    	exception.setStartDate(startDate);
    		exception.setFinishDate(finishDate);
    		exception.setDescription(description);
    		
			exception = ProjectCalendarExceptionsLogic.saveException(exception);
			
			outJSON.put(Projectcalendarexceptions.IDPROJECTCALENDAREXCEPTION, exception.getIdProjectCalendarException());
			out.print(outJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
    /**
     * Save Project Calendar
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void saveCalendarJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	
    	Integer idProject		= ParamUtil.getInteger(req, "idProject",-1);
    	Integer weekStart 		= ParamUtil.getInteger(req, "weekStart",1);
    	Integer fiscalYearStart = ParamUtil.getInteger(req, "fiscalYearStart",1);
    	double startTime1 		= ParamUtil.getDouble(req, "startTime1");
    	double startTime2 		= ParamUtil.getDouble(req, "startTime2");
    	double endTime1 		= ParamUtil.getDouble(req, "endTime1");
    	double endTime2 		= ParamUtil.getDouble(req, "endTime2");
    	double hoursDay			= ParamUtil.getDouble(req, "hoursDay");
    	double hoursWeek 		= ParamUtil.getDouble(req, "hoursWeek");
    	Integer daysMonth 		= ParamUtil.getInteger(req, "daysMonth");
		
    	PrintWriter out			= resp.getWriter();		
		
		try {	
			JSONObject outJSON = null;
				
			Projectcalendar calendar = ProjectcalendarLogic.consCalendarByProject(new Project(idProject));
			
			if (calendar == null) {
				calendar = new Projectcalendar();
				outJSON = infoCreated(outJSON, "project.calendar");
			}
			
			calendar.setWeekStart((weekStart == -1 ? null : weekStart));
			calendar.setFiscalYearStart((fiscalYearStart == -1 ? null : fiscalYearStart));
			calendar.setDaysMonth((daysMonth == -1 ? null : daysMonth));
			calendar.setStartTime1((startTime1 == -1 ? null : startTime1));
			calendar.setStartTime2((startTime2 == -1 ? null : startTime2));
			calendar.setEndTime1((endTime1 == -1 ? null : endTime1));
			calendar.setEndTime2((endTime2 == -1 ? null : endTime2));
			calendar.setHoursDay((hoursDay == -1 ? null : hoursDay));
			calendar.setHoursWeek((hoursWeek == -1 ? null : hoursWeek));
			
			calendar = ProjectcalendarLogic.saveCalendar(calendar);
			
			if (outJSON != null) {
				Project proj = ProjectLogic.consProject(idProject);
				proj.setProjectcalendar(calendar);
				
				ProjectLogic.saveProject(proj);
			}
			else {
				
				outJSON = infoUpdated(outJSON, "project.calendar");
			}
			
			
			out.print(outJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
   
    /**
     * Change Calendar Base
     * @param req
     * @param resp
     * @param idProject
     * @throws IOException 
     * @throws ServletException 
     */
    private void changeCalendarBase(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	int idProject		= ParamUtil.getInteger(req, "id");
    	int idCalendarBase	= ParamUtil.getInteger(req, Calendarbase.IDCALENDARBASE, -1);
    	
    	try {
    		
    		List<String> joins = new ArrayList<String>();
			joins.add(Project.PROJECTCALENDAR);
			
			Project project = ProjectLogic.consProject(new Project(idProject), joins);
    		
    		Projectcalendar projCalendar = project.getProjectcalendar();
    		
    		if (projCalendar == null && idCalendarBase != -1) {
    			
    			projCalendar = new Projectcalendar();
    			
    			Calendarbase base = CalendarBaseLogic.consCalendarBase(new Calendarbase(idCalendarBase));
    			projCalendar.setDaysMonth(base.getDaysMonth());
    			projCalendar.setEndTime1(base.getEndTime1());
    			projCalendar.setEndTime2(base.getEndTime2());
    			projCalendar.setFiscalYearStart(base.getFiscalYearStart());
    			projCalendar.setHoursDay(base.getHoursDay());
    			projCalendar.setHoursWeek(base.getHoursWeek());
    			projCalendar.setStartTime1(base.getStartTime1());
    			projCalendar.setStartTime2(base.getStartTime2());
    			projCalendar.setWeekStart(base.getWeekStart());
    			
    			projCalendar.setCalendarbase(new Calendarbase(idCalendarBase));
    			projCalendar = ProjectcalendarLogic.saveCalendar(projCalendar);
    			
    			project.setProjectcalendar(projCalendar);
    			
    			ProjectLogic.saveProject(project);
    			
    			infoCreated(req, "project.calendar");
    		}
    		else if (idCalendarBase != -1){

    			infoUpdated(req, "project.calendar");
    			
    			projCalendar.setCalendarbase(new Calendarbase(idCalendarBase));
    			ProjectcalendarLogic.saveCalendar(projCalendar);
    		}
    		else if (projCalendar != null && idCalendarBase == -1) {
    			
    			projCalendar.setCalendarbase(null);
    			ProjectcalendarLogic.saveCalendar(projCalendar);
    			
    			infoUpdated(req, "project.calendar");
    		}
    	}
    	catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
    	viewProjectPlanning(req, resp, idProject);
	}

	/**
     * Delete Checklist
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void deleteCheckListJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idChecklist	= ParamUtil.getInteger(req, Checklist.IDCHECKLIST,-1);
    	PrintWriter out = resp.getWriter();
		
		try {
			
			ChecklistLogic.deleteChecklist(new Checklist(idChecklist));
			out.print(infoDeleted("checklist"));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Save Checklist
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void saveCheckListJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idWbsnode		= ParamUtil.getInteger(req, Wbsnode.IDWBSNODE);
    	int idChecklist		= ParamUtil.getInteger(req, Checklist.IDCHECKLIST,-1);
    	String code			= ParamUtil.getString(req, Checklist.CODE);
    	String description	= ParamUtil.getString(req, Checklist.DESCRIPTION);
    	
    	PrintWriter out = resp.getWriter();
		
		try {
			
			ChecklistLogic checklistLogic = new ChecklistLogic();
			
			Checklist checklist = null;
			
			if (idChecklist == -1) { checklist = new Checklist(); }
			else {
				checklist = checklistLogic.findById(idChecklist, false);
			}
			
			checklist.setCode(code);
			checklist.setDescription(description);
			checklist.setWbsnode(new Wbsnode(idWbsnode));
			
			checklist = checklistLogic.save(checklist);
			
			out.print(JsonUtil.toJSON(Checklist.IDCHECKLIST, checklist.getIdChecklist()));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Save Milestone
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveMilestoneJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	Character reportType	= ParamUtil.getString(req, "report_sign", StringPool.BLANK).charAt(0);
		Date plannedDate		= ParamUtil.getDate(req, "planned_date", dateFormat, null);
		String label			= ParamUtil.getString(req, "label", StringPool.BLANK);
		String description		= ParamUtil.getString(req, "description", StringPool.BLANK);
		Integer idMilestone 	= ParamUtil.getInteger(req, "milestone_id", -1);
		Integer idProject		= ParamUtil.getInteger(req, Project.IDPROJECT, -1);
		Integer idActivity		= ParamUtil.getInteger(req, "activity", -1);
		boolean notify			= ParamUtil.getBoolean(req, Milestones.NOTIFY,false);
		int	notifyDays			= ParamUtil.getInteger(req, Milestones.NOTIFYDAYS,0);
		String notificationText = ParamUtil.getString(req, Milestones.NOTIFICATIONTEXT);
		
		PrintWriter out = resp.getWriter();
		
		try {

			Projectactivity activity = ProjectActivityLogic.consActivity(idActivity);
			
			JSONObject returnJSON	= null;
			Milestones milestone	= null;
			
			if (idMilestone != -1) {
				milestone = MilestoneLogic.consMilestone(new Milestones(idMilestone));
				returnJSON = infoUpdated(returnJSON, "milestone");
			}
			else {
				milestone = new Milestones();
				milestone.setProject(new Project(idProject));
				returnJSON = infoCreated(returnJSON, "milestone");
			}
			
			milestone.setReportType(reportType);
			milestone.setPlanned(plannedDate);
			milestone.setLabel(label);
			milestone.setDescription(description);
			milestone.setNotify(notify);
			milestone.setNotifyDays(notifyDays);
			milestone.setNotificationText(notificationText);
			
			// Date for notification
			if (notify) {
				Calendar notifyDate = Calendar.getInstance();
				notifyDate.setTime(plannedDate);
				notifyDate.add(Calendar.DAY_OF_MONTH, 0-notifyDays);
				
				milestone.setNotifyDate(notifyDate.getTime());
			}
			else {
				milestone.setNotifyDate(null);
			}
			
			milestone.setProjectactivity(activity);
			
			milestone = MilestoneLogic.saveMilestone(milestone);
			
			JSONObject milestoneJSON = JSONModelUtil.milestoneToJSON(idioma, milestone);
			JSONObject activityJSON = JSONModelUtil.activityToJSON(idioma, activity);
			
			returnJSON.put("milestone", milestoneJSON);
			returnJSON.put("activity", activityJSON);
			
			out.print(returnJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Send information of structure
     * @param req
     * @param resp
     * @throws IOException
     */
    private void validateWBS(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
    	
    	int idProject = ParamUtil.getInteger(req, Project.IDPROJECT);
    	
    	List<ParamResourceBundle> info = null;
    	try {
    		
    		info = WBSNodeLogic.checkErrorsWBS(new Project(idProject));
    		
    		JSONObject infoJSON = new JSONObject();

    		for (ParamResourceBundle e : info) {
    			info(e.toString(idioma), infoJSON);
			}
    		
			if (info.isEmpty()) { info("wbs.info", infoJSON); }
			
    		out.print(infoJSON.toString());
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

    private void projectActions(HttpServletRequest req, HttpServletResponse resp, String accion) throws IOException, ServletException {
    	Integer idProject = ParamUtil.getInteger(req, "id",null);
		
		try {			
			if (DELETE_WBSNODE.equals(accion)) { deleteWbsNode(req, resp); }
			else if (EDIT_WBSNODE.equals(accion) || SAVE_WBSNODE.equals(accion)) { saveWbsNode (req, resp, accion); }
			else if (SAVE_PROJECT.equals(accion)) { saveProject(req, resp); }
			else if (DEL_INCOME.equals(accion)) { deleteIncome(req, resp); }
			else if (DEL_FOLLOWUP.equals(accion)) { deleteFollowup(req, resp); }
			else if (DEL_COST.equals(accion)) { deleteCost(req, resp); }
			else if (DEL_IWO.equals(accion)) { deleteIwo(req, resp); }
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewProjectPlanning(req, resp, idProject);
    }
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     */
    private void deleteWbsNode(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    	int idWbsnode = ParamUtil.getInteger(req, "wbs_id", -1);
    	
    	try {		
    		WBSNodeLogic.deleteWBSNode(idWbsnode);
			infoDeleted(req, "change.wbs_node");
	    }
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
    /**
     * 
     * @param req
     * @param resp
     * @param accion
     * @throws IOException
     * @throws ServletException
     */
    private void saveWbsNode(HttpServletRequest req, HttpServletResponse resp, String accion) throws IOException, ServletException {
    	Integer idProject = ParamUtil.getInteger(req, "id",null);
    	
    	try {
    		Wbsnode wbsNode = null;						
			wbsNode = setWbsNodeFromRequest(req);
			boolean isChangedCA = WBSNodeLogic.saveWBSnode(wbsNode, new Project(idProject));
			
			if (EDIT_WBSNODE.equals(accion)) {
				infoUpdated(req, "change.wbs_node");
				if (isChangedCA) {								
					info(req, "msg.info.wbsnode_ca", "change.wbs_node");
				}
			}
			else {
				infoCreated(req, "change.wbs_node");
			}    	
	    }
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     */
    private void saveProject(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
    	Integer idProject = ParamUtil.getInteger(req, "id",null);
		String scopeStatement 	= ParamUtil.getString(req, "scope_statement", StringPool.BLANK);
		String hdDescription 	= ParamUtil.getString(req, "schedule_hd_description", StringPool.BLANK);
		
		try {
			Project project = ProjectLogic.consProject(idProject);
			project.setScopeStatement(scopeStatement);
			project.setHdDescription(hdDescription);
			ProjectLogic.saveProject(project);
			
			List<ParamResourceBundle> info = WBSNodeLogic.checkErrorsWBS(project);
			
			for (ParamResourceBundle e : info) {
				info(req, e.toString(idioma));
			}
	
			if (MilestoneLogic.checkMilestones(project)) {
				info(req, "msg.error.milestones_without_activity");
			}
	    }
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     */
    private void deleteIncome(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {    	
    	Integer idIncome = ParamUtil.getInteger(req, "income_id", -1);
    	
		try {
			IncomesLogic.deleteIncome(idIncome);
	    }
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     */
    private void deleteFollowup(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {    	
    	Integer idFollowup = ParamUtil.getInteger(req, "followup_id", -1);
    	
		try {
			ProjectFollowupLogic.deleteFollowup(idFollowup);
	    }
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     */
    private void deleteCost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {    	
    	Integer idCost = ParamUtil.getInteger(req, "cost_id", -1);
		Integer costType = ParamUtil.getInteger(req, "cost_type", -1);
		
		try {
			ProjectCostsLogic.deleteCost(idCost, costType);
	    }
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     */
    private void deleteIwo(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {    	
    	Integer idIwo = ParamUtil.getInteger(req, "iwo_id", -1);
    	
		try {		
			IwosLogic.deleteIwo(idIwo);
	    }
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
    }
    
	/**
     * Save activity
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     * updater Cedric Ndanga
     */
    private void saveActivity(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

		Integer idActivity 		= ParamUtil.getInteger(req, "idactivity", -1);
		Date initDate 			= ParamUtil.getDate(req, "init_date", dateFormat, null);
		Date endDate 			= ParamUtil.getDate(req, "end_date", dateFormat, null);
		Double initWorkload		= ParamUtil.getDouble(req, "init_workload", null);				// cnw us40 getting initial workload
		String dictionary 		= ParamUtil.getString(req, "wbs_dictionary", null);
		double pv		 		= ParamUtil.getCurrency(req, Projectactivity.PV, 0);
		
		try {
			if (idActivity == -1) {
				throw new NoDataFoundException();
			}
			Projectactivity activity = ProjectActivityLogic.consActivity(idActivity);
			activity.setPlanInitDate(initDate);
			activity.setPlanEndDate(endDate);
			activity.setInitWorkload(initWorkload);					// cnw us40 setting initial workload before saving activity. 
			activity.setWbsdictionary(dictionary);
			activity.setPv(pv);
			
			ProjectActivityLogic.savePlanActivity(activity);
			LOGGER.debug(activity.getInitWorkload()+"init");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewProjectPlanning(req, resp, null);
	}

	/**
	 * Set Team Member instance from request
	 * @param req
	 * @return
	 */
	private Teammember setMemberFromRequest(HttpServletRequest req, Teammember member) {
		
		Integer idActivity		= ParamUtil.getInteger(req, "idActivity", -1);
		Date dateIn				= ParamUtil.getDate(req, "member_datein", dateFormat, null);
		Date dateOut			= ParamUtil.getDate(req, "member_dateout", dateFormat, null);
		Integer idEmployee 		= ParamUtil.getInteger(req, "employee_id", -1);
		int fte					= ParamUtil.getInteger(req, "member_fte", 0);
		double sellRate			= ParamUtil.getCurrency(req, Teammember.SELLRATE, 0);
		int idSkill				= ParamUtil.getInteger(req, "idSkill",-1);
		String commentsPm		= ParamUtil.getString(req, "commentsPm");
		double workloadInDays	= ParamUtil.getCurrency(req, "member_days", 0);
		
		member.setSkill(idSkill == -1 ? null : new Skill(idSkill));
		member.setFte(fte);
		member.setSellRate(sellRate);
		member.setDateIn(dateIn);
		member.setDateOut(dateOut);
		member.setProjectactivity(new Projectactivity(idActivity));
		member.setEmployee(new Employee(idEmployee));
		member.setCommentsPm(commentsPm);
		member.setWorkloadInDays(workloadInDays);
		
		return member;
	}
	

	/**
     * Redirect to Project Planning
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
	private void viewProjectPlanning(HttpServletRequest req,
			HttpServletResponse resp, Integer idProject) throws ServletException, IOException {
		
		// Information to recover
		Project project						= null;		
		List<Program> programs				= null;
		List<Milestones> milestones			= null;		
		List<Projectfollowup> followups		= null;
		List<Projectcosts> costs			= null;
		List<Iwo> iwos						= null;
		List<Budgetaccounts> budgetaccounts = null;
		List<Teammember> team				= null;
		List<Resourceprofiles> profiles 	= null;
		List<Skill> skills					= null;
		List<Performingorg> perfOrgs		= null;
		List<Checklist> checklists			= null;
		List<Wbsnode> wbsnodes				= null;
		List<Calendarbase> listCalendars	= null;
		Projectactivity rootActivity		= null;
		List<Documentproject> docs			= null;
		List<Metrickpi> metricKpis			= null;
		List<Employee> resourceManagers		= null;
		List<Projectactivity> activities	= null;
		
		if (idProject == null) {
			idProject = ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		}
		
		boolean hasPermission = false;
		
		try {
			
			hasPermission = SecurityUtil.hasPermission(req, new Project(idProject), Constants.TAB_PLAN);
			
			if (hasPermission) {
				
				Employee user	= SecurityUtil.consUser(req);
				Company company	= CompanyLogic.searchByEmployee(user);
				
				CalendarBaseLogic baseLogic	= new CalendarBaseLogic();
				SkillLogic skillLogic		= new SkillLogic();
				ResourceProfilesLogic resourceProfilesLogic = new ResourceProfilesLogic();
				PerformingOrgLogic performingOrgLogic		= new PerformingOrgLogic();
				ProjectActivityLogic activityLogic			= new ProjectActivityLogic();
				
				List<String> joins = new ArrayList<String>();
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
				joins.add(Project.PROJECTCALENDAR);
				joins.add(Project.PROJECTKPIS);
				joins.add(Project.PROJECTKPIS+"."+Projectkpi.METRICKPI);
				joins.add(Project.PROJECTCALENDAR+"."+Projectcalendar.PROJECTCALENDAREXCEPTIONSES);
				joins.add(Project.PROJECTCALENDAR+"."+Projectcalendar.CALENDARBASE);
				joins.add(Project.PROJECTCALENDAR+"."+Projectcalendar.CALENDARBASE+"."+Calendarbase.CALENDARBASEEXCEPTIONSES);
				joins.add(Project.INCOMESES);
				
				project = ProjectLogic.consProject(new Project(idProject), joins);
				
				joins = new ArrayList<String>();
				joins.add(Projectactivity.WBSNODE);
				
				activities		= activityLogic.findByRelation(Projectactivity.PROJECT, project, Projectactivity.ACTIVITYNAME, Constants.ASCENDENT, joins);

				
				for (Projectactivity monact:activities){
					LOGGER.debug(monact.getInitWorkload() +" init " + monact.getActivityName());
				}
				milestones		= MilestoneLogic.consMilestones(idProject);
				programs		= ProgramLogic.consByPO(user);				
				checklists		= ChecklistLogic.findByProject(project);
				wbsnodes		= WBSNodeLogic.findByProject(project);								
				followups		= ProjectFollowupLogic.consFollowups(project);
				costs			= ProjectCostsLogic.consCosts(project);
				iwos			= IwosLogic.consIwos(project);
				budgetaccounts	= BudgetaccountsLogic.consBudgetaccounts();
				listCalendars 	= baseLogic.findByRelation(Calendarbase.COMPANY, company);
				
				profiles	= resourceProfilesLogic.findAll();
				team		= TeamMemberLogic.consTeamMembers(new Project(idProject));
//	             Devoteam User story 23  Xl 22/04/20015 trie de la liste 
//					skills		= skillLogic.findByRelation(Skill.COMPANY, company);
					skills		= skillLogic.findByRelation(Skill.COMPANY, company,Skill.NAME, Constants.ASCENDENT);
				
				metricKpis		= MetrickpiLogic.findByCompany(user, null);
//	             Devoteam User story 23  Xl 22/04/20015 trie de la liste 				
//				perfOrgs  		= performingOrgLogic.findByRelation(Performingorg.COMPANY, company);
				perfOrgs  		= performingOrgLogic.findByRelation(Performingorg.COMPANY, company,Performingorg.NAME,Constants.ASCENDENT);

				
				joins = new ArrayList<String>();
				joins.add(Employee.CONTACT);
				
				resourceManagers = EmployeeLogic.searchEmployees(new Resourceprofiles(Constants.ROLE_RM), company, joins);
				
				rootActivity = ProjectActivityLogic.consRootActivity(project);
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					docs = new ArrayList<Documentproject>();
					docs.add(DocumentprojectLogic.findByType(project, Constants.DOCUMENT_PLANNING));	
				}
				else {
					docs = DocumentprojectLogic.findListByType(project, Constants.DOCUMENT_PLANNING);	
				}
			}
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		if (hasPermission) {
			
			req.setAttribute("project", project);
			req.setAttribute("activities", activities);
			req.setAttribute("milestones", milestones);
			req.setAttribute("programs", programs);
			req.setAttribute("rootActivity", rootActivity);
			req.setAttribute("checklists", checklists);
			req.setAttribute("wbsnodes", wbsnodes);
			req.setAttribute("listCalendars", listCalendars);			
			req.setAttribute("followups", followups);
			req.setAttribute("costs", costs);
			req.setAttribute("iwos", iwos);
			req.setAttribute("budgetaccounts", budgetaccounts);
			req.setAttribute("team", team);
			req.setAttribute("profiles", profiles);
			req.setAttribute("skills", skills);
			req.setAttribute("perforgs", perfOrgs);		
			req.setAttribute("metricKpis", metricKpis);
			req.setAttribute("resourceManagers", resourceManagers);
			
			if(Constants.DOCUMENT_STORAGE.equals("link")) {
				req.setAttribute("docs", docs.get(0));
			}
			else {
				req.setAttribute("docs", docs);	
			}		
			
			req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
			
			forward("/index.jsp?nextForm=project/plan/planning_project", req, resp);
		}
		else {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
	/**
	 * Set Wbs Node instance from request
	 * @param req
	 * @return
	 * @throws Exception 
	 */
	private Wbsnode setWbsNodeFromRequest(HttpServletRequest req) throws Exception {
		Wbsnode wbsNode = null;
		
		Integer id 			= ParamUtil.getInteger(req, "id", -1);		
		Integer idWbsnode	= ParamUtil.getInteger	(req, "wbs_id", -1);
		String code			= ParamUtil.getString	(req, "wbs_code", null);
		Integer idParent	= ParamUtil.getInteger	(req, "wbs_parent", -1);
		String name			= ParamUtil.getString	(req, "wbs_name", null);
		String desc			= ParamUtil.getString	(req, "wbs_desc", null);
		Boolean isCA		= ParamUtil.getBoolean	(req, "wbs_ca", false);
		double budget		= ParamUtil.getCurrency	(req, "wbs_budget", 0);
		
		Wbsnode parent = null;
		if (idParent != -1) {
			parent = new Wbsnode();
			parent.setIdWbsnode(idParent);
		}
		
		if (idWbsnode != -1) {
			
			WBSNodeLogic nodeLogic = new WBSNodeLogic();
			
			List<String> joins = new ArrayList<String>();
			joins.add(Wbsnode.WBSNODE);
			
			wbsNode = nodeLogic.findById(idWbsnode, joins);
		}
		else {
			wbsNode = new Wbsnode();
			wbsNode.setProject(new Project(id));
		}
		
		if (idWbsnode == -1 || (idWbsnode != -1 && wbsNode.getWbsnode() != null)) {
			wbsNode.setWbsnode(parent);
		}
		
		wbsNode.setCode(code);
		wbsNode.setName(name);
		wbsNode.setDescription(desc);
		wbsNode.setIsControlAccount(isCA);
		
		if (isCA) { wbsNode.setBudget(budget); }
		else { wbsNode.setBudget(null); }
		
		return wbsNode;
	}
	
	
	/**
	 * Save IWO cost from request
	 * @param req
	 * @param costs
	 * @return
	 * @throws LogicException 
	 */
	private Iwo saveIwoFromRequest(HttpServletRequest req, Projectcosts costs) throws Exception {
		
		Integer idIwo 	= ParamUtil.getInteger	(req, "iwo_id", -1);
		double planned	= ParamUtil.getCurrency	(req, "planned", 0);
		String desc		= ParamUtil.getString	(req, "desc", null);
		
		Iwo iwo = IwosLogic.consIwo(idIwo);
		if (iwo == null) {
			iwo = new Iwo();
		}
		iwo.setProjectcosts(costs);
		iwo.setDescription(desc);
		iwo.setPlanned(planned);
		iwo.setActual(new Double(0));
		
		IwosLogic.saveIwo(iwo, null);
		
		return iwo;
	}

	/**
	 * Save Expense cost detail from request
	 * @param req
	 * @param costs
	 * @return
	 * @throws LogicException 
	 */
	private Expenses saveExpenseCostFromRequest(HttpServletRequest req, Projectcosts costs) throws Exception {
		
		Integer idProject 	= ParamUtil.getInteger(req, "id", -1);
		Integer idCost		= ParamUtil.getInteger(req, "cost_id", -1);
		double planned		= ParamUtil.getCurrency(req, "planned", 0);
		Integer idBudget	= ParamUtil.getInteger(req, "budget_account", -1);
		String desc			= ParamUtil.getString(req, "desc", null);
		
		ExpensesLogic expensesLogic = new ExpensesLogic();
		
		if (expensesLogic.isBudgetInUse(new Project(idProject), new Expenses(idCost), new Budgetaccounts(idBudget))) {
			BudgetaccountsLogic budgetaccountsLogic = new BudgetaccountsLogic();
			Budgetaccounts budgetaccounts = budgetaccountsLogic.findById(idBudget);
			
			throw new LogicException("msg.info.in_use", "cost.charge_account", budgetaccounts.getDescription());
		}
		Expenses cost = null;
		if (idCost == -1) {
			cost = new Expenses();
		}
		else {
			cost = ExpensesLogic.consExpenses(idCost);
		}
		
		cost.setProjectcosts(costs);
		cost.setDescription(desc);
		cost.setPlanned(planned);
		cost.setBudgetaccounts(new Budgetaccounts(idBudget));
		
		ExpensesLogic.saveExpenses(cost, null);
		
		return cost;
	}


	/**
	 * Save direct cost detail from request
	 * @param req
	 * @param costs
	 * @return
	 * @throws LogicException 
	 */
	private Directcosts saveDirectCostFromRequest(HttpServletRequest req, Projectcosts costs) throws Exception {
		
		Integer idCost		= ParamUtil.getInteger	(req, "cost_id", -1);
		double planned 		= ParamUtil.getCurrency	(req, "planned", 0);
		Integer idBudget	= ParamUtil.getInteger	(req, "budget_account", -1);
		String desc			= ParamUtil.getString	(req, "desc", null);
		
		Budgetaccounts budget = null;
		if (idBudget != -1) {
			budget = new Budgetaccounts();
			budget.setIdBudgetAccount(idBudget);
		}
		
		Directcosts cost = DirectCostsLogic.consDirectcosts(idCost);
		if (cost == null) {
			cost = new Directcosts();
		}
		cost.setProjectcosts(costs);
		cost.setDescription(desc);
		cost.setPlanned(planned);
		cost.setBudgetaccounts(budget);
		
		DirectCostsLogic.saveDirectcost(cost, null);
		
		return cost;
	}


	/**
	 * Save followup cost from request
	 * @param req
	 * @param followup
	 */
	private void setFollowupFromRequest(HttpServletRequest req,
			Projectfollowup followup) {

		Date date			= ParamUtil.getDate		(req, "date", dateFormat, null);
		Double pv			= ParamUtil.getCurrency	(req, "pv", null);
		
		followup.setFollowupDate(date);
		followup.setPv(pv);
	}


	/**
	 * Set Income instance from request
	 * @param req
	 * @param income
	 */
	private void setIncomeFromRequest(HttpServletRequest req, Incomes income) {
		
		Integer idProject 		= ParamUtil.getInteger(req, "id", -1);
		Date plannedDate		= ParamUtil.getDate		(req, "planned_date", dateFormat, null);
		double plannedAmount	= ParamUtil.getCurrency	(req, "planned_amount", 0);
		String description		= ParamUtil.getString (req, "description", "");

		income.setPlannedBillDate(plannedDate);
		income.setPlannedBillAmmount(plannedAmount);
		income.setPlannedDescription(description);
		income.setProject(new Project(idProject));
	}
}
