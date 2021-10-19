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

import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ParamUtil;

public class ErrorServlet extends AbstractGenericServlet {

	private static final long serialVersionUID = 1L;
	
	private static final  Logger LOGGER = Logger.getLogger(ErrorServlet.class);
	
	public static final String REFERENCE = "error";
	
	/***************** Actions ****************/
	public static final String ERROR_403 = "403";
	public static final String ERROR_404 = "404";
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.service(req, resp);
		
		String accion = ParamUtil.getString(req, "accion",ERROR_403);
		LOGGER.debug("Accion: " + accion);
		
		/***************** Actions ****************/
		if (ERROR_403.equals(accion)) { notPermission(req, resp); }
		else if (ERROR_404.equals(accion)) { notFound(req, resp); }
	}

	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void notFound(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("error", idioma.getString("msg.error.404"));
		forward("/index.jsp", req, resp);
	}

	/**
	 * No permission for view
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void notPermission(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("error", idioma.getString("msg.error.without_permission"));
		forward("/index.jsp", req, resp);
	}
}
