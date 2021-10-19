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

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

import es.sm2.openppm.logic.SettingLogic;
import es.sm2.openppm.model.Setting;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.ValidateUtil;

public class AdministrationServlet extends AbstractGenericServlet {

	private static final long serialVersionUID = 1L;
	
	private static final  Logger LOGGER = Logger.getLogger(AdministrationServlet.class);
	
	public static final String REFERENCE = "administration";
	
	/***************** Actions ****************/
	public static final String SAVE_SETTING = "save-setting";
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.service(req, resp);
		
		String accion = ParamUtil.getString(req, "accion");
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1 && SecurityUtil.hasPermission(req, ValidateUtil.isNullCh(accion, REFERENCE))) {
			
			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion) || REFERENCE.equals(accion)) { viewAdministration(req, resp); }
			else if (SAVE_SETTING.equals(accion)) { saveSetting(req, resp); }
			
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}

	/**
	 * Save Setting
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	private void saveSetting(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		int idSetting	= ParamUtil.getInteger(req, Setting.IDSETTING);
		String value	= ParamUtil.getString(req, Setting.VALUE, null);
		
		PrintWriter out = resp.getWriter();
    	try {
    		
			SettingLogic settingLogic = new SettingLogic();
			Setting setting = settingLogic.findById(idSetting);
			
			setting.setValue(value);
			
			settingLogic.save(setting);
			
    		out.print(infoUpdated(new JSONObject(), "setting"));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

	/**
	 * View settings
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void viewAdministration(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<Setting> settings = null;
		
		try {
			
			SettingLogic settingLogic = new SettingLogic();
			
			settings = settingLogic.findByCompany(getUser(req));
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("settings", settings);
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));

		req.setAttribute("title", idioma.getString("settings"));
		forward("/index.jsp?nextForm=administration/administration", req, resp);
	}

}
