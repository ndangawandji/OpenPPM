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

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.javabean.ParamResourceBundle;
import es.sm2.openppm.logic.ContactLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.PerformingOrgLogic;
import es.sm2.openppm.logic.PluginLogic;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;

/**
 * Servlet implementation class GestorServlet
 */
public abstract class AbstractGenericServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static final Logger LOGGER = Logger.getLogger(AbstractGenericServlet.class);
	private boolean isForward = false; 
	
	protected ResourceBundle idioma	= null;
	protected SimpleDateFormat dateFormat = null;
	protected NumberFormat numberFormat = null;
	protected String datePattern = null; 
	
    
	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String accion 		= ParamUtil.getString(request, "accion");
		String accionLogin	= ParamUtil.getString(request, "a");
		String scrollTop	= ParamUtil.getString(request, "scrollTop", null);
		setForward(false);
		
		if (scrollTop != null) { request.setAttribute("scrollTop", scrollTop); }
		
		setLocale(request);
		
		if (SecurityUtil.consUserRole(request) == -1 && !HomeServlet.CHOOSE_ROL.equals(accion)
				&& request.getRemoteUser() != null && !LoginServlet.LOGOFF.equals(accionLogin)
				&& !ErrorServlet.ERROR_403.equals(accion)) {
			
			setRolSession(request, response);
		}
	}

	/**
	 * Set locale
	 * @param request
	 */
	protected void setLocale(HttpServletRequest request) {
		
		try {
			String[] locale = getUser(request).getContact().getLocale().split("_");
			idioma = ResourceBundle.getBundle("es.sm2.openppm.common.openppm", new Locale(locale[0], locale[1]));
		}
		catch (Exception e) {
			idioma = ResourceBundle.getBundle("es.sm2.openppm.common.openppm", Constants.DEF_LOCALE);
		}
		
		dateFormat 		= new SimpleDateFormat(DateUtil.getDatePattern(idioma), Constants.DEF_LOCALE_NUMBER);
		numberFormat 	= NumberFormat.getNumberInstance(Constants.DEF_LOCALE_NUMBER);
		datePattern		= DateUtil.getDatePattern(idioma);
		
		request.setAttribute("locale", idioma.getLocale());
		request.setAttribute("datePattern", DateUtil.getDatePattern(idioma));
		request.setAttribute("datePickerPattern", DateUtil.getDatePickerPattern(idioma));
	}
	
	protected void setRolSession(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Contact contact = ContactLogic.findByUser(request.getRemoteUser());

			if (contact != null) {
				
				if (request.getSession().getAttribute("plugins") == null) {
					
					PluginLogic pluginLogic = new PluginLogic();
					request.getSession().setAttribute("plugins", pluginLogic.getPlugins(contact));
				}
				
				List<Employee> employees = EmployeeLogic.consEmployeesByUser(contact);
				
				if (employees.isEmpty()) {
					request.setAttribute("error", idioma.getString("msg.error.without_permission"));
					request.setAttribute("notLogin", true);
					
					HttpSession session = request.getSession();
					if (session != null) { session.invalidate();  }
					
					setForward(true);
					forward("/login.jsp", request, response);
				}
				else if (employees.size() == 1) {
					Employee user = EmployeeLogic.consEmployee(employees.get(0).getIdEmployee());
					request.getSession().setAttribute("user", user);
					request.getSession().setAttribute("rolPrincipal", user.getResourceprofiles().getIdProfile());
				}
				else if (employees.size() > 1) {
					List<Performingorg> orgs = PerformingOrgLogic.consByContact(contact);
					
					request.setAttribute("employees", employees);
					request.setAttribute("organizactions", orgs);
					setForward(true);
					forward("/select_rol.jsp", request, response);
				}
			}
			else {
				// Contact not exists
				//
				request.setAttribute("error", idioma.getString("msg.error_login.message"));
				setForward(true);
				forward("/index.jsp", request, response);
			}
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(request, idioma, LOGGER, e);
			setForward(true);
			forward("/index.jsp", request, response);
		}
	}

	/**
	 * JSP Forward
	 * @param uri
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void forward (String uri, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			getServletConfig().getServletContext().getRequestDispatcher("/jsp"+uri).forward(req, resp);
		}
		catch (Exception e) {
			LOGGER.error(StringPool.ERROR, e);
		}
	}
	
	/**
	 * Servlet Forward
	 * @param uri
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void forwardServlet(String uri, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			getServletConfig().getServletContext().getRequestDispatcher("/"+uri).forward(req, resp);
		}
		catch (Exception e) {
			LOGGER.error(StringPool.ERROR, e);
		}
	}
	
	/**
	 * Send file
	 * @param req
	 * @param resp
	 * @param file
	 * @throws ServletException
	 * @throws IOException
	 */
	protected void sendFile(HttpServletRequest req, HttpServletResponse resp, byte[] file, String fileName) throws ServletException, IOException {
		resp.setContentType("application/octet-stream");

		resp.setHeader("Content-Disposition", "attachment; filename=\""+fileName + "\"");
		resp.setContentLength(file.length);
		ByteArrayInputStream bais = new ByteArrayInputStream(file);
		OutputStream outs = resp.getOutputStream();
		int start = 0;
		int length = 4 * 1024; // Buffer de 4KB
		byte[] buff = new byte[length];
		while (bais.read(buff, start, length) != -1) {
			outs.write(buff, start, length);
		}
		bais.close();
		
	}
	
	
	@SuppressWarnings("rawtypes")
	protected Hashtable<String, FileItem> parseFields (List fileItems) throws IOException {

    	Hashtable<String, FileItem> hashFields = new Hashtable<String, FileItem>();
    	Iterator it = fileItems.iterator();
    	
		while (it.hasNext()) {
			
			FileItem fileItemTemp = (FileItem)it.next();
			
			if (fileItemTemp.isFormField()) {
				hashFields.put (fileItemTemp.getFieldName(), fileItemTemp);
			}
			else {
				hashFields.put ("file", fileItemTemp);
			}
		}

        return hashFields;
    }
	
	/****************** JSON Methods ***********************/
	
	protected JSONObject infoCreated(JSONObject info, String key) {
		
		return info("msg.info.created", info, key);
	}
	
	protected JSONObject infoUpdated(JSONObject info, String key) {
		
		return info("msg.info.updated", info, key);
	}

	protected JSONObject infoDeleted(String key) {
		
		return info("msg.info.deleted", null, key);
	}
	
	protected JSONObject putInfo(JSONObject objectJSON, JSONObject infoJSON) {
		
		if (objectJSON != null && infoJSON != null) {
		
			JSONArray information = infoJSON.getJSONArray(StringPool.INFORMATION);
			
			if (information != null) {
				objectJSON.put(StringPool.INFORMATION, information);
			}
		}
		return objectJSON;
	}
	
	protected JSONObject info(String key, JSONObject objectJSON, Object...args) {
		
		if (objectJSON == null) { objectJSON = new JSONObject(); }
		
		JSONArray information = null;
		try {
			information = objectJSON.getJSONArray(StringPool.INFORMATION);
			objectJSON.remove(StringPool.INFORMATION);
		}
		catch (Exception e) {
			information = new JSONArray();
		}

		ParamResourceBundle msgFormat = new ParamResourceBundle(key, true, args);
		
		information.add(msgFormat.getMessage(idioma));
		objectJSON.put(StringPool.INFORMATION, information);
		
		return objectJSON;
	}

	/****************** Request Methods ***********************/
	
	protected void infoCreated(HttpServletRequest req, String key) {
		
		info(req,"msg.info.created",key);
	}
	
	protected void infoUpdated(HttpServletRequest req, String key) {
		
		info(req,"msg.info.updated",key);
	}
	
	protected void infoDeleted(HttpServletRequest req, String key) {
		
		info(req,"msg.info.deleted",key);
	}
	
	@SuppressWarnings("unchecked")
	protected void info(HttpServletRequest req, String key, Object...args) {
		
		List<String> information = (List<String>) req.getAttribute("information");
		if (information == null) {
			information = new ArrayList<String>();
		}
		ParamResourceBundle msgFormat = new ParamResourceBundle(key, true, args);
		information.add(msgFormat.getMessage(idioma));
		req.setAttribute("information", information);
	}

	protected Employee getUser(HttpServletRequest req) {
		return SecurityUtil.consUser(req);
	}
	
	protected boolean isAjaxCall(HttpServletRequest request) {
		return ("XMLHttpRequest".equals(request.getHeader("X-Requested-With")));
	}
	
	public void setForward(boolean isForward) {
		this.isForward = isForward;
	}

	public boolean isForward() {
		return isForward;
	}
}
