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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import es.sm2.openppm.javabean.CsvFile;
import es.sm2.openppm.javabean.DatoColumna;
import es.sm2.openppm.javabean.FiltroTabla;
import es.sm2.openppm.javabean.TeamMembersFTEs;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.PerformingOrgLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.SkillLogic;
import es.sm2.openppm.logic.TeamMemberLogic;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.model.Skillsemployee;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JSONModelUtil;
import es.sm2.openppm.utils.PaginacionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class ResourceManagerServlet
 */
public class ResourceServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(ResourceServlet.class);
	
	public final static String REFERENCE = "resource";
	
	/***************** Actions ****************/
	public final static String VIEW_ASSIGNATIONS		= "view-assignations";
	public final static String VIEW_RESOURCE_POOL		= "view-resource-pool";
	public final static String VIEW_CAPACITY_PLANNING	= "view-capacity-planning";
	public final static String VIEW_CAPACITY_RUNNING	= "view-capacity-running";
	public final static String CAPACITY_PLANNING_TO_CSV	= "capacity-planning-to-csv";
	
	/************** Actions AJAX **************/
	public final static String JX_FILTER_ASSIGNATIONS				= "ajax-filter-assignations";
	public final static String JX_APPROVE_RESOURCE					= "ajax-approve-resource";
	public final static String JX_REJECT_RESOURCE					= "ajax-reject-resource";
	public final static String JX_PROPOPSED_RESOURCE				= "ajax-proposed-resource";
	public final static String JX_VIEW_RESOURCE						= "ajax-view-resource";
	public final static String JX_UPDATE_CAPACITY_PLANNING			= "ajax-update-capacity-planning";
	public final static String JX_VIEW_CAPACITY_PLANNING_RESOURCE	= "ajax-view-capacity-planning-resource";
	
    
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1 && SecurityUtil.hasPermission(req, ValidateUtil.isNullCh(accion, REFERENCE))) {
			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion) || VIEW_ASSIGNATIONS.equals(accion)) { viewAssignations(req, resp); }
			else if (VIEW_RESOURCE_POOL.equals(accion)) { viewResourcePool(req, resp); }
			else if (VIEW_CAPACITY_PLANNING.equals(accion)) { viewCapacityPlanning(req, resp); }
			else if (VIEW_CAPACITY_RUNNING.equals(accion)) { viewCapacityRunning(req, resp); }
			else if (CAPACITY_PLANNING_TO_CSV.equals(accion)) { capacityRunningToCsv(req, resp); }
			
			/************** Actions AJAX **************/
			
			else if (JX_FILTER_ASSIGNATIONS.equals(accion)) { filterAssignationsJX(req, resp); }
			else if (JX_APPROVE_RESOURCE.equals(accion)) { approveResourceJX(req, resp); }
			else if (JX_REJECT_RESOURCE.equals(accion)) { rejectResourceJX(req, resp); }
			else if (JX_VIEW_RESOURCE.equals(accion)) { viewResourceJX(req, resp); }
			else if (JX_PROPOPSED_RESOURCE.equals(accion)) { proposedResourceJX(req, resp); }
			else if (JX_UPDATE_CAPACITY_PLANNING.equals(accion)) { updateCapacityPlanningJX(req, resp); }
			else if (JX_VIEW_CAPACITY_PLANNING_RESOURCE.equals(accion)) { updateCapacityPlanningResourceJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}

    /**
     * Update capacity planning resource
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void updateCapacityPlanningResourceJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	Integer[] idProjects	= ParamUtil.getIntegerList(req, Project.ENTITY, null);
    	Integer[] idPMs			= ParamUtil.getIntegerList(req, Project.EMPLOYEEBYPROJECTMANAGER, null);
    	Integer[] idSkills		= ParamUtil.getIntegerList(req, Teammember.SKILL, null);
    	String[] statusList		= ParamUtil.getStringValues(req, "filter", null);
    	String fullName			= ParamUtil.getString(req, Contact.FULLNAME, StringPool.BLANK);
    	Date since				= ParamUtil.getDate(req, "since", dateFormat, null);
    	Date until				= ParamUtil.getDate(req, "until", dateFormat, null);
    	String order			= ParamUtil.getString(req, "orderName", Constants.ASCENDENT);
    	String type				= ParamUtil.getString(req, "resourceType",Project.ENTITY);
    	Integer idEmployee 		= ParamUtil.getInteger(req, "idEmployee", -1);
    
    	List<TeamMembersFTEs> ftEs 	= null;
		List<String> listDates		= new ArrayList<String>();
		
    	try {
    		
    		TeamMemberLogic memberLogic = new TeamMemberLogic();
    		
    		SimpleDateFormat dfYear = new SimpleDateFormat("yy");
    		
    		Calendar sinceCal		= DateUtil.getCalendar();
			Calendar untilCal		= DateUtil.getCalendar();
			
    		sinceCal.setTime(DateUtil.getFirstWeekDay(since));
			untilCal.setTime(DateUtil.getLastWeekDay(until));
			
			
			if (Project.ENTITY.equals(type)) {

				List<Teammember> teammembers = memberLogic.consStaffinFtes(
						idProjects, idPMs, idSkills, statusList,
						fullName, since, until, Project.IDPROJECT, order, idEmployee);
				
				ftEs = generateFTEsMembersByProject(teammembers, sinceCal.getTime(), untilCal.getTime());
				
				req.setAttribute("titleTable", idioma.getString("project"));
			}
			else {
				List<Teammember> teammembers = memberLogic.consStaffinFtes(
						idProjects, idPMs, idSkills, statusList,
						fullName, since, until, Skill.IDSKILL, order, idEmployee);
				
				ftEs = generateFTEsMembersBySkill(teammembers, sinceCal.getTime(), untilCal.getTime());
				
				req.setAttribute("titleTable", idioma.getString("skill"));
			}
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
		
		forward("/resource/capacity_planning/staffing_table_popup.ajax.jsp", req, resp);
	}

	/**
     * Capacity Planning to CSV
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void capacityRunningToCsv(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	Integer[] idProjects	= ParamUtil.getIntegerList(req, Project.ENTITY, null);
    	Integer[] idPMs			= ParamUtil.getIntegerList(req, Project.EMPLOYEEBYPROJECTMANAGER, null);
    	Integer[] idSkills		= ParamUtil.getIntegerList(req, Teammember.SKILL, null);
    	String[] statusList		= ParamUtil.getStringValues(req, "filter", null);
    	String fullName			= ParamUtil.getString(req, Contact.FULLNAME, StringPool.BLANK);
    	Date since				= ParamUtil.getDate(req, "since", dateFormat, null);
    	Date until				= ParamUtil.getDate(req, "until", dateFormat, null);
    	String order			= ParamUtil.getString(req, "orderName", Constants.ASCENDENT);
    	
    	CsvFile file = new CsvFile(Constants.SEPARATOR_CSV);
    	
    	try {
			
    		TeamMemberLogic memberLogic = new TeamMemberLogic();
    		
    		SimpleDateFormat dfYear = new SimpleDateFormat("yy");
    		
    		Calendar sinceCal		= DateUtil.getCalendar();
			Calendar untilCal		= DateUtil.getCalendar();
			
    		sinceCal.setTime(DateUtil.getFirstWeekDay(since));
			untilCal.setTime(DateUtil.getLastWeekDay(until));
			
			List<Teammember> teammembers = memberLogic.consStaffinFtes(
					idProjects, idPMs, idSkills, statusList,
					fullName, since, until, Contact.FULLNAME, order, null);
			
			List<TeamMembersFTEs> ftEs = generateFTEsMembers(teammembers, sinceCal.getTime(), untilCal.getTime());
			
			// Generate CSV
			file.addValue(idioma.getString("contact.fullname"));
			while (!sinceCal.after(untilCal)) {

				int sinceDay = sinceCal.get(Calendar.DAY_OF_MONTH);
				Calendar calWeek = DateUtil.getLastWeekDay(sinceCal);
				int untilDay = calWeek.get(Calendar.DAY_OF_MONTH);
				
				file.addValue(sinceDay+"-"+untilDay +" "+idioma.getString("month.min_"+(calWeek.get(Calendar.MONTH)+1))+" "+dfYear.format(calWeek.getTime()));
				
				sinceCal.add(Calendar.WEEK_OF_MONTH, 1);
			}
			
			file.newLine();
			
			for (TeamMembersFTEs memberFte : ftEs) {
				
				file.addValue(memberFte.getMember().getEmployee().getContact().getFullName());
				
				for (int fte : memberFte.getFtes()) {
					String fteStr = (fte > 0?fte+StringPool.BLANK:StringPool.BLANK); 
					file.addValue(fteStr);
				}
				file.newLine();
			}
			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		sendFile(req, resp, file.getFileBytes(), "Export "+idioma.getString("menu.resource_capacity_planning") + ".csv");
	}

	/**
     * Update table Capacity Planning
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
	private void updateCapacityPlanningJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {

		Integer[] idProjects	= ParamUtil.getIntegerList(req, Project.ENTITY, null);
		Integer[] idPMs			= ParamUtil.getIntegerList(req, Project.EMPLOYEEBYPROJECTMANAGER, null);
		Integer[] idSkills		= ParamUtil.getIntegerList(req, Teammember.SKILL, null);
		String[] statusList		= ParamUtil.getStringValues(req, "filter", null);
		String fullName			= ParamUtil.getString(req, Contact.FULLNAME, StringPool.BLANK);
    	Date since				= ParamUtil.getDate(req, "since", dateFormat, null);
    	Date until				= ParamUtil.getDate(req, "until", dateFormat, null);
    	String order			= ParamUtil.getString(req, "orderName", Constants.ASCENDENT);
    
    	List<TeamMembersFTEs> ftEs 	= null;
		List<String> listDates		= new ArrayList<String>();
		
    	try {
    		
    		TeamMemberLogic memberLogic = new TeamMemberLogic();
    		
    		SimpleDateFormat dfYear = new SimpleDateFormat("yy");
    		
    		Calendar sinceCal		= DateUtil.getCalendar();
			Calendar untilCal		= DateUtil.getCalendar();
			
    		sinceCal.setTime(DateUtil.getFirstWeekDay(since));
			untilCal.setTime(DateUtil.getLastWeekDay(until));
			
			List<Teammember> teammembers = memberLogic.consStaffinFtes(
					idProjects, idPMs, idSkills, statusList,
					fullName, since, until, Contact.FULLNAME, order, null);
			
			ftEs = generateFTEsMembers(teammembers, sinceCal.getTime(), untilCal.getTime());
			
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
		
		forward("/resource/capacity_planning/staffing_table.ajax.jsp", req, resp);
	}

	/**
     * View resource pool
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void viewCapacityPlanning(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	List<Employee> projectManagers	= null;
    	List<Project> projects			= null;
		List<Skill> skills				= null;
		try {
			
			ProjectLogic projectLogic	= new ProjectLogic();
			SkillLogic skillLogic		= new SkillLogic();
			
			Company company = CompanyLogic.searchByEmployee(getUser(req));
			
			List<String> joins = new ArrayList<String>();
			joins.add(Employee.CONTACT);
			
			projectManagers = EmployeeLogic.searchEmployees(new Resourceprofiles(Constants.ROLE_PM), company, joins);
			
			projects = projectLogic.findByPO(getUser(req).getPerformingorg());
			
			skills			= skillLogic.findByRelation(Skill.COMPANY, company, Skill.NAME, Constants.ASCENDENT);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("projectManagers", projectManagers);
		req.setAttribute("projects", projects);
		req.setAttribute("skills", skills);
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.resource_capacity_planning"));
		forward("/index.jsp?nextForm=resource/capacity_planning/capacity_planning", req, resp);
	}
    
	/**
     * View resource pool
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void viewCapacityRunning(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	List<Employee> projectManagers = null;
		List<Skill> skills = null;
		
		try {
			SkillLogic skillLogic = new SkillLogic();
			
			Employee user	= SecurityUtil.consUser(req);
			Company company = CompanyLogic.searchByEmployee(user);
			
			List<String> joins = new ArrayList<String>();
			joins.add(Employee.CONTACT);
			
			projectManagers = EmployeeLogic.searchEmployees(new Resourceprofiles(Constants.ROLE_PM), company, joins);
			
			skills			= skillLogic.findByRelation(Skill.COMPANY, company, Skill.NAME, Constants.ASCENDENT);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("projectManagers", projectManagers);
		req.setAttribute("skills", skills);
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.resource_capacity_running"));
		forward("/index.jsp?nextForm=resource/capacity_running/capacity_running", req, resp);
	}
    
	/**
     * View resource pool
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
    private void viewResourcePool(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
    	List<Employee> projectManagers = null;
		List<Skill> skills = null;
		
		try {
			Employee user	= SecurityUtil.consUser(req);
			Company company = CompanyLogic.searchByEmployee(user);
			
			List<String> joins = new ArrayList<String>();
			joins.add(Employee.CONTACT);
			
			projectManagers = EmployeeLogic.searchEmployees(new Resourceprofiles(Constants.ROLE_PM), company, joins);
			
			SkillLogic skillLogic = new SkillLogic();
			skills			= skillLogic.findByRelation(Skill.COMPANY, company);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("projectManagers", projectManagers);
		req.setAttribute("skills", skills);
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.resource_pool"));
		forward("/index.jsp?nextForm=resource/pool/pool", req, resp);
	}

	/**
     * Proposed resource
     * @param req
     * @param resp
     * @throws IOException
     */
    private void proposedResourceJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idResource			= ParamUtil.getInteger(req, "idResource", -1);
    	int idResourceProposed	= ParamUtil.getInteger(req, "idResourceProposed", -1);
    	Date dateIn				= ParamUtil.getDate(req, "dateIn", dateFormat);
    	Date dateOut			= ParamUtil.getDate(req, "dateOut", dateFormat);
    	int fte					= ParamUtil.getInteger(req, "fte", 0);
    	Integer idSkill			= ParamUtil.getInteger(req, "idSkill", null);
    	String commentsRm		= ParamUtil.getString(req, "commentsRm");
    	
    	PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		TeamMemberLogic memberLogic = new TeamMemberLogic();
    		
    		Teammember resource = memberLogic.findById(idResource);
    		
    		if (resource.getEmployee().getIdEmployee() == idResourceProposed) {
    			
    			resource.setStatus(Constants.RESOURCE_PROPOSED);
    			resource.setDateIn(dateIn);
    			resource.setDateOut(dateOut);
    			resource.setFte(fte);
    			resource.setCommentsRm(commentsRm);
    			
    			if (idSkill == null) { resource.setSkill(null); }
    			else { resource.setSkill(new Skill(idSkill)); }
    			
    			memberLogic.save(resource);
    		}
    		else {
    			
    			resource.setStatus(Constants.RESOURCE_TURNED_DOWN);
    			memberLogic.save(resource);
    			
    			Teammember resourceProposed = new Teammember();
    			resourceProposed.setProjectactivity(resource.getProjectactivity());
    			resourceProposed.setEmployee( new Employee(idResourceProposed));
    			resourceProposed.setStatus(Constants.RESOURCE_PROPOSED);
    			resourceProposed.setDateIn(dateIn);
    			resourceProposed.setDateOut(dateOut);
    			resourceProposed.setFte(fte);
    			resourceProposed.setCommentsRm(commentsRm);
    			
    			if (idSkill == null) { resourceProposed.setSkill(null); }
    			else { resourceProposed.setSkill(new Skill(idSkill)); }
    			
    			TeamMemberLogic.saveResource(resourceProposed);
    		}
    		
    		out.print(info("resource.proposed.new", null));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
		
	}

	private void viewResourceJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
    	int idResource = ParamUtil.getInteger(req, "idResource",-1);
    	
    	PrintWriter out = resp.getWriter();
    	
    	try {
    		TeamMemberLogic memberLogic = new TeamMemberLogic();
    		
    		List<String> joins = new ArrayList<String>();
    		joins.add(Teammember.SKILL);
    		joins.add(Teammember.EMPLOYEE);
    		joins.add(Teammember.EMPLOYEE+"."+Employee.SKILLSEMPLOYEES);
    		joins.add(Teammember.EMPLOYEE+"."+Employee.SKILLSEMPLOYEES+"."+Skillsemployee.SKILL);
    		joins.add(Teammember.EMPLOYEE+"."+Employee.CONTACT);
    		joins.add(Teammember.PROJECTACTIVITY);
    		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT);    		
    		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT+"."+Project.PROGRAM);
    		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT+"."+Project.PERFORMINGORG);
    		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT+"."+Project.EMPLOYEEBYPROJECTMANAGER);
    		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT+"."+Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
    		
    		Teammember member	= memberLogic.findById(idResource, joins);
    		
    		JSONObject memberJSON = JSONModelUtil.toJSON(idioma, dateFormat ,member);
    		
    		out.print(memberJSON);
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Reject Resource
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void rejectResourceJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	int idResource		= ParamUtil.getInteger(req, "idResource",-1);
    	String commentsRm	= ParamUtil.getString(req, "commentsRm");
		
		PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		TeamMemberLogic memberLogic = new TeamMemberLogic();
    		
    		Teammember memeber = memberLogic.findById(idResource);
    		memeber.setStatus(Constants.RESOURCE_TURNED_DOWN);
    		memeber.setCommentsRm(commentsRm);
    		
    		memberLogic.save(memeber);
    		
    		out.print(info("reject.resource.turn_down", null));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

    /**
     * Approve Resource
     * @param req
     * @param resp
     * @throws IOException 
     */
	private void approveResourceJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		int idResource		= ParamUtil.getInteger(req, "idResource",-1);
		String commentsRm	= ParamUtil.getString(req, "commentsRm");
		
		PrintWriter out = resp.getWriter();
    	
    	try {
    		
    		TeamMemberLogic.approveTeamMember(idResource, commentsRm);
    		
    		out.print(info("approve.resource.assigned", null));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * Filter table assignations
     * @param req
     * @param resp
     * @throws IOException 
     */
    private void filterAssignationsJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
    	PrintWriter out = resp.getWriter();
    	
    	try {
    		
			ArrayList<DatoColumna > columnas = new ArrayList<DatoColumna>();
			
			// Real Columns
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
			columnas.add(new DatoColumna(Teammember.STATUS,List.class));
			columnas.add(new DatoColumna(Contact.FULLNAME,String.class));
			columnas.add(new DatoColumna("skill.idSkill",String.class,List.class));
			columnas.add(new DatoColumna(Project.PROJECTNAME,String.class));
			columnas.add(new DatoColumna(Projectactivity.ACTIVITYNAME,String.class));
			columnas.add(new DatoColumna(Project.EMPLOYEEBYPROJECTMANAGER,String.class,List.class));
			columnas.add(new DatoColumna(Teammember.DATEIN,Date.class));
			columnas.add(new DatoColumna(Teammember.DATEOUT,Date.class));
			columnas.add(new DatoColumna(Teammember.FTE,Date.class));
			columnas.add(new DatoColumna(StringPool.BLANK,String.class));
    		
			// Filter since until
			String[] sinceUntil = {Teammember.DATEIN,Teammember.DATEOUT};
			columnas.add(new DatoColumna(sinceUntil,List.class,Date.class));
			
			ArrayList<String > joins = new ArrayList<String>();
			joins.add(Teammember.EMPLOYEE);
			joins.add(Teammember.EMPLOYEE + "." + Employee.CONTACT);
			joins.add(Teammember.SKILL);
			joins.add(Teammember.PROJECTACTIVITY);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT);			
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT + "." + Project.EMPLOYEEBYPROJECTMANAGER);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT + "." + Project.EMPLOYEEBYPROJECTMANAGER + "." + Employee.CONTACT);
			
			PaginacionUtil paginacion = new PaginacionUtil(req, columnas, Teammember.class, joins);
			
			FiltroTabla filter		= paginacion.crearFiltro();
			List<Teammember> lista	= TeamMemberLogic.filter(filter,joins, getUser(req));
			
			JSONArray membersJSON = new JSONArray();
			
			for (Teammember member : lista) {
				
				
				JSONArray memberJSON = new JSONArray();
				memberJSON.add(member.getIdTeamMember());
				memberJSON.add(member.getStatus() != null?idioma.getString("resource."+member.getStatus()):StringPool.BLANK);
				memberJSON.add(ValidateUtil.escape(member.getEmployee().getContact().getFullName()));
				memberJSON.add(ValidateUtil.escape(member.getSkill() != null?member.getSkill().getName():StringPool.BLANK));
				memberJSON.add(ValidateUtil.escape(member.getProjectactivity().getProject().getProjectName()));
				memberJSON.add(ValidateUtil.escape(member.getProjectactivity().getActivityName()));
				memberJSON.add(ValidateUtil.escape(member.getProjectactivity().getProject()
						.getEmployeeByProjectManager().getContact().getFullName()));
				memberJSON.add(member.getDateIn() != null? dateFormat.format(member.getDateIn()):StringPool.BLANK);
				memberJSON.add(member.getDateOut() != null? dateFormat.format(member.getDateOut()):StringPool.BLANK);
				memberJSON.add(member.getFte());
				memberJSON.add(member.getStatus());
				membersJSON.add(memberJSON);
			}
			
			int total		= TeamMemberLogic.findTotal(paginacion.getFiltros(), getUser(req));
			int totalFilter = TeamMemberLogic.findTotalFiltered(filter, getUser(req));
			
			out.print(paginacion.obtenerDatos(membersJSON, total, totalFilter, null));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
     * View Assignations Approvals
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
	private void viewAssignations(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		List<Employee> projectManagers = null;
		List<Skill> skills = null;
		List<Performingorg> perfOrgs = null;
		
		try {
			Employee user	= SecurityUtil.consUser(req);
			Company company = CompanyLogic.searchByEmployee(user);
			
			List<String> joins = new ArrayList<String>();
			joins.add(Employee.CONTACT);
			
			projectManagers = EmployeeLogic.searchEmployees(new Resourceprofiles(Constants.ROLE_PM), company, joins);
			
			SkillLogic skillLogic = new SkillLogic();
			skills			= skillLogic.findByRelation(Skill.COMPANY, company);
			
			PerformingOrgLogic performingOrgLogic = new PerformingOrgLogic();
			perfOrgs = performingOrgLogic.findByRelation(Performingorg.COMPANY, company);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("projectManagers", projectManagers);
		req.setAttribute("perforgs", perfOrgs);
		req.setAttribute("skills", skills);
		
		req.setAttribute("title", idioma.getString("menu.assignations_approvals"));
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		
		forward("/index.jsp?nextForm=resource/assignations/assignations", req, resp);
	}
	
	private List<TeamMembersFTEs> generateFTEsMembersByProject(List<Teammember> teammembers, Date sinceDate, Date untilDate) throws Exception {
		
		List<TeamMembersFTEs> listMembers 	= new ArrayList<TeamMembersFTEs>();
		Calendar sinceCal			= DateUtil.getCalendar();
		Calendar untilCal			= DateUtil.getCalendar();
		int idProject				= -1;
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
				
				
				if (memberFtes == null || !(idProject == member.getProjectactivity().getProject().getIdProject())) {
					 
					if (memberFtes != null) {
						memberFtes.setFtes(listFTES);
						listMembers.add(memberFtes);
					}
					
					listFTES	= new int[weeks];
					memberFtes	= new TeamMembersFTEs(member, member.getProjectactivity().getProject());
					idProject	= member.getProjectactivity().getProject().getIdProject();
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

	private List<TeamMembersFTEs> generateFTEsMembersBySkill(List<Teammember> teammembers, Date sinceDate, Date untilDate) throws Exception {
		
		List<TeamMembersFTEs> listMembers 	= new ArrayList<TeamMembersFTEs>();
		Calendar sinceCal			= DateUtil.getCalendar();
		Calendar untilCal			= DateUtil.getCalendar();
		int idSkill				= -1;
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

			List<Project> projects = null;
			
			for (Teammember member : teammembers) {
				
				if (memberFtes == null || !(idSkill == member.getSkill().getIdSkill())) {
					 
					if (memberFtes != null) {
						memberFtes.setFtes(listFTES);
						memberFtes.setProjectNames(projects);
						listMembers.add(memberFtes);
					}
					
					listFTES	= new int[weeks];
					memberFtes	= new TeamMembersFTEs(member);
					projects	= new ArrayList<Project>();
					idSkill	= member.getSkill().getIdSkill();
				}
				
				if (!projects.contains(member.getProjectactivity().getProject())) {
					projects.add(member.getProjectactivity().getProject());
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
				memberFtes.setProjectNames(projects);
				listMembers.add(memberFtes);
			}
		}
		return listMembers;
	}

	private List<TeamMembersFTEs> generateFTEsMembers(List<Teammember> teammembers, Date sinceDate, Date untilDate) throws Exception {
		
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
}
