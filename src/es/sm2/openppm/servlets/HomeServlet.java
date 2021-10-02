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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;

/**
 * Servlet implementation class TimeSheetServlet
 */
public class HomeServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(HomeServlet.class);

	public final static String REFERENCE = "home";
	
	/***************** Actions ****************/
	public final static String CHOOSE_ROL	= "choose-rol";
	public final static String SELECT_ROL	= "select-rol";
	
	/************** Actions AJAX **************/
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		LOGGER.debug("Accion: " + accion);
		
		if (CHOOSE_ROL.equals(accion)) {
			
			chooseRol(req, resp);
			accion = StringPool.BLANK;
		}
		else if (SELECT_ROL.equals(accion)) {
			
			SecurityUtil.unsetUserRole(req);
			
			accion = "";
			setRolSession(req, resp);
			
			if (SecurityUtil.consUserRole(req) != -1) {
				info(req, "msg.info.one-profile");
			}
		}
		
		if (SecurityUtil.consUserRole(req) != -1) {
			
			/************** Actions AJAX **************/
			if (accion == null || StringPool.BLANK.equals(accion)) { viewInitPage(req, resp); }
			
			/************** Actions AJAX **************/
			
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}

    /**
     * View init page
     * @param req
     * @param resp
     * @throws IOException 
     * @throws ServletException 
     */
	private void viewInitPage(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if (SecurityUtil.isUserInRole (req, Constants.ROLE_PMO)) {
			
			req.setAttribute("url", ProjectServlet.REFERENCE+"?accion="+ProjectServlet.LIST_INVESTMENTS);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_PORFM)) {
			
			req.setAttribute("url", ProjectServlet.REFERENCE+"?accion="+ProjectServlet.LIST_INVESTMENTS);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_FM)) {

			req.setAttribute("url", ProjectServlet.REFERENCE+"?accion="+ProjectServlet.LIST_INVESTMENTS);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_SPONSOR)) {

			req.setAttribute("url", ProjectServlet.REFERENCE+"?accion="+ProjectServlet.LIST_INVESTMENTS);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_IM)) {

			req.setAttribute("url", ProjectServlet.REFERENCE+"?accion="+ProjectServlet.LIST_INVESTMENTS);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_PROGM)) {

			req.setAttribute("url", ProjectServlet.REFERENCE+"?accion="+ProjectServlet.LIST_INVESTMENTS);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_PM)) {

			req.setAttribute("url", ProjectServlet.REFERENCE);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_RM)) {
			
			req.setAttribute("url", ResourceServlet.REFERENCE);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_RESOURCE)) {

			req.setAttribute("url", AssignmentServlet.REFERENCE);
			forward("/redirect.jsp", req, resp);
		}
		else if (SecurityUtil.isUserInRole (req, Constants.ROLE_ADMIN)) {

			req.setAttribute("url", AdministrationServlet.REFERENCE);
			forward("/redirect.jsp", req, resp);
		}
		else {
			
			req.setAttribute("url", ErrorServlet.REFERENCE);
			forward("/redirect.jsp", req, resp);
		}
	}

	private void chooseRol(HttpServletRequest req, HttpServletResponse resp) {
		
    	int idEmployee = ParamUtil.getInteger(req, "idEmployee",-1);
    	
    	try {
    		Employee user = EmployeeLogic.consEmployee(idEmployee);
			req.getSession().setAttribute("user", user);
			req.getSession().setAttribute("rolPrincipal", user.getResourceprofiles().getIdProfile());
    	}
    	catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
	}
}
