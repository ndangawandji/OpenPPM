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
 * Update  : 2015/05/20 Xavier de Langautier Devoteam 
 *          User Story 15  Add remaining  on activity in  viewControlProject 
 *                         Create a popup printing remaining per teammember on an activity 
 *          			   add control AJax => function getTeammemberActivityJX (call  string : JX_GET_TEAMMEMBER)
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
import java.util.Set;

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

import com.itextpdf.text.Image;

import es.sm2.openppm.charts.ChartDataSet;
import es.sm2.openppm.charts.ChartDataSetPL;
import es.sm2.openppm.charts.ChartDataSetStack;
import es.sm2.openppm.charts.ChartFinancePlan;
import es.sm2.openppm.charts.ChartFinancePlanValues;
import es.sm2.openppm.charts.ChartGantt;
import es.sm2.openppm.charts.ChartLine;
import es.sm2.openppm.charts.ChartMSLine;
import es.sm2.openppm.charts.ChartStacked;
import es.sm2.openppm.charts.ChartWBS;
import es.sm2.openppm.charts.PlChartInfo;
import es.sm2.openppm.charts.StackedColumn2D;
import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.exceptions.CostTypeException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.javabean.CsvFile;
import es.sm2.openppm.javabean.TeamMembersFTEs;
import es.sm2.openppm.logic.ChangeControlLogic;
import es.sm2.openppm.logic.ChangeTypesLogic;
import es.sm2.openppm.logic.ChartLogic;
import es.sm2.openppm.logic.ChecklistLogic;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.DirectCostsLogic;
import es.sm2.openppm.logic.DocumentprojectLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.ExpensesLogic;
import es.sm2.openppm.logic.IncomesLogic;
import es.sm2.openppm.logic.IwosLogic;
import es.sm2.openppm.logic.MilestoneLogic;
import es.sm2.openppm.logic.ProjectActivityLogic;
import es.sm2.openppm.logic.ProjectCostsLogic;
import es.sm2.openppm.logic.ProjectFollowupLogic;
import es.sm2.openppm.logic.ProjectKpiLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.SkillLogic;
import es.sm2.openppm.logic.TeamMemberLogic;
import es.sm2.openppm.logic.TimesheetLogic;
import es.sm2.openppm.logic.WBSNodeLogic;
import es.sm2.openppm.model.Changecontrol;
import es.sm2.openppm.model.Changetype;
import es.sm2.openppm.model.Checklist;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Directcosts;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expenses;
import es.sm2.openppm.model.Incomes;
import es.sm2.openppm.model.Iwo;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Projectkpi;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JSONModelUtil;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.JstlUtil;
import es.sm2.openppm.utils.NumberUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.SettingUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class ProjectServer
 */
public class ProjectControlServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	private static final Logger LOGGER = Logger.getLogger(ProjectControlServlet.class);
	private static final SimpleDateFormat dfYear = new SimpleDateFormat("yy");
	
	public final static String REFERENCE = "projectcontrol";
	
	/***************** Actions ****************/
	public final static String SAVE_ACTIVITY_CONTROL	= "save-activity";
	public final static String SAVE_SCOPE_ACTIVITY_CONTROL	= "save-scope-activity";
	public final static String SAVE_REQUEST_CHANGE 		= "save-request-change";
	public final static String EXPORT_EVM_CSV			= "export-evm-table";
	public final static String EXPORT_KPI_CSV			= "export-kpi-table";
	public final static String EXPORT_SR_CSV			= "export-sr-table";
	public final static String EXPORT_CHANGE			= "export-change";	
	public final static String FUNDING_CHART_IMG		= "funding-chart-img";
	public final static String UPDATE_FOLLOWUP			= "update-followup";
	public final static String NEW_FOLLOWUP				= "new-followup";
	
	/************** Actions AJAX*************/
	public final static String JX_UPDATE_STAFFING_TABLE	= "ajax-update-staffing-table";
	public final static String JX_SAVE_FOLLOWUP 		= "ajax-save-followup";
	public final static String JX_SAVE_PROJECT 			= "ajax-save-project";
	public final static String JX_SAVE_MILESTONE		= "ajax-save-milestone";
	public final static String JX_SAVE_REQUEST_CHANGE	= "ajax-save-request-change";
	public final static String JX_CONS_CHANGE			= "ajax-cons-change";
	public final static String JX_CONS_FOLLOWUP			= "ajax-cons-followup";
	public final static String JX_COST_CONTROL_CHART	= "ajax-update-chart-control-costs";
	public final static String JX_WBS_CHART				= "ajax-generate-chart-wbs";
	public final static String JX_CONTROL_GANTT_CHART	= "ajax-update-chart-Schedule-Control-Gantt";
	public final static String JX_PL_CHART				= "ajax-update-chart-pl";
	public final static String JX_SAVE_COST 			= "ajax-save-cost";
	public final static String JX_SAVE_IWO				= "ajax-save-iwo";
	public final static String JX_SAVE_INCOME			= "ajax-save-income";
	public final static String JX_UPDATE_CHECKLIST 		= "ajax-update-checklist";
	public final static String JX_UPDATE_STATUS_DATE	= "ajax-change-status-date";
	public final static String JX_UPDATE_KPI			= "ajax-update-kpi";
	public final static String JX_HISTOGRAM_CHART		= "ajax-histogram-chart";
	public final static String JX_GET_TEAMMEMBER        = "ajax-get-teammember-acivity";   //us15

    
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
			
			/***************** Actions ****************/
			if (accion == null || StringPool.BLANK.equals(accion))  { viewControlProject(null, req, resp); }
			else if (SAVE_SCOPE_ACTIVITY_CONTROL.equals(accion)) { saveScopeActivity(req, resp); }
			else if (SAVE_ACTIVITY_CONTROL.equals(accion)) { saveActivity(req, resp); }
			else if (FUNDING_CHART_IMG.equals(accion)) { viewFundingChart(req, resp); }
			else if (UPDATE_FOLLOWUP.equals(accion)) { updateFollowup(req, resp); }
			else if (NEW_FOLLOWUP.equals(accion)) { newFollowup(req, resp); }
			else if (SAVE_REQUEST_CHANGE.equals(accion)) { saveRequestChange(req, resp); }
			else if (EXPORT_EVM_CSV.equals(accion)) { exportEvmCsv(req, resp); }
			else if (EXPORT_KPI_CSV.equals(accion)) { exportKpiCsv(req, resp); }
			else if (EXPORT_SR_CSV.equals(accion)) { exportSrCsv(req, resp); }	
			else if (EXPORT_CHANGE.equals(accion)) { exportChange(req, resp); }
			
			/************** Actions AJAX **************/
			else if (JX_UPDATE_STAFFING_TABLE.equals(accion)) { updateStaffingTableJX(req, resp); }
			else if (JX_SAVE_MILESTONE.equals(accion)) { saveMilestoneJX(req, resp); }
			else if (JX_SAVE_INCOME.equals(accion)) { saveIncomeJX(req, resp); }
			else if (JX_SAVE_FOLLOWUP.equals(accion)) { saveFollowupJX(req, resp); }
			else if (JX_SAVE_COST.equals(accion)) { saveCostJX(req, resp); }
			else if (JX_SAVE_IWO.equals(accion)) { saveIwoJX(req, resp); }
			else if (JX_UPDATE_CHECKLIST.equals(accion)) { updateCheckListJX(req, resp); }
			else if (JX_COST_CONTROL_CHART.equals(accion)) { costChartsJX(req, resp); }
			else if (JX_WBS_CHART.equals(accion)) { wbsChartJX(req, resp); }
			else if (JX_UPDATE_STATUS_DATE.equals(accion)) { updateStatusDateJX(req, resp); }
			else if (JX_UPDATE_KPI.equals(accion)) { updateKpiJX(req, resp); }
			else if (JX_HISTOGRAM_CHART.equals(accion)) { histogramChartJX(req, resp); }
			else if (JX_SAVE_REQUEST_CHANGE.equals(accion)) { saveRequestChangeJX(req, resp); }
			else if (JX_CONS_CHANGE.equals(accion)) { consultRequestChangeJX(req, resp); }			
			else if (JX_CONS_FOLLOWUP.equals(accion)) { consultFollowupJX(req, resp); }			
			else if (JX_CONTROL_GANTT_CHART.equals(accion)) { controlGanttChartJX(req, resp); }			
			else if (JX_PL_CHART.equals(accion)) { plChartJX(req, resp); }
			else if (JX_GET_TEAMMEMBER.equals(accion)) { getTeammemberActivityJX(req, resp); }  //us15
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
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
    		
    		EmployeeLogic employeeLogic = new EmployeeLogic();
    		
    		SimpleDateFormat dfYear = new SimpleDateFormat("yy");
    		
    		Calendar sinceCal		= DateUtil.getCalendar();
			Calendar untilCal		= DateUtil.getCalendar();
			
    		sinceCal.setTime(DateUtil.getFirstWeekDay(since));
			untilCal.setTime(DateUtil.getLastWeekDay(until));
			
			List<Employee> resources = employeeLogic.findInputedInProject(new Project(idProject), since, until);
			
			ftEs = generateFTEsMembersByProject(new Project(idProject), resources, sinceCal.getTime(), untilCal.getTime());
			
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
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		
		forward("/project/common/staffing_table.ajax.jsp", req, resp);
	}
    
	/**
     * Generate Histogram Chart
     * @param req
     * @param resp
     * @throws IOException
     */
    private void histogramChartJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idProject	= ParamUtil.getInteger(req, Project.IDPROJECT);
    	Date since		= ParamUtil.getDate(req, "since", dateFormat);
    	Date until		= ParamUtil.getDate(req, "until", dateFormat);
    	
    	PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		TimesheetLogic timesheetLogic	= new TimesheetLogic();
    		TeamMemberLogic memberLogic		= new TeamMemberLogic();
    		
    		StackedColumn2D chartHistogram = new StackedColumn2D(idioma);
    		
    		Employee user	= SecurityUtil.consUser(req);    		    		
    		Company company	= CompanyLogic.searchByEmployee(user);
    		
			Calendar sinceCal = DateUtil.getCalendar();
			sinceCal.setTime(DateUtil.getFirstWeekDay(since));
			
			Calendar untilCal = DateUtil.getCalendar();
			untilCal.setTime(DateUtil.getLastWeekDay(until));
			
			while (!sinceCal.after(untilCal)) {
				
				int sinceDay = sinceCal.get(Calendar.DAY_OF_MONTH);
				Calendar calWeek = DateUtil.getLastWeekDay(sinceCal);
				int untilDay = calWeek.get(Calendar.DAY_OF_MONTH);
				
				chartHistogram.addCategory(sinceDay+"-"+untilDay+" "+idioma.getString("month.min_" + (calWeek.get(Calendar.MONTH) +1)) + 
						" " + dfYear.format(calWeek.getTime()));
				
				sinceCal.add(Calendar.WEEK_OF_MONTH, 1);
			}
    		
			List<Teammember> members	= memberLogic.consStaffinActualsFtes(new Project(idProject), since, until);
			
			SkillLogic skillLogic = new SkillLogic();
			List<Skill> skills			= skillLogic.findByRelation(Skill.COMPANY, company);
			ChartDataSetStack dataSet 	= null;
			
			for (Skill skill : skills) {

				dataSet = new ChartDataSetStack(skill);
				
				sinceCal.setTime(DateUtil.getFirstWeekDay(since));
				
				while (!sinceCal.after(untilCal)) {
					
					double resources = 0;
					
					for (Teammember member : members) {
						
						if (member.getSkill() != null && skill.getIdSkill().equals(member.getSkill().getIdSkill()) 
								&& DateUtil.betweenWeek(member.getDateIn(), member.getDateOut(), sinceCal.getTime())) {
							
							Double fte = timesheetLogic.getFte(
									new Project(idProject), member,
									DateUtil.getFirstWeekDay(sinceCal.getTime()),
									DateUtil.getLastWeekDay(sinceCal.getTime()));
							
							resources += fte;
						}
					}
					dataSet.addValue(String.valueOf((resources>0?resources/100:0)));
					
					sinceCal.add(Calendar.WEEK_OF_MONTH, 1);
				}
				chartHistogram.addDataSet(dataSet);
			}
			
			dataSet = new ChartDataSetStack(idioma.getString("not_defined"),"FFFFFF");
			
			sinceCal.setTime(DateUtil.getFirstWeekDay(since));
			while (!sinceCal.after(untilCal)) {
				
				double resources	= 0;
				
				for (Teammember member : members) {
					if (member.getSkill() == null && DateUtil.betweenWeek(member.getDateIn(), member.getDateOut(), sinceCal.getTime())) {
						
						Double fte = timesheetLogic.getFte(
								new Project(idProject), member,
								DateUtil.getFirstWeekDay(sinceCal.getTime()),
								DateUtil.getLastWeekDay(sinceCal.getTime()));
						
						resources += fte;
					}
					
				}
				dataSet.addValue(String.valueOf((resources>0?resources/100:0)));
				
				sinceCal.add(Calendar.WEEK_OF_MONTH, 1);
			}
			
			chartHistogram.addDataSet(dataSet);
			
			JSONObject updateJSON = new JSONObject();
			
			updateJSON.put("xml", chartHistogram.generateXML());
			
			out.print(updateJSON);
    	}
    	catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
    	finally { out.close(); }
	}
    
    /**
     * Save Requested change
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveRequestChangeJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
    	Changecontrol change = null;
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			change = setChangeFromRequest(req);
			ChangeControlLogic.saveChangeControl(change);
			change = ChangeControlLogic.consChangeControl(change);
			
			out.print(JSONModelUtil.changeControlToJSON(idioma, change));
			
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}    	
    }
    
    /**
     * Consult Requested change
     * @param req
     * @param resp
     * @throws IOException
     */
    private void consultRequestChangeJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
    	Integer idChange = ParamUtil.getInteger(req, "change_id", -1);
		
		PrintWriter out = resp.getWriter();
		
		try {
			Changecontrol change = ChangeControlLogic.consChangeControl(new Changecontrol(idChange));

			out.print(JSONModelUtil.changeControlToJSON(idioma, change));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}    	
    }
    
    /**
     * Consult Project Followup
     * @param req
     * @param resp
     * @throws IOException
     */
    private void consultFollowupJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
    	Integer idFollowup = ParamUtil.getInteger(req, "followup_id", -1);
		
		PrintWriter out = resp.getWriter();
		
		try {

			Projectfollowup followup = ProjectFollowupLogic.consFollowupWithProject(new Projectfollowup(idFollowup));
			out.print(JSONModelUtil.followupToJSON(idioma, followup, null));
			
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}    	
    }

    /**
     * Update chart Gantt Schedule-Control
     * @param req
     * @param resp
     * @throws IOException
     */
    private void controlGanttChartJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
    	PrintWriter out = resp.getWriter();
		
		Integer idProject	= ParamUtil.getInteger(req, "id");
		Date since			= ParamUtil.getDate(req, "filter_start", dateFormat,null);
		Date until			= ParamUtil.getDate(req, "filter_finish", dateFormat,null);
		
		String numTasks = null;
		String textXML = StringPool.BLANK;
		
		try {	
			
			Project project = ProjectLogic.consProject(idProject);
			ChartGantt chartGantt = ChartLogic.consChartGantt(idioma, project, true, true, since, until);
			
			textXML = chartGantt.generateXML();
			numTasks = chartGantt.getNumTasks();
			
			JSONObject updateJSON = new JSONObject();
			updateJSON.put("xml", textXML);
			updateJSON.put("tasks", numTasks);
			out.print(updateJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}    	
    }    
    
    /**
     * Update project-costs chart P&L
     * @param req
     * @param resp
     * @throws IOException
     */
    private void plChartJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
    	PrintWriter out = resp.getWriter();
		
		try {
			Integer idProject = ParamUtil.getInteger(req, "id");
			
			Project project = ProjectLogic.consProject(idProject);
			
			PlChartInfo plChartInfo = ChartLogic.consActualInfoPlChart(project);
			double sumIwos			= plChartInfo.getSumIwos();
			double sumExpenses		= plChartInfo.getSumExpenses();
			double sumDirectCost	= plChartInfo.getSumDirectCost();
			double dm				= plChartInfo.getDirectMargin();
			double dmPer			= Math.round(plChartInfo.getDirectMarginPercent());
			double tcv				= plChartInfo.getTcv();
			double netIncome		= plChartInfo.getCalculatedNetIncome();
			
			ChartStacked chartPL = new ChartStacked(idioma.getString("project_pl.thousands"), idioma.getString("project_pl"));
			chartPL.addCategory(idioma.getString("tcv"));
			chartPL.addCategory(idioma.getString("project_pl.expenses"));
			chartPL.addCategory(idioma.getString("iwo"));
			chartPL.addCategory(idioma.getString("project_pl.net_income"));
			chartPL.addCategory(idioma.getString("project_pl.direct_costs"));
			chartPL.addCategory(idioma.getString("project_pl.dm")+" "+dmPer+"%");
			
			double divDouble = new Double(1000);
			
			ChartDataSetPL dataSetPL = new ChartDataSetPL(StringPool.BLANK, "BDBDBD", 
					Double.toString(tcv/divDouble), 
					Double.toString(netIncome/divDouble),
					StringPool.BLANK, 
					1);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(StringPool.BLANK, "FFFFFF", 
					Double.toString((tcv-sumExpenses)/divDouble), 
					Double.toString((tcv-sumExpenses-sumIwos)/divDouble),
					Double.toString((netIncome-sumDirectCost)/divDouble), 
					2);
			dataSetPL.setAlpha("0");
			dataSetPL.setShowValues("0");
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.direct_costs"), "B40404", 
					Double.toString(sumDirectCost/divDouble), StringPool.BLANK, StringPool.BLANK, 3);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.expenses"), "688BB4", 
					Double.toString(sumExpenses/divDouble), StringPool.BLANK, StringPool.BLANK, 4);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.iwo"), "FFFF00", 
					Double.toString(sumIwos/divDouble), StringPool.BLANK, StringPool.BLANK, 5);
			chartPL.addDataSet(dataSetPL);
			
			dataSetPL = new ChartDataSetPL(idioma.getString("project_pl.dm")+" "+dmPer+"%", 
					"7E7E7E", 
					Double.toString(dm/divDouble), 
					StringPool.BLANK, StringPool.BLANK, 6);
			chartPL.addDataSet(dataSetPL);
			
			chartPL.setShowLegend("0");
			String textXML = chartPL.generateXML(netIncome/divDouble);
			
			JSONObject updateJSON = new JSONObject();
			if (!project.getNetIncome().equals(netIncome)) {
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
     * Update Project Kpi
     * @param req
     * @param resp
     * @throws IOException
     */
    private void updateKpiJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		int idProjectKPI	= ParamUtil.getInteger(req, Projectkpi.IDPROJECTKPI,-1);
		int value			= ParamUtil.getInteger(req, Projectkpi.VALUE,0);
    	
    	PrintWriter out = resp.getWriter();
    	
		try {
			
			JSONObject returnJSON = null;
			
			Projectkpi projKpi = ProjectKpiLogic.findProjectKpi(idProjectKPI);
			projKpi.setValue(value);
			
			projKpi = ProjectKpiLogic.saveProjectKpi(projKpi);
			
			returnJSON = infoUpdated(returnJSON, "kpi");
			returnJSON.put("adjustedValue", projKpi.getAdjustedValue());
			returnJSON.put("score", projKpi.getScore());
			
			out.print(returnJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Create new followup
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void newFollowup(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
    	int idProject		= ParamUtil.getInteger(req, Project.IDPROJECT);
		Date followupDate	= ParamUtil.getDate(req, Projectfollowup.FOLLOWUPDATE, dateFormat);
		double pv 			= ParamUtil.getCurrency(req, Projectfollowup.PV);
		
		try {
			
			Projectfollowup followup = new Projectfollowup();
			followup.setProject(new Project(idProject));
			followup.setFollowupDate(followupDate);
			followup.setPv(pv != 0?pv:null);
			
			ProjectFollowupLogic.saveFollowup(followup);
			
			infoCreated(req, "followup");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewControlProject(idProject, req, resp);
	}
    
    /**
     * 
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void saveRequestChange(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Changecontrol change = null;
		
		try {
		
			change = setChangeFromRequest(req);
			ChangeControlLogic.saveChangeControl(change);
			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		Integer idProject = ParamUtil.getInteger(req, "id");
		
		infoUpdated(req, "change_request");
		viewControlProject(idProject, req, resp);
    }
    
    /**
     * Export EVM to CSV
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void exportEvmCsv(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Integer idProject = ParamUtil.getInteger(req, "id");
		String fileName = "";
		CsvFile file = null;
		
		try {
			
			Project project = ProjectLogic.consProject(idProject);
			
			fileName = project.getChartLabel();
			
			file = new CsvFile(Constants.SEPARATOR_CSV);
			List<Projectfollowup> followups = ProjectFollowupLogic.consFollowups(project);
			
			file.addValue(idioma.getString("followup"));
			file.addValue(idioma.getString("followup.days_date"));
			file.addValue(idioma.getString("followup.es"));
			file.addValue(idioma.getString("followup.pv"));
			file.addValue(idioma.getString("followup.ev"));
			file.addValue(idioma.getString("followup.ac"));
			file.addValue(idioma.getString("followup.complete"));
			file.addValue(idioma.getString("followup.cpi"));
			file.addValue(idioma.getString("followup.spi"));
			file.addValue(idioma.getString("followup.spit"));
			file.addValue(idioma.getString("followup.cv"));
			file.addValue(idioma.getString("followup.sv"));
			file.addValue(idioma.getString("followup.svt"));
			file.addValue(idioma.getString("followup.eac"));					
			file.newLine();
			for (Projectfollowup followup : followups) {
				
				Integer daysToDate = followup.getDaysToDate();
				daysToDate = (daysToDate == null?0:daysToDate);
				
				file.addValue(dateFormat.format(followup.getFollowupDate()));
				file.addValue((followup.getDaysToDate()== null ? StringPool.BLANK : numberFormat.format(followup.getDaysToDate())));					
				file.addValue((ValidateUtil.getES(followups, followup)== null ? StringPool.BLANK : numberFormat.format(ValidateUtil.getES(followups, followup))));
				file.addValue((followup.getPv()== null ? StringPool.BLANK : numberFormat.format(followup.getPv())));
				file.addValue((followup.getEv()== null ? StringPool.BLANK : numberFormat.format(followup.getEv())));
				file.addValue((followup.getAc()== null ? StringPool.BLANK : numberFormat.format(followup.getAc())));
				file.addValue((followup.getPoc()== null ? StringPool.BLANK : numberFormat.format(followup.getPoc())));
				file.addValue((followup.getCpi()== null ? StringPool.BLANK : numberFormat.format(followup.getCpi())));
				file.addValue((followup.getSpi()== null ? StringPool.BLANK : numberFormat.format(followup.getSpi())));
				file.addValue(
						ValidateUtil.getES(followups, followup)== null || followup.getDaysToDate() == null
							? StringPool.BLANK :
								numberFormat.format(ValidateUtil.getES(followups, followup)/daysToDate)
				);
				file.addValue((followup.getCv()== null ? StringPool.BLANK : numberFormat.format(followup.getCv())));						
				file.addValue((followup.getSv()== null ? StringPool.BLANK : numberFormat.format(followup.getSv())));						
				file.addValue((ValidateUtil.getES(followups, followup)== null ? StringPool.BLANK : numberFormat.format(ValidateUtil.getES(followups, followup) - daysToDate)));						
				file.addValue((followup.getEac()== null ? StringPool.BLANK : numberFormat.format(followup.getEac())));						
				file.newLine();						
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
        sendFile(req, resp, file.getFileBytes(), fileName + ".csv");    	
    }
    
    /**
     * Export KPI to CSV
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void exportKpiCsv(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Integer idProject = ParamUtil.getInteger(req, "id");
		String fileName = "";
		CsvFile file = null;
		
		try {
			
			Project project = ProjectLogic.consProject(idProject);
			
			fileName = project.getChartLabel();
			
			file = new CsvFile(Constants.SEPARATOR_CSV);
			
			List<String> joins = new ArrayList<String>();
			joins.add(Projectkpi.METRICKPI);
			
			ProjectKpiLogic kpiLogic = new ProjectKpiLogic();
			List<Projectkpi> kpis = kpiLogic.findByRelation(Projectkpi.PROJECT, project, joins);
			
			file.addValue(idioma.getString("kpi"));
			file.addValue(idioma.getString("kpi.metric"));
			file.addValue(idioma.getString("kpi.definition"));
			file.addValue(idioma.getString("kpi.upper_threshold") + "%");
			file.addValue(idioma.getString("kpi.lower_threshold") + "%");
			file.addValue(idioma.getString("kpi.normalized_value") + "%");
			file.addValue(idioma.getString("kpi.weight") + "%");
			file.addValue(idioma.getString("kpi.value") + "%");										
			file.newLine();
			for (Projectkpi kpi : kpis) {
				file.addValue((kpi.getMetrickpi()== null ? StringPool.BLANK : kpi.getMetrickpi().getName()));
				file.addValue((kpi.getMetrickpi()== null ? StringPool.BLANK : kpi.getMetrickpi().getDefinition()));					
				file.addValue((kpi.getUpperThreshold()== null ? StringPool.BLANK : numberFormat.format(kpi.getUpperThreshold())));
				file.addValue((kpi.getLowerThreshold()== null ? StringPool.BLANK : numberFormat.format(kpi.getLowerThreshold())));
				file.addValue(numberFormat.format(kpi.getAdjustedValue()));
				file.addValue((kpi.getWeight()== null ? StringPool.BLANK : numberFormat.format(kpi.getWeight())));
				file.addValue((kpi.getValue()== null ? StringPool.BLANK : numberFormat.format(kpi.getValue())));						
				file.newLine();						
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
        sendFile(req, resp, file.getFileBytes(), fileName + ".csv");    	
    }
    
    /**
     * Export Status Report to CSV
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void exportSrCsv(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Integer idProject = ParamUtil.getInteger(req, "id");
		String fileName = "";
		CsvFile file = null;
		
		try {
			
			Project project = ProjectLogic.consProject(idProject);
			
			fileName = project.getChartLabel();
			
			file = new CsvFile(Constants.SEPARATOR_CSV);
			List<Projectfollowup> followups = ProjectFollowupLogic.consFollowups(project);
			
			file.addValue(idioma.getString("date"));
			file.addValue(idioma.getString("status"));
			file.addValue(idioma.getString("type"));
			file.addValue(idioma.getString("desc"));												
			file.newLine();
			file.newLine();
			
			for (Projectfollowup followup : followups) {
				
				file.addValue(StringPool.BLANK);
				file.addValue((followup.getGeneralFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getGeneralFlag().toString())));
				file.addValue(idioma.getString("general"));
				file.addValue((followup.getGeneralComments()== null ? StringPool.BLANK : followup.getGeneralComments()));
				file.newLine();
				
				file.addValue(followup.getFollowupDate() == null?StringPool.BLANK:dateFormat.format(followup.getFollowupDate()));
				file.addValue((followup.getRiskFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getRiskFlag().toString())));
				file.addValue(idioma.getString("risk"));
				file.addValue((followup.getRisksComments()== null ? StringPool.BLANK : followup.getRisksComments()));
				file.newLine();
				
				file.addValue(StringPool.BLANK);
				file.addValue((followup.getScheduleFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getScheduleFlag().toString())));
				file.addValue(idioma.getString("schedule"));
				file.addValue((followup.getScheduleComments()== null ? StringPool.BLANK : followup.getScheduleComments()));
				file.newLine();
				
				file.addValue(StringPool.BLANK);
				file.addValue((followup.getCostFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getCostFlag().toString())));
				file.addValue(idioma.getString("cost"));
				file.addValue((followup.getCostComments()== null ? StringPool.BLANK : followup.getCostComments()));
				file.newLine();
				file.newLine();							
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
        sendFile(req, resp, file.getFileBytes(), fileName + ".csv");    	
    }
    
    /**
     * Export control change to PDF
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void exportChange(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	Integer idChangeControl = ParamUtil.getInteger(req, "change_export_id", -1);
		Integer idProject		= ParamUtil.getInteger(req, "id", -1);
		
		try {
			Employee user = (Employee) req.getSession().getAttribute("user");
			
			Changecontrol change = ChangeControlLogic.consChangeControl(new Changecontrol(idChangeControl));
			
			List<String> joins = new ArrayList<String>();
			joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER);
			joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER+"."+Employee.CONTACT);
			joins.add(Project.EMPLOYEEBYSPONSOR);
			joins.add(Project.EMPLOYEEBYSPONSOR+"."+Employee.CONTACT);
			joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
			joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
			joins.add(Project.CUSTOMER);
			joins.add(Project.CUSTOMER+"."+Customer.CUSTOMERTYPE);
			
			Project project = ProjectLogic.consProject(new Project(idProject), joins);
			
			Image headerImg = Image.getInstance(getServletContext().getResource("/images/cabecera.jpg"));
			headerImg.scalePercent(47F);
			
			Image footerImg = Image.getInstance(getServletContext().getResource("/images/footer.jpg"));
			footerImg.scalePercent(47F);
			
			byte[] file = DocumentUtils.toPdf(idioma, project, change, user, headerImg, footerImg);
			
			sendFile(req, resp, file, idioma.getString("change_request")+"_"+idChangeControl+".pdf");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }    	
    }

	/**
     * Update Project Status Date
     * @param req
     * @param resp
     * @throws IOException
     */
    private void updateStatusDateJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		
		int idProject	= ParamUtil.getInteger(req, Project.IDPROJECT);
		Date statusDate	= ParamUtil.getDate(req, Project.STATUSDATE, dateFormat, null);
		
		try {
			
			JSONObject updateJSON = new JSONObject();
			
			if (statusDate == null) {
				statusDate = new Date();
				
				updateJSON = info("project.status_date.is_empty",updateJSON, "project.status_date",datePattern, dateFormat.format(statusDate));
			}
			else {
				updateJSON = infoUpdated(updateJSON, "project.status_date");
			}
			
			updateJSON.put(Project.STATUSDATE, dateFormat.format(statusDate));
			
			Project proj = ProjectLogic.consProject(idProject);
			proj.setStatusDate(statusDate);
			ProjectLogic.saveProject(proj);
			
			out.print(updateJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Generate WBS Chart
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
			Projectactivity rootActivity = project.getRootActivity();
			
			ChartWBS chartWBS = new ChartWBS(wbsNodeParent, true, rootActivity.getPocCalc());
			
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
     * Update Checklist
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void updateCheckListJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idWbsnode		= ParamUtil.getInteger(req, Wbsnode.IDWBSNODE);
    	int idChecklist		= ParamUtil.getInteger(req, Checklist.IDCHECKLIST,-1);
    	String code			= ParamUtil.getString(req, Checklist.CODE);
    	String description	= ParamUtil.getString(req, Checklist.DESCRIPTION);
    	int percentage		= ParamUtil.getInteger(req, Checklist.PERCENTAGECOMPLETE,0);
    	Date actDate		= ParamUtil.getDate(req, Checklist.ACTUALIZATIONDATE,dateFormat , new Date());
    	
    	PrintWriter out = resp.getWriter();
		
		try {
			
			Checklist checklist = null;
			
			if (idChecklist == -1) { checklist = new Checklist(); }
			else {
				ChecklistLogic checkLogic = new ChecklistLogic();
				checklist = checkLogic.findById(idChecklist); 
			}
			
			checklist.setCode(code);
			checklist.setDescription(description);
			checklist.setWbsnode(new Wbsnode(idWbsnode));
			checklist.setPercentageComplete(percentage);
			checklist.setActualizationDate(actDate);
			
			checklist = ChecklistLogic.saveChecklist(checklist);
			
			JSONObject datJSON = JsonUtil.toJSON(Checklist.IDCHECKLIST, checklist.getIdChecklist());
			datJSON.put(Checklist.ACTUALIZATIONDATE, dateFormat.format(actDate));
			if (idChecklist == -1) { 
				datJSON = infoCreated(datJSON, "checklist"); 
			}
			else {
				datJSON = infoUpdated(datJSON, "checklist");			 
			}
			
			out.print(datJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Save IWO
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void saveIwoJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    	PrintWriter out = resp.getWriter();
		
		try {
			Integer idIwo 	= ParamUtil.getInteger(req, "iwo_id", -1);
			double actual	= ParamUtil.getCurrency(req, "iwo_actual", 0);
			String desc		= ParamUtil.getString(req, "iwo_desc", null);
			Date iwoDate	= ParamUtil.getDate(req, "iwo_date", dateFormat, new Date());
			
			Iwo iwo = IwosLogic.consIwo(idIwo);
			iwo.setActual(actual);
			iwo.setDescription(desc);

			IwosLogic.saveIwo(iwo, iwoDate);
			
			JSONObject costJSON = new JSONObject();
			costJSON.put("actual", iwo.getActual());
			costJSON.put("desc", iwo.getDescription());
			costJSON.put("iwoDate", dateFormat.format(iwoDate));
			
			out.print(costJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Save cost
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void saveCostJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		try {
			// Determine what kind of cost detail is
			Integer costType	= ParamUtil.getInteger	(req, "cost_cost_type", -1);
			int costId			= ParamUtil.getInteger	(req, "cost_id", -1);
			double actual	 	= ParamUtil.getCurrency(req, "cost_actual", 0);
			String desc		 	= ParamUtil.getString	(req, "desc", null);
			Date costDate		= ParamUtil.getDate(req, "cost_date", dateFormat, new Date());
			
			JSONObject costJSON = new JSONObject();
			if (costType.equals(Constants.COST_TYPE_DIRECT)) {
				Directcosts cost = DirectCostsLogic.consDirectcosts(costId);
				cost.setActual(actual);
				cost.setDescription(desc);
				
				DirectCostsLogic.saveDirectcost(cost, costDate);
				
				costJSON.put("actual", cost.getActual());
				costJSON.put("desc", cost.getDescription());
				costJSON.put("costDate", dateFormat.format(costDate));
			}
			else if (costType.equals(Constants.COST_TYPE_EXPENSE)) {
				Expenses expense = ExpensesLogic.consExpenses(costId);
				expense.setActual(actual);
				expense.setDescription(desc);
				
				ExpensesLogic.saveExpenses(expense, costDate);
				
				costJSON.put("actual", expense.getActual());
				costJSON.put("desc", expense.getDescription());
				costJSON.put("costDate", dateFormat.format(costDate));
			}
			else {
				throw new CostTypeException();
			}
			
			costJSON.put("type", costType);
			
			out.print(costJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Generate Cost Charts for Control
     * @param req
     * @param resp
     * @throws IOException
     */
    private void costChartsJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		Integer idProject = ParamUtil.getInteger(req, "id");

		try {
			Project project = ProjectLogic.consProject(idProject);
			List<Projectfollowup> projectFollowups = ProjectFollowupLogic.consFollowups(project); 
			
			ChartMSLine chart = new ChartMSLine(idioma);
			chart.setCaption(idioma.getString("cost_baseline_chart.eamed_value_management_chart"));
			
			ChartDataSet pv = new ChartDataSet(idioma.getString("cost_baseline_chart.planned_value"),"000000","1");
			ChartDataSet ev = new ChartDataSet(idioma.getString("cost_baseline_chart.eamed_value"),"088A08","1");
			ChartDataSet ac = new ChartDataSet(idioma.getString("cost_baseline_chart.acual_cost"),"FF0000","1");
			
			ChartLine chartCV = new ChartLine(idioma, idioma.getString("cost_baseline_chart.cost_variance"),"FF0000","0");
			ChartLine chartSVt = new ChartLine(idioma, idioma.getString("cost_baseline_chart.svt"),"FF0000","0");
			
			Integer daysToDate = null;
			Integer daysToDateEs = null; 
			
			for (Projectfollowup item : projectFollowups) {
				
				daysToDate = item.getDaysToDate();
				daysToDate = (daysToDate == null?0:daysToDate);
				
				chart.addCategory(daysToDate+StringPool.BLANK);
				pv.addValue(StringPool.BLANK+(item.getPv() != null?item.getPv():StringPool.BLANK));
				ev.addValue(StringPool.BLANK+(item.getEv() != null?item.getEv():StringPool.BLANK));
				ac.addValue(StringPool.BLANK+(item.getAc() != null?item.getAc():StringPool.BLANK));
				
				chartCV.addElement(daysToDate+StringPool.BLANK, StringPool.BLANK +(item.getCv() != null?item.getCv():StringPool.BLANK));
				
				Double es = ValidateUtil.getES(projectFollowups, item);
				if (es != null) {
					double svt = es - daysToDate;
					
					daysToDateEs = daysToDate;
					chartSVt.addElement(daysToDate+StringPool.BLANK, StringPool.BLANK+svt);
				}
			}
			if (daysToDateEs != null && daysToDate != null && !daysToDateEs.equals(daysToDate)) { chartSVt.addElement(daysToDate+StringPool.BLANK, StringPool.BLANK); }
			
			chart.addDataSet(pv);
			chart.addDataSet(ev);
			chart.addDataSet(ac);
			
			JSONObject updateJSON = new JSONObject();
			updateJSON.put("xml", chart.generateXML());
			updateJSON.put("xmlTime", chartSVt.generateXML());
			updateJSON.put("xmlCost", chartCV.generateXML());
			out.print(updateJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Save followup
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void saveFollowupJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	int idFollowup	= ParamUtil.getInteger(req, "followup_id", -1);
    	int idProject	= ParamUtil.getInteger(req, "id", -1);
    	
    	
		
    	PrintWriter out = resp.getWriter();
    	
		try {

			Projectfollowup followup = ProjectFollowupLogic.consFollowup(idFollowup);
			Project proj = ProjectLogic.consProject(idProject);
			
			setFollowupFromRequest(req, followup);
			ProjectFollowupLogic.saveFollowup(followup);
			followup.setProject(proj);
			
			JSONObject info = null;
			out.print(infoUpdated(info,"followup"));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
    
    
    /**
     *Get each teammember hours of an project activity
     * @param req  (id = Idactivity)
     * @param resp
     * @throws IOException
     * @return : array of Json with teammmeber information
     * 
     * function added by devoteam, Xavier de Langautier 09/06/2015
     *  User Story 15 :  print  detail activity per teammember
     * 
     */
    private void getTeammemberActivityJX(HttpServletRequest req,
			HttpServletResponse resp) throws  IOException {

    	TimesheetLogic timesheetLogic		= new TimesheetLogic();
    	List<Teammember> team 				= null;
		Date dateaujourdhui = new Date();                 
		Date fisrtDayOfNextWeekDate;                     
		fisrtDayOfNextWeekDate = DateUtil.getFirstWeekDay(DateUtil.addDay(dateaujourdhui , 7));   
    	
    	double  remaining;
		PrintWriter out = resp.getWriter();
    	
    	Integer idActivity = ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		JSONObject teamJSONelement = null;

		JSONArray teamJSON = new JSONArray();
		try {
		    team   = TeamMemberLogic.consTeamMembers(new Projectactivity(idActivity));  

			for (Teammember teammember : team) {
			  // Calcul du Reste a faire à partir du lundi de la semaine suivante
				remaining					    =   (timesheetLogic.getHoursResource(teammember.getEmployee().getIdEmployee(), 
												 idActivity,
												 fisrtDayOfNextWeekDate, 
												 teammember.getDateOut(), 
												 Constants.TIMESTATUS_APP0,
												 Constants.TIMESTATUS_APP0
											) /Constants.DEFAULT_HOUR_DAY); /* reste à faire en jours*/
			
				remaining =  NumberUtil.truncate2decimals(remaining);
			
				teammember.setRemainingWorkload( remaining <0 ?0 : remaining);  

				teamJSONelement = new JSONObject();
				teamJSONelement.put("teamId",teammember.getIdTeamMember());
				teamJSONelement.put("teamFullName",teammember.getEmployee().getContact().getFullName());		
				teamJSONelement.put("teamDateIn",DateUtil.format(idioma,teammember.getDateIn()));  
				teamJSONelement.put("teamDateOut",DateUtil.format(idioma,teammember.getDateOut()));		
				teamJSONelement.put("teamRemainingWorkload",teammember.getRemainingWorkload());
				teamJSONelement.put("teamWorkload",teammember.getWorkloadInDays());

				teamJSON.add(teamJSONelement);
			}
			out.print(teamJSON);
		}
		catch (Exception e) {	ExceptionUtil.evalueExceptionJX(out,req, idioma, LOGGER, e); }
		finally {
			out.close();
		}    

    }

	/**
     * Update Followup
     * @param req
     * @param resp
	 * @throws IOException 
	 * @throws ServletException 
     */
    private void updateFollowup(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Integer idFollowup = ParamUtil.getInteger(req, "followup_id", -1);
		
		Double ev = ParamUtil.getCurrency(req, "ev", null);
		Double ac = ParamUtil.getCurrency(req, "ac", null);
		
		try {

			Projectfollowup followup = ProjectFollowupLogic.consFollowup(idFollowup);
			
			followup.setAc(ac);
			followup.setEv(ev);
			
			ProjectFollowupLogic.saveFollowup(followup);
			
			infoUpdated(req, "followup");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewControlProject(null, req, resp);
	}

	/**
     * View Funding Chart
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void viewFundingChart(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idProject = ParamUtil.getInteger(req, "id");
		
    	OutputStream out = resp.getOutputStream();
    	
		try {
			
			List<Incomes> incomes	= IncomesLogic.consIncomes(idProject, Incomes.ACTUALBILLDATE); 
			
			ChartFinancePlan chartFinancePlan = new ChartFinancePlan();
			
			for (Incomes item : incomes) {
				 
				if (item.getActualBillAmmount() != null && item.getActDaysToDate() != null) {
					ChartFinancePlanValues values = new ChartFinancePlanValues();
					
					values.setPlannedAmount(Double.toString(item.getActualBillAmmount() /1000));
					values.setValue(item.getActDaysToDate()+StringPool.BLANK);	
					
					chartFinancePlan.addFinancePlan(values);
				}
			}				
			if (!incomes.isEmpty()){
				JFreeChart chart = chartFinancePlan.generateChart(idioma);
				 
				resp.setContentType("image/jpeg");					
													
				ChartUtilities.writeChartAsJPEG(out, chart, 800, 480);					
				out.close();
			 }
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
     * Save income
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveIncomeJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	int idIncome			 = ParamUtil.getInteger(req, Incomes.IDINCOME, -1);
    	double actualBillAmmount = ParamUtil.getCurrency(req, Incomes.ACTUALBILLAMMOUNT,0);
    	Date actualBillDate		 = ParamUtil.getDate(req, Incomes.ACTUALBILLDATE,dateFormat,null);
    	String actualDescription = ParamUtil.getString(req, Incomes.ACTUALDESCRIPTION);
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			Incomes income = IncomesLogic.consIncome(idIncome);
			income.setActualBillAmmount(actualBillAmmount);
			income.setActualBillDate(actualBillDate);
			income.setActualDescription(actualDescription);
			
			income = IncomesLogic.saveIncome(income);
			
			JSONObject returnJSON = null;
			returnJSON = infoUpdated(returnJSON, "funding");
			
			returnJSON.put("actDaysToDate", income.getActDaysToDate());
			returnJSON.put(Incomes.PLANNEDBILLDATE, dateFormat.format(income.getPlannedBillDate()));
			returnJSON.put(Incomes.PLANNEDBILLAMMOUNT, income.getPlannedBillAmmount());
			
			out.print(returnJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Save Scope Activity
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void saveScopeActivity(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	Integer idProject	= ParamUtil.getInteger(req, "id", null);
		int idActivity		= ParamUtil.getInteger(req, "activity_id", -1);
		double ev			= ParamUtil.getCurrency (req, "ev", 0);
		double poc			= ParamUtil.getCurrency (req, "poc", 0);
		
		try {
			
			Projectactivity activity = ProjectActivityLogic.consActivity(idActivity);
			
			activity.setEv(ev);
			activity.setPoc(poc);

			ProjectActivityLogic.saveScopeControlActivity(activity);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewControlProject(idProject, req, resp);
	}

	/**
     * Update Milestone
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveMilestoneJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	Integer idMilestone		= ParamUtil.getInteger(req, "milestone_id", -1);
		Date achieved			= ParamUtil.getDate(req, "achieved", dateFormat, null);
		String achievedComments = ParamUtil.getString(req, Milestones.ACHIEVEDCOMMENTS,null);
		
		PrintWriter out = resp.getWriter();
		
		try {
			Milestones milestone = MilestoneLogic.consMilestone(new Milestones(idMilestone));
			
			milestone.setAchieved(achieved);
			milestone.setAchievedComments(achievedComments);
			
			MilestoneLogic.saveMilestone(milestone);
			
			out.print(JSONModelUtil.milestoneToJSON(idioma, milestone));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}


	/**
     * Save Activity in control
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void saveActivity(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    	Integer idProject	= ParamUtil.getInteger(req, "id");
    	Integer idActivity	= ParamUtil.getInteger(req, "activity_id", -1);
    	Date actualInitDate = ParamUtil.getDate(req, Projectactivity.ACTUALINITDATE, dateFormat, null);
    	Date actualEndDate	= ParamUtil.getDate(req, Projectactivity.ACTUALENDDATE, dateFormat, null);
		
		try {
			
			Projectactivity activity = ProjectActivityLogic.consActivity(idActivity);
			
			activity.setActualInitDate(actualInitDate);
			activity.setActualEndDate(actualEndDate);
			
			ProjectActivityLogic.saveControlActivity(new Project(idProject), activity);
			
			infoUpdated(req, "activity");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewControlProject(idProject, req, resp);
	}


	/**
	 * Set Change control object from Http Request parameters of control_change_popup
	 * @param req
	 * @return
	 * @throws Exception
	 */
	private Changecontrol setChangeFromRequest(HttpServletRequest req) throws LogicException {
		Changecontrol change = null;
		
		Integer idProject	= ParamUtil.getInteger(req, "id", -1);
		Integer idChange	= ParamUtil.getInteger(req, "change_id", -1);
		String desc 		= ParamUtil.getString(req, "desc", null);
		Character priority 	= ParamUtil.getString(req, "priority", null).charAt(0);
		Date date			= ParamUtil.getDate(req, "date", dateFormat);
		Integer idType		= ParamUtil.getInteger(req, "type", -1);
		String recSolution	= ParamUtil.getString(req, "solution", null);
		String originator	= ParamUtil.getString(req, "originator", null);
		Integer idWbsNode	= ParamUtil.getInteger(req, "wbsnode", -1);
		Integer effort		= ParamUtil.getInteger(req, "effort", 0);
		double cost			= ParamUtil.getCurrency(req, "cost", 0);
		String impact		= ParamUtil.getString(req, "impact", null);
		String[] aResolution= ParamUtil.getStringValues(req, "resolution", null);
		String resolution	= (aResolution == null ? null : aResolution[0]);
		Date resolutionDate = ParamUtil.getDate(req, "resolution_date", dateFormat, null);
		String reason		= ParamUtil.getString(req, "resolution_reason", null);
		
		if (idProject == -1 || idType == -1) {
			throw new NoDataFoundException();
		}
		
		Changetype type = new Changetype();
		type.setIdChangeType(idType);
		
		change = new Changecontrol();
		if (idChange != -1) {
			change.setIdChange(idChange);
		}
		change.setProject(new Project(idProject));
		change.setChangeDate(date);
		change.setDescription(desc);
		change.setPriority(priority);
		change.setChangetype(type);
		change.setRecommendedSolution(recSolution);
		change.setOriginator(originator);
		
		if (idWbsNode != -1) { // Analyze change control
			Wbsnode node = new Wbsnode();
			node.setIdWbsnode(idWbsNode);
			change.setWbsnode(node);
			change.setEstimatedEffort(effort);
			change.setEstimatedCost(cost);
			change.setImpactDescription(impact);
		}
		
		if (resolution != null) { // Resolve change control
			change.setResolution("Y".equals(resolution));
			change.setResolutionDate(resolutionDate);
			change.setResolutionReason(reason);
		}
		
		return change;
	}
	
	/**
	 *  Recover Control-Project info and forward to control-project.jsp
	 * @param idProject
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	/*
	 * Update Devoteam, Xavier de Langautier 2015-06-09 
	 * 			us15 : compute of remùaining on an activity
	 */
	private void viewControlProject(Integer idProject, HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {
		
		String orderFollowup = ParamUtil.getString(req, "orderFollowup", SettingUtil.getSetting(getUser(req), Settings.SETTING_STATUS_REPORT_ORDER));
		
		// Information to recover
		Project project						= null;	
		List<Projectfollowup> followups		= null;
		List<Milestones> milestones			= null;
		List<Changecontrol> changes			= null;
		List<Changetype> changeTypes		= null;
		Double wip							= 0D;
		Integer dsoBilled					= null;
		Integer dsoUnbilled					= null;
		List<Projectcosts> costs			= null;
		List<Iwo> iwos						= null;		
		Projectactivity rootActivity		= null;		
		List<Checklist> checklists			= null;
		List<Wbsnode> wbsnodes				= null;
		List<Documentproject> docs			= null;		
		Double sumTimeSheet					= null;
		List<Teammember> team 				= null;      //us15 
		double remainingActivity, remainingTeammember;   //us15
		int lastIdActivity; 							 //us15
		// recuperer le lundi de la semaine suivante
		  Date aujourdhui = new Date();                  //us15
		  Date fisrtDayOfNextWeek;                       //us15
		 fisrtDayOfNextWeek = DateUtil.getFirstWeekDay(DateUtil.addDay(aujourdhui , 7));   //us15
		
		if (idProject == null) {
			idProject = ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		}
		
		boolean hasPermission = false;
		
		try {
	
			hasPermission = SecurityUtil.hasPermission(req, new Project(idProject), Constants.TAB_CONTROL);
			
			if (hasPermission) {
				
				Employee user	= SecurityUtil.consUser(req);
				Company company = CompanyLogic.searchByEmployee(user);
				
				ProjectFollowupLogic followupLogic	= new ProjectFollowupLogic();
				TimesheetLogic timesheetLogic		= new TimesheetLogic();
				ChangeTypesLogic changeLogic		= new ChangeTypesLogic();
				
				List<String> joins = new ArrayList<String>();
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
				joins.add(Project.STAKEHOLDERS);
				joins.add(Project.STAKEHOLDERS+"."+Employee.CONTACT);
				joins.add(Project.PROJECTKPIS);
				joins.add(Project.PROJECTKPIS+"."+Projectkpi.METRICKPI);
				joins.add(Project.INCOMESES);
				joins.add(Project.PROJECTACTIVITIES);
				joins.add(Project.PROJECTACTIVITIES + "." + Projectactivity.WBSNODE);
				
				project = ProjectLogic.consProject(new Project(idProject), joins);			
				
				joins = new ArrayList<String>();
				joins.add(Projectfollowup.PROJECT);
				followups		= followupLogic.findByRelation(Projectfollowup.PROJECT, project, Projectfollowup.FOLLOWUPDATE, orderFollowup, joins); 
				
				milestones		= MilestoneLogic.consMilestones(idProject);
				changes			= ChangeControlLogic.consChangesControl(project);
				changeTypes		= changeLogic.findByRelation(Changetype.COMPANY, company);
				wip				= ProjectLogic.calculateWIP(project);
				dsoBilled		= ProjectLogic.calculateDSOBilled(project);
				dsoUnbilled		= ProjectLogic.calculateDSOUnbilled(project);
				costs			= ProjectCostsLogic.consCosts(project);
				iwos			= IwosLogic.consIwos(project);		
				checklists		= ChecklistLogic.findByProject(project);
				wbsnodes		= WBSNodeLogic.findByProject(project);
				
				sumTimeSheet	= timesheetLogic.calcTimeSheetAC(project);
				team		    = TeamMemberLogic.consTeamMembers(new Project(idProject));  //us 15
				remainingActivity = 0;  													//us15
				lastIdActivity = 0;
	            

	            
 					/* UserStory 15 Calcul du Reste à faire par activité et par teammember */             
				for (Teammember teammember: team ) {

					// on ne prend que les teammembers au status assigned

					if (teammember.getStatus().compareTo(Constants.RESOURCE_ASSIGNED) == 0) {
						// Calcul du Reste a faire à partir du lundi de la semaine suivante
						remainingTeammember =   (timesheetLogic.getHoursResource(teammember.getEmployee().getIdEmployee(), 
														 teammember.getProjectactivity().getIdActivity(),
														 fisrtDayOfNextWeek, //project.getPlannedInitDate(),   //Lundi de la semaine suivante
														 teammember.getDateOut(), 
														 Constants.TIMESTATUS_APP0,
														 Constants.TIMESTATUS_APP0
													) /Constants.DEFAULT_HOUR_DAY); /* reste à faire en jours*/
						
						remainingTeammember =  NumberUtil.truncate2decimals(remainingTeammember);
						
						teammember.setRemainingWorkload( remainingTeammember <0 ?0 : remainingTeammember);  		
						if (lastIdActivity != teammember.getProjectactivity().getIdActivity()){
				            
				         if (lastIdActivity != 0) {
				        	 			//	 Mise à jour du raf sur l'activité
				        	 for (Projectactivity  currentactivity : project.getProjectactivities() ){
				        		 if (currentactivity.getIdActivity() == lastIdActivity ){
				        			 currentactivity.setRemainingWorkload(remainingActivity <0 ?0 : remainingActivity); 
				        		 }
				        	 }
				         }   			// lasIdActivity non null			             
				         	remainingActivity = 0;
				         	lastIdActivity = teammember.getProjectactivity().getIdActivity();			             
						 } 				// On change d'activity
						remainingActivity =  remainingActivity + remainingTeammember;   
					  // LOGGER.debug(teammember.getIdTeamMember()+" remainingTeammember " + remainingTeammember +" remaining " + remainingActivity + " activity " +teammember.getProjectactivity().getIdActivity()+ " employee " + teammember.getEmployee().getIdEmployee());
					}              // if status teammember
				}                  // end  boucle for
				if (lastIdActivity != 0) { //mise à jour du RAF pour la derniere acvtivité
     	 			//	 Mise à jour du raf sur l'activité 
					for (Projectactivity  currentactivity : project.getProjectactivities() ){
						if (currentactivity.getIdActivity() == lastIdActivity ){
							currentactivity.setRemainingWorkload(remainingActivity <0 ?0 : remainingActivity); 
						}
						if (!ProjectActivityLogic.checkIfActivityInputed(currentactivity)){
							//LOGGER.debug("pas d'assignatin pour cette activite "+ currentactivity.getIdActivity() +currentactivity.getInitWorkload() );
							currentactivity.setRemainingWorkload(currentactivity.getInitWorkload() == null?0:currentactivity.getInitWorkload());
						}
					}
				}
					
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					docs = new ArrayList<Documentproject>();
					docs.add(DocumentprojectLogic.findByType(project,Constants.DOCUMENT_CONTROL));	
				}
				else {
					docs = DocumentprojectLogic.findListByType(project, Constants.DOCUMENT_CONTROL);	
				}					
				rootActivity = ProjectActivityLogic.consRootActivity(project);				
			}
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		if (hasPermission) {
			req.setAttribute("project", project);			
			req.setAttribute("followups", followups);
			req.setAttribute("milestones", milestones);
			req.setAttribute("changes", changes);
			req.setAttribute("changeTypes", changeTypes);
			req.setAttribute("wip", wip);
			req.setAttribute("dso_billed", dsoBilled);
			req.setAttribute("dso_unbilled", dsoUnbilled);
			req.setAttribute("costs", costs);
			req.setAttribute("iwos", iwos);
			req.setAttribute("rootActivity", rootActivity);			
			req.setAttribute("checklists", checklists);
			req.setAttribute("wbsnodes", wbsnodes);
			req.setAttribute("sumTimeSheet", sumTimeSheet);
			req.setAttribute("orderFollowup", orderFollowup);
			
			if(Constants.DOCUMENT_STORAGE.equals("link")) {
				req.setAttribute("docs", docs.get(0));
			}
			else {
				req.setAttribute("docs", docs);	
			}
			
			req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
			forward("/index.jsp?nextForm=project/control/control_project", req, resp);
		}
		else {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
	/**
	 *  Set ProjectFollowup from Control-Project request
	 * @param req
	 * @param followup
	 */
	private void setFollowupFromRequest(HttpServletRequest req,
			Projectfollowup followup) {
		
		String sGeneralFlag		= ParamUtil.getString(req, "general_status", null);
		Character generalFlag	= (sGeneralFlag != null && sGeneralFlag.length() > 0) ? sGeneralFlag.charAt(0) : null;
		String generalComments	= ParamUtil.getString(req, "general_desc", null);
		String sRiskFlag		= ParamUtil.getString(req, "risk_status", null);
		Character riskFlag		= (sRiskFlag != null && sRiskFlag.length() > 0) ? sRiskFlag.charAt(0) : null;
		String riskComments		= ParamUtil.getString(req, "risk_desc", null);
		String sScheduleFlag	= ParamUtil.getString(req, "schedule_status", null);
		Character scheduleFlag	= (sScheduleFlag != null && sScheduleFlag.length() > 0) ? sScheduleFlag.charAt(0) : null;
		String scheduleComments	= ParamUtil.getString(req, "schedule_desc", null);
		String sCostFlag		= ParamUtil.getString(req, "cost_status", null);
		Character costFlag		= (sCostFlag != null && sCostFlag.length() > 0) ? sCostFlag.charAt(0) : null;
		String costComments		= ParamUtil.getString(req, "cost_desc", null);
		
		followup.setGeneralFlag(generalFlag);
		followup.setGeneralComments(generalComments);
		followup.setRiskFlag(riskFlag);
		followup.setRisksComments(riskComments);
		followup.setScheduleFlag(scheduleFlag);
		followup.setScheduleComments(scheduleComments);
		followup.setCostFlag(costFlag);
		followup.setCostComments(costComments);
	}
	
	 /**
	 * Generate Team Members Ftes by Project
	 * @param project 
	 * @param teammembers
	 * @param sinceDate
	 * @param untilDate
	 * @return
	 * @throws LogicException 
	 */
	private List<TeamMembersFTEs> generateFTEsMembersByProject(Project project, List<Employee> resources, Date sinceDate, Date untilDate) throws Exception {
		
		List<TeamMembersFTEs> listMembers 	= new ArrayList<TeamMembersFTEs>();
		Calendar sinceCal			= DateUtil.getCalendar();
		Calendar untilCal			= DateUtil.getCalendar();
		TeamMembersFTEs memberFtes	= null;
		int[] listFTES				= null;
		
		if (sinceDate != null || untilDate != null) {
			
			TimesheetLogic timesheetLogic = new TimesheetLogic();
			
			sinceCal.setTime(sinceDate);
			untilCal.setTime(untilDate);
			
			int weeks = 0;
			while (!sinceCal.after(untilCal)) {
				weeks++;
				sinceCal.add(Calendar.DAY_OF_MONTH, +7);
			}
			
			for (Employee resource : resources) {
				
					 
				if (memberFtes != null) {
					memberFtes.setFtes(listFTES);
					listMembers.add(memberFtes);
				}
				
				Teammember member = new Teammember();
				member.setEmployee(resource);
				
				listFTES	= new int[weeks];
				memberFtes	= new TeamMembersFTEs(member);
				
				int i = 0;
				sinceCal.setTime(sinceDate);
				while (!sinceCal.after(untilCal)) {
					
					Double fte = timesheetLogic.getFte(
							project, resource,
							DateUtil.getFirstWeekDay(sinceCal.getTime()),
							DateUtil.getLastWeekDay(sinceCal.getTime()));
					
					listFTES[i] += (fte == null?0:fte);
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
}
