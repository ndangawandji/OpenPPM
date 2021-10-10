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

import org.apache.log4j.Logger;

import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.logic.ContactLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.SecurityLogic;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Security;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class UtilServlet
 */
public class MyAccountServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(MyAccountServlet.class);
	
	public final static String REFERENCE = "myaccount";
	
	/***************** Actions ****************/
	public final static String UPDATE_MY_ACCOUNT = "update-my-account";
	
	/************** Actions AJAX **************/
	public final static String JX_GENERATE_TOKEN = "ajax-generate-token";

    
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1) {
			
			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion)) { viewMyAccount(req, resp, null); }
			else if (UPDATE_MY_ACCOUNT.equals(accion)) { updateMyAccount(req, resp); }
			
			/************** Actions AJAX **************/
			else if (JX_GENERATE_TOKEN.equals(accion)) { generateTokenJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
    /**
     * Generate token for employee
     * @param req
     * @param resp
     * @throws IOException
     */
    private void generateTokenJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
    	
		int idEmployee = ParamUtil.getInteger(req, Employee.IDEMPLOYEE,-1);
		
    	try {
    		
    		EmployeeLogic employeeLogic = new EmployeeLogic();
    		
    		String token = employeeLogic.addToken(new Employee(idEmployee));
    		
    		out.print(JsonUtil.toJSON("token", token));
    	}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}


	/**
     * Update My Account
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     */
	private void updateMyAccount(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		String fullName 		= ParamUtil.getString(req, Contact.FULLNAME);
		String jobTitle 		= ParamUtil.getString(req, Contact.JOBTITLE);
		String fileAs 			= ParamUtil.getString(req, Contact.FILEAS);
		String businessAddress	= ParamUtil.getString(req, Contact.BUSINESSADDRESS);
		String businessPhone 	= ParamUtil.getString(req, Contact.BUSINESSPHONE);
		String mobilePhone		= ParamUtil.getString(req, Contact.MOBILEPHONE);
		String email			= ParamUtil.getString(req, Contact.EMAIL);
		String notes			= ParamUtil.getString(req, Contact.NOTES);
		String password			= ParamUtil.getString(req, "password", null);
		String passwordNew		= ParamUtil.getString(req, "passwordNew");
		String passwordConfirm	= ParamUtil.getString(req, "passwordConfirm");
		String locale 			= ParamUtil.getString(req, "locale", null);
		
		Employee user = SecurityUtil.consUser(req);
		Security security = null;
		
		try {
			
			Contact contact = ContactLogic.consultContact(user.getContact().getIdContact());
			
			if (!ValidateUtil.isNull(password)) {
				security = SecurityLogic.getByContact(user.getContact());
				
				if (!security.getPassword().equals(SecurityUtil.md5(password))) {					
					throw new LogicException("msg.error.pass_incorrect");
				}
				else if (!ValidateUtil.isNull(passwordNew) && !passwordNew.equals(passwordConfirm)) {
					throw new LogicException("msg.error.pass_not_match");
				}
				else {					 
					security.setPassword(SecurityUtil.md5(passwordNew));
					SecurityLogic.updateSecurity(security);
					infoUpdated(req, "pass");
				}
			}
			String oldLocale = contact.getLocale();
			
			contact.setFullName(fullName);
			contact.setJobTitle(jobTitle);
			contact.setFileAs(fileAs);
			contact.setBusinessAddress(businessAddress);
			contact.setBusinessPhone(businessPhone);
			contact.setMobilePhone(mobilePhone);
			contact.setEmail(email);
			contact.setNotes(notes);
			contact.setLocale(locale);
			
			ContactLogic.saveContact(contact);
			
			user = EmployeeLogic.consEmployee(user.getIdEmployee());
			req.getSession().setAttribute("user", user);
			req.getSession().setAttribute("rolPrincipal", user.getResourceprofiles().getIdProfile());
			
			if (oldLocale != null && !oldLocale.equals(locale)) { setLocale(req); }
			
			infoUpdated(req, "contact");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewMyAccount(req, resp, security);
	}


	/**
	 * View My Account
	 * @param req
	 * @param resp
	 * @param security 
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewMyAccount(HttpServletRequest req, HttpServletResponse resp, Security security) throws ServletException, IOException {
		
		List<Employee> employees	= null;
		
		try {
			
			EmployeeLogic employeeLogic = new EmployeeLogic();
			
			Employee user = SecurityUtil.consUser(req);
			
			if (security == null) {
				security = SecurityLogic.getByContact(user.getContact());
			}
			
			employees = employeeLogic.findForToken(user.getContact());
			
			req.setAttribute("username", security.getLogin());
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		req.setAttribute("employees", employees);
		
		req.setAttribute("title", idioma.getString("my_account"));
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		forward("/index.jsp?nextForm=common/my_account", req, resp);
	}
}
