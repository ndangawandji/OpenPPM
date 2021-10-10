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
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.ContactLogic;
import es.sm2.openppm.logic.DocumentationLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.ContentFileLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Contentfile;
import es.sm2.openppm.model.Documentation;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.StringUtil;

/**
 * Servlet implementation class UtilServlet
 */
public class UtilServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(UtilServlet.class);
	
	public final static String REFERENCE = "util";
	
	public final static String SHOW_DOCUMENTATION			= "show-documentation";
	/************** Actions AJAX **************/
	public final static String JX_SEARCH_EMPLOYEE			= "ajax-search-employee";
	public final static String JX_SEARCH_CONTACT			= "ajax-search-contact";
	public final static String JX_SEARCH_PROJECTS			= "ajax-search-projects";
	public final static String JX_CHANGE_CLOSED_TO_CONTROL	= "ajax-change-closed-to-control";

    
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1) {
			
			if (SHOW_DOCUMENTATION.equals(accion)) { showDocument(req, resp); }
			/************** Actions AJAX **************/
			else if (JX_SEARCH_EMPLOYEE.equals(accion)) { searchEmployeeJX(req, resp); }
			else if (JX_SEARCH_CONTACT.equals(accion)) { searchContactJX(req, resp); }
			else if (JX_SEARCH_PROJECTS.equals(accion)) { searchProjectsJX(req, resp); }
			else if (JX_CHANGE_CLOSED_TO_CONTROL.equals(accion)) { changeClosedToControl(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
    /**
     * Change status closed of project to control
     * @param req
     * @param resp
     * @throws IOException
     */
    private void changeClosedToControl(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		
		int idProject = ParamUtil.getInteger(req, "idProject");
		
		try {
			
			ProjectLogic.changeToControl(new Project(idProject), getUser(req));
			
			out.print(JsonUtil.infoTrue());
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
	}

	/**
     * Search projects
     * @param req
     * @param resp
     * @throws IOException
     */
    private void searchProjectsJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		
		String search = ParamUtil.getString(req, Project.PROJECTNAME,null);
		
		try {
			
			Employee user = SecurityUtil.consUser(req);
			
			List<Project> list = ProjectLogic.find(search,user.getPerformingorg());

			JSONArray listJSON = new JSONArray();
			for (Project item : list) {
				
				JSONObject itemJSON = new JSONObject();
				
				itemJSON.put(Project.IDPROJECT, item.getIdProject());
				itemJSON.put(Project.PROJECTNAME, item.getProjectName());
				itemJSON.put(Project.ACCOUNTINGCODE, item.getAccountingCode());
				itemJSON.put(Project.CHARTLABEL, item.getChartLabel());
				
				listJSON.add(itemJSON);
			}
			
			out.print(listJSON);
			
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
	}


	/**
     * Search contact by filter
     * @param req
     * @param resp
     * @throws IOException
     */
    private void searchContactJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
		
		String fullName		= ParamUtil.getString(req, "search_name",null);
		String fileAs		= ParamUtil.getString(req, "search_fileas",null);
		Integer idPerfOrg	= ParamUtil.getInteger(req, "search_perforg",-1);
		
		try {
			
			Company company = CompanyLogic.searchByEmployee(SecurityUtil.consUser(req));
			
			List<Contact> contacts = ContactLogic.searchContacts(fullName, fileAs, new Performingorg(idPerfOrg), company);

			JSONArray contactsJson = new JSONArray();
			for (Contact contact : contacts) {
				
				JSONObject itemJSON = new JSONObject();
				
				itemJSON.put("idContact", contact.getIdContact());
				itemJSON.put("fullname", StringUtil.nullEmpty(contact.getFullName()));
				itemJSON.put("phone", StringUtil.nullEmpty(contact.getMobilePhone()));
				itemJSON.put("jobTitle", StringUtil.nullEmpty(contact.getJobTitle()));
				itemJSON.put("fileAs", StringUtil.nullEmpty(contact.getFileAs()));
				
				contactsJson.add(itemJSON);
			}
			
			out.print(contactsJson);
			
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
	}


    /**
     * Search employee by filter
     * @param req
     * @param resp
     * @throws IOException
     */
	private void searchEmployeeJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		String name			= ParamUtil.getString(req, "name",StringPool.BLANK);
		String jobTitle		= ParamUtil.getString(req, "jobTitle",StringPool.BLANK);
		Integer idProfile	= ParamUtil.getInteger(req, "idProfile",-1);
		Integer idPerfOrg	= ParamUtil.getInteger(req, "idPerfOrg",-1);
		
		try {
			
			Employee user = SecurityUtil.consUser(req);
			
			List<Employee> employees = EmployeeLogic.searchEmployees(name, jobTitle, idProfile, idPerfOrg, user);
			
			JSONArray employeesJson = new JSONArray();
			for (Employee employee : employees) {
				
				JSONObject itemJSON = new JSONObject();
				
				itemJSON.put("idEmployee", employee.getIdEmployee());
				itemJSON.put("fullname", employee.getContact().getFullName());
				itemJSON.put("company", employee.getContact().getCompany().getName());
				itemJSON.put("jobTitle", employee.getContact().getJobTitle());
				itemJSON.put("perfOrg", employee.getPerformingorg().getName());
				
				employeesJson.add(itemJSON);
			}
			
			out.print(employeesJson);
			
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void showDocument(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Integer docId = ParamUtil.getInteger(req, "docId");
		Documentation doc = null;
		Contentfile docFile = null;
		DocumentationLogic docLogic;
		ContentFileLogic fileLogic;
				
		try {	
			docLogic = new DocumentationLogic();
			fileLogic = new ContentFileLogic();
			doc = docLogic.findById(docId);
			docFile = fileLogic.findByDocumentation(doc);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
        sendFile(req, resp, docFile.getContent(), doc.getNameFile());
	}
}
