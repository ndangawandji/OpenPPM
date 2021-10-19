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
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.logic.CalendarBaseLogic;
import es.sm2.openppm.logic.CalendarbaseexceptionsLogic;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.model.Calendarbaseexceptions;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Projectcalendar;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.Exclusion;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;


/**
 * Servlet implementation class CalendarServlet
 */
public class CalendarServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	private static final Logger LOGGER = Logger.getLogger(CalendarServlet.class);
	
	public final static String REFERENCE = "calendar";
	
	/***************** Actions ****************/
	public final static String DEL_CALENDAR_BASE = "delete-calendar-base";
	public final static String CREATE_CALENDAR				= "create-calendar";
	
	/************** Actions AJAX **************/
	public final static String JX_SAVE_CALENDAR				= "ajax-save-calendar";
	public final static String JX_GET_CALENDAR				= "ajax-get-calendar";
	public final static String JX_SAVE_CALENDAR_EXCEPTION	= "ajax-save-calendar-exception";
	public final static String JX_DELETE_CALENDAR_EXCEPTION = "ajax-delete-calendar-exception";
    
    /**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1 && SecurityUtil.isUserInRole(req, Constants.ROLE_PMO)) {
			
			/***************** Actions ****************/
			if (accion == null || "".equals(accion)) { viewCalendar(req, resp); }
			else if (DEL_CALENDAR_BASE.equals(accion)) { deleteCalendarBase(req, resp); }
			else if (CREATE_CALENDAR.equals(accion)) { createCalendar(req, resp); }
			
			/************** Actions AJAX **************/
			else if (JX_SAVE_CALENDAR.equals(accion)) { saveCalendarJX(req, resp); }
			else if (JX_GET_CALENDAR.equals(accion)) { getCalendarJX(req, resp); }
			else if (JX_SAVE_CALENDAR_EXCEPTION.equals(accion)) { saveCalendarExceptionJX(req, resp); }
			else if (JX_DELETE_CALENDAR_EXCEPTION.equals(accion)) { deleteCalendarExceptionJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
    }
	
	/**
	 * Delete Calendar Base
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteCalendarBase(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		Integer idCalendarBase = ParamUtil.getInteger(req, "idCalendarBase", -1);
		
		try {		
			CalendarBaseLogic.deleteCalendar(new Calendarbase(idCalendarBase));
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewCalendar(req, resp);
	}
	
	
	/**
	 * Delete Calendar Exception
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteCalendarExceptionJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		PrintWriter out			= resp.getWriter();		
		
		Integer idCalendarBaseException = ParamUtil.getInteger(req, "idCalendarBaseException",-1);
		
		try {	
			
			CalendarbaseexceptionsLogic.deleteException(new Calendarbaseexceptions(idCalendarBaseException));

			JSONObject sucessJSON = new JSONObject();
			sucessJSON.put("sucess", "true");
			
			out.print(sucessJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}	
	}

	/**
	 * Save Calendar Base Exception
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveCalendarExceptionJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		Integer idCalendarBase 	= ParamUtil.getInteger(req, "idCalendarBase", -1);
		Date startDate 			= ParamUtil.getDate(req, "startDate", dateFormat);
		Date finishDate			= ParamUtil.getDate(req, "endDate", dateFormat);
		String description		= ParamUtil.getString(req, "name");
		
		PrintWriter out			= resp.getWriter();		
		
		try {	
			
	    	
	    	Calendarbaseexceptions exception = null;
	    	
	    	if (idCalendarBase != -1) {
	    		
	    		exception = new Calendarbaseexceptions();
	    		
	    		exception.setStartDate(startDate);
	    		exception.setFinishDate(finishDate);
	    		exception.setDescription(description);
	    		exception.setCalendarbase(new Calendarbase(idCalendarBase));
	    	}
			
			if (exception != null) {
				
				exception = CalendarbaseexceptionsLogic.saveException(exception);
			}
			
			out.print(JsonUtil.toJSON(exception));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}	
	}

	/**
	 * Get calendar
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void getCalendarJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		PrintWriter out			= resp.getWriter();		
		Integer idCalendarBase 	= ParamUtil.getInteger(req, "idCalendarBase",-1);
		
		try {	

			Calendarbase calendarBase = CalendarBaseLogic.consCalendarBaseWithExceptions(new Calendarbase(idCalendarBase));
			
			String pattern = DateUtil.getDatePattern(idioma);
			
			Gson gson = new GsonBuilder().setDateFormat(pattern).create();
			calendarBase.setEmployees(null);
			calendarBase.setProjectcalendars(null);
			for (Calendarbaseexceptions item : calendarBase.getCalendarbaseexceptionses()) {
				item.setCalendarbase(null);
			}
			
			out.print(gson.toJson(calendarBase));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Save calendar
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveCalendarJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Integer idCalendarBase 	= ParamUtil.getInteger(req, "idCalendarBase",-1);
		Integer idTemplate	 	= ParamUtil.getInteger(req, "idTemplate",-1);
		String name 			= ParamUtil.getString(req, "name");
		Integer weekStart 		= ParamUtil.getInteger(req, "weekStart",1);
		Integer fiscalYearStart = ParamUtil.getInteger(req, "fiscalYearStart",1);
		double startTime1 		= ParamUtil.getDouble(req, "startTime1");
		double startTime2 		= ParamUtil.getDouble(req, "startTime2");
		double endTime1 		= ParamUtil.getDouble(req, "endTime1");
		double endTime2 		= ParamUtil.getDouble(req, "endTime2");
		double hoursDay			= ParamUtil.getDouble(req, "hoursDay");
		double hoursWeek 		= ParamUtil.getDouble(req, "hoursWeek");
		Integer daysMonth 		= ParamUtil.getInteger(req, "daysMonth");
		
		PrintWriter out = resp.getWriter();		
		
		try {	
			
			Employee user = SecurityUtil.consUser(req);
			Company company = CompanyLogic.searchByEmployee(user);
			
			Calendarbase calendarBase = new Calendarbase();
			calendarBase.setCompany(company);
			
			if (idCalendarBase == -1) {
				
				if (idTemplate == -1) {
					calendarBase.setName(name);
					calendarBase.setCompany(company);
					
					calendarBase = CalendarBaseLogic.saveCalendar(calendarBase);
				}
				else {
					calendarBase = CalendarBaseLogic.consCalendarBase(new Calendarbase(idTemplate));
					calendarBase.setIdCalendarBase(null);
					calendarBase.setName(name);
					
					Set<Calendarbaseexceptions> exceptions = calendarBase.getCalendarbaseexceptionses();
					
					calendarBase = CalendarBaseLogic.saveCalendar(calendarBase);
					
					for (Calendarbaseexceptions item :exceptions) {
						
						item.setIdCalendarBaseException(null);
						item.setCalendarbase(calendarBase);
						
						CalendarbaseexceptionsLogic.saveException(item);
					}
				}
				
			}
			else {
				calendarBase.setIdCalendarBase(idCalendarBase);
				calendarBase.setWeekStart((weekStart == -1 ? null : weekStart));
				calendarBase.setFiscalYearStart((fiscalYearStart == -1 ? null : fiscalYearStart));
				calendarBase.setDaysMonth((daysMonth == -1 ? null : daysMonth));
				calendarBase.setStartTime1((startTime1 == -1 ? null : startTime1));
				calendarBase.setStartTime2((startTime2 == -1 ? null : startTime2));
				calendarBase.setEndTime1((endTime1 == -1 ? null : endTime1));
				calendarBase.setEndTime2((endTime2 == -1 ? null : endTime2));
				calendarBase.setHoursDay((hoursDay == -1 ? null : hoursDay));
				calendarBase.setHoursWeek((hoursWeek == -1 ? null : hoursWeek));
				
				if (name != null) {
					calendarBase.setName(name);
				}				
				calendarBase = CalendarBaseLogic.saveCalendar(calendarBase);
				
				for (Calendarbaseexceptions item : calendarBase.getCalendarbaseexceptionses()) {
					item.setCalendarbase(null);
				}
			}

			out.print(JsonUtil.toJSON(calendarBase, new Exclusion(Company.class), new Exclusion(Projectcalendar.class)));
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
	 * @throws ServletException
	 * @throws IOException
	 */
	private void createCalendar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Integer idTemplate	 	= ParamUtil.getInteger(req, "template_calendar",-1);
		String name 			= ParamUtil.getString(req, "new_calendar_name");
		
		Calendarbase calendarBase = null;

		try {
			
			Employee user = SecurityUtil.consUser(req);
			Company company = CompanyLogic.searchByEmployee(user);
			
			if (idTemplate == -1) {
				calendarBase = new Calendarbase();
				calendarBase.setName(name);
				calendarBase.setCompany(company);
				
				calendarBase = CalendarBaseLogic.saveCalendar(calendarBase);
			}
			else {
				calendarBase = CalendarBaseLogic.consCalendarBase(new Calendarbase(idTemplate));
				calendarBase.setIdCalendarBase(null);
				calendarBase.setName(name);
				calendarBase.setCompany(company);
				
				Set<Calendarbaseexceptions> exceptions = calendarBase.getCalendarbaseexceptionses();
				
				calendarBase = CalendarBaseLogic.saveCalendar(calendarBase);
				
				for (Calendarbaseexceptions item :exceptions) {
					
					item.setIdCalendarBaseException(null);
					item.setCalendarbase(calendarBase);
					
					CalendarbaseexceptionsLogic.saveException(item);
				}
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("calendarId", calendarBase.getIdCalendarBase());
		req.setAttribute("calendarName", calendarBase.getName());		
		
		viewCalendar(req, resp);
	
	}
	
	/**
     * View Calendar
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
    private void viewCalendar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    	Integer idCalendar = ParamUtil.getInteger(req, "calendarId", null);
    	
		List<Calendarbase> listCalendars = null;
		
		try {
			Employee user = SecurityUtil.consUser(req);
			Company company		= CompanyLogic.searchByEmployee(user);
			
			CalendarBaseLogic baseLogic = new CalendarBaseLogic();
			listCalendars = baseLogic.findByRelation(Calendarbase.COMPANY, company);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }

		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("calendar.base"));
		req.setAttribute("listCalendars", listCalendars);
		
		if (idCalendar != null) { req.setAttribute("calendarId", idCalendar); }
		
		forward("/index.jsp?nextForm=calendar/calendar", req, resp);	
	}
}
