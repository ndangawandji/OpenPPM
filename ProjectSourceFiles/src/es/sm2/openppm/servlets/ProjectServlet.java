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
/******************************************************************************
 * Update : Devoteam XL 2015-04-17  user story 23  tri des ressources
 *                 fonction :  viewProjects  tri des listes category et seller
 *
  ******************************************************************************/
/*
 * Updater : Cedric Ndanga Wandji
 * Devoteam, 18/06/2015, user story 4 : updating viewCreateProjectForm() java method.
 * Devoteam, 22/06/2015, user story 4 : updating createProject() java method.
 */
package es.sm2.openppm.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;


import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.javabean.DatoColumna;
import es.sm2.openppm.javabean.FiltroTabla;
import es.sm2.openppm.logic.CategoryLogic;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.CustomerLogic;
import es.sm2.openppm.logic.CustomertypeLogic;
import es.sm2.openppm.logic.DocumentprojectLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.FundingsourceLogic;
import es.sm2.openppm.logic.GeographyLogic;
import es.sm2.openppm.logic.LogprojectstatusLogic;
import es.sm2.openppm.logic.PerformingOrgLogic;
import es.sm2.openppm.logic.ProgramLogic;
import es.sm2.openppm.logic.ProjectCharterLogic;
import es.sm2.openppm.logic.ProjectFollowupLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.ResourceProfilesLogic;
import es.sm2.openppm.logic.SellerLogic;
import es.sm2.openppm.logic.charter.ProjectCharterTemplate;
import es.sm2.openppm.model.Category;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Customertype;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Fundingsource;
import es.sm2.openppm.model.Geography;
import es.sm2.openppm.model.Logprojectstatus;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JSONModelUtil;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.PaginacionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.StringUtil;
import es.sm2.openppm.utils.ValidateUtil;


/**
 * Servlet implementation class ProjectServer
 */
public class ProjectServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(ProjectServlet.class);
	
	public final static String REFERENCE = "projects";
	
	/***************** Actions ****************/
	public final static String NEW_PROJECT		= "new-project";
	public final static String NEW_INVERTMENT	= "new-investment";
	public final static String CREATE_PROJECT	= "create-project";
	public final static String LIST_PROJECTS	= "list-projects";
	public final static String LIST_INVESTMENTS	= "list-investments";
	public final static String DELETE_PROJECT	= "delete-project";
	public final static String GENERATE_STATUS_REPORT	= "generate-status-report";
	public final static String DOWNLOAD_DOC				= "download-document";	
	
	/************** Actions AJAX **************/
	public final static String JX_CHECK_CODE		= "ajax-check-code";
	public final static String JX_SAVE_CUSTOMER		= "ajax-save-customer";	
	public final static String JX_SAVE_DOCUMENT		= "save-document-jx";
	public final static String JX_CONS_PROJECT		= "cons-project-jx";
	public final static String JX_APPROVE_INVESTMENT	= "approve-investment-jx";
	public final static String JX_REJECT_INVESTMENT		= "reject-investment-jx";
	public final static String JX_CANCEL_INVESTMENT		= "cancel-investment-jx";
	public final static String JX_RESET_INVESTMENT		= "reset-investment-jx";
	public final static String JX_FILTER_TABLE			= "filter-table-projects-jx";
	public final static String JX_FILTER_TABLE_INVESTMENTS	= "filter-table-investments-jx";
	public final static String JX_UPLOAD_FILESYSTEM		= "upload-file-system-jx";	
	public final static String JX_DELETE_DOC				= "delete-document-jx";
	
    
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		Hashtable<String, FileItem> reqFields = null;		
		
		if (SecurityUtil.consUserRole(req) != -1) {
			if(ServletFileUpload.isMultipartContent(req) && StringPool.BLANK.equals(accion)) {		
				try {
					ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
					List<?> fileItemList = servletFileUpload.parseRequest(req);
					reqFields = parseFields(fileItemList);
					accion = reqFields.get("accion").getString();										
				} 
				catch (FileUploadException e) {
					LOGGER.error(StringPool.ERROR, e);
					req.setAttribute(StringPool.ERROR, e.getMessage());
				}
			}		
			
			LOGGER.debug("Accion: " + accion);
			
			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion) || LIST_PROJECTS.equals(accion) || LIST_INVESTMENTS.equals(accion)) {
				viewProjects(req, resp, accion);
			}
			else if (NEW_PROJECT.equals(accion) || NEW_INVERTMENT.equals(accion)) { viewCreateProjectForm(req, resp, accion); }
			else if (DELETE_PROJECT.equals(accion)) { deleteProject(req, resp); }
			else if (CREATE_PROJECT.equals(accion)) { createProject(req, resp); }
			else if (GENERATE_STATUS_REPORT.equals(accion)) { generateStatusReport(req, resp); }
			else if (DOWNLOAD_DOC.equals(accion)) {downloadDocument(req, resp);}

			/*********** Actions AJAX ************/
			else if (JX_SAVE_DOCUMENT.equals(accion)) { saveDocumentJX(req,resp); }
			else if (JX_CHECK_CODE.equals(accion)) { checkCodeJX(req, resp); }
			else if (JX_SAVE_CUSTOMER.equals(accion)) { saveCustomerJX(req, resp); }			
			else if (JX_CONS_PROJECT.equals(accion)) { consProjectJX(req, resp); }
			else if (JX_APPROVE_INVESTMENT.equals(accion)) { approveInvestmentJX(req, resp); }
			else if (JX_REJECT_INVESTMENT.equals(accion)) { rejectInvestmentJX(req, resp); }
			else if (JX_CANCEL_INVESTMENT.equals(accion)) { cancelInvestmentJX(req, resp); }
			else if (JX_RESET_INVESTMENT.equals(accion)) { resetInvestmentJX(req, resp); }
			else if (JX_FILTER_TABLE.equals(accion)) { filterTableProjectsJX(req, resp); }
			else if (JX_FILTER_TABLE_INVESTMENTS.equals(accion)) { filterTableiInvestmentsJX(req, resp); }
			else if (JX_UPLOAD_FILESYSTEM.equals(accion)) { uploadFileSystem(req, resp, reqFields); }
			else if (JX_DELETE_DOC.equals(accion)) { deleteFileSystem(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}


	private void resetInvestmentJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			int idProject = ParamUtil.getInteger(req, Project.IDPROJECT,-1);
			
			Project proj = ProjectLogic.consProject(idProject);
			
			proj.setStatus(Constants.STATUS_INITIATING);
			proj.setInvestmentStatus(Constants.INVESTMENT_IN_PROCESS);
			
			ProjectLogic.saveProject(proj);
			
			LogprojectstatusLogic logstatusLogic = new LogprojectstatusLogic();
			logstatusLogic.save(new Logprojectstatus(
					proj,getUser(req), Constants.STATUS_INITIATING,Constants.INVESTMENT_IN_PROCESS, new Date()));
			
			out.print(JsonUtil.infoTrue());
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}


	private void cancelInvestmentJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			int idProject 		= ParamUtil.getInteger(req, Project.IDPROJECT,-1);
			String comments		= ParamUtil.getString(req, Project.CLIENTCOMMENTS);
			
			Project proj = ProjectLogic.consProject(idProject);
			
			proj.setClientComments(comments);
			proj.setStatus(Constants.STATUS_CLOSED);
			proj.setInvestmentStatus(Constants.INVESTMENT_INACTIVATED);
			
			ProjectLogic.saveProject(proj);
			
			LogprojectstatusLogic logstatusLogic = new LogprojectstatusLogic();
			logstatusLogic.save(new Logprojectstatus(
					proj,getUser(req), Constants.STATUS_CLOSED,Constants.INVESTMENT_INACTIVATED, new Date()));
			
			out.print(JsonUtil.infoTrue());
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}


	private void rejectInvestmentJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			int idProject		= ParamUtil.getInteger(req, Project.IDPROJECT,-1);
			int finalPosition	= ParamUtil.getInteger(req, Project.FINALPOSITION,0);
			int numCompetitors	= ParamUtil.getInteger(req, Project.NUMCOMPETITORS,0);
			String clientComm	= ParamUtil.getString(req, Project.CLIENTCOMMENTS);
			
			Project proj = ProjectLogic.consProject(idProject);
			
			proj.setClientComments(clientComm);
			proj.setFinalPosition(finalPosition);
			proj.setNumCompetitors(numCompetitors);
			proj.setStatus(Constants.STATUS_CLOSED);
			proj.setInvestmentStatus(Constants.INVESTMENT_REJECTED);
			
			ProjectLogic.saveProject(proj);
			
			LogprojectstatusLogic logstatusLogic = new LogprojectstatusLogic();
			logstatusLogic.save(new Logprojectstatus(
					proj,getUser(req), Constants.STATUS_CLOSED,Constants.INVESTMENT_REJECTED, new Date()));
			
			out.print(JsonUtil.infoTrue());
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}


	private void approveInvestmentJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			LogprojectstatusLogic logstatusLogic = new LogprojectstatusLogic();
			
			int idProject		= ParamUtil.getInteger(req, Project.IDPROJECT,-1);
			int numCompetitors	= ParamUtil.getInteger(req, Project.NUMCOMPETITORS,0);
			String comments		= ParamUtil.getString(req, Project.CLIENTCOMMENTS);
			
			Project proj = ProjectLogic.consProject(idProject);
			
			proj.setNumCompetitors(numCompetitors);
			proj.setProbability(100);
			proj.setFinalPosition(1);
			proj.setStatus(Constants.STATUS_PLANNING);
			proj.setPlanDate(new Date());
			proj.setClientComments(comments);
			proj.setInvestmentStatus(Constants.INVESTMENT_APPROVED);
			
			ProjectLogic.saveProject(proj);
			
			logstatusLogic.save(new Logprojectstatus(
					proj,getUser(req), Constants.STATUS_PLANNING,Constants.INVESTMENT_APPROVED, new Date()));
			
			out.print(JsonUtil.infoTrue());
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}


	private void consProjectJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		List<Documentproject> docs = null;
		
		PrintWriter out = resp.getWriter();		
		
		try {
			int idProject = ParamUtil.getInteger(req, Project.IDPROJECT,-1);
			
			Project proj = ProjectLogic.consProject(idProject);
			
			if(Constants.DOCUMENT_STORAGE.equals("link")) {
				docs = new ArrayList<Documentproject>();
				docs.add(DocumentprojectLogic.findByType(proj,Constants.DOCUMENT_INVESTMENT));	
			}
			else {
				docs = DocumentprojectLogic.findListByType(proj, Constants.DOCUMENT_INVESTMENT);	
			}	
			
			out.print(JSONModelUtil.investmentToJSON(proj, docs));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	private void filterTableiInvestmentsJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			Employee user = SecurityUtil.consUser(req);

			// Real Columns
			ArrayList<DatoColumna > columnas = new ArrayList<DatoColumna>();
			columnas.add(new DatoColumna(StringPool.BLANK,Integer.class));
			columnas.add(new DatoColumna(Project.INVESTMENTSTATUS,List.class));
			columnas.add(new DatoColumna(Project.ACCOUNTINGCODE,String.class));
			columnas.add(new DatoColumna(Project.PROJECTNAME,String.class));
			columnas.add(new DatoColumna(Project.CHARTLABEL,String.class));
			columnas.add(new DatoColumna(Project.TCV,Double.class));
			columnas.add(new DatoColumna(Project.PRIORITY,Integer.class));
			columnas.add(new DatoColumna(Project.PROBABILITY,Integer.class));
			columnas.add(new DatoColumna(Project.PLANNEDINITDATE,Date.class));
			columnas.add(new DatoColumna(Project.PLANNEDFINISHDATE,Date.class));
			columnas.add(new DatoColumna(Projectactivity.PLANINITDATE,Date.class));
			columnas.add(new DatoColumna(Projectactivity.PLANENDDATE,Date.class));
			columnas.add(new DatoColumna(Project.EFFORT,Integer.class));
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
			
			// Filter columns
			columnas.add(new DatoColumna(Project.PERFORMINGORG,String.class));
			columnas.add(new DatoColumna(Project.CUSTOMER,String.class));
			columnas.add(new DatoColumna(Project.INTERNALPROJECT,Boolean.class));
			columnas.add(new DatoColumna(Project.BUDGETYEAR,Integer.class));
			columnas.add(new DatoColumna("customer.idCustomer",String.class,List.class));
			columnas.add(new DatoColumna("program.idProgram",String.class,List.class));
			columnas.add(new DatoColumna("employeeByProjectManager.idEmployee",String.class,List.class));
			columnas.add(new DatoColumna("employeeBySponsor.idEmployee",String.class,List.class));
			columnas.add(new DatoColumna("category.idCategory",String.class,List.class));
			columnas.add(new DatoColumna("geography.idGeography",String.class,List.class));
			columnas.add(new DatoColumna("seller.idSeller",String.class,List.class,Project.PROCUREMENTPAYMENTSES));
			columnas.add(new DatoColumna("customertype.idCustomerType",String.class,List.class,Project.CUSTOMER));
			columnas.add(new DatoColumna(Project.IDPROJECT,String.class,List.class));
			columnas.add(new DatoColumna("fundingsource.idFundingSource",String.class,List.class));
			
			String[] sinceUntil = {Projectactivity.PLANINITDATE,Projectactivity.PLANENDDATE};
			columnas.add(new DatoColumna(sinceUntil,List.class,Date.class));
			
			PaginacionUtil paginacion = new PaginacionUtil(req, columnas, Project.class);
			
			if (SecurityUtil.isUserInRole(req, Constants.ROLE_PMO) || SecurityUtil.isUserInRole(req, Constants.ROLE_FM)) {	// PMO or Functional Manager

				paginacion.addFiltro(new DatoColumna(Project.PERFORMINGORG,Performingorg.class,user.getPerformingorg()));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PORFM)) {	// Porfolio Manager
				
				Company company = CompanyLogic.searchByEmployee(user);
				paginacion.addFiltro(new DatoColumna(Performingorg.COMPANY,Company.class,company, Project.PERFORMINGORG));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_IM)) {	// Investment Manager
				
				paginacion.addFiltro(new DatoColumna(Project.EMPLOYEEBYINVESTMENTMANAGER,Employee.class,user));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_SPONSOR)) {	// Sponsor
				
				paginacion.addFiltro(new DatoColumna(Project.EMPLOYEEBYSPONSOR,Employee.class,user));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PROGM)) {	// Program Manager
				
				List<Program> programs = ProgramLogic.consByProgramManager(user);
				
				StringBuilder sb = new StringBuilder();
				
				if (programs.isEmpty()) {
					sb.append("-1");
				}
				else {
					for (Program prg : programs) {
						if (ValidateUtil.isNull(sb.toString())) {
							sb.append(prg.getIdProgram());
						}
						else {
							sb.append(StringPool.COMMA+prg.getIdProgram());
						}
					}
				}
				DatoColumna dato = new DatoColumna("program.idProgram",String.class,List.class);
				dato.setValor(sb.toString());
				paginacion.addFiltro(dato);
			}
			
			FiltroTabla filter	= paginacion.crearFiltro();
			
			List<Project> lista	= ProjectLogic.filter(filter,null);
			
			if (paginacion.isInfoTable()) {
				
				StringBuilder sb = new StringBuilder();
				
				for (Project item : lista) {
					
					if (sb.toString().equals(StringPool.BLANK)) {
						sb.append(item.getIdProject());
					}
					else {
						sb.append(","+item.getIdProject());
					}
				}
				
				JSONObject json = new JSONObject();
				
				if (filter.getOrden() != null && !filter.getOrden().isEmpty()) {
					
					DatoColumna dato = filter.getOrden().get(0);
					
					json.put("propiedad", dato.getNombre());
					json.put("orden", dato.getValor());	
				}
				else {
					json.put("propiedad", Project.IDPROJECT);
					json.put("orden", "desc");	
				}

				json.put("ids", sb.toString());
				
				out.print(json.toString());
			}
			else {
				JSONArray projectsJSON = new JSONArray();
				
				for (Project item : lista) {
					
					String state = idioma.getString("investments.status."+
							(item.getInvestmentStatus()== null?Constants.INVESTMENT_IN_PROCESS:item.getInvestmentStatus())
						);
					
					Projectactivity rootActivity = item.getRootActivity();
					JSONArray projectJSON = new JSONArray();
					projectJSON.add(item.getIdProject());
					projectJSON.add(state);
					projectJSON.add(ValidateUtil.escape(item.getAccountingCode()));
					projectJSON.add(ValidateUtil.escape(item.getProjectName()));
					projectJSON.add(ValidateUtil.escape(item.getChartLabel()));
					projectJSON.add(ValidateUtil.toCurrency(item.getTcv()));
					projectJSON.add(item.getPriority());
					projectJSON.add(item.getProbability());
					projectJSON.add(dateFormat.format(item.getPlannedInitDate()));
					projectJSON.add(dateFormat.format(item.getPlannedFinishDate()));
					
					Date start = null;
					Date finish = null;
					if (Constants.STATUS_INITIATING == item.getStatus()) {
						start	= item.getPlannedInitDate();
						finish	= item.getPlannedFinishDate();
					}
					else if (Constants.STATUS_PLANNING == item.getStatus() && rootActivity != null) {
						start	= rootActivity.getPlanInitDate();
						finish	= rootActivity.getPlanEndDate();
					}
					else if (Constants.STATUS_CONTROL == item.getStatus() && rootActivity != null) {
						start	= (rootActivity.getActualInitDate() == null? rootActivity.getPlanInitDate():rootActivity.getActualInitDate());
						finish	= rootActivity.getPlanEndDate();
					}
					else if (rootActivity != null) {
						start	= rootActivity.getActualInitDate();
						finish	= rootActivity.getActualEndDate();
					}
					projectJSON.add(start != null? dateFormat.format(start):StringPool.BLANK);
					projectJSON.add(finish != null? dateFormat.format(finish):StringPool.BLANK);

					projectJSON.add(item.getEffort());
					projectJSON.add(ValidateUtil.toCurrency(item.getExternalCosts()));
					projectJSON.add(StringPool.BLANK);
					projectsJSON.add(projectJSON);
				}
				
				int total		 = ProjectLogic.findTotal(paginacion.getFiltros());
				int totalFilter	 = ProjectLogic.findTotalFiltered(filter);
				double sumBudget = ProjectLogic.sumProperty(filter, Project.TCV);
				
				out.print(paginacion.obtenerDatos(projectsJSON, total, totalFilter, sumBudget));
			}
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e);	}
		finally { out.close(); }
	}


	private void filterTableProjectsJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			Employee user = SecurityUtil.consUser(req);
			
			ArrayList<DatoColumna > columnas = new ArrayList<DatoColumna>();
			
			// Real Columns
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
			columnas.add(new DatoColumna(Project.STATUS,List.class));
			columnas.add(new DatoColumna(Project.ACCOUNTINGCODE,String.class));
			columnas.add(new DatoColumna(Project.PROJECTNAME,String.class));
			columnas.add(new DatoColumna(Project.CHARTLABEL,String.class));
			columnas.add(new DatoColumna(Project.TCV,Double.class));
			columnas.add(new DatoColumna(Project.PRIORITY,Integer.class));
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
			columnas.add(new DatoColumna(Project.PLANNEDINITDATE,Date.class));
			columnas.add(new DatoColumna(Project.PLANNEDFINISHDATE,Date.class));
			columnas.add(new DatoColumna(Projectactivity.PLANINITDATE,Date.class));
			columnas.add(new DatoColumna(Projectactivity.PLANENDDATE,Date.class));
			columnas.add(new DatoColumna(Project.EFFORT,Integer.class));
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
			
			// Filter columns
			columnas.add(new DatoColumna(Project.PERFORMINGORG,String.class));
			columnas.add(new DatoColumna(Project.CUSTOMER,String.class));
			columnas.add(new DatoColumna(Project.INTERNALPROJECT,Boolean.class));
			columnas.add(new DatoColumna(Project.BUDGETYEAR,Integer.class));
			columnas.add(new DatoColumna("customer.idCustomer",String.class,List.class));
			columnas.add(new DatoColumna("program.idProgram",String.class,List.class));
			columnas.add(new DatoColumna("employeeByProjectManager.idEmployee",String.class,List.class));
			columnas.add(new DatoColumna("employeeBySponsor.idEmployee",String.class,List.class));
			columnas.add(new DatoColumna("category.idCategory",String.class,List.class));
			columnas.add(new DatoColumna("geography.idGeography",String.class,List.class));
			columnas.add(new DatoColumna("seller.idSeller",String.class,List.class,Project.PROCUREMENTPAYMENTSES));
			columnas.add(new DatoColumna("customertype.idCustomerType",String.class,List.class,Project.CUSTOMER));
			columnas.add(new DatoColumna(Project.IDPROJECT,String.class,List.class));
			columnas.add(new DatoColumna("fundingsource.idFundingSource",String.class,List.class));
			
			String[] sinceUntil = {Projectactivity.PLANINITDATE,Projectactivity.PLANENDDATE};
			columnas.add(new DatoColumna(sinceUntil,List.class,Date.class));
			
			ArrayList<String > joins = new ArrayList<String>();
			joins.add(Project.PERFORMINGORG);
			joins.add(Project.CUSTOMER);
			
			PaginacionUtil paginacion = new PaginacionUtil(req, columnas, Project.class, joins);
			
			if (SecurityUtil.isUserInRole(req, Constants.ROLE_PMO) || SecurityUtil.isUserInRole(req, Constants.ROLE_FM)) {	// PMO or Functional Manager
				
				paginacion.addFiltro(new DatoColumna(Project.PERFORMINGORG,Performingorg.class,user.getPerformingorg()));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PORFM)) {	// Porfolio Manager
				
				Company company = CompanyLogic.searchByEmployee(user);
				paginacion.addFiltro(new DatoColumna(Performingorg.COMPANY,Company.class,company, Project.PERFORMINGORG));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_IM)) {	// Investment Manager
				
				paginacion.addFiltro(new DatoColumna(Project.EMPLOYEEBYINVESTMENTMANAGER,Employee.class,user));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) {	// Project Manager
				
				paginacion.addFiltro(new DatoColumna(Project.EMPLOYEEBYPROJECTMANAGER,Employee.class,user));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_SPONSOR)) {	// Sponsor
				
				paginacion.addFiltro(new DatoColumna(Project.EMPLOYEEBYSPONSOR,Employee.class,user));
			}
			else if (SecurityUtil.isUserInRole(req, Constants.ROLE_PROGM)) {	// Program Manager
				
				List<Program> programs = ProgramLogic.consByProgramManager(user);
				
				StringBuilder sb = new StringBuilder();
				
				if (programs.isEmpty()) {
					sb.append("-1");
				}
				else {
					for (Program prg : programs) {
						if (ValidateUtil.isNull(sb.toString())) {
							sb.append(prg.getIdProgram());
						}
						else {
							sb.append(StringPool.COMMA+prg.getIdProgram());
						}
					}
				}
				
				DatoColumna dato = new DatoColumna("program.idProgram",String.class,List.class);
				dato.setValor(sb.toString());
				paginacion.addFiltro(dato);
			}
			
			FiltroTabla filter	= paginacion.crearFiltro();
			List<Project> lista	= ProjectLogic.filter(filter,joins);
			
			if (paginacion.isInfoTable()) {
				
				StringBuilder sb = new StringBuilder();
				
				for (Project item : lista) {
					
					if (sb.toString().equals(StringPool.BLANK)) {
						sb.append(item.getIdProject());
					}
					else {
						sb.append(","+item.getIdProject());
					}
				}
				
				JSONObject json = new JSONObject();
				
				if (filter.getOrden() != null && !filter.getOrden().isEmpty()) {
					
					DatoColumna dato = filter.getOrden().get(0);
					
					json.put("propiedad", dato.getNombre());
					json.put("orden", dato.getValor());	
				}
				else {
					json.put("propiedad", Project.IDPROJECT);
					json.put("orden", "desc");	
				}
				
				json.put("ids", sb.toString());

				out.print(json.toString());
			}
			else {
				
				JSONArray porjectsJSON = new JSONArray();
				
				for (Project item : lista) {
					
					Projectactivity rootActivity = item.getRootActivity();
					Projectfollowup lastFollowup = item.getLastFollowup();
					
					Character risk = (lastFollowup != null && lastFollowup.getGeneralFlag() != null
							?lastFollowup.getGeneralFlag():null);
					
					String generalRisk = StringPool.BLANK;
					
					if (risk != null) {
						if (risk.equals(Constants.RISK_LOW)) { generalRisk = "low_importance"; }
						else if (risk.equals(Constants.RISK_MEDIUM)) { generalRisk = "medium_importance"; }
						else if (risk.equals(Constants.RISK_HIGH)) { generalRisk = "high_importance"; }
						else if (risk.equals(Constants.RISK_NORMAL)) { generalRisk = "normal_importance"; }
						generalRisk = "<div class='"+generalRisk+"'>&nbsp;&nbsp;&nbsp;</div>";
					}
					
					JSONArray projectJSON = new JSONArray();
					projectJSON.add(item.getIdProject());
					projectJSON.add(item.getStatus());
					projectJSON.add(generalRisk);
					projectJSON.add(idioma.getString("project_status."+item.getStatus()));
					projectJSON.add(ValidateUtil.escape(item.getAccountingCode()));
					projectJSON.add(ValidateUtil.escape(item.getProjectName()));
					projectJSON.add(ValidateUtil.escape(item.getChartLabel()));
					projectJSON.add(ValidateUtil.toCurrency(item.getTcv()));
					projectJSON.add(item.getPriority());
					projectJSON.add(ValidateUtil.toPercent(item.getPOC()/100));
					projectJSON.add(
							item.getPlannedInitDate() != null?
							dateFormat.format(item.getPlannedInitDate()):StringPool.BLANK
						);
					projectJSON.add(
							item.getPlannedFinishDate() != null?
							dateFormat.format(item.getPlannedFinishDate()):StringPool.BLANK
						);
					
					Date start = null;
					Date finish = null;
					if (Constants.STATUS_INITIATING == item.getStatus()) {
						start	= item.getPlannedInitDate();
						finish	= item.getPlannedFinishDate();
					}
					else if (Constants.STATUS_PLANNING == item.getStatus() && rootActivity != null) {
						start	= rootActivity.getPlanInitDate();
						finish	= rootActivity.getPlanEndDate();
					}
					else if (Constants.STATUS_CONTROL == item.getStatus() && rootActivity != null) {
						start	= (rootActivity.getActualInitDate() == null? rootActivity.getPlanInitDate():rootActivity.getActualInitDate());
						finish	= rootActivity.getPlanEndDate();
					}
					else if (rootActivity != null) {
						start	= rootActivity.getActualInitDate();
						finish	= rootActivity.getActualEndDate();
					}
					projectJSON.add(start != null? dateFormat.format(start):StringPool.BLANK);
					projectJSON.add(finish != null? dateFormat.format(finish):StringPool.BLANK);
					
					if (Settings.PROJECT_COL_AC) {
						ProjectFollowupLogic followupLogic = new ProjectFollowupLogic();
						Projectfollowup followup = followupLogic.findLastByProjectWithAC(item);
						
						projectJSON.add(ValidateUtil.toCurrency(followup == null?null:followup.getAc()));
					}
					else { projectJSON.add(StringPool.BLANK); }
					
					projectJSON.add(item.getEffort());
					projectJSON.add(ValidateUtil.toCurrency(item.getExternalCosts()));
					projectJSON.add(StringPool.BLANK);
					porjectsJSON.add(projectJSON);
				}
				
				int total		= ProjectLogic.findTotal(paginacion.getFiltros());
				int totalFilter = ProjectLogic.findTotalFiltered(filter);
				
				double sumBudget = ProjectLogic.sumProperty(filter, Project.TCV);
				
				out.print(paginacion.obtenerDatos(porjectsJSON, total, totalFilter, sumBudget));
			}
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e);	}
		finally { out.close(); }
	}

	/**
     * Save customer
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveCustomerJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    	String customerName	 = ParamUtil.getString(req, "customer_name", null);
    	int idCustomerType	 = ParamUtil.getInteger(req, "customer_type", -1);
    	
    	PrintWriter out = resp.getWriter();
		resp.setContentType("application/json");
		
		try {
			
			if (customerName == null || idCustomerType == -1) {
				throw new NoDataFoundException();
			}
			
			Customer customer = new Customer();
			customer.setName(customerName);
			customer.setCustomertype(new Customertype(idCustomerType));
			
			Company company = CompanyLogic.searchByEmployee(SecurityUtil.consUser(req));
			customer.setCompany(company);
			
			CustomerLogic.saveCustomer(customer);
			
			JSONObject customerJSON = new JSONObject();
			customerJSON.put("id", customer.getIdCustomer());
			
			out.print(customerJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}


	/**
     * Check duplicate code of project
     * @param req
     * @param resp
     * @throws IOException
     */
    private void checkCodeJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {

//    	String code = ParamUtil.getString(req, "code", null);
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			//if (!ProjectLogic.checkCode(code)) {
			//	throw new ProjectCodeInUseException();
			//}
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}


	/**
     * Create new project
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void createProject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    	Integer idPerfOrg		= ParamUtil.getInteger(req, Project.PERFORMINGORG, null);
    	Date plannedInitDate 	= ParamUtil.getDate(req, Project.PLANNEDINITDATE, dateFormat, null);
    	Date plannedFinishDate	= ParamUtil.getDate(req, Project.PLANNEDFINISHDATE, dateFormat, null);
    	String accountingCode 	= ParamUtil.getString(req, Project.ACCOUNTINGCODE, null);
    	String projectName		= ParamUtil.getString(req, Project.PROJECTNAME, null);
    	String chartLabel		= ParamUtil.getString(req, Project.CHARTLABEL, null);
    	Integer idProgram		= ParamUtil.getInteger(req, Project.PROGRAM, null);
    	Integer idCustomer		= ParamUtil.getInteger(req, Project.CUSTOMER, null);
    	Integer idCategory		= ParamUtil.getInteger(req, Project.CATEGORY, null);
    	int funcionalManager	= ParamUtil.getInteger(req, Project.EMPLOYEEBYFUNCTIONALMANAGER, -1);
    	int sponsor				= ParamUtil.getInteger(req, Project.EMPLOYEEBYSPONSOR, -1);
    	int projectManager		= ParamUtil.getInteger(req, Project.EMPLOYEEBYPROJECTMANAGER, -1);
    	int investmentManager	= ParamUtil.getInteger(req, Project.EMPLOYEEBYINVESTMENTMANAGER, -1);
    	double tcv				= ParamUtil.getCurrency(req, Project.TCV,0);
    	Integer duration		= ParamUtil.getInteger(req, Project.DURATION, null);
    	Integer priority		= ParamUtil.getInteger(req, Project.PRIORITY, 0);
    	Integer probability		= ParamUtil.getInteger(req, Project.PROBABILITY, 0);
    	Integer budgetYear		= ParamUtil.getInteger(req, Project.BUDGETYEAR,null);
    	
    	
    	if (SecurityUtil.isUserInRole(req, Constants.ROLE_PMO) ||
    			SecurityUtil.isUserInRole(req, Constants.ROLE_IM) ||
    			SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) {		// cnw us4 adding permission to PM to create project
			
			Project proj = new Project();

			proj.setStatus(Constants.STATUS_INITIATING);
			proj.setInitDate(new Date());
			proj.setPlannedInitDate(plannedInitDate);
			proj.setPlannedFinishDate(plannedFinishDate);
			proj.setAccountingCode(accountingCode);
			proj.setProjectName(projectName);
			proj.setChartLabel(chartLabel);
			proj.setTcv(tcv);
			proj.setDuration(duration);
			proj.setPriority(priority);
			proj.setProbability(probability);
			proj.setBudgetYear(budgetYear);
			proj.setInvestmentStatus(Constants.INVESTMENT_IN_PROCESS);
			proj.setInternalProject(false);
			
			if (idPerfOrg != null) {
				proj.setPerformingorg(new Performingorg(idPerfOrg));
			}
			if (funcionalManager != -1) {
				proj.setEmployeeByFunctionalManager(new Employee(funcionalManager));
			}
			if (sponsor != -1) {
				proj.setEmployeeBySponsor(new Employee(sponsor));
			}
			if (projectManager != -1) {
				proj.setEmployeeByProjectManager(new Employee(projectManager));
			}
			if (investmentManager != -1) {
				proj.setEmployeeByInvestmentManager(new Employee(investmentManager));
			}
			if (idCategory != null) {
				proj.setCategory(new Category(idCategory));
			}
			if (idCustomer != null) {
				proj.setCustomer(new Customer(idCustomer));
			}
			if (idProgram != null) {
				proj.setProgram(new Program(idProgram));
			}
			
			try {
				proj = ProjectLogic.createProject(proj);
				
				LogprojectstatusLogic logstatusLogic = new LogprojectstatusLogic();
				logstatusLogic.save(new Logprojectstatus(
						proj,getUser(req), Constants.STATUS_INITIATING,Constants.INVESTMENT_IN_PROCESS, new Date()));
				
				if (!proj.getAccountingCode().equals(StringPool.BLANK) && ProjectLogic.accountingCodeInUse(proj, getUser(req))) {
					info(req, "msg.info.accounting_code_in_use", proj.getAccountingCode());
				}
				if (ProjectLogic.chartLabelInUse(proj, getUser(req))) {
					info(req, "msg.info.in_use", "project.chart_label", proj.getChartLabel());
				}
			}
			catch (Exception e) {
				ExceptionUtil.evalueException(req, idioma, LOGGER, e);
			}
			String type = ParamUtil.getString(req, "type");
			forwardServlet(ProjectInitServlet.REFERENCE+"?accion=&type="+type+"&id="+proj.getIdProject(), req, resp);
		}
		else {
			req.setAttribute(StringPool.ERROR, idioma.getString("msg.error.permission.create_project"));
			req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
			forward("/index.jsp", req, resp);
		}
	}


	/**
     * Save document project
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveDocumentJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	int idDocumentProject	= ParamUtil.getInteger(req, Documentproject.IDDOCUMENTPROJECT, -1);
    	int idProject			= ParamUtil.getInteger(req, Documentproject.PROJECT, -1);
    	String type				= ParamUtil.getString(req, Documentproject.TYPE, null);
		String link				= ParamUtil.getString(req, Documentproject.LINK);
    	
		PrintWriter out = resp.getWriter();
		
		try {
			
			Documentproject doc = DocumentprojectLogic.saveDocumentproject(
					idDocumentProject,
					idProject,
					type,
					link
				);
			out.print(JsonUtil.toJSON(Documentproject.IDDOCUMENTPROJECT, doc.getIdDocumentProject()));
		}
		catch (Exception e) {
			ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e);
		}
		finally { out.close(); }
	}


	/**
     * Delete project in initiating
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
	private void deleteProject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int idProject = ParamUtil.getInteger(req, "id",-1);
		
		try {
			
			ProjectLogic.deleteProject(new Project(idProject));
		} 
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewProjects(req, resp, LIST_PROJECTS);
	}


	private void viewCreateProjectForm(HttpServletRequest req,
			HttpServletResponse resp, String accion) throws ServletException, IOException {
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		
		if (SecurityUtil.isUserInRole(req, Constants.ROLE_PMO) ||
				SecurityUtil.isUserInRole(req, Constants.ROLE_IM) ||
				SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) {	// cnw us4 adding permission to PM to view create project form
			try {
				Employee user = SecurityUtil.consUser(req);
				Company company = CompanyLogic.searchByEmployee(user);
				
				CategoryLogic categoryLogic = new CategoryLogic();
				ResourceProfilesLogic resourceProfilesLogic = new ResourceProfilesLogic();
				PerformingOrgLogic performingOrgLogic = new PerformingOrgLogic();
				
				req.setAttribute("customers", CustomerLogic.searchByCompany(company));
				req.setAttribute("customertypes", CustomertypeLogic.findByCompany(user));
				req.setAttribute("profiles", resourceProfilesLogic.findAll());
				req.setAttribute("programs", ProgramLogic.searchByPerfOrg(user.getPerformingorg()));
				req.setAttribute("categories", categoryLogic.findByRelation(Category.COMPANY, company));
				req.setAttribute("perforgs", performingOrgLogic.findByRelation(Performingorg.COMPANY, company));
				
				
				if (NEW_PROJECT.equals(accion)) {
					req.setAttribute("title", idioma.getString("title.new_project"));
					req.setAttribute("type", Constants.TYPE_PROJECT);
				}
				else {
					req.setAttribute("title", idioma.getString("title.new_investment"));
					req.setAttribute("type", Constants.TYPE_INVESTMENT);
				}
			} 
			catch (Exception e) {
				ExceptionUtil.evalueException(req, idioma, LOGGER, e);
			}
			
			forward("/index.jsp?nextForm=project/new_project", req, resp);
		}
		else {
			req.setAttribute(StringPool.ERROR, idioma.getString("msg.error.permission.create_project"));
			forward("/index.jsp", req, resp);
		}
	}


	private void viewProjects(HttpServletRequest req, HttpServletResponse resp, String accion) throws ServletException, IOException {
		
		Employee user = SecurityUtil.consUser(req);
		
		if ((SecurityUtil.isUserInRole(req, Constants.ROLE_PMO)) || 	// PMO
			(SecurityUtil.isUserInRole(req, Constants.ROLE_IM)) || 		// Investment Manager
			(SecurityUtil.isUserInRole(req, Constants.ROLE_PORFM)) || 	// Porfolio Manager
			(SecurityUtil.isUserInRole(req, Constants.ROLE_PM)) || 		// Project Manager
			(SecurityUtil.isUserInRole(req, Constants.ROLE_PROGM)) ||	// Program Manager 
			(SecurityUtil.isUserInRole(req, Constants.ROLE_FM)) ||		// Functional Manager 
			(SecurityUtil.isUserInRole(req, Constants.ROLE_SPONSOR))) {	// Sponsor
			
			List<Customertype> cusType	 = null;
			List<Customer> customers	 = null;
			List<Category> categories	 = null;
			List<Program> programs		 = null;
			List<Employee> projtManagers = null;
			List<Seller> sellers		 = null;
			List<Geography> geographys	 = null;
			List<Employee> sponsors		 = null;
			List<Fundingsource> fundingSources = null;
			
			try {
				
				Company company = CompanyLogic.searchByEmployee(user);

				CategoryLogic categoryLogic = new CategoryLogic();
				GeographyLogic geoLogic = new GeographyLogic();
				
				if (SecurityUtil.isUserInRole(req, Constants.ROLE_PORFM)) {
					
					List<String> joins = new ArrayList<String>();
					joins.add(Program.EMPLOYEE);
					joins.add(Program.EMPLOYEE+"."+Employee.CONTACT);
					
					programs = ProgramLogic.consByCompany(user, joins);
				}
				else { programs	= ProgramLogic.consByPO(user); }
				
				cusType			= CustomertypeLogic.findByCompany(user);
				customers		= CustomerLogic.searchByCompany(company);
//		         XL 2015-04-17 UserStory 23 Trier la liste des categories		
//				categories		= categoryLogic.findByRelation(Category.COMPANY, company);				
				categories		= categoryLogic.findByRelation(Category.COMPANY, company,Category.NAME, Constants.ASCENDENT);
				projtManagers	= EmployeeLogic.findByPOAndRol(user.getPerformingorg(), Constants.ROLE_PM);
				sponsors		= EmployeeLogic.findByPOAndRol(user.getPerformingorg(), Constants.ROLE_SPONSOR);
//   XL 2015-04-22  UserStory 23 trier la liste des sellers 
//				sellers			= SellerLogic.searchByCompany(company);
				sellers			= SellerLogic.searchByCompany(company,Seller.NAME, Constants.ASCENDENT);
//				geographys	 	= geoLogic.findByRelation(Geography.COMPANY, company);
				geographys	 	= geoLogic.findByRelation(Geography.COMPANY, company,Geography.NAME,Constants.ASCENDENT);
				fundingSources	= FundingsourceLogic.findByCompany(user);
			}
			catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
			
			req.setAttribute("cusType", cusType);
			req.setAttribute("customers", customers);
			req.setAttribute("categories", categories);
			req.setAttribute("programs", programs);
			req.setAttribute("projectManagers", projtManagers);
			req.setAttribute("sellers", sellers);
			req.setAttribute("geographys", geographys);
			req.setAttribute("sponsors", sponsors);
			req.setAttribute("fundingSources", fundingSources);
			
			req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
			
			if (LIST_INVESTMENTS.equals(accion)) {
				
				req.setAttribute("title", idioma.getString("investments"));
				forward("/index.jsp?nextForm=project/list_investments", req, resp);
			}
			else {
				req.setAttribute("title", idioma.getString("projects"));
				forward("/index.jsp?nextForm=project/list_projects", req, resp);
			}
		}
		else {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}


	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void generateStatusReport(HttpServletRequest req, HttpServletResponse resp) 
	throws ServletException, IOException {
		
		boolean error = false;
		byte[] zipBytes = null;

		try {
			ParamUtil.print(req);
			
			String strIds	= ParamUtil.getString(req, "ids");

			Integer[] idsList = StringUtil.splitStrToIntegers(strIds, null);
			Employee user = SecurityUtil.consUser(req);
			
			if (idsList != null) {
				List<File> chartersFiles = new ArrayList<File>(); 
				
				String[] joins = new String[9];
				joins[0] = Project.CUSTOMER;
				joins[1] = Project.CUSTOMER + "." + Customer.CUSTOMERTYPE;
				joins[2] = Project.PROGRAM;
				joins[3] = Project.EMPLOYEEBYPROJECTMANAGER;
				joins[4] = Project.EMPLOYEEBYPROJECTMANAGER + "." + Employee.CONTACT;
				joins[5] = Project.EMPLOYEEBYSPONSOR;
				joins[6] = Project.EMPLOYEEBYSPONSOR + "." + Employee.CONTACT;
				joins[7] = Project.CATEGORY;
				joins[8] = Project.GEOGRAPHY;
				
				List<Project> lista = ProjectLogic.consList(idsList, null, null, null);
				
				for (Project proj : lista) {
			
					Projectcharter projCharter = ProjectCharterLogic.findByProject(proj);
					
					ProjectCharterTemplate projCharterTemplate = ProjectCharterTemplate.getProjectChaterTemplate();
					
					File charterDocFile = projCharterTemplate.generateCharter(
							idioma, proj, projCharter, user.getContact().getFullName());
					
					if (charterDocFile != null) {
						chartersFiles.add(charterDocFile);
					}
				}
				
				if (!chartersFiles.isEmpty()) {
					zipBytes = DocumentUtils.zipFiles(chartersFiles);
				}
			}
			else {
				info(req, "msg.error.not_for_showing", "projects","executive_report");
			}
		}
		catch (Exception e) {
			error = true;
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		if (zipBytes != null && !error) {
			sendFile(req, resp, zipBytes, "executive_reports.zip");
		}
		else {
			viewProjects (req, resp, "");
		}
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void uploadFileSystem(HttpServletRequest req, HttpServletResponse resp, Hashtable<String, FileItem> reqFields) 
	throws ServletException, IOException {
		
		int idProject = Integer.parseInt(reqFields.get("projectId").getString());
		int docId = Integer.parseInt(reqFields.get("docId").getString());		
		String docType = reqFields.get("docType").getString();
		String oldName = "";		
		
		PrintWriter out = resp.getWriter();
		resp.setContentType("text/plain");
		
		Documentproject doc =  new Documentproject();
		DocumentprojectLogic documentprojectLogic = new DocumentprojectLogic();
		
		try {			
			FileItem dataFile = reqFields.get("file");			
			
			if (dataFile != null && dataFile.getSize() > 0) {	
				
				if(docId != -1) {					
					doc = documentprojectLogic.findById(docId, false);
					oldName = doc.getIdDocumentProject() + "_" + (doc.getName().lastIndexOf("\\") != -1 ? doc.getName().substring(doc.getName().lastIndexOf("\\") + 1) : doc.getName());
				}
				
				doc.setProject(new Project(idProject));
				doc.setName(dataFile.getName().lastIndexOf("\\") != -1 ? dataFile.getName().substring(dataFile.getName().lastIndexOf("\\") + 1) : dataFile.getName());
				doc.setExtension(FilenameUtils.getExtension(dataFile.getName()));
				doc.setMime(dataFile.getContentType());
				doc.setType(docType);
				
				doc = documentprojectLogic.save(doc);				
				
				String newName = doc.getIdDocumentProject() + "_" + (doc.getName().lastIndexOf("\\") != -1 ? doc.getName().substring(doc.getName().lastIndexOf("\\") + 1) : doc.getName());
				
				File file = new File(Constants.DOCUMENT_FOLDER, doc.getIdDocumentProject() + "_" + (dataFile.getName().lastIndexOf("\\") != -1 ? dataFile.getName().substring(dataFile.getName().lastIndexOf("\\") + 1) : dataFile.getName()));
				dataFile.write(file);
				
				if(!oldName.equals(newName)) {
					file = new File(Constants.DOCUMENT_FOLDER + "\\" + oldName);
					file.delete();
				}
				
				JSONObject docJSON = new JSONObject();
				docJSON.put(Documentproject.IDDOCUMENTPROJECT, doc.getIdDocumentProject());
				docJSON.put(Documentproject.NAME, (doc.getName().lastIndexOf("\\") != -1 ? doc.getName().substring(doc.getName().lastIndexOf("\\") + 1) : doc.getName()));
				
				out.print(docJSON);
			}
		}		
		catch (Exception e) {
			try {				
				documentprojectLogic.delete(doc);				
			} catch (Exception e1) {
				ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e1);	
			}
			ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e);			
		} 
		finally {
			out.close();
		}	
	}
	
	// Download document 
	private void downloadDocument(HttpServletRequest req, HttpServletResponse resp) 
	throws ServletException, IOException {
		Integer idDoc = ParamUtil.getInteger(req, "idDocument");
		File file = null;
		Documentproject doc = null;
		
		try {
			DocumentprojectLogic documentprojectLogic = new DocumentprojectLogic();
			doc = documentprojectLogic.findById(idDoc, false);
			file = new File(Constants.DOCUMENT_FOLDER + 
					File.separator + doc.getIdDocumentProject() + "_" + doc.getName());					
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
        sendFile(req, resp, DocumentUtils.getBytesFromFile(file), doc.getName());
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteFileSystem(HttpServletRequest req, HttpServletResponse resp) 
	throws ServletException, IOException {
		
		Integer idDoc = ParamUtil.getInteger(req, Documentproject.IDDOCUMENTPROJECT);
		File file = null;
		boolean deleted = false;
		
		PrintWriter out = resp.getWriter();		
		
		try {
			DocumentprojectLogic documentprojectLogic = new DocumentprojectLogic();
			Documentproject doc =  documentprojectLogic.findById(idDoc, false);			
			file = new File(Constants.DOCUMENT_FOLDER + 
					File.separator + doc.getIdDocumentProject() + "_" + doc.getName());

			if (!file.exists()) {
				DocumentprojectLogic.deleteDocumentproject(doc);
			}
			else if (!file.canWrite()) {
		    	throw new LogicException("msg.error.document_read");
		    }		 			  
		    else {
		    	deleted = file.delete();				
				if(deleted) {
					DocumentprojectLogic.deleteDocumentproject(doc);
				}
		    }		
			
		    out.print(infoDeleted("document"));			
		}
		catch (Exception e) {
			ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e);
		}		
		finally { out.close(); }
	}
}
