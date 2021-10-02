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

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.logic.DocumentprojectLogic;
import es.sm2.openppm.logic.ProjectCharterLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.ProjectclosureLogic;
import es.sm2.openppm.logic.charter.ProjectCloseTemplate;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.model.Projectclosure;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.ValidateUtil;

public class ProjectClosureServlet extends AbstractGenericServlet {

	private static final long serialVersionUID = 1L;
	
	private static final  Logger LOGGER = Logger.getLogger(ProjectClosureServlet.class);
	
	public static final String REFERENCE = "projectclosure";
	
	/***************** Actions ****************/
	public static final String VIEW_CLOSE		= "view-close";
	public final static String CLOSE_PROJECT	= "close-project";
	
	/************** Actions AJAX **************/
	public static final String JX_SAVE_CLOSURE 			= "ajax-save-closure";
	public static final String JX_SAVE_DOCUMENTATION 	= "ajax-save-documentation";
	
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.service(req, resp);
		
		String accion = ParamUtil.getString(req, "accion");
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1) {
			
			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion)) { viewClosure(req, resp, null); }
			else if(VIEW_CLOSE.equals(accion)){ viewProjectClose(req, resp); }			
			else if (CLOSE_PROJECT.equals(accion)) { closeProject(req,resp); }
			
			/************** Actions AJAX **************/
			else if(JX_SAVE_CLOSURE.equals(accion)){ saveProjectClosureJX(req, resp); }
			else if(JX_SAVE_DOCUMENTATION.equals(accion)){ saveDocumentationJX(req, resp); }
			
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
    /**
     * Close project
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void closeProject(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
    	int idProject 	= ParamUtil.getInteger(req, "id");
		String comments 	= ParamUtil.getString(req, "comments", null);
		String stkComments	= ParamUtil.getString(req, "stk_comments", null);
		
		try {
			Project project = ProjectLogic.consProject(idProject);
			project.setCloseComments(comments);
			project.setCloseStakeholderComments(stkComments);
			
			ProjectLogic.closeProject(project, getUser(req));
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewClosure(req, resp, idProject);
	}
    
	/**
	 * View Project Closure
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewClosure(HttpServletRequest req, HttpServletResponse resp, Integer idProject) throws ServletException, IOException {
		
		Project project	= null;
		List<Documentproject> docs = null;
		List<Documentproject> repository = null;
		Documentproject docInv = null;
		Documentproject docInit = null;
		Documentproject docRisk = null;
		Documentproject docPlan = null;
		Documentproject docControl = null;
		Documentproject docProcurement = null;
		Documentproject docClosure = null;
		List<Projectclosure> closures = null;
		Projectclosure closure = null;
		
		ProjectclosureLogic closureLogic = null;
		
		if (idProject == null) {
			idProject = ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		}
		
		boolean hasPermission = false;
		
		try {
			
			hasPermission = SecurityUtil.hasPermission(req, new Project(idProject), Constants.TAB_CLOSURE);
			
			if (hasPermission) {
				List<String> joins = new ArrayList<String>();
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
				joins.add(Project.WORKINGCOSTSES);
				
				project = ProjectLogic.consProject(new Project(idProject), joins);
				
				// DOCUMENT REPOSITORY
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					docInv			= DocumentprojectLogic.findByType(project, Constants.DOCUMENT_INVESTMENT);
					docInit			= DocumentprojectLogic.findByType(project, Constants.DOCUMENT_INITIATING);
					docRisk			= DocumentprojectLogic.findByType(project, Constants.DOCUMENT_RISK);
					docPlan			= DocumentprojectLogic.findByType(project, Constants.DOCUMENT_PLANNING);
					docControl		= DocumentprojectLogic.findByType(project, Constants.DOCUMENT_CONTROL);
					docProcurement	= DocumentprojectLogic.findByType(project, Constants.DOCUMENT_PROCUREMENT);
					docClosure		= DocumentprojectLogic.findByType(project, Constants.DOCUMENT_CLOSURE);
				}
				else {
					repository = DocumentprojectLogic.findListByType(project, null);					
				}		
				
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					req.setAttribute("docInv", docInv);
					req.setAttribute("docInit", docInit);
					req.setAttribute("docRisk", docRisk);
					req.setAttribute("docPlan", docPlan);
					req.setAttribute("docControl", docControl);
					req.setAttribute("docProcurement", docProcurement);
					req.setAttribute("docClosure", docClosure);
				}
				else {
					req.setAttribute("repository", repository);					
				}
				
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					docs = new ArrayList<Documentproject>();
					docs.add(DocumentprojectLogic.findByType(project,Constants.DOCUMENT_CLOSURE));	
				}
				else {
					docs = DocumentprojectLogic.findListByType(project, Constants.DOCUMENT_CLOSURE);	
				}	
				
				closureLogic = new ProjectclosureLogic();
				closures = closureLogic.findByRelation(Projectclosure.PROJECT, project);
				
				if(closures.size() > 0) {
					closure = closures.get(0);
				}
				
				req.setAttribute("project", project);
				req.setAttribute("closure", closure);
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		
		if (hasPermission) {
			req.setAttribute("project", project);
			
			if(Constants.DOCUMENT_STORAGE.equals("link")) {
				req.setAttribute("docs", docs.get(0));
			}
			else {
				req.setAttribute("docs", docs);	
			}
			
			forward("/index.jsp?nextForm=project/closure/closure_project", req, resp);
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
	private void viewProjectClose(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Project proj = null;		
		Projectcharter projClose = null;
		byte[] charterDoc = null;
		boolean error = false;
		
		int idProject = ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		
		try {
			
			List<String> joins = new ArrayList<String>();
			joins.add(Project.PROGRAM);
			joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
			joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
			
			proj = ProjectLogic.consProject(new Project(idProject), joins);
			
			projClose = ProjectCharterLogic.findByProject(proj);

			Employee user = SecurityUtil.consUser(req);
			
			ProjectCloseTemplate projCloseTemplate = ProjectCloseTemplate.getProjectCloseTemplate();
			
			File charterDocFile = projCloseTemplate.generateClose(
					idioma, proj, projClose, user.getContact().getFullName());

			if (charterDocFile != null) {
				charterDoc = DocumentUtils.getBytesFromFile(charterDocFile);
			}
			
			proj = ProjectLogic.consProject(proj.getIdProject());
		}
		catch (Exception e) {
			error = true;
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		if (charterDoc != null && !error) {
			sendFile(req, resp, charterDoc, proj.getProjectName() + "_" + proj.getAccountingCode() + Settings.PROJECT_CLOSE_EXTENSION);
		}
		else {
			viewClosure(req, resp, proj.getIdProject());
		}
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @param chargescosts
	 * @throws IOException
	 */
	private void saveProjectClosureJX (HttpServletRequest req, HttpServletResponse resp) 
	throws IOException {

		PrintWriter out = resp.getWriter();
		
		Integer idProject = ParamUtil.getInteger(req, "id", -1);
		String result = ParamUtil.getString(req, "results", "");
		String goals = ParamUtil.getString(req, "goal", "");
		String lessons = ParamUtil.getString(req, "lessons", "");
		
		Projectclosure closure = null;
		List<Projectclosure> closures = null;
		
		try {						
			ProjectclosureLogic closureLogic = new ProjectclosureLogic();
			closures = closureLogic.findByRelation(Projectclosure.PROJECT, new Project(idProject));			
			
			if(closures.size() > 0) {
				closure = closures.get(0);
			}
			else {
				closure = new Projectclosure();				
			}
			
			closure.setProject(new Project(idProject));
			closure.setProjectResults(result);
			closure.setGoalAchievement(goals);
			closure.setLessonsLearned(lessons);
			
			closureLogic.save(closure);
			
			JSONObject info = null;
			out.print(infoUpdated(info, "project closure"));			
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	private void saveDocumentationJX (HttpServletRequest req, HttpServletResponse resp) 
	throws IOException {

		PrintWriter out = resp.getWriter();
		
		Integer idProject = ParamUtil.getInteger(req, "project", -1);
		Integer idDocument = ParamUtil.getInteger(req, "document", -1);
		String comment = ParamUtil.getString(req, "comment", "");		
		
		Project project = null;
		Documentproject doc = null;
		
		try {		
									
			if(idDocument == -1) {
				project = ProjectLogic.consProject(idProject);
				project.setLinkComment(comment);
				ProjectLogic.saveProject(project);
			}
			else {		
				DocumentprojectLogic documentprojectLogic = new DocumentprojectLogic();
				doc = documentprojectLogic.findById(idDocument, false);
				doc.setContentComment(comment);
				DocumentprojectLogic.saveDocumentproject(doc);
			}
									
			JSONObject info = null;
			out.print(infoUpdated(info, "documment"));			
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}	
}
