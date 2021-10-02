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

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import es.sm2.openppm.logic.SecurityLogic;
import es.sm2.openppm.model.Security;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.StringPool;

public class LoginServlet extends AbstractGenericServlet {

	private static final long serialVersionUID = 1L;
	
	private static final  Logger LOGGER = Logger.getLogger(LoginServlet.class);
	
	public static final String REFERENCE = "login";
	
	/***************** Actions ****************/
	public static final String ERROR_LOGIN = "error-login";
	public static final String LOGOFF = "logoff";
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.service(req, resp);
		
		String accion = ParamUtil.getString(req, "a");
		LOGGER.debug("Accion: " + accion);
		
		/***************** Actions ****************/
		if (accion == null || StringPool.BLANK.equals(accion)) {
			
			if (isAjaxCall(req)) {
				PrintWriter out = resp.getWriter();
				try {
					JSONObject errorJSON = new JSONObject();
					errorJSON.put(StringPool.ERROR, idioma.getString("msg.error.session_expired")+"<a href='javascript:location.reload();'>"+idioma.getString("sign_in")+"</a>");
					out.print(errorJSON);
				}
				catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
				finally { out.close(); }
			}
			else {
				forward("/login.jsp", req, resp);
			}
		}
		else if (ERROR_LOGIN.equals(accion)) { viewLoginError(req, resp); }
		else if (LOGOFF.equals(accion)) { forward("/logoff.jsp", req, resp); }
	}
	
	private void viewLoginError(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
		
			Security sec = new Security();
			sec.setLogin(req.getParameter("j_username"));
			
			SecurityLogic.preLogin(sec);
			
			req.setAttribute(StringPool.ERROR, StringPool.TRUE);
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		forward("/login.jsp", req, resp);
	}
}
