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
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.imageio.IIOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;

import es.sm2.openppm.charts.ChartArea2D;
import es.sm2.openppm.charts.ChartGantt;
import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.javabean.CsvFile;
import es.sm2.openppm.logic.CategoryLogic;
import es.sm2.openppm.logic.ChargescostsLogic;
import es.sm2.openppm.logic.ChartLogic;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.CustomerLogic;
import es.sm2.openppm.logic.CustomertypeLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.FundingsourceLogic;
import es.sm2.openppm.logic.GeographyLogic;
import es.sm2.openppm.logic.ProgramLogic;
import es.sm2.openppm.logic.ProjectFollowupLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.SellerLogic;
import es.sm2.openppm.logic.WorkingcostsLogic;
import es.sm2.openppm.model.Category;
import es.sm2.openppm.model.Chargescosts;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Customertype;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Fundingsource;
import es.sm2.openppm.model.Geography;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JSONModelUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.SettingUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.StringUtil;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class ProgramServlet
 */
public class ProgramServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	private static final  Logger LOGGER = Logger.getLogger(ProgramServlet.class);
	
	public final static String REFERENCE 	= "program";
	
	/***************** Actions ****************/
	public final static String DEL_PROGRAM	= "delete-program";
	public final static String CHART_BUBBLE	= "chart-bubble";
	public final static String SAVE_PROGRAM = "save-program";
	public final static String EXPORT_STATUS_REPORT_CSV	= "export-status-report-csv";
	public final static String EXPORT_PROJECTS_CSV		= "export-projects-csv";
	public final static String EXPORT_INVESTMENTS_CSV	= "export-investments-csv";
	
	/************** Actions AJAX **************/
	public final static String JX_CONS_SALES_FORECAST	= "ajax-cons-sales-forecast";
	public final static String JX_SATUS_REPORT			= "ajax-staus-report";
	public final static String JX_CONS_GANTT 			= "ajax-cons-gantt";
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.service(req, resp);
		
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		if (SecurityUtil.consUserRole(req) != -1) {
			
			/***************** Actions ****************/
			if (accion == null || "".equals(accion)) { viewPrograms(req, resp); }
			else if (DEL_PROGRAM.equals(accion)) { deleteProgram(req, resp); }
			else if (CHART_BUBBLE.equals(accion)) { chartBubble(req, resp); }
			else if (SAVE_PROGRAM.equals(accion)) { saveProgram(req, resp); }
			else if (EXPORT_STATUS_REPORT_CSV.equals(accion)) { exportSRToCSV(req, resp); }
			else if (EXPORT_PROJECTS_CSV.equals(accion)) { exportProjectsToCSV(req, resp); }
			else if (EXPORT_INVESTMENTS_CSV.equals(accion)) { exportInvestmentsToCSV(req, resp); }
			
			/************** Actions AJAX **************/
			else if (JX_CONS_SALES_FORECAST.equals(accion)) { consSalesForecastJX(req, resp); }
			else if (JX_SATUS_REPORT.equals(accion)) { generateStatusReport(req, resp); }
			else if (JX_CONS_GANTT.equals(accion)) { consGantt(req, resp); }
			
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}

	/**
	 * Cons chart gantt
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void consGantt(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			final int maxProjects = 50;
			
			String idStr = ParamUtil.getString(req, "ids");
			String propiedad = ParamUtil.getString(req, "propiedad");
			String orden = ParamUtil.getString(req, "orden");
			Date since	 = ParamUtil.getDate(req, "since", dateFormat, null);
			Date until	 = ParamUtil.getDate(req, "until", dateFormat, null);
			
			Integer[] ids = StringUtil.splitStrToIntegers(idStr, maxProjects);
			
			List<Project> projects = null;
			if (ids != null) {
				projects = ProjectLogic.consList(ids, propiedad, orden, null);   
			}
			
			JSONObject returnJSON = new JSONObject();
			
			if (projects == null || projects.isEmpty()) {
				
				returnJSON = info("data_not_found", returnJSON);
			}
			else {
				ChartGantt gantt = ChartLogic.consChartGantt(idioma, projects, since, until);
			
				if (gantt != null) {
					returnJSON.put("tasksGantt", gantt.getNumTasks());
					returnJSON.put("xml", gantt.generateXML());
				}
	
				if (StringUtil.lengthIntegers(idStr) > maxProjects) {
					returnJSON = info("msg.info.gantt_first_projects", returnJSON, maxProjects+StringPool.BLANK);
				}
			}
			out.print(returnJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
	 * Generate Status Report
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	private void generateStatusReport(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		String idStr	= ParamUtil.getString(req, "ids");
		String property = ParamUtil.getString(req, "property",Project.IDPROJECT);
		String order	= ParamUtil.getString(req, "order",Constants.DESCENDENT);
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			Integer[] ids = StringUtil.splitStrToIntegers(idStr, null);
			
			if (ids != null) {
				List<Project> projects = ProjectLogic.consListInControl(ids, property, order);
				
				JSONArray listJSON = new JSONArray();
				
				for (Project project : projects) {
					
					Projectfollowup followup = ProjectFollowupLogic.findLastWithDataByProject(project);
					
					JSONObject objectJSON = JSONModelUtil.followupToJSON(idioma, followup);
					
					objectJSON.put("idProject", project.getIdProject());
					objectJSON.put("projectName", project.getProjectName());
					
					listJSON.add(objectJSON);
				}
	
				out.print(listJSON.toString());
			}
			else { out.print(info("msg.error.not_for_showing", null,"projects","status_report")); }
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
	 * Create Sales Forecast Chart
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	private void consSalesForecastJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		String idStr = ParamUtil.getString(req, "ids");
		
		PrintWriter out = resp.getWriter();
		
		try {
			Integer[] ids = StringUtil.splitStrToIntegers(idStr, null);
			
			JSONObject returnJSON = new JSONObject();
			
			if (ids != null) {
					ChartArea2D chartSales 	= ChartLogic.consChartSales(idioma, ids);
				
				if (chartSales != null) {
					returnJSON.put("xml", chartSales.generateXML());
				}
				else {
					returnJSON = info("msg.error.data", returnJSON);
				}
			}
			else {
				returnJSON = info("data_not_found", returnJSON);
			}
			
			out.print(returnJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}


	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewPrograms(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		List<Program> programs		= null;
		List<Employee> progManagers	= null;
		List<Customer> customers	= null;
		List<Category> categories	= null;
		List<Employee> projManagers = null;
		List<Seller> sellers		= null;
		List<Geography> geographys	= null;
		List<Employee> sponsors		= null;
		List<Customertype> cusType	= null;
		List<Fundingsource> fundingSources = null;
		
		Employee user	= SecurityUtil.consUser(req);
		
		try {
			Company company	= CompanyLogic.searchByEmployee(user);
						
			if (SecurityUtil.isUserInRole(req, Constants.ROLE_PROGM)) {
				programs = ProgramLogic.consByProgramManager(user);
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PMO)
					|| SecurityUtil.isUserInRole(req, Constants.ROLE_FM)) {
				
				programs = ProgramLogic.consByPO(user);	
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PORFM)) {
				
				List<String> joins = new ArrayList<String>();
				joins.add(Program.EMPLOYEE);
				joins.add(Program.EMPLOYEE+"."+Employee.CONTACT);
				
				programs = ProgramLogic.consByCompany(user, joins);
			}

			CategoryLogic categoryLogic = new CategoryLogic();
			GeographyLogic geoLogic = new GeographyLogic();
			
			cusType		 = CustomertypeLogic.findByCompany(user);
			customers	 = CustomerLogic.searchByCompany(company);
			projManagers = EmployeeLogic.findByPOAndRol(user.getPerformingorg(), Constants.ROLE_PM);
			sponsors	 = EmployeeLogic.findByPOAndRol(user.getPerformingorg(), Constants.ROLE_SPONSOR);
			categories	 = categoryLogic.findByRelation(Category.COMPANY, company);
			geographys	 = geoLogic.findByRelation(Geography.COMPANY, company);
			sellers		 = SellerLogic.searchByCompany(company);
			progManagers = EmployeeLogic.findByPOAndRol(user.getPerformingorg(), Constants.ROLE_PROGM);
			fundingSources	= FundingsourceLogic.findByCompany(user);

		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("title", idioma.getString("title.programs"));
		req.setAttribute("list_programs", programs);
		req.setAttribute("profile", user.getResourceprofiles().getIdProfile());
		req.setAttribute("list_employees", progManagers);
		req.setAttribute("cusType", cusType);
		req.setAttribute("customers", customers);
		req.setAttribute("projectManagers", projManagers);
		req.setAttribute("categories", categories);
		req.setAttribute("geographys", geographys);
		req.setAttribute("sellers", sellers);
		req.setAttribute("sponsors", sponsors);
		req.setAttribute("fundingSources", fundingSources);
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		
		forward("/index.jsp?nextForm=program/list_programs", req, resp);
	}


	/**
	 * Create bubble chart
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void chartBubble(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		resp.setContentType("image/jpeg");
		OutputStream out = resp.getOutputStream();
		
		try {
			String idStr	= ParamUtil.getString(req, "ids");
			boolean size	= ParamUtil.getBoolean(req, "minsize",false);
			boolean investiment = ParamUtil.getBoolean(req, "investiment",false);
			
			Integer[] ids = StringUtil.splitStrToIntegers(idStr, null);
			
			if (ids != null && ids.length > 0) {
				List<String> joins = new ArrayList<String>();
				joins.add(Project.CUSTOMER);
				joins.add(Project.CUSTOMER + "." + Customer.CUSTOMERTYPE);
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER + "." + Employee.CONTACT);
				joins.add(Project.EMPLOYEEBYSPONSOR);
				joins.add(Project.EMPLOYEEBYSPONSOR + "." + Employee.CONTACT);
				joins.add(Project.CATEGORY);
				joins.add(Project.GEOGRAPHY);
				
				List<Project> projList = ProjectLogic.consList(ids, null, null, joins);
				
				JFreeChart bubbleChart = ChartLogic.createBubbleChart(idioma, projList, investiment);
			
				if (size) {
					ChartUtilities.writeChartAsJPEG(out, bubbleChart, 750, 750);
				}
				else {
					ChartUtilities.writeChartAsJPEG(out, bubbleChart, 850, 850);
				}
			}
			out.close();
		}
		catch (IIOException e) {
			LOGGER.info(StringPool.INFO+StringPool.COLON_SPACE+ e.getMessage());
			req.setAttribute(StringPool.ERROR, e.getMessage());
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
	}


	/**
	 * Delete program
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteProgram(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Integer idProgram = ParamUtil.getInteger(req, "id", -1);
		try {		
			ProgramLogic.deleteProgram(idProgram);
			infoDeleted(req, "program");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewPrograms(req, resp);
	}
	
	/**
	 * Save program
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveProgram(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idProgram			= ParamUtil.getInteger(req, "program_id", -1);
		int idProgManager		= ParamUtil.getInteger(req, "program_manager");
		String programCode		= ParamUtil.getString(req, "program_code", "");
		String programName		= ParamUtil.getString(req, "program_name", "");	
		String programTitle		= ParamUtil.getString(req, "program_title", "");	
		String description		= ParamUtil.getString(req, "program_description", "");
		String programDoc		= ParamUtil.getString(req, "program_doc", "");
		Double budget			= ParamUtil.getCurrency(req, "budget", 0);
		String budgetYear		= ParamUtil.getString(req, "budgetYear", "");
		
		try {		
			
			Program program = null;
			
			Employee user = SecurityUtil.consUser(req);
			
			if (idProgram == -1){
				program = new Program();
				
				program.setPerformingorg(user.getPerformingorg());
				infoCreated(req, "program");
			}
			else {
				program = ProgramLogic.consProgram(idProgram);
				infoUpdated(req, "program");
			}
			
			if (SecurityUtil.isUserInRole(req, Constants.ROLE_PMO)) {
				
				program.setEmployee(new Employee(idProgManager));
				program.setProgramCode(programCode);
				program.setProgramName(programName);
				program.setProgramTitle(programTitle);
				program.setProgramDoc(programDoc);
				program.setBudget(budget);
				program.setBudgetYear(budgetYear);
			}
			
			program.setDescription(description);
			
			ProgramLogic.saveProgram(program);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewPrograms(req, resp);
	}
	
	/**
	 * Export status report to csv
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void exportSRToCSV (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String idStr = ParamUtil.getString(req, "ids");		
		String fileName = "";
		CsvFile file = null;
		
		try {
			
			Integer[] ids = StringUtil.splitStrToIntegers(idStr, null);
			
			if (ids != null) {
				
				fileName = "Projects status report";
				
				file = new CsvFile(Constants.SEPARATOR_CSV);
				
				file.addValue(idioma.getString("project_name"));
				file.addValue(idioma.getString("date"));
				file.addValue(idioma.getString("status"));
				file.addValue(idioma.getString("type"));
				file.addValue(idioma.getString("desc"));
				file.newLine();
				file.newLine();
				
				List<Project> projects = ProjectLogic.consList(ids, null, null, null);				
				
				for (Project project : projects) {
					
					Projectfollowup followup = ProjectFollowupLogic.findLastWithDataByProject(project);
					
					if (followup != null) {
						
						file.addValue(StringPool.BLANK);
						file.addValue(StringPool.BLANK);
						file.addValue((followup.getGeneralFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getGeneralFlag().toString())));
						file.addValue(idioma.getString("general"));
						file.addValue((followup.getGeneralComments()== null ? StringPool.BLANK : followup.getGeneralComments()));
						file.newLine();
						
						file.addValue(project.getProjectName());
						file.addValue(followup.getFollowupDate() == null?StringPool.BLANK:dateFormat.format(followup.getFollowupDate()));
						file.addValue((followup.getRiskFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getRiskFlag().toString())));
						file.addValue(idioma.getString("risk"));
						file.addValue((followup.getRisksComments()== null ? StringPool.BLANK : followup.getRisksComments()));
						file.newLine();
						
						file.addValue(StringPool.BLANK);
						file.addValue(StringPool.BLANK);
						file.addValue((followup.getScheduleFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getScheduleFlag().toString())));
						file.addValue(idioma.getString("schedule"));
						file.addValue((followup.getScheduleComments()== null ? StringPool.BLANK : followup.getScheduleComments()));
						file.newLine();
						
						file.addValue(StringPool.BLANK);
						file.addValue(StringPool.BLANK);
						file.addValue((followup.getCostFlag()== null ? StringPool.BLANK : idioma.getString("followup.status_" + followup.getCostFlag().toString())));
						file.addValue(idioma.getString("cost"));
						file.addValue((followup.getCostComments()== null ? StringPool.BLANK : followup.getCostComments()));
						file.newLine();
						file.newLine();
					}
				}
				sendFile(req, resp, file.getFileBytes(), fileName + ".csv");
			}										
		}
		catch (Exception e) { 
			ExceptionUtil.evalueException(req, idioma, LOGGER, e); 
		}		
	}
	
	/**
	 * Export projects to csv
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void exportProjectsToCSV (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String idStr = ParamUtil.getString(req, "ids");
		String fileName = "";
		CsvFile file = null;
		
		try {
			
			Integer[] ids = StringUtil.splitStrToIntegers(idStr, null);

			if (ids != null) {
				
				fileName = "Projects";
				file = new CsvFile(Constants.SEPARATOR_CSV);
				
				file.addValue(idioma.getString("project.chart_label"));
				file.addValue(idioma.getString("project"));
				file.addValue(idioma.getString("project.budget_year"));
				file.addValue(idioma.getString("project.accounting_code"));
				file.addValue(idioma.getString("investment_manager"));
				file.addValue(idioma.getString("project_manager"));
				file.addValue(idioma.getString("program"));
				file.addValue(idioma.getString("category"));
				file.addValue(idioma.getString("business_manager"));
				file.addValue(idioma.getString("sponsor"));
				file.addValue(idioma.getString("customer"));
				file.addValue(idioma.getString("customer_type"));
				file.addValue(idioma.getString("contract_type"));
				file.addValue(idioma.getString("project.net_value"));
				file.addValue(idioma.getString("activity.budget"));
				file.addValue(idioma.getString("bac"));
				file.addValue(idioma.getString("baseline_start"));
				file.addValue(idioma.getString("baseline_finish"));
				file.addValue(idioma.getString("change.priority"));
				file.addValue(idioma.getString("project.external_cost"));
				file.addValue(idioma.getString("geography"));				
				file.addValue(idioma.getString("rag"));
				file.addValue(idioma.getString("status"));
				file.addValue(idioma.getString("percent_complete"));
				file.addValue(idioma.getString("start"));
				file.addValue(idioma.getString("finish"));
				file.addValue(idioma.getString("project.internal"));
				file.addValue(idioma.getString("sellerscosts"));
				file.addValue(idioma.getString("infrastructurecosts"));
				file.addValue(idioma.getString("licensescosts"));
				file.addValue(idioma.getString("project.internal_cost"));
				if(!Settings.WORKING_COST_DEPARTMENTS[0].equals(StringPool.BLANK)) {
					for(String s : Settings.WORKING_COST_DEPARTMENTS) {
						file.addValue(s);	
					}
					file.addValue(idioma.getString("workingcosts.total"));
				}								
				file.newLine();
				
				List<String> joins = new ArrayList<String>();
				joins.add(Project.CONTRACTTYPE);
				joins.add(Project.CUSTOMER);
				joins.add(Project.CUSTOMER + "." + Customer.CUSTOMERTYPE);
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER + "." + Employee.CONTACT);
				joins.add(Project.EMPLOYEEBYSPONSOR);
				joins.add(Project.EMPLOYEEBYSPONSOR + "." + Employee.CONTACT);
				joins.add(Project.CATEGORY);
				joins.add(Project.GEOGRAPHY);
				joins.add(Project.EMPLOYEEBYINVESTMENTMANAGER);
				joins.add(Project.EMPLOYEEBYINVESTMENTMANAGER+ "." + Employee.CONTACT);
				joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER);
				joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER + "." + Employee.CONTACT);
				
				boolean exportFollowup = SettingUtil.getBolean(getUser(req), Settings.SETTING_FOLLOWUP_INFORMATION_CSV);
				
				List<Project> projects = ProjectLogic.consList(ids, null, null, joins);
				
				for (Project project : projects) {
					
					Projectactivity rootActivity = project.getRootActivity();
					Projectfollowup followup = project.getLastFollowup();
					
					Character risk = (followup != null && followup.getGeneralFlag() != null
							? followup.getGeneralFlag() : null);
					
					String generalRisk = StringPool.BLANK;	
					
					if (risk != null) {
						if (risk.equals(Constants.RISK_LOW)) { generalRisk = Character.toString(Constants.RISK_LOW); }
						else if (risk.equals(Constants.RISK_MEDIUM)) { generalRisk = Character.toString(Constants.RISK_MEDIUM); }
						else if (risk.equals(Constants.RISK_HIGH)) { generalRisk = Character.toString(Constants.RISK_HIGH); }
						else if (risk.equals(Constants.RISK_NORMAL)) { generalRisk = Character.toString(Constants.RISK_NORMAL); }						
					}
										
					file.addValue(project.getChartLabel());
					file.addValue(project.getProjectName());
					file.addValue((project.getBudgetYear() == null ? StringPool.BLANK : project.getBudgetYear().toString()));
					file.addValue(project.getAccountingCode());
					file.addValue(project.getEmployeeByInvestmentManager() != null
							?project.getEmployeeByInvestmentManager().getContact().getFullName()
							:StringPool.BLANK);
					file.addValue((project.getEmployeeByProjectManager() == null || project.getEmployeeByProjectManager().getContact() == null ? StringPool.BLANK : project.getEmployeeByProjectManager().getContact().getFullName()));
					file.addValue((project.getProgram() == null ? StringPool.BLANK : project.getProgram().getProgramName()));
					file.addValue((project.getCategory() == null ? StringPool.BLANK : project.getCategory().getName()));
					file.addValue(project.getEmployeeByFunctionalManager() != null
							?project.getEmployeeByFunctionalManager().getContact().getFullName()
							:StringPool.BLANK);
					file.addValue((project.getEmployeeBySponsor()== null || project.getEmployeeBySponsor().getContact() == null ? StringPool.BLANK : project.getEmployeeBySponsor().getContact().getFullName()));
					file.addValue((project.getCustomer() == null ? StringPool.BLANK : project.getCustomer().getName()));
					file.addValue((project.getCustomer() == null || project.getCustomer().getCustomertype() == null ? StringPool.BLANK : project.getCustomer().getCustomertype().getName()));
					file.addValue(project.getContracttype() == null ? StringPool.BLANK : project.getContracttype().getDescription());
					file.addValue(project.getNetIncome() == null ? StringPool.BLANK : ValidateUtil.toCurrency(project.getNetIncome()));
					file.addValue(project.getTcv() == null ? StringPool.BLANK : ValidateUtil.toCurrency(project.getTcv()));
					file.addValue((project.getBac() == null ? StringPool.BLANK : ValidateUtil.toCurrency(project.getBac())));
					file.addValue(project.getPlannedInitDate() != null ? dateFormat.format(project.getPlannedInitDate()):StringPool.BLANK);
					file.addValue(project.getPlannedFinishDate() != null ? dateFormat.format(project.getPlannedFinishDate()):StringPool.BLANK);
					file.addValue(project.getPriority() == null ? StringPool.BLANK  : project.getPriority().toString());
					file.addValue(ValidateUtil.toCurrency(ChargescostsLogic.consExternalCostByProject(project)));
					file.addValue((project.getGeography() == null ? StringPool.BLANK : project.getGeography().getName()));					

					file.addValue(generalRisk);
					file.addValue(idioma.getString("project_status." + project.getStatus()));
					file.addValue(ValidateUtil.toPercent(project.getPOC()/100));
					Date start = null;
					Date finish = null;
					if (Constants.STATUS_INITIATING == project.getStatus()) {
						start	= project.getPlannedInitDate();
						finish	= project.getPlannedFinishDate();
					}
					else if (Constants.STATUS_PLANNING == project.getStatus() && rootActivity != null) {
						start	= rootActivity.getPlanInitDate();
						finish	= rootActivity.getPlanEndDate();
					}
					else if (Constants.STATUS_CONTROL == project.getStatus() && rootActivity != null) {
						start	= (rootActivity.getActualInitDate() == null? rootActivity.getPlanInitDate():rootActivity.getActualInitDate());
						finish	= rootActivity.getPlanEndDate();
					}
					else if (rootActivity != null) {
						start	= rootActivity.getActualInitDate();
						finish	= rootActivity.getActualEndDate();
					}					
					file.addValue(start != null ? dateFormat.format(start) : StringPool.BLANK);
					file.addValue(finish != null ? dateFormat.format(finish) : StringPool.BLANK);
					file.addValue((project.getInternalProject() ? Constants.YES : Constants.NO));
					double result = 0;
					List <Chargescosts> list = null;
					list = ChargescostsLogic.consChargescostsByProject(project, Constants.SELLER_CHARGE_COST);
					if(!list.isEmpty()) {
						for(Chargescosts c : list) {
							result += c.getCost();
						}
					}					
					file.addValue(ValidateUtil.toCurrency(result));
					result = 0;
					list = ChargescostsLogic.consChargescostsByProject(project, Constants.INFRASTRUCTURE_CHARGE_COST);
					if(!list.isEmpty()) {
						for(Chargescosts c : list) {
							result += c.getCost();
						}
					}					
					file.addValue(ValidateUtil.toCurrency(result));
					result = 0;
					list = ChargescostsLogic.consChargescostsByProject(project, Constants.LICENSE_CHARGE_COST);
					if(!list.isEmpty()) {
						for(Chargescosts c : list) {
							result += c.getCost();
						}
					}
					file.addValue(ValidateUtil.toCurrency(result));
					file.addValue(new Integer(WorkingcostsLogic.consInternalCostByProject(project)).toString());
					if(!Settings.WORKING_COST_DEPARTMENTS[0].equals(StringPool.BLANK)) {
						int total = 0;
						for(String s : Settings.WORKING_COST_DEPARTMENTS) {
							int temp = WorkingcostsLogic.getCostByDeptAndProject(project, s);
							file.addValue(new Integer(temp).toString());
							total += temp;
						}
						file.addValue(new Integer(total).toString());
					}								
					
					// Export Followup information
					if (exportFollowup) { executeExportFollowup(file, project); }					
					
					file.newLine();		
				}
				sendFile(req, resp, file.getFileBytes(), fileName + ".csv");
			}										
		}
		catch (Exception e) { 
			ExceptionUtil.evalueException(req, idioma, LOGGER, e); 
		}		
	}
	
	/**
	 * Export investments to csv
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void exportInvestmentsToCSV (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String idStr = ParamUtil.getString(req, "ids");
		String fileName = "";
		CsvFile file = null;
		
		try {
			
			Integer[] ids = StringUtil.splitStrToIntegers(idStr, null);

			if (ids != null) {
				
				fileName = "Investments";
				file = new CsvFile(Constants.SEPARATOR_CSV);
				
				file.addValue(idioma.getString("project.chart_label"));
				file.addValue(idioma.getString("investment"));
				file.addValue(idioma.getString("project.budget_year"));
				file.addValue(idioma.getString("project.accounting_code"));
				file.addValue(idioma.getString("investment_manager"));
				file.addValue(idioma.getString("project_manager"));
				file.addValue(idioma.getString("program"));
				file.addValue(idioma.getString("category"));
				file.addValue(idioma.getString("business_manager"));
				file.addValue(idioma.getString("sponsor"));
				file.addValue(idioma.getString("customer"));
				file.addValue(idioma.getString("customer_type"));
				file.addValue(idioma.getString("contract_type"));
				file.addValue(idioma.getString("project.net_value"));
				file.addValue(idioma.getString("activity.budget"));
				file.addValue(idioma.getString("bac"));
				file.addValue(idioma.getString("baseline_start"));
				file.addValue(idioma.getString("baseline_finish"));
				file.addValue(idioma.getString("change.priority"));
				file.addValue(idioma.getString("project.external_cost"));
				file.addValue(idioma.getString("geography"));				
				file.addValue(idioma.getString("status"));
				file.addValue(idioma.getString("proposal.win_probability"));
				file.addValue(idioma.getString("start"));
				file.addValue(idioma.getString("finish"));
				file.addValue(idioma.getString("project.internal"));
				file.addValue(idioma.getString("sellerscosts"));
				file.addValue(idioma.getString("infrastructurecosts"));
				file.addValue(idioma.getString("licensescosts"));				
				file.addValue(idioma.getString("project.internal_cost"));
				if(!Settings.WORKING_COST_DEPARTMENTS[0].equals(StringPool.BLANK)) {
					for(String s : Settings.WORKING_COST_DEPARTMENTS) {
						file.addValue(s);	
					}
					file.addValue(idioma.getString("workingcosts.total"));
				}
				file.newLine();
				
				List<String> joins = new ArrayList<String>();
				joins.add(Project.CONTRACTTYPE);
				joins.add(Project.CUSTOMER);
				joins.add(Project.CUSTOMER + "." + Customer.CUSTOMERTYPE);
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER + "." + Employee.CONTACT);
				joins.add(Project.EMPLOYEEBYSPONSOR);
				joins.add(Project.EMPLOYEEBYSPONSOR + "." + Employee.CONTACT);
				joins.add(Project.CATEGORY);
				joins.add(Project.GEOGRAPHY);
				joins.add(Project.EMPLOYEEBYINVESTMENTMANAGER);
				joins.add(Project.EMPLOYEEBYINVESTMENTMANAGER+ "." + Employee.CONTACT);
				joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER);
				joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER + "." + Employee.CONTACT);
				
				boolean exportFollowup = SettingUtil.getBolean(getUser(req), Settings.SETTING_FOLLOWUP_INFORMATION_CSV);
				
				List<Project> projects = ProjectLogic.consList(ids, null, null, joins);
				
				for (Project project : projects) {
					
					Projectactivity rootActivity = project.getRootActivity();
					
					String state = idioma.getString("investments.status." + (project.getInvestmentStatus()== null ? 
							Constants.INVESTMENT_IN_PROCESS : project.getInvestmentStatus())
					);
										
					file.addValue(project.getChartLabel());
					file.addValue(project.getProjectName());
					file.addValue((project.getBudgetYear() == null ? StringPool.BLANK : project.getBudgetYear().toString()));
					file.addValue(project.getAccountingCode());
					file.addValue(project.getEmployeeByInvestmentManager() != null
							?project.getEmployeeByInvestmentManager().getContact().getFullName()
							:StringPool.BLANK);
					file.addValue((project.getEmployeeByProjectManager() == null || project.getEmployeeByProjectManager().getContact() == null ? StringPool.BLANK : project.getEmployeeByProjectManager().getContact().getFullName()));
					file.addValue((project.getProgram() == null ? StringPool.BLANK : project.getProgram().getProgramName()));
					file.addValue((project.getCategory() == null ? StringPool.BLANK : project.getCategory().getName()));
					file.addValue(project.getEmployeeByFunctionalManager() != null
							?project.getEmployeeByFunctionalManager().getContact().getFullName()
							:StringPool.BLANK);
					file.addValue((project.getEmployeeBySponsor()== null || project.getEmployeeBySponsor().getContact() == null ? StringPool.BLANK : project.getEmployeeBySponsor().getContact().getFullName()));
					file.addValue((project.getCustomer() == null ? StringPool.BLANK : project.getCustomer().getName()));
					file.addValue((project.getCustomer() == null || project.getCustomer().getCustomertype() == null ? StringPool.BLANK : project.getCustomer().getCustomertype().getName()));
					file.addValue(project.getContracttype() == null ? StringPool.BLANK : project.getContracttype().getDescription());
					file.addValue(project.getNetIncome() == null ? StringPool.BLANK : ValidateUtil.toCurrency(project.getNetIncome()));
					file.addValue(project.getTcv() == null ? StringPool.BLANK : ValidateUtil.toCurrency(project.getTcv()));
					file.addValue((project.getBac() == null ? StringPool.BLANK : ValidateUtil.toCurrency(project.getBac())));
					file.addValue(project.getPlannedInitDate() != null ? dateFormat.format(project.getPlannedInitDate()):StringPool.BLANK);
					file.addValue(project.getPlannedFinishDate() != null ? dateFormat.format(project.getPlannedFinishDate()):StringPool.BLANK);
					file.addValue(project.getPriority() == null ? StringPool.BLANK  : project.getPriority().toString());
					file.addValue(ValidateUtil.toCurrency(ChargescostsLogic.consExternalCostByProject(project)));
					file.addValue((project.getGeography() == null ? StringPool.BLANK : project.getGeography().getName()));					

					file.addValue(state);
					file.addValue(project.getProbability() == null ? StringPool.BLANK  : project.getProbability().toString());
					Date start = null;
					Date finish = null;
					if (Constants.STATUS_INITIATING == project.getStatus()) {
						start	= project.getPlannedInitDate();
						finish	= project.getPlannedFinishDate();
					}
					else if (Constants.STATUS_PLANNING == project.getStatus() && rootActivity != null) {
						start	= rootActivity.getPlanInitDate();
						finish	= rootActivity.getPlanEndDate();
					}
					else if (Constants.STATUS_CONTROL == project.getStatus() && rootActivity != null) {
						start	= (rootActivity.getActualInitDate() == null? rootActivity.getPlanInitDate():rootActivity.getActualInitDate());
						finish	= rootActivity.getPlanEndDate();
					}
					else if (rootActivity != null) {
						start	= rootActivity.getActualInitDate();
						finish	= rootActivity.getActualEndDate();
					}					
					file.addValue(start != null ? dateFormat.format(start) : StringPool.BLANK);
					file.addValue(finish != null ? dateFormat.format(finish) : StringPool.BLANK);
					file.addValue((project.getInternalProject() ? Constants.YES : Constants.NO));
					double result = 0;
					List <Chargescosts> list = null;
					list = ChargescostsLogic.consChargescostsByProject(project, Constants.SELLER_CHARGE_COST);
					if(!list.isEmpty()) {
						for(Chargescosts c : list) {
							result += c.getCost();
						}
					}					
					file.addValue(ValidateUtil.toCurrency(result));
					result = 0;
					list = ChargescostsLogic.consChargescostsByProject(project, Constants.INFRASTRUCTURE_CHARGE_COST);
					if(!list.isEmpty()) {
						for(Chargescosts c : list) {
							result += c.getCost();
						}
					}					
					file.addValue(ValidateUtil.toCurrency(result));
					result = 0;
					list = ChargescostsLogic.consChargescostsByProject(project, Constants.LICENSE_CHARGE_COST);
					if(!list.isEmpty()) {
						for(Chargescosts c : list) {
							result += c.getCost();
						}
					}	
					file.addValue(ValidateUtil.toCurrency(result));	
					file.addValue(new Integer(WorkingcostsLogic.consInternalCostByProject(project)).toString());
					if(!Settings.WORKING_COST_DEPARTMENTS[0].equals(StringPool.BLANK)) {
						int total = 0;
						for(String s : Settings.WORKING_COST_DEPARTMENTS) {
							int temp = WorkingcostsLogic.getCostByDeptAndProject(project, s);
							file.addValue(new Integer(temp).toString());
							total += temp;
						}
						file.addValue(new Integer(total).toString());
					}
					
					// Export Followup information
					if (exportFollowup) { executeExportFollowup(file, project); }
					
					file.newLine();		
				}
				sendFile(req, resp, file.getFileBytes(), fileName + ".csv");
			}										
		}
		catch (Exception e) { 
			ExceptionUtil.evalueException(req, idioma, LOGGER, e); 
		}		
	}

	/**
	 * Export Followup information
	 * @param file
	 * @param project
	 * @throws Exception
	 */
	private void executeExportFollowup(CsvFile file, Project project) throws Exception {
		
		ProjectFollowupLogic followupLogic = new ProjectFollowupLogic();
		
		Calendar since = DateUtil.getCalendar();
		Calendar until = DateUtil.getCalendar();
		since.setTime(new Date());
		
		if (since.get(Calendar.DAY_OF_MONTH) <= 7){ since.add(Calendar.MONTH, -1); }
		since.set(Calendar.DAY_OF_MONTH, 1);
		
		Projectfollowup followup = followupLogic.findLast(project);
		until.setTime(followup.getFollowupDate());
		
		double probability = new Double(project.getProbability()) / 100;
		
		int month		= 0;
		double lastPv	= 0;
		
		boolean findFollowup = false;
		
		while (!since.after(until)) {
			
			followup = followupLogic.findLasInMonth(project, since.getTime());
			
			if (followup == null && !findFollowup) { file.addValue(ValidateUtil.toCurrency(0)); }
			else if (followup == null && findFollowup) { month++; }
			else if (followup != null && !findFollowup && (followup.getPv() == null || followup.getPv() == 0)) {
				findFollowup = true;
				month++;
			}
			else if (month > 0) {
				
				findFollowup = true;
				
				double calc = ((followup.getPv() - lastPv) * probability) / ++month;
				
				for (int i = 0; i < month; i++) {
					file.addValue(ValidateUtil.toCurrency(calc));
				}
				month	= 0;
				lastPv	= followup.getPv();
			}
			else {
				
				findFollowup = true;
				double calc = (followup.getPv() - lastPv) * probability;
				file.addValue(ValidateUtil.toCurrency(calc));
				lastPv	= followup.getPv();
			}
			
			since.add(Calendar.MONTH, 1);
		}
	}
}
