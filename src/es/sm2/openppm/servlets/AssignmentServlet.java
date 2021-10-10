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
 *  Updater : Cedric Ndanga
 ******************************************************************************/
/**
 * Updater : Cedric Ndanga
 * Devoteam, 2015/04/09, userstory 10 : Updating method filterAssignments(HttpServletRequest req, HttpServletResponse resp)
 * Update : Xavier de Langautier
 * Devoteam, 2015/04/24, userstory 9 : Update method filterAssignments and viewAssignments (Add remainingWorkload computing)
 */

package es.sm2.openppm.servlets;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.TeamMemberLogic;
import es.sm2.openppm.logic.TimesheetLogic;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.NumberUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class AssignmentServlet
 */
public class AssignmentServlet extends AbstractGenericServlet {

	private static final long serialVersionUID = 3334829605751579755L;
	
	private static final Logger LOGGER = Logger.getLogger(AssignmentServlet.class);
	
	public final static String REFERENCE = "assignment";
	
	/***************** Actions ****************/
	public final static String VIEW_ASSIGNMENTS		= "view-assignments";
	public final static String FILTER_ASSIGNMENTS	= "filter-assignments";
	
	/************** Actions AJAX **************/
	
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		super.service(req, resp);
		
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1 && SecurityUtil.hasPermission(req, ValidateUtil.isNullCh(accion, VIEW_ASSIGNMENTS))) {
			if (ValidateUtil.isNull(accion) || VIEW_ASSIGNMENTS.equals(accion)) { viewAssignments(req, resp); }
			else if (FILTER_ASSIGNMENTS.equals(accion)) { filterAssignments(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
	private void filterAssignments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 List<Teammember> teamMembers = null;
		 List<Project> projects = null;	
		 double  remaining;
		 double  cent = 100;
		 Date since = ParamUtil.getDate(req, "since", dateFormat, null);
		 Date until = ParamUtil.getDate(req, "until", dateFormat, null);
		 
		 try {
			 
			TeamMemberLogic teamLogic = new TeamMemberLogic();
			TimesheetLogic timeSheetlogic = new TimesheetLogic();	
			
			List<String> joins = new ArrayList<String>();
			joins.add(Teammember.PROJECTACTIVITY);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT);			
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT + "." + Project.EMPLOYEEBYPROJECTMANAGER);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT + "." + Project.EMPLOYEEBYPROJECTMANAGER + "." + Employee.CONTACT);
			
			teamMembers = teamLogic.findByEmployeeOrderByProject(SecurityUtil.consUser(req), since, until, joins);
			LOGGER.debug(teamMembers.isEmpty() + "pas d'assignation");

			for (Teammember teammember : teamMembers) {
				/* Calcul du nombre de jour qu'un team member a sur une activité */
				teammember.setDays((teamLogic.workloadInDays(teammember, teammember.getDateIn(), teammember.getDateOut())));
                
				/* Userstory 9  ajout du reste à faire*/
			
			    remaining = /*(double) teammember.getDays() -*/ (timeSheetlogic.getHoursResource(teammember.getEmployee().getIdEmployee(), 	
																			   teammember.getProjectactivity().getIdActivity(),
																			   DateUtil.getFirstWeekDay(DateUtil.addDay(teammember.getDateIn(), 7)), 
																			   teammember.getDateOut(), 
																			   Constants.TIMESTATUS_APP0,
																			   Constants.TIMESTATUS_APP0
															 )/Constants.DEFAULT_HOUR_DAY);
			    
			    remaining = NumberUtil.truncate2decimals(remaining);
//				 LOGGER.debug("remaining" + remaining +  teammember.getProjectactivity().getIdActivity());

			    remaining = (remaining <0 ?0:remaining);  // On ne prend pas en compte le trop consomé.

                teammember.setRemainingWorkload( remaining); /* reste à faire en jours*/		
			}
			
			joins = new ArrayList<String>();
			joins.add(Teammember.PROJECTACTIVITY);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT);							
			
			projects = ProjectLogic.findByEmployee(SecurityUtil.consUser(req), joins);
		 }
		 catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		 
		 req.setAttribute("teamMembers", teamMembers);
		 req.setAttribute("projects", projects);				
		 req.setAttribute("title", idioma.getString("menu.assignments"));
		 req.setAttribute("dateIn", since);
		 req.setAttribute("dateOut", until);
		 
		 forward("/index.jsp?nextForm=assignment/assignment", req, resp);
	 }
	
	 private void viewAssignments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		 List<Teammember> teamMembers = null;
		 List<Project> projects = null;	
		 double remaining;
		 Date dateIn = null;
		 Date dateOut = null;
		 
		 try {
			 
			TeamMemberLogic teamLogic = new TeamMemberLogic();
			TimesheetLogic timeSheetlogic = new TimesheetLogic();	
			
			List<String> joins = new ArrayList<String>();
			joins.add(Teammember.PROJECTACTIVITY);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT);			
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT + "." + Project.EMPLOYEEBYPROJECTMANAGER);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT + "." + Project.EMPLOYEEBYPROJECTMANAGER + "." + Employee.CONTACT);
			
			Calendar cal = Calendar.getInstance();
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), 1);
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			dateIn = sdf.parse(sdf.format(cal.getTime()));	
			cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.getActualMaximum(Calendar.DAY_OF_MONTH));
			dateOut = sdf.parse(sdf.format(cal.getTime()));
			
			teamMembers = teamLogic.findByEmployeeOrderByProject(SecurityUtil.consUser(req), dateIn, dateOut, joins);

			
			joins = new ArrayList<String>();
			joins.add(Teammember.PROJECTACTIVITY);
			joins.add(Teammember.PROJECTACTIVITY + "." + Projectactivity.PROJECT);				

			LOGGER.debug(teamMembers.isEmpty() + "pas d'assignation");
			for (Teammember teammember : teamMembers) {

				/* Calcul du nombre de jour qu'un team member a sur une activité */
				teammember.setDays((teamLogic.workloadInDays(teammember, teammember.getDateIn(), teammember.getDateOut())));

				/* UserStory 9 Calcul du Reste à faire */
				
				remaining =  /*teammember.getDays() -*/ (timeSheetlogic.getHoursResource(teammember.getEmployee().getIdEmployee(), 
						                                									 teammember.getProjectactivity().getIdActivity(),
						                                									 DateUtil.getFirstWeekDay(DateUtil.addDay(teammember.getDateIn(), 7)), 
						                                									 teammember.getDateOut(), 
						                                									 Constants.TIMESTATUS_APP0,
						                                									 Constants.TIMESTATUS_APP0
                                                        			) /Constants.DEFAULT_HOUR_DAY); /* reste à faire en jours*/
				
				remaining =  NumberUtil.truncate2decimals(remaining);
//				 LOGGER.debug("remaining" + remaining +  teammember.getProjectactivity().getIdActivity());
				 remaining = (remaining <0 ?0:remaining);  // On ne prend pas en compte le trop consomé.
	             teammember.setRemainingWorkload( remaining); /* reste à faire en jours*/

			}
			
			projects = ProjectLogic.findByEmployee(SecurityUtil.consUser(req), joins);
		 }
		 catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		 
		 req.setAttribute("teamMembers", teamMembers);
		 req.setAttribute("projects", projects);				
		 req.setAttribute("title", idioma.getString("menu.assignments"));
		 req.setAttribute("dateIn", dateIn);
		 req.setAttribute("dateOut", dateOut);
		 
		 forward("/index.jsp?nextForm=assignment/assignment", req, resp);
	 }
}
