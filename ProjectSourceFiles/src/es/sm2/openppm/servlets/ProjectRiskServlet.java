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
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.logic.AssumptionLogLogic;
import es.sm2.openppm.logic.AssumptionRegisterLogic;
import es.sm2.openppm.logic.DocumentprojectLogic;
import es.sm2.openppm.logic.IssuelogLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.RiskCategoriesLogic;
import es.sm2.openppm.logic.RiskReassessmentLogLogic;
import es.sm2.openppm.logic.RiskRegisterLogic;
import es.sm2.openppm.model.Assumptionreassessmentlog;
import es.sm2.openppm.model.Assumptionregister;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Issuelog;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Riskcategories;
import es.sm2.openppm.model.Riskreassessmentlog;
import es.sm2.openppm.model.Riskregister;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JSONModelUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;

/**
 * Servlet implementation class ProjectManageRisksServlet
 */
public class ProjectRiskServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
    
	public final static Logger LOGGER = Logger.getLogger(ProjectRiskServlet.class);
	
	public final static String REFERENCE 			= "projectrisk";
	
	/***************** Actions ****************/
	public final static String DELETE_ASSUMPTION		= "delete-assumption";
	public final static String DELETE_RISK				= "delete-risk";
	public final static String DELETE_ISSUE				= "delete-issue";
	public final static String DELETE_LOG_ASSUMPTION	= "delete-log-assumption";
	public final static String ADD_RISK					= "add-risk";
	public final static String EDIT_RISK				= "edit-risk";	
	public final static String SAVE_RISK				= "save-risk";
	
	/************** Actions AJAX **************/
	public final static String JX_SAVE_ISSUE			= "ajax-save-issue";	
	public final static String JX_SAVE_ASSUMPTION		= "ajax-save-assumption";
	public final static String JX_CONS_LOG_ASSUMPTIONS	= "ajax-cons-log-assumptions";
	public final static String JX_SAVE_ASSUMPTION_LOG	= "ajax-save-assumption-log";
	public final static String JX_SAVE_REASSESSMENT_LOG	= "ajax-save-reassessment-log";
	public final static String JX_CONS_LOG_REASSESSMENT	= "ajax-cons-log-reassessment";
	public final static String JX_DELETE_LOG_REASSESSMENT	= "ajax-delete-log-reassessment";

	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1) {
			
			/***************** Actions ****************/
			if (accion == null || "".equals(accion)) { viewManageRisk(req, resp); }
			if (DELETE_ASSUMPTION.equals(accion)) { deleteAssumption(req, resp); }
			else if (SAVE_RISK.equals(accion)) { saveRisk(req, resp); }
			else if (ADD_RISK.equals(accion)) { addRisk(req, resp); }
			else if (EDIT_RISK.equals(accion)) { editRisk(req, resp); }
			else if(DELETE_RISK.equals(accion)) { deleteRisk(req, resp); }
			else if (DELETE_ISSUE.equals(accion)) { deleteIssue(req, resp); }
			else if (DELETE_LOG_ASSUMPTION.equals(accion)) { deleteLogAssumption(req, resp); }
			
			/************** Actions AJAX **************/			
			else if (JX_DELETE_LOG_REASSESSMENT.equals(accion)) { deleteLogReassessmentJX(req, resp); }
			else if (JX_SAVE_ASSUMPTION.equals(accion)) { saveAssumptionJX(req, resp); }
			else if (JX_SAVE_ISSUE.equals(accion)) { saveIssueJX(req, resp); }
			else if (JX_CONS_LOG_ASSUMPTIONS.equals(accion)) { consultLogAssumptionJX(req, resp); }			
			else if (JX_SAVE_ASSUMPTION_LOG.equals(accion)) { saveAssumptionLogJX(req, resp); }			
			else if (JX_CONS_LOG_REASSESSMENT.equals(accion)) { consultLogRessessmentJX(req, resp); }
			else if (JX_SAVE_REASSESSMENT_LOG.equals(accion)) { saveLogRessessmentJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
    }


	private void viewManageRisk(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		Integer idProject = ParamUtil.getInteger(req, "id", null);
		
		Project project = null;
		List<Assumptionregister> assumptions = null;
		List<Riskregister> risks = null;
		List<Riskcategories> riskCategories = null;
		List<Issuelog> issues = null;
		List<Documentproject> docs = null;
		
		if (idProject == null) {
			idProject = ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		}
		
		boolean hasPermission = false;
		
		try {
			
			hasPermission = SecurityUtil.hasPermission(req, new Project(idProject), Constants.TAB_RISK);
			
			if (hasPermission) {
			
				List<String> joins = new ArrayList<String>();
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
				
				project = ProjectLogic.consProject(new Project(idProject), joins);
				
				assumptions = AssumptionRegisterLogic.consAssumptions(project);
				
				RiskRegisterLogic riskRegLogic = new RiskRegisterLogic();
				joins = new ArrayList<String>();
				joins.add(Riskregister.RISKCATEGORIES);
				risks = riskRegLogic.findByRelation(Riskregister.PROJECT, project, joins);
				
				RiskCategoriesLogic riskCatLogic = new RiskCategoriesLogic();
				riskCategories = riskCatLogic.findAll();
				
				issues = IssuelogLogic.consIssues(project);
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					docs = new ArrayList<Documentproject>();
					docs.add(DocumentprojectLogic.findByType(project,Constants.DOCUMENT_RISK));	
				}
				else {
					docs = DocumentprojectLogic.findListByType(project, Constants.DOCUMENT_RISK);	
				}
			}
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		if (hasPermission) {
			req.setAttribute("project", project);
			req.setAttribute("assumptions", assumptions);
			req.setAttribute("risks", risks);
			req.setAttribute("riskCategories", riskCategories);
			req.setAttribute("issues", issues);
			if(Constants.DOCUMENT_STORAGE.equals("link")) {
				req.setAttribute("docs", docs.get(0));
			}
			else {
				req.setAttribute("docs", docs);	
			}
			req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
			forward("/index.jsp?nextForm=project/risk/manage_risks_project", req, resp);
		}
		else {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
	/**
	 * Delete assumption
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteAssumption(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer idAssumption = ParamUtil.get(req, "assumption_id", -1);
		
		try {			
			AssumptionRegisterLogic.deleteAssumption(idAssumption);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewManageRisk(req, resp);
	}
	
	/**
	 * Save planning risk
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveRisk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			Riskregister risk = setRiskFromRequest(req);
			RiskRegisterLogic.saveRisk(risk);			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		viewManageRisk(req, resp);
	}
	
	/**
	 * Add planning risk
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void addRisk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setAttribute("showRisk", true);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		viewManageRisk(req, resp);
	}
	
	/**
	 * Edit planning risk
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void editRisk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer idRisk		= ParamUtil.getInteger(req, "risk_id", -1);
		
		try {		
			if(idRisk != -1) {
				RiskRegisterLogic riskRegisterLogic = new RiskRegisterLogic();
				req.setAttribute("risk", riskRegisterLogic.findById(idRisk));
				req.setAttribute("showRisk", true);	
			}				
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewManageRisk(req, resp);
	}
	
	/**
	 * Delete Risk
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteRisk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer idRisk = ParamUtil.get(req, "risk_id", -1);
		
		try {			
			RiskRegisterLogic.deleteRisk(idRisk);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewManageRisk(req, resp);
	}

	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteIssue(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer idIssue = ParamUtil.get(req, "issue_id", -1);
		
		try {			
			IssuelogLogic.deleteIssue(idIssue);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewManageRisk(req, resp);
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteLogAssumption(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer idLog = ParamUtil.get(req, "assumption_log_id", -1);
		
		try {
			AssumptionLogLogic.deleteAssumptionLog(idLog);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewManageRisk(req, resp);
	}
	
	/**
	 * Delete log reassessment
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteLogReassessmentJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		int idLog = ParamUtil.get(req, "reassessment_log_id", -1);
		
		try {			
			RiskReassessmentLogLogic.deleteReassessmentLog(idLog);			
			out.print(infoDeleted("reassessment log"));
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }	
	}
	
	/**
	 * Save assumption register
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveAssumptionJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		
		try {
			Assumptionregister assumption = setAssumptionFromRequest(req);
			AssumptionRegisterLogic.saveAssumption(assumption);
			JSONObject assumptionJSON = JSONModelUtil.assumptionToJSON(assumption);
			out.print(assumptionJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	/**
	 * Save issue log
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveIssueJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		
		try {
			Issuelog issue = setIssueFromRequest(req);
			IssuelogLogic.saveIssue(issue);
			JSONObject issueJSON = JSONModelUtil.issueToJSON(idioma, issue);
			out.print(issueJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	/**
	 * Consult log assumptions of an assumption
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void consultLogAssumptionJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		try {
			Integer idAssumption = ParamUtil.getInteger(req, "assumption_id");
			List<Assumptionreassessmentlog> assumptionLogs = AssumptionLogLogic.consAssumptions(new Assumptionregister(idAssumption));
			
			JSONArray data = new JSONArray();
			for (Assumptionreassessmentlog log : assumptionLogs) {
				data.add(JSONModelUtil.assumptionLogToJSON(idioma, log));
			}
			
			out.print(data);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	/**
	 * Save assumption log
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveAssumptionLogJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		
		try {
			Assumptionreassessmentlog assumptionLog = setAssumptionLogFromRequest(req);
			AssumptionLogLogic.saveAssumptionLog(assumptionLog);
			JSONObject assumptionLogJSON = JSONModelUtil.assumptionLogToJSON(idioma, assumptionLog);
			out.print(assumptionLogJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	/**
	 * Consult Log ressessment
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void consultLogRessessmentJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Integer idRisk = ParamUtil.getInteger(req, "risk_id");
		PrintWriter out = resp.getWriter();
		
		try {			
			List<Riskreassessmentlog> reassessmentLogs = RiskReassessmentLogLogic.consReassessments(new Riskregister(idRisk));
			
			JSONArray data = new JSONArray();
			for (Riskreassessmentlog log : reassessmentLogs) {
				data.add(JSONModelUtil.reassessmentLogToJSON(idioma, log));
			}
			
			out.print(data);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	/**
	 * Save Log ressessment
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveLogRessessmentJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
		
		try {
			Riskreassessmentlog riskLog = setRiskReassessmentLogFromRequest(req);
			RiskReassessmentLogLogic.saveReassessmentLog(riskLog);
			JSONObject assumptionLogJSON = JSONModelUtil.reassessmentLogToJSON(idioma, riskLog);
			out.print(assumptionLogJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	
    /**
     * Set risk register from request
     * @param req
     * @return
     */
    private Riskregister setRiskFromRequest(HttpServletRequest req) {
		Integer idProject 	= ParamUtil.getInteger(req, "id");
    	Integer idRisk		= ParamUtil.getInteger(req, "risk_id", -1);
    	String code			= ParamUtil.getString(req, "risk_code", null);
    	String name			= ParamUtil.getString(req, "risk_name", null);
    	String owner		= ParamUtil.getString(req, "owner", null);
    	Date dateRaised		= ParamUtil.getDate(req, "date_raised", dateFormat, null);
    	Date dueDate		= ParamUtil.getDate(req, "due_date", dateFormat, null);
    	String description	= ParamUtil.getString(req, "description", null);
    	int probability		= ParamUtil.getInteger(req, "probability", 0);
    	int impact			= ParamUtil.getInteger(req, "impact", 0);
    	String status		= ParamUtil.getString(req, "status", null);
    	double potentialCost	= ParamUtil.getCurrency(req, "potential_cost", -1);
    	Integer potentialDelay	= ParamUtil.getInteger(req, "potential_delay", -1);
    	String riskTrigger		= ParamUtil.getString(req, "risk_trigger", null);
    	Integer riskType		= ParamUtil.getInteger(req, "risk_type", -1);
    	Integer response		= ParamUtil.getInteger(req, "response", -1);
    	String mitigationActions = ParamUtil.getString(req, "mitigation_actions", null);
    	double mitigationCost	= ParamUtil.getCurrency(req, "mitigation_cost", -1);
    	String contingencyActions = ParamUtil.getString(req, "contingency_actions", null);
    	double contingencyCost	= ParamUtil.getCurrency(req, "contingency_cost", -1);
    	String residualRisk = ParamUtil.getString(req, "residual_risk", null);
    	double residualCost	= ParamUtil.getCurrency(req, "residual_cost", -1);
    	boolean materialized = ParamUtil.getBoolean(req, "materialized", false);
    	Date dateMaterialized = ParamUtil.getDate(req, "date_materialized", dateFormat, null);
    	double actualCost	= ParamUtil.getCurrency(req, "actual_cost", -1);
    	Integer actualDelay	= ParamUtil.getInteger(req, "actual_delay", -1);
    	String finalComments = ParamUtil.getString(req, "final_comments", null);
    	String responseDescription = ParamUtil.getString(req, "response_description", null);
    	    	
    	Riskregister risk = new Riskregister();
    	
    	if (idRisk > 0) {
    		risk.setIdRisk(idRisk);
    	}
    	risk.setProject(new Project(idProject));
    	risk.setRiskCode(code);
    	risk.setRiskName(name);
    	risk.setOwner(owner);
    	risk.setDateRaised(dateRaised);
    	risk.setDueDate(dueDate);
    	risk.setDescription(description);
    	risk.setResponseDescription(responseDescription);
    	if (probability != -1) {
    		risk.setProbability(probability);
    	}
    	if (impact != -1) {
    		risk.setImpact(impact);
    	}
    	if (potentialCost != -1) {
    		risk.setPotentialCost(potentialCost);
    	}
    	if (potentialDelay != -1) {
    		risk.setPotentialDelay(potentialDelay);
    	}
    	risk.setRiskTrigger(riskTrigger);
    	if (riskType != -1) {
    		risk.setRiskType(riskType);
    	}
    	if (response != -1) {
    		risk.setRiskcategories(new Riskcategories(response));
    	}
    	risk.setMitigationActionsRequired(mitigationActions);
    	if (mitigationCost != -1) {
    		risk.setPlannedMitigationCost(mitigationCost);
    	}
    	risk.setContingencyActionsRequired(contingencyActions);
    	if (contingencyCost != -1) {
    		risk.setPlannedContingencyCost(contingencyCost);
    	}
    	risk.setResidualRisk(residualRisk);
    	if (residualCost != -1) {
    		risk.setResidualCost(residualCost);
    	}
    	risk.setMaterialized(materialized);
    	risk.setDateMaterialization(dateMaterialized);
    	if (actualCost != -1) {
    		risk.setActualMaterializationCost(actualCost);
    	}
    	if (actualDelay != -1) {
    		risk.setActualMaterializationDelay(actualDelay);
    	}
    	risk.setFinalComments(finalComments);
    	risk.setStatus(status);
    	
		return risk;
	}

    
    /**
     * Set risk reassessment log from AJAX Request
     * @param req
     * @return
     */
    private Riskreassessmentlog setRiskReassessmentLogFromRequest(
			HttpServletRequest req) {
    	Riskreassessmentlog riskLog = new Riskreassessmentlog();
    	
    	Integer idLog = ParamUtil.getInteger(req, "reassessment_log_id", -1);
    	Integer idRisk = ParamUtil.getInteger(req, "risk_id", -1);
    	Date date = ParamUtil.getDate(req, "date", dateFormat, null);
    	String change = ParamUtil.getString(req, "change", null);
    	
    	if (idLog > 0) {
    		riskLog.setIdLog(idLog);
    	}
    	riskLog.setRiskregister(new Riskregister(idRisk));
    	riskLog.setRiskChange(change);
    	riskLog.setRiskDate(date);
    	
		return riskLog;
	}
    

	/**
     * Set assumption log from AJAX Request
     * @param req
     * @return
     */
    private Assumptionreassessmentlog setAssumptionLogFromRequest(
			HttpServletRequest req) {
    	Assumptionreassessmentlog assumptionLog = new Assumptionreassessmentlog();
    	
    	Integer idLog = ParamUtil.getInteger(req, "assumption_log_id", -1);
    	Integer idAssumption = ParamUtil.getInteger(req, "assumption_id", -1);
    	Date date = ParamUtil.getDate(req, "date", dateFormat, null);
    	String change = ParamUtil.getString(req, "change", null);
    	
    	if (idLog > 0) {
    		assumptionLog.setIdLog(idLog);
    	}
    	assumptionLog.setAssumptionregister(new Assumptionregister(idAssumption));
    	assumptionLog.setAssumptionChange(change);
    	assumptionLog.setAssumptionDate(date);
    	
		return assumptionLog;
	}


	/**
     * Set Issue log from AJAX Request
     * @param req
     * @return
     */
	private Issuelog setIssueFromRequest(HttpServletRequest req) {
		Issuelog issue = new Issuelog();
		
		Integer idIssue = ParamUtil.getInteger(req, "issue_id", -1);
		Integer idProject = ParamUtil.getInteger(req, "id", -1);
		String sPriority = ParamUtil.getString(req, "priority", null);
		Date dateLogged = ParamUtil.getDate(req, "date_logged", dateFormat, null);
		Date targetDate = ParamUtil.getDate(req, "target_date", dateFormat, null);
		String assignedTo = ParamUtil.getString(req, "assigned_to", null);
		String description = ParamUtil.getString(req, "description", null);
		String resolution = ParamUtil.getString(req, "resolution", null);
		Date dateClosed = ParamUtil.getDate(req, "date_closed", dateFormat, null);
		
		if (idIssue > -1) {
			issue.setIdIssue(idIssue);
		}
		if (sPriority != null && sPriority.length() > 0) {
			issue.setPriority(sPriority.charAt(0));
		}
		issue.setProject(new Project(idProject));
		issue.setDateLogged(dateLogged);
		issue.setTargetDate(targetDate);
		issue.setAssignedTo(assignedTo);
		issue.setDescription(description);
		issue.setResolution(resolution);
		issue.setDateClosed(dateClosed);
		
		return issue;
	}

	
	/**
     * Set assumption register from request
     * @param req
     * @return
     */
    private Assumptionregister setAssumptionFromRequest(HttpServletRequest req) {
    	Assumptionregister assumption = new Assumptionregister();
		
		Integer idAssumption = ParamUtil.getInteger(req, "assumption_id", -1);
		Integer idProject = ParamUtil.getInteger(req, "id", -1);
		String code = ParamUtil.getString(req, "code", null);
		String name = ParamUtil.getString(req, "name", null);
		String originator = ParamUtil.getString(req, "originator", null);
		String description = ParamUtil.getString(req, "description", null);
		String documentation = ParamUtil.getString(req, "doc", null);
		
		if (idAssumption > -1) {
			assumption.setIdAssumption(idAssumption);
		}
		assumption.setProject(new Project(idProject));
		assumption.setDescription(description);
		assumption.setAssumptionCode(code);
		assumption.setAssumptionName(name);
		assumption.setOriginator(originator);
		assumption.setAssumptionDoc(documentation);
		
		return assumption;
	}
}
