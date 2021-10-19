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
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.exceptions.ChangePasswordException;
import es.sm2.openppm.exceptions.EmployeeNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.LoginNameInUseException;
import es.sm2.openppm.javabean.ParamResourceBundle;
import es.sm2.openppm.logic.BscdimensionLogic;
import es.sm2.openppm.logic.BudgetaccountsLogic;
import es.sm2.openppm.logic.CalendarBaseLogic;
import es.sm2.openppm.logic.CategoryLogic;
import es.sm2.openppm.logic.ChangeTypesLogic;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.ContactLogic;
import es.sm2.openppm.logic.ContentFileLogic;
import es.sm2.openppm.logic.ContractTypeLogic;
import es.sm2.openppm.logic.CustomerLogic;
import es.sm2.openppm.logic.CustomertypeLogic;
import es.sm2.openppm.logic.DocumentationLogic;
import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.logic.ExpenseaccountsLogic;
import es.sm2.openppm.logic.FundingsourceLogic;
import es.sm2.openppm.logic.GeographyLogic;
import es.sm2.openppm.logic.MetrickpiLogic;
import es.sm2.openppm.logic.OperationLogic;
import es.sm2.openppm.logic.OperationaccountLogic;
import es.sm2.openppm.logic.PerformingOrgLogic;
import es.sm2.openppm.logic.ProgramLogic;
import es.sm2.openppm.logic.ResourceProfilesLogic;
import es.sm2.openppm.logic.SecurityLogic;
import es.sm2.openppm.logic.SellerLogic;
import es.sm2.openppm.logic.SkillLogic;
import es.sm2.openppm.logic.SkillsemployeeLogic;
import es.sm2.openppm.model.Bscdimension;
import es.sm2.openppm.model.Budgetaccounts;
import es.sm2.openppm.model.Calendarbase;
import es.sm2.openppm.model.Category;
import es.sm2.openppm.model.Changetype;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Contentfile;
import es.sm2.openppm.model.Contracttype;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Customertype;
import es.sm2.openppm.model.Documentation;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expenseaccounts;
import es.sm2.openppm.model.Fundingsource;
import es.sm2.openppm.model.Geography;
import es.sm2.openppm.model.Metrickpi;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.model.Operationaccount;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Security;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.model.Skillsemployee;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.EmailUtil;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JSONModelUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class MantenimientosServlet
 */
public class MaintenanceServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
	   
	private static final Logger LOGGER = Logger.getLogger(MaintenanceServlet.class);
	
	public final static String REFERENCE = "maintenance";
	
	/***************** Actions ****************/
	public final static String CONS_MAINTENANCE		= "cons-maintenance";
	public final static String DEL_COMPANY			= "delete-company";
	public final static String DEL_PERFORG			= "delete-perfoming-org";
	public final static String DEL_SKILL			= "delete-skill";
	public final static String DEL_CONTACT			= "delete-contact";
	public final static String SAVE_EMPLOYEE	 	= "save-employee";
	public final static String DEL_EMPLOYEE			= "delete-employee";
	public final static String DEL_BUDGETACCOUNTS	= "delete-budgetaccounts";
	public final static String DEL_CONTRACTTYPE		= "delete-contracttype";
	public final static String DEL_CHANGETYPE		= "delete-changetype";
	public final static String DEL_EXPENSEACCOUNTS	= "delete-expenseaccounts";
	public final static String DEL_CATEGORY			= "delete-category";
	public final static String DEL_GEOGRAPHY		= "delete-geography";
	public final static String DEL_OPERATIONACCOUNT = "delete-operationaccount";
	public final static String DEL_OPERATION		= "delete-operation";
	public final static String DEL_CUSTOMER			= "delete-customer";
	public final static String DEL_SELLER			= "delete-seller";
	public final static String DEL_METRIC			= "delete-metric";
	public final static String DEL_CUSTOMER_TYPE	= "delete-customer-type";
	public final static String DEL_FUNDINGSOURCE 	= "delete-fundingsource";
	public final static String SAVE_DOCUMENTATION 	= "save-documentation";
	public final static String DEL_DOCUMENTATION 	= "delete-documentation";
	
	/************** Actions AJAX **************/
	public final static String JX_SAVE_COMPANY			= "ajax-save-company";
	public final static String JX_SAVE_PERFORG			= "ajax-save-performing-org";
	public final static String JX_SAVE_SKILL			= "ajax-save-skill";
	public final static String JX_SAVE_CONTACT			= "ajax-save-contact";	
	public final static String JX_SAVE_BUDGETACCOUNTS	= "ajax-save-budgetaccounts";
	public final static String JX_SAVE_CONTRACTTYPE		= "ajax-save-contracttype";
	public final static String JX_SAVE_CHANGETYPE		= "ajax-save-changetype";
	public final static String JX_SAVE_EXPENSEACCOUNTS	= "ajax-save-expenseaccounts";
	public final static String JX_SAVE_CATEGORY			= "ajax-save-category";
	public final static String JX_SAVE_GEOGRAPHY		= "ajax-save-geography";
	public final static String JX_SAVE_OPERATIONACCOUNT	= "ajax-save-operationaccount";
	public final static String JX_SAVE_OPERATION		= "ajax-save-operation";
	public final static String JX_RESET_PASSWORD		= "ajax-reset-password";
	public final static String JX_GET_USERNAME			= "ajax-get-username";
	public final static String JX_SAVE_CUSTOMER			= "ajax-save-customer";
	public final static String JX_SAVE_SELLER			= "ajax-save-seller";
	public final static String JX_SAVE_METRIC			= "ajax-save-metric";
	public final static String JX_SAVE_CUSTOMER_TYPE	= "ajax-save-customer-type";
	public final static String JX_CONS_SKILLS			= "ajax-cons-skills";
	public final static String JX_SAVE_FUNDINGSOURCE	= "ajax-save-fundingsource";
	
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
	@SuppressWarnings("rawtypes")
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		super.service(req, resp);
		
		String accion = ParamUtil.getString(req, "accion", "");
		Hashtable<String, FileItem> reqFields = null;
		
		if (SecurityUtil.consUserRole(req) != -1 && SecurityUtil.isUserInRole(req, Constants.ROLE_PMO)) {
			if(ServletFileUpload.isMultipartContent(req) && StringPool.BLANK.equals(accion)) {	
				try {
					
					ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
					List fileItemList = servletFileUpload.parseRequest(req);
					reqFields = parseFields(fileItemList);
					accion = reqFields.get("accion").getString();
					
				} catch (FileUploadException e) {
					LOGGER.error(StringPool.ERROR, e);
					req.setAttribute(StringPool.ERROR, e.getMessage());
				}
			}
			
			LOGGER.debug("Accion: " + accion);

			
			/***************** Actions ****************/
			if (StringPool.BLANK.equals(accion)) { viewMaintenance(req, resp); }
			else if (CONS_MAINTENANCE.equals(accion)) { consMaintenance(req, resp, null); }
			else if (DEL_COMPANY.equals(accion)) { deleteCompany(req, resp); }
			else if (SAVE_EMPLOYEE.equals(accion)) { saveEmployee(req, resp); }
			else if (DEL_EMPLOYEE.equals(accion)) { deleteEmployee(req, resp); }
			else if (DEL_PERFORG.equals(accion)) { deletePerfOrg(req, resp); }
			else if (DEL_SKILL.equals(accion)) { deleteSkill(req, resp); }
			else if (DEL_CONTACT.equals(accion)) { deleteContact(req, resp); }
			else if (DEL_BUDGETACCOUNTS.equals(accion)) { deleteBudgetAccount(req, resp); }
			else if (DEL_CONTRACTTYPE.equals(accion)) { deleteContractType(req, resp); }
			else if (DEL_CHANGETYPE.equals(accion)) { deleteChangeType(req, resp); }
			else if (DEL_EXPENSEACCOUNTS.equals(accion)) { deleteExpenseAccount(req, resp); }
			else if (DEL_CATEGORY.equals(accion)) { deleteCategory(req, resp); }
			else if (DEL_GEOGRAPHY.equals(accion)) { deleteGeography(req, resp); }
			else if (DEL_OPERATIONACCOUNT.equals(accion)) { deleteOperationAccount(req, resp); }
			else if (DEL_OPERATION.equals(accion)) { deleteOperation(req, resp); }
			else if (DEL_CUSTOMER.equals(accion)) { deleteCustomer(req, resp); }
			else if (DEL_SELLER.equals(accion)) { deleteSeller(req, resp); }
			else if (DEL_METRIC.equals(accion)) { deleteMetric(req, resp); }
			else if (DEL_CUSTOMER_TYPE.equals(accion)) { deleteCustomerType(req, resp); }
			else if (DEL_FUNDINGSOURCE.equals(accion)) { deleteFundingSource(req, resp); }
			else if (SAVE_DOCUMENTATION.equals(accion)) { saveDocumentation(req, resp, reqFields); }
			else if (DEL_DOCUMENTATION.equals(accion)) { deleteDocumentation(req, resp); }
			
			/************** Actions AJAX **************/
			else if (JX_SAVE_COMPANY.equals(accion)) { saveCompanyJX(req, resp); }
			else if (JX_SAVE_PERFORG.equals(accion)) { savePerfOrgJX(req, resp); }
			else if (JX_SAVE_SKILL.equals(accion)) { saveSkillJX(req, resp); }
			else if (JX_SAVE_CONTACT.equals(accion)) { saveContactJX(req, resp); }
			else if (JX_RESET_PASSWORD.equals(accion)) { resetPasswordJX(req, resp); }
			else if (JX_GET_USERNAME.equals(accion)) { getUserNameJX(req, resp); }
			else if (JX_SAVE_BUDGETACCOUNTS.equals(accion)) { saveBudbetAccountJX(req, resp); }
			else if (JX_SAVE_CONTRACTTYPE.equals(accion)) { saveContractTypeJX(req, resp); }
			else if (JX_SAVE_CHANGETYPE.equals(accion)) { saveChangeTypeJX(req, resp); }
			else if (JX_SAVE_EXPENSEACCOUNTS.equals(accion)) { saveExpenseAccountJX(req, resp); }
			else if (JX_SAVE_CATEGORY.equals(accion)) { saveCategoryJX(req, resp); }
			else if (JX_SAVE_GEOGRAPHY.equals(accion)) { saveGeographyJX(req, resp); }
			else if (JX_SAVE_OPERATIONACCOUNT.equals(accion)) { saveOperationAccountJX(req, resp); }
			else if (JX_SAVE_OPERATION.equals(accion)) { saveOperationJX(req, resp); }
			else if (JX_SAVE_CUSTOMER.equals(accion)) { saveCustomerJX(req, resp); }
			else if (JX_SAVE_SELLER.equals(accion)) { saveSellerJX(req, resp); }
			else if (JX_SAVE_METRIC.equals(accion)) { saveMetricJX(req, resp); }
			else if (JX_SAVE_CUSTOMER_TYPE.equals(accion)) { saveCustomerTypeJX(req, resp); }
			else if (JX_CONS_SKILLS.equals(accion)) { consSkillsJX(req, resp); }
			else if (JX_SAVE_FUNDINGSOURCE.equals(accion)) { saveFundingSourceJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}

	/**
	 * Save or update Funding Source
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveFundingSourceJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		int idFundingSource	= ParamUtil.getInteger(req, "id", -1);
		String name 		= ParamUtil.getString(req, "name");
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();
		
		try {		
			JSONObject infoJSON	= null;
			Fundingsource fundingsource	= null;
			
			if (idFundingSource == -1){
			
				fundingsource = new Fundingsource();
				
				infoJSON = infoCreated(infoJSON, "maintenance.fundingsource"); 
			}
			else {
				FundingsourceLogic fundingsourceLogic = new FundingsourceLogic();
				fundingsource = fundingsourceLogic.findById(idFundingSource, false);
				
				infoJSON = infoUpdated(infoJSON, "maintenance.fundingsource");
			}
			
			fundingsource.setName(name);
			fundingsource.setCompany(CompanyLogic.searchByEmployee(loguedUser));
			
			fundingsource = FundingsourceLogic.saveFundingsource(fundingsource);			
			
			infoJSON.put( Fundingsource.IDFUNDINGSOURCE, fundingsource.getIdFundingSource());
			infoJSON.put( Fundingsource.NAME, fundingsource.getName());
			
			out.print(infoJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Delete Funding Source
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteFundingSource(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idFundingSource = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			FundingsourceLogic.deleteFundingsource(new Fundingsource(idFundingSource));
			infoDeleted(req, "maintenance.fundingsource");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete Customer Type
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteCustomerType(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idCustomerType = ParamUtil.getInteger(req, Customertype.IDCUSTOMERTYPE, -1);
		
		try {
			CustomertypeLogic.deleteCustomertype(new Customertype(idCustomerType));
			infoDeleted(req, "customer_type");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Save or update customer type
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	private void saveCustomerTypeJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		int idCustomerType	= ParamUtil.getInteger(req, Customertype.IDCUSTOMERTYPE, -1);
		String name			= ParamUtil.getString(req, Customertype.NAME);
		String description	= ParamUtil.getString(req, Customertype.DESCRIPTION);

		PrintWriter out			= resp.getWriter();
		
		try {
			JSONObject infoJSON		= null;
			Customertype type		= null;
			
			if (idCustomerType == -1) {
				Employee loguedUser = SecurityUtil.consUser(req);
				Company company		= CompanyLogic.searchByEmployee(loguedUser);
				
				type = new Customertype();
				
				type.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "customer_type");
			}
			else {
				CustomertypeLogic customertypeLogic = new CustomertypeLogic();
				type = customertypeLogic.findById(idCustomerType, false);
				
				infoJSON = infoUpdated(infoJSON, "customer_type");
			}
			
			type.setName(name);
			type.setDescription(description);
			
			type = CustomertypeLogic.saveCustomertype(type);
		
			infoJSON.put(Customertype.IDCUSTOMERTYPE, type.getIdCustomerType());
			
			out.print(infoJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}


	/**
	 * Delete Metric
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteMetric(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idMetricKpi = ParamUtil.getInteger(req, Metrickpi.IDMETRICKPI, -1);
		
		try {
			MetrickpiLogic.deleteMetrickpi(new Metrickpi(idMetricKpi));
			infoDeleted(req, "metric");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}


	/**
	 * Save or create Metric Kpi
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void saveMetricJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		int idMetricKpi		= ParamUtil.getInteger(req, Metrickpi.IDMETRICKPI, -1);
		String name			= ParamUtil.getString(req, Metrickpi.NAME);
		String definition	= ParamUtil.getString(req, Metrickpi.DEFINITION);
		int idBscDimension	= ParamUtil.getInteger(req, Bscdimension.IDBSCDIMENSION, -1);

		PrintWriter out = resp.getWriter();
		
		try {
			Metrickpi metric		= null;
			JSONObject infoJSON		= null;
			
			if (idMetricKpi == -1) {
				Employee loguedUser = SecurityUtil.consUser(req);
				Company company 	= CompanyLogic.searchByEmployee(loguedUser);
				
				metric = new Metrickpi();
				metric.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "metric");
			}
			else {
				MetrickpiLogic metrickpiLogic = new MetrickpiLogic();
				metric = metrickpiLogic.findById(idMetricKpi, false);
				
				infoJSON = infoUpdated(infoJSON, "metric");
			}
			
			metric.setName(name);
			metric.setDefinition(definition);
			
			if (idBscDimension != -1) {
				metric.setBscdimension(new Bscdimension(idBscDimension));
			}
			else {
				metric.setBscdimension(null);
			}
			
			metric = MetrickpiLogic.saveMetrickpi(metric);
			
			infoJSON.put(Metrickpi.IDMETRICKPI, metric.getIdMetricKpi());
			
			out.print(infoJSON);
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
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void viewMaintenance(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		req.setAttribute("title", idioma.getString("menu.maintenance"));
		forward("/index.jsp?nextForm=maintenance/maintenance", req, resp);
	}

	/**
	 * Save Customer Exception
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveCustomerJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idCustomer		= ParamUtil.getInteger(req, "id", -1);
		String name			= ParamUtil.getString(req, "name");
		int idCustomerType	= ParamUtil.getInteger(req, "type", -1);
		String description	= ParamUtil.getString(req, "description");
		
		Employee loguedUser = SecurityUtil.consUser(req);		

		PrintWriter out		= resp.getWriter();
		
		try {
			JSONObject infoJSON = null;
			Customer customer 	= null;
	    	
	    	if (idCustomer == -1) {   
	    		customer = new Customer();
	    		
	    		infoJSON = infoCreated(infoJSON, "customer"); 
	    	}
	    	else {
	    		customer = CustomerLogic.findById(idCustomer, false);
	    		
	    		infoJSON = infoUpdated(infoJSON, "customer");
	    	}
	    	
	    	if (idCustomerType == -1) { customer.setCustomertype(null); }
	    	else { customer.setCustomertype(new Customertype(idCustomerType)); }
	    	
    		customer.setName(name);
    		customer.setDescription(description);
    		customer.setCompany(CompanyLogic.searchByEmployee(loguedUser));
    		CustomerLogic.saveCustomer(customer);
			
			infoJSON.put("idCustomer", customer.getIdCustomer());
			
			out.print(infoJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
	
	/**
	 * Save Seller Exception
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveSellerJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idSeller			= ParamUtil.getInteger(req, "id", -1);
		String name				= ParamUtil.getString(req, "name");
		Boolean selected		= ParamUtil.getBoolean(req, "selected", false);
		Boolean qualified		= ParamUtil.getBoolean(req, "qualified", false);
		Date qualifiedDate		= ParamUtil.getDate(req, "qualifiedDate", dateFormat, null);
		String information		= ParamUtil.getString(req, "information");
		Boolean sole			= ParamUtil.getBoolean(req, "sole", false);
		Boolean single			= ParamUtil.getBoolean(req, "single", false);
		
		Employee loguedUser 	= SecurityUtil.consUser(req);		

		PrintWriter out			= resp.getWriter();
		
		try {
			JSONObject infoJSON	= null;
			Seller seller 		= null;
	    	
	    	if (idSeller == -1) {    		
	    		seller = new Seller();
	    		
	    		infoJSON = infoCreated(infoJSON, "seller"); 
	    	}
	    	else{
	    		SellerLogic sellerLogic = new SellerLogic();
	    		seller = sellerLogic.findById(idSeller, false);
	    		
	    		infoJSON = infoUpdated(infoJSON, "seller");
	    	}
	    	
    		seller.setName(name);
    		seller.setInformation(information);
    		seller.setSelected(selected);
    		seller.setQualified(qualified);
    		seller.setQualificationDate(qualifiedDate);
    		seller.setSingleSource(single);
    		seller.setSoleSource(sole);
    		
    		seller.setCompany(CompanyLogic.searchByEmployee(loguedUser));
			
			seller = SellerLogic.saveSeller(seller);
			
			infoJSON.put("idSeller", seller.getIdSeller());
			
			out.print(infoJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Save Operation
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveOperationJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idOperation 		= ParamUtil.getInteger(req, "id", -1);
		String operationName 	= ParamUtil.getString(req, "name", "");
		String operationCode	= ParamUtil.getString(req, "code", "");
		Integer idOpAccount		= ParamUtil.getInteger(req, "idOpAccount", -1);
		
		PrintWriter out = resp.getWriter();	
		
		try {
			JSONObject infoJSON	= null;
			Operation operation = null;
			
			if (idOperation == -1){
				operation = new Operation();
				
				infoJSON = infoCreated(infoJSON, "operation"); 
			}
			else{
				operation = OperationLogic.consOperation(idOperation);
				
				infoJSON = infoUpdated(infoJSON, "operation");
			}

			Operationaccount operationaccount = new Operationaccount();
			if (idOpAccount != -1) {
				operationaccount.setIdOpAccount(idOpAccount);
				operation.setOperationaccount(operationaccount);
			}
			
			operation.setOperationCode(operationCode);
			operation.setOperationName(operationName);
			
			OperationLogic.saveOperation(operation);			
			
			out.print(putInfo(JSONModelUtil.operationToJSON(operation), infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Save OperationAccount
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveOperationAccountJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idOperationAccount		= ParamUtil.getInteger(req, "id", -1);
		String description			= ParamUtil.getString(req, "description", "");
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();	
		
		try {
			JSONObject infoJSON					= null;
			Operationaccount operationaccount 	= null;
			
			Company company		= CompanyLogic.searchByEmployee(loguedUser);
			
			if (idOperationAccount == -1){
				operationaccount = new Operationaccount();
				
				operationaccount.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "maintenance.operation.op_account"); 
			}
			else{
				OperationaccountLogic operationaccountLogic = new OperationaccountLogic();
				
				operationaccount = operationaccountLogic.findById(idOperationAccount);
				
				infoJSON = infoUpdated(infoJSON, "maintenance.operation.op_account");
			}

			operationaccount.setDescription(description);
			
			OperationaccountLogic.saveOperationAccount(operationaccount);			
			
			out.print(putInfo(JSONModelUtil.operationAccountToJSON(operationaccount),infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Save Geography
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveGeographyJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idGeography 	= ParamUtil.getInteger(req, "id", -1);
		String name			= ParamUtil.getString(req, "name", "");
		String description	= ParamUtil.getString(req, "description", "");
		
		PrintWriter out 	= resp.getWriter();
		
		try {		
			JSONObject infoJSON	= null;
			Geography geography = null;
			GeographyLogic geoLogic = new GeographyLogic();
			
			if (idGeography == -1){
				geography = new Geography();
				
				Employee user = SecurityUtil.consUser(req);
				Company company = CompanyLogic.searchByEmployee(user);
				geography.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "geography"); 
			}
			else{				
				geography = geoLogic.findById(idGeography);
				
				infoJSON = infoUpdated(infoJSON, "geography");
			}
			
			geography.setName(name);
			geography.setDescription(description);
			
			geoLogic.save(geography);			
			
			out.print(putInfo(JSONModelUtil.geographyToJSON(geography), infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Save Category
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveCategoryJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idCategory		= ParamUtil.getInteger(req, "id", -1);
		String categoryName = ParamUtil.getString(req, "name", "");
		String description	= ParamUtil.getString(req, "description", "");
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();
		
		try {		
			JSONObject infoJSON	= null;
			Category category	= null;
			
			if (idCategory == -1){
				category 		= new Category();
				Company company	= CompanyLogic.searchByEmployee(loguedUser);
				category.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "category"); 
			}
			else {
				CategoryLogic categoryLogic = new CategoryLogic();
				
				category = categoryLogic.findById(idCategory);
				
				infoJSON = infoUpdated(infoJSON, "category");
			}
			
			category.setName(categoryName);
			category.setDescription(description);
			
			CategoryLogic.saveCategory(category);
			
			out.print(putInfo(JSONModelUtil.categoryToJSON(category), infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}


	/**
	 * Save Expenseaccounts
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveExpenseAccountJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idExpenseAccount	= ParamUtil.getInteger(req, "id", -1);
		String description		= ParamUtil.getString(req, "description", "");
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();
		
		try {	
			JSONObject infoJSON				= null;
			Expenseaccounts expenseaccount 	= null;
			
			if (idExpenseAccount == -1){
				expenseaccount 	= new Expenseaccounts();
				Company company	= CompanyLogic.searchByEmployee(loguedUser);
				expenseaccount.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "maintenance.expenseaccounts"); 
			}
			else{
				ExpenseaccountsLogic expenseaccountsLogic = new ExpenseaccountsLogic();
				
				expenseaccount = expenseaccountsLogic.findById(idExpenseAccount);
				
				infoJSON = infoUpdated(infoJSON, "maintenance.expenseaccounts");
			}
			
			expenseaccount.setDescription(description);
			
			ExpenseaccountsLogic.saveExpenseAccount(expenseaccount);
			
			out.print(putInfo(JSONModelUtil.expenseAccountToJSON(expenseaccount), infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}	
	}

	/**
	 * Save contracttype
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveContractTypeJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idContractType	= ParamUtil.getInteger(req, "id", -1);
		String description	= ParamUtil.getString(req, "description", "");
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();
		
		try {		
			JSONObject infoJSON			= null;
			Contracttype contractType 	= null;
			
			if (idContractType == -1){
				contractType 	= new Contracttype();
				Company company	= CompanyLogic.searchByEmployee(loguedUser);
				contractType.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "contract_type");
			}
			else{
				ContractTypeLogic contractTypeLogic = new ContractTypeLogic();
				
				contractType = contractTypeLogic.findById(idContractType);
				
				infoJSON = infoUpdated(infoJSON, "contract_type");
			}
			
			contractType.setDescription(description);
			
			ContractTypeLogic.saveContractType(contractType);
			
			out.print(putInfo(JSONModelUtil.contractTypeToJSON(contractType),infoJSON));
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
	private void saveChangeTypeJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idChangeType	= ParamUtil.getInteger(req, "id", -1);
		String description	= ParamUtil.getString(req, "description", "");
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();
		
		try {		
			JSONObject infoJSON			= null;
			Changetype changeType 	= null;
			ChangeTypesLogic changeTypeLogic = new ChangeTypesLogic();
			
			if (idChangeType == -1){
				changeType 	= new Changetype();
				Company company	= CompanyLogic.searchByEmployee(loguedUser);
				changeType.setCompany(company);
				infoJSON = infoCreated(infoJSON, "change_type");
			}
			else{			
				changeType = changeTypeLogic.findById(idChangeType);
				infoJSON = infoUpdated(infoJSON, "change_type");
			}
			
			changeType.setDescription(description);
			
			changeType = changeTypeLogic.save(changeType);
			
			infoJSON.put(Changetype.IDCHANGETYPE, changeType.getIdChangeType());
			
			out.print(infoJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}	
	}

	/**
	 * Save budgetaccounts
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveBudbetAccountJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idBudgetAccounts	= ParamUtil.getInteger(req, "id", -1);
		String description		= ParamUtil.getString(req, "description", "");
		Integer typeCost		= ParamUtil.getInteger(req, "type_cost", -1);
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();
		
		try {	
			JSONObject infoJSON				= null;
			Budgetaccounts budgetaccounts 	= null;
			
			if (idBudgetAccounts == -1){
				budgetaccounts 	= new Budgetaccounts();
				Company company	= CompanyLogic.searchByEmployee(loguedUser);
				budgetaccounts.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "maintenance.budgetaccounts"); 
			}
			else{
				BudgetaccountsLogic budgetaccountsLogic = new BudgetaccountsLogic();
				budgetaccounts 							= budgetaccountsLogic.findById(idBudgetAccounts);
				
				infoJSON = infoUpdated(infoJSON, "maintenance.budgetaccounts"); 
			}
			
			budgetaccounts.setDescription(description);
			budgetaccounts.setTypeCost(typeCost);
			
			BudgetaccountsLogic.saveBudgetAccounts(budgetaccounts);
			
			out.print(putInfo(JSONModelUtil.budgetAccountsToJSON(idioma, budgetaccounts),infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * return the username of contact
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void getUserNameJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idContact = ParamUtil.getInteger(req, "idContact",-1);
		
		PrintWriter out = resp.getWriter();	
		
		try {		
			Security security = SecurityLogic.getByContact(new Contact(idContact));
			
			JSONObject dataJSON = new JSONObject();
			
			if (security == null) {
				dataJSON.put(StringPool.ERROR, idioma.getString("msg.error.username"));
			}
			else {
				dataJSON.put("login", security.getLogin());
			}
			
			out.print(dataJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Reset Password
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void resetPasswordJX(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idContact = ParamUtil.getInteger(req, "idContact",-1);
		
		PrintWriter out = resp.getWriter();
		
		try {
			JSONObject replyJSON = new JSONObject();
			
			if (idContact == -1) {
				throw new EmployeeNotFoundException("msg.error.employee");
			}
			else {
				Contact contact = ContactLogic.consultContact(idContact);
				String to = contact.getEmail();
				String password = null;
				if (!Settings.LOGIN_LDAP && Settings.MAIL_NOTIFICATION && to != null && !"".equals(to)) {
					password = SecurityUtil.getRandomString(8);
				}
				Security security = SecurityLogic.changePassword(new Contact(idContact), password);
				
				if (security == null) {
					throw new ChangePasswordException("msg.error.change_password");
				}
				else {
					if (Settings.MAIL_NOTIFICATION && to != null && !"".equals(to)) {					
						try {							
							EmailUtil email = new EmailUtil(Constants.EMAIL_NO_REPLY, to);
							email.setSubject("[OpenPPM] - " + idioma.getString("maintenance.employee.email.login"));
							
							StringBuilder bodytext = new StringBuilder();
							bodytext.append(
									new ParamResourceBundle("maintenance.employee.email.user_register", contact.getFullName()).toString(idioma) +
									"\n\n" + idioma.getString("maintenance.employee.username")+": " +
									security.getLogin() + "\n" + idioma.getString("maintenance.employee.password")+": " + password);
							
							email.setBodyText(bodytext.toString());
							email.send();
						}
						catch (Exception e) {
							replyJSON.put(StringPool.INFORMATION, idioma.getString("msg.info.mail_account"));
							ExceptionUtil.sendToLogger(LOGGER, e, null);
						}
					}
					replyJSON.put(StringPool.INFORMATION, idioma.getString("msg.info.change_password"));
				}
			}
			out.print(replyJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * save contact
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveContactJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idContact					= ParamUtil.getInteger(req, "id", -1);
		String contactFullName 			= ParamUtil.getString(req, "full_name", "");
		String contactJobTitle			= ParamUtil.getString(req, "job_title", "");	
		String contactFileAs			= ParamUtil.getString(req, "file_as", "");	
		String contactBusinessPhone		= ParamUtil.getString(req, "business_phone", "");
		String contactMobilePhone		= ParamUtil.getString(req, "mobile_phone", "");
		String contactBusinessAddress	= ParamUtil.getString(req, "business_address", "");
		String contactEmail				= ParamUtil.getString(req, "email", "");	
		String contactNotes				= ParamUtil.getString(req, "notes", "");	
		String login 					= ParamUtil.getString(req, "login");
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		PrintWriter out = resp.getWriter();
		try {
			SecurityLogic securityLogic = new SecurityLogic();
			
			Company company		= CompanyLogic.searchByEmployee(loguedUser);
			
			JSONObject infoJSON	= null;
			Contact contact 	= null;
			
			if (idContact == -1){
				contact = new Contact();
				contact.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "contact"); 
			}
			else {
				ContactLogic contactLogic = new ContactLogic();
				contact = contactLogic.findById(idContact, false);
				
				infoJSON = infoUpdated(infoJSON, "contact");
			}
			
			contact.setFullName(contactFullName);
			contact.setJobTitle(contactJobTitle);
			contact.setFileAs(contactFileAs);
			contact.setBusinessPhone(contactBusinessPhone);
			contact.setMobilePhone(contactMobilePhone);
			contact.setBusinessAddress(contactBusinessAddress);
			contact.setEmail(contactEmail);
			contact.setNotes(contactNotes);
			
			if (contact.getIdContact() == null) {			
				Security security = new Security();
				security.setLogin(login);
				security.setAttempts(0);
				security.setDateCreation(DateUtil.getCalendar().getTime());
				
				if (SecurityLogic.isUserName(security)) { throw new LoginNameInUseException(); }
				
				ContactLogic.saveContact(contact, security);				
			}
			else {
				if (SecurityUtil.isUserInRole(req, Constants.ROLE_PMO)) {
					if (securityLogic.isUserName(contact, login)) { throw new LoginNameInUseException(); }
					else {
						List<Security> securities = (List<Security>)securityLogic.findByRelation(Security.CONTACT, contact);
						
						if (!securities.isEmpty() && securities.size() == 1) {
							
							Security security = securities.get(0);
							if (!security.getLogin().equals(login)) {
								
								security.setLogin(login);
								securityLogic.save(security);
							}
						}
					}
				}
					
				ContactLogic.saveContact(contact);
				idContact = contact.getIdContact();
				contact = ContactLogic.consultContact(idContact);	
			}
			
			out.print(putInfo(JSONModelUtil.contactToJSON(contact),infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Save skill
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveSkillJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idSkill			= ParamUtil.getInteger(req, "id", -1);
		String name			= ParamUtil.getString(req, "name", "");	
		String description	= ParamUtil.getString(req, "description", "");	
		
		PrintWriter out = resp.getWriter();
		
		try {		
			JSONObject infoJSON 	= null;
			Skill skill 			= null;
			
			if (idSkill == -1){
				skill = new Skill();
				
				Employee loguedUser = SecurityUtil.consUser(req);
				Company company		= CompanyLogic.searchByEmployee(loguedUser);
				
				skill.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "skill");
			}
			else {
				skill = SkillLogic.findById(new Skill(idSkill));
				
				infoJSON = infoUpdated(infoJSON, "skill");
			}
			
			skill.setName(name);
			skill.setDescription(description);
			
			skill = SkillLogic.saveSkill(skill);
			
			infoJSON.put("id", skill.getIdSkill());
			
			out.print(infoJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * Save performing organization
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void savePerfOrgJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idPerfOrg			= ParamUtil.getInteger(req, "id", -1);
		int idPerforgManager 	= ParamUtil.getInteger(req, "manager");
		boolean perforgOnsaas	= ParamUtil.getBoolean(req, "onsaas", false);	
		String perforgName		= ParamUtil.getString(req, "name", "");
		
		PrintWriter out = resp.getWriter();
		
		try {		
			JSONObject infoJSON 	= null;
			Performingorg perforg 	= null;
			
			if (idPerfOrg == -1){
				Employee loguedUser	= SecurityUtil.consUser(req);
				Company company		= CompanyLogic.searchByEmployee(loguedUser);
				
				perforg = new Performingorg();
				perforg.setCompany(company);
				
				infoJSON = infoCreated(infoJSON, "perf_organization");
			}
			else {
				perforg = PerformingOrgLogic.consPerforg(idPerfOrg);
				
				infoJSON = infoUpdated(infoJSON, "perf_organization");
			}
			
			perforg.setEmployee(new Employee(idPerforgManager));
			perforg.setName(perforgName);
			perforg.setOnSaaS(perforgOnsaas);
			
			perforg = PerformingOrgLogic.savePerfOrg(perforg);
			
			if (idPerfOrg == -1) {
				
				Employee pmoForPO = new Employee();
				pmoForPO.setContact(getUser(req).getContact());
				pmoForPO.setPerformingorg(perforg);
				pmoForPO.setResourceprofiles( new Resourceprofiles(Constants.ROLE_PMO));
				pmoForPO.setProfileDate(new Date());
				
				EmployeeLogic employeeLogic = new EmployeeLogic();
				employeeLogic.save(pmoForPO);
			}
			
			infoJSON.put(Performingorg.IDPERFORG, perforg.getIdPerfOrg());
			
			out.print(infoJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}	
	}

	/**
	 * Save company
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void saveCompanyJX(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idCompany	= ParamUtil.getInteger(req, "id", -1);
		String companyName	= ParamUtil.getString(req, "name", "");	
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			CompanyLogic companyLogic = new CompanyLogic();
			JSONObject infoJSON	= null;
			Company company 	= null;
			
			if (idCompany == -1){
				company = new Company();
				
				infoJSON = infoCreated(infoJSON, "company"); 
			}
			else{
				
				company = companyLogic.findById(idCompany, false);
				
				infoJSON = infoUpdated(infoJSON, "company");
			}
			
			company.setName(companyName);
			
			companyLogic.save(company);
			
			out.print(putInfo(JSONModelUtil.companyToJSON(company),infoJSON));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}	
	}
	
	/**
	 * Delete operation
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteOperation(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idOperation = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			OperationLogic.deleteOperation(idOperation);
			infoDeleted(req, "operation");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete operationaccount
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteOperationAccount(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idOperationAccount = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			OperationaccountLogic.deleteOperationAccount(idOperationAccount);
			infoDeleted(req, "maintenance.operation.op_account");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete geography
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteGeography(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idGeography = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			GeographyLogic.deleteGeography(idGeography);
			infoDeleted(req, "geography");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete category
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteCategory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idCategory = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			CategoryLogic.deleteCategory(new Category(idCategory));
			infoDeleted(req, "category");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}
	
	/**
	 * Delete customer
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteCustomer(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idCustomer = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			CustomerLogic.deleteCustomer(new Customer(idCustomer));
			infoDeleted(req, "customer");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}
	
	/**
	 * Delete seller
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteSeller(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idSeller = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			SellerLogic.deleteSeller(new Seller(idSeller));
			infoDeleted(req, "seller");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}


	/**
	 * Delete Expenseaccounts
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteExpenseAccount(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idExpenseAccount = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			ExpenseaccountsLogic.deleteExpenseAccount(idExpenseAccount);
			infoDeleted(req, "maintenance.expenseaccounts");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete Contracttype
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteContractType(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idContractType = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			ContractTypeLogic.deleteContractType(idContractType);
			infoDeleted(req, "contract_type");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}
	
	/**
	 * Delete Changetype
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteChangeType(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idChangeType = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			ChangeTypesLogic logic = new ChangeTypesLogic();
			logic.delete(new Changetype(idChangeType));
			infoDeleted(req, "change_type");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete budgetAccounts
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteBudgetAccount(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idBudgetAccounts = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			BudgetaccountsLogic.deleteBudgetAccounts(idBudgetAccounts);
			infoDeleted(req, "maintenance.budgetaccounts");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete contact
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteContact(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idContact = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			ContactLogic.deleteContact(idContact);
			infoDeleted(req, "contact");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete skill
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteSkill(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idSkill = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			SkillLogic.deleteSkill(idSkill);
			infoDeleted(req, "skill");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete performing organization
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deletePerfOrg(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idPerfOrg = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			PerformingOrgLogic.deletePerfOrg(idPerfOrg);
			infoDeleted(req, "perf_organization");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}
	
	/**
	 * Save employee
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idEmployee 				= ParamUtil.getInteger(req, "employee_id", -1);		
		double costRate 			= ParamUtil.getCurrency (req, "cost_rate", 0);
		Integer idContact 			= ParamUtil.getInteger(req, "idContact", null);
		Integer idResourceManager 	= ParamUtil.getInteger(req, "idManager", null);
		Integer idProfile 			= ParamUtil.getInteger(req, "idProfile", null);
		Date profileDate 			= ParamUtil.getDate(req, "profileDate", dateFormat, new Date());
		String[] idSkills			= ParamUtil.getStringValues(req, "skills", null);
		boolean isUpdate 			= ParamUtil.getBoolean(req, "isUpdate", false);
		Integer idCalendarBase		= ParamUtil.getInteger(req, "idCalendarBase", null);
		
		try {		
			Employee loguedUser = SecurityUtil.consUser(req);
			
			if(isUpdate || !ContactLogic.hasProfile(loguedUser.getPerformingorg(), new Contact(idContact), 
					new Resourceprofiles(idProfile))) {
				
				Employee employee	= null;
				
				if (idEmployee == -1) {
					employee = new Employee();					
					infoCreated(req, "maintenance.employee");
				}
				else {
					employee = EmployeeLogic.consEmployee(idEmployee);
					infoUpdated(req, "maintenance.employee");					
				}
				
				if (idProfile == Constants.ROLE_PORFM) {
					employee.setPerformingorg(null);
				}
				else if (employee.getPerformingorg() == null){
					Employee user = SecurityUtil.consUser(req);
					employee.setPerformingorg(user.getPerformingorg());
				}
				
				EmployeeLogic employeeLogic = new EmployeeLogic();
				
				int employees = employeeLogic.rowCountEq(Employee.CONTACT, new Contact(idContact));
				if (employees == 0) {
					
					Contact contact = ContactLogic.consultContact(idContact);
					Security security = SecurityLogic.getByContact(new Contact(idContact));
					
					//Password
					String password = security.getLogin();
					String to = contact.getEmail();
					if (Settings.MAIL_NOTIFICATION && !ValidateUtil.isNull(to) && !"".equals(to)) {
						password = SecurityUtil.getRandomString(8);
					}				
					security.setPassword(SecurityUtil.md5(password));
					
					ContactLogic.saveContact(contact, security);
					
					if (Settings.MAIL_NOTIFICATION && to != null && !"".equals(to)) {
						
						try {
							EmailUtil email = new EmailUtil(Constants.EMAIL_NO_REPLY, to);
							email.setSubject("[OpenPPM] - " + idioma.getString("maintenance.employee.email.login"));
							
							StringBuilder bodytext = new StringBuilder();
							bodytext.append(
									new ParamResourceBundle("maintenance.employee.email.user_register", contact.getFullName()).toString(idioma) +
									"\n\n" + idioma.getString("url")+": " +
									req.getRequestURL().substring(0, req.getRequestURL().lastIndexOf("/")) + "\n"+ idioma.getString("maintenance.employee.username")+": " +
									security.getLogin());
							
							if (!Settings.LOGIN_LDAP) {
								bodytext.append("\n"+ idioma.getString("maintenance.employee.password")+": " + password);
							}
							
							email.setBodyText(bodytext.toString());
							email.send();
						}
						catch (Exception e) {
							ExceptionUtil.sendToLogger(LOGGER, e, null);
						}
					}
				}
				
				if (idResourceManager != null) { employee.setEmployee(new Employee(idResourceManager)); }			
				if (idCalendarBase != null) { employee.setCalendarbase(new Calendarbase(idCalendarBase)); }
				
				employee.setContact(new Contact(idContact));
				employee.setResourceprofiles(new Resourceprofiles(idProfile));
				employee.setCostRate(costRate);
				employee.setProfileDate(profileDate);
				
				List<Skill> listSkills = null;
				
				if (idSkills != null) {
					listSkills = new ArrayList<Skill>();			
					for (String i : idSkills) {
						Skill sk = new Skill(Integer.parseInt(i));
						listSkills.add(sk);
					}				
				}			
				
				EmployeeLogic.saveEmployee(employee, listSkills);
				employee = EmployeeLogic.consEmployee(employee.getIdEmployee());
			}
			else {
				throw new LogicException("msg.error.contact_has_profile");
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete employee
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idEmployee = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			EmployeeLogic.deleteEmployee(idEmployee);
			infoDeleted(req, "maintenance.employee");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	/**
	 * Delete company
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void deleteCompany(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int idCompany = ParamUtil.getInteger(req, "id", -1);
		
		try {		
			CompanyLogic.deleteCompany(idCompany);
			infoDeleted(req, "company");
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}
	
	/**
	 * Save a document or manual
	 * @param req
	 * @param resp
	 * @param reqFields
	 * @throws IOException
	 * @throws ServletException
	 */
	private void saveDocumentation(HttpServletRequest req, HttpServletResponse resp, Hashtable<String, FileItem> reqFields)
		throws IOException, ServletException {
		
		int docId = Integer.parseInt(reqFields.get("idDocumentation").getString());
		int idManten = Integer.parseInt(reqFields.get("idManten").getString());
		String namePopup = reqFields.get("namePopup").getString();
		
		Employee loguedUser = SecurityUtil.consUser(req);
		
		try {	
			FileItem dataFile = reqFields.get("file");
						
			if (dataFile != null) {
				Documentation doc = new Documentation();
				Contentfile docFile = new Contentfile();
				DocumentationLogic docLogic = new DocumentationLogic();
				ContentFileLogic fileLogic = new ContentFileLogic();
				
				if(docId != -1) {
					doc = docLogic.findById(docId);
					infoUpdated(req, "maintenance.documentation_manuals.documentation");
				}					
				else {
					infoCreated(req, "maintenance.documentation_manuals.documentation");
				}
				
				if(dataFile.getSize() > 0) {
					doc.setNameFile(dataFile.getName());
					docFile.setExtension(FilenameUtils.getExtension(dataFile.getName()));
					docFile.setMime(dataFile.getContentType());
					docFile.setContent(dataFile.get());					
					docFile = fileLogic.save(docFile);
					doc.setContentfile(docFile);
				}				
				
				doc.setNamePopup(namePopup);
				doc.setCompany(CompanyLogic.searchByEmployee(loguedUser));
				doc = docLogic.save(doc);
			}		
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		consMaintenance(req, resp, idManten);
	}
	
	/**
	 * Delete a document or manual
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteDocumentation(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		
		int idDocumentation = ParamUtil.getInteger(req, "id", -1);		
		
		try {		
			ContentFileLogic fileLogic = new ContentFileLogic();
			DocumentationLogic docLogic = new DocumentationLogic();
			Documentation doc = docLogic.findById(idDocumentation);
			Contentfile docFile = fileLogic.findByDocumentation(doc);
			docLogic.delete(doc);
			fileLogic.delete(docFile);			
			infoDeleted(req, "maintenance.documentation_manuals.documentation");	
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		consMaintenance(req, resp, null);
	}

	@SuppressWarnings("rawtypes")
	private void consMaintenance(HttpServletRequest req,
			HttpServletResponse resp, Integer idMant) throws ServletException, IOException {
		
		int idManten = -1;
		if(idMant != null) {idManten = idMant;}else {idManten = ParamUtil.getInteger(req, "idManten", -1);}
		
		List list = null;
		
		try {
			Employee user	= SecurityUtil.consUser(req);	
			list			= maintenanceCheck(idManten, user);	
			
			if (idManten == Constants.MANT_PERFORMING_ORG){ 
				List<Employee> listEmployees = EmployeeLogic.searchEmployees(
						"", "", Constants.ROLE_FM, -1, user);
				
				List<String> joins = new ArrayList<String>();
				joins.add(Performingorg.EMPLOYEE);
				joins.add(Performingorg.EMPLOYEE+"."+Employee.CONTACT);
				
				Company company	= CompanyLogic.searchByEmployee(user);
				
				PerformingOrgLogic performingOrgLogic = new PerformingOrgLogic();
//				List<Performingorg> perfOrgs = performingOrgLogic.findByRelation(Performingorg.COMPANY, company, joins);
				List<Performingorg> perfOrgs = performingOrgLogic.findByRelation(Performingorg.COMPANY, company,Performingorg.NAME,Constants.ASCENDENT, joins);
				
				req.setAttribute("perfOrgs", perfOrgs);
				req.setAttribute("listEmployees", listEmployees);
			}
			else if (idManten == Constants.MANT_CONTACT){
				CompanyLogic companyLogic = new CompanyLogic();
				List<Company> listCompanies = companyLogic.findAll();	
				
				req.setAttribute("listCompanies", listCompanies);
			}
			
			else if (idManten == Constants.MANT_RESOURCE){
				
				ResourceProfilesLogic resourceProfilesLogic = new ResourceProfilesLogic();
				PerformingOrgLogic performingOrgLogic		= new PerformingOrgLogic();
				CalendarBaseLogic calendarBaseLogic = new CalendarBaseLogic();
				EmployeeLogic employeeLogic			= new EmployeeLogic();
				SkillLogic skillLogic				= new SkillLogic();
				
				List<String> joins = new ArrayList<String>();
				joins.add(Employee.CONTACT);
				
				Company company = CompanyLogic.searchByEmployee(user);
				
				List<Resourceprofiles> profiles	= resourceProfilesLogic.findAll();
//				List<Performingorg> perforgs 	= performingOrgLogic.findByRelation(Performingorg.COMPANY, company);
				List<Performingorg> perforgs    = performingOrgLogic.findByRelation(Performingorg.COMPANY, company,Performingorg.NAME,Constants.ASCENDENT, joins);
				List<Employee> listResManagers	= EmployeeLogic.searchEmployees(new Resourceprofiles(Constants.ROLE_RM), company, joins);
//				List<Skill> listSkills			= skillLogic.findByRelation(Skill.COMPANY, company);
				List<Skill> listSkills			= skillLogic.findByRelation(Skill.COMPANY, company,Skill.NAME,Constants.ASCENDENT);
				List<Calendarbase> calendars 	= calendarBaseLogic.findByRelation(Calendarbase.COMPANY, company);
					
				joins.add(Employee.EMPLOYEE);
				joins.add(Employee.EMPLOYEE+"."+Employee.CONTACT);
				joins.add(Employee.PERFORMINGORG);
				joins.add(Employee.RESOURCEPROFILES);
				
				list = employeeLogic.findByCompany(company, joins);
				
				req.setAttribute("profiles", profiles);
				req.setAttribute("perforgs", perforgs);
				req.setAttribute("listResManagers", listResManagers);
				req.setAttribute("listSkills", listSkills);
				req.setAttribute("calendars", calendars);
			}
			
			else if (idManten == Constants.MANT_OPERATION) {
				
				OperationLogic operationLogic 	= new OperationLogic();
				Company company 				= CompanyLogic.searchByEmployee(user);
				
				list = operationLogic.findByAllCompany(company);
				
				OperationaccountLogic operationaccountLogic = new OperationaccountLogic();
				
				List<Operationaccount> listOpAccounts  = operationaccountLogic.findByRelation(Operationaccount.COMPANY, company);
				
				req.setAttribute("listOpAccounts", listOpAccounts);
			}
			
			else if (idManten == Constants.MANT_SELLERS) {
				
				Company company	= CompanyLogic.searchByEmployee(user);
				SellerLogic sellerLogic = new SellerLogic();
				
				List<Seller> listSellers = sellerLogic.findByRelation(Seller.COMPANY, company);
				
				req.setAttribute("listSellers", listSellers);
			}
			
			else if (idManten == Constants.MANT_CUSTOMERS) {
				
				List<Customertype> types = CustomertypeLogic.findByCompany(user);
				List<Customer> listCustomers = CustomerLogic.findByCompany(user);
				
				req.setAttribute("listCustomers", listCustomers);
				req.setAttribute("types", types);
			}
			
			else if (idManten == Constants.MANT_METRIC_KPI) {
				
				List<String> joins = new ArrayList<String>();
				joins.add(Metrickpi.BSCDIMENSION);
				
				List<Bscdimension> bscdimensions	= BscdimensionLogic.findByCompany(user);
				List<Metrickpi> metrics				= MetrickpiLogic.findByCompany(user, joins);
				
				req.setAttribute("bscdimensions", bscdimensions);
				req.setAttribute("metrics", metrics);
			}
			else if (idManten == Constants.MANT_CUSTOMER_TYPE) {
				
				List<Customertype> customerTypes	= CustomertypeLogic.findByCompany(user);
				req.setAttribute("customerTypes", customerTypes);
			}
			
			else if (idManten == Constants.MANT_SKILL) {

				Company company = CompanyLogic.searchByEmployee(user);
				
				SkillLogic skillLogic = new SkillLogic();
				List<Skill> skills = skillLogic.findByRelation(Skill.COMPANY, company);;
				
				req.setAttribute("skills", skills);
			}
			
			else if (idManten == Constants.MANT_BUDGETACCOUNTS) {
				
				BudgetaccountsLogic budgetaccountsLogic = new BudgetaccountsLogic();
				Company company 						= CompanyLogic.searchByEmployee(user);
				
				list = budgetaccountsLogic.findByRelation(Budgetaccounts.COMPANY, company);
			}
			else if (idManten == Constants.MANT_CATEGORY) {
				
				CategoryLogic categoryLogic = new CategoryLogic();
				Company company 			= CompanyLogic.searchByEmployee(user);
				
				list = categoryLogic.findByRelation(Category.COMPANY, company);
			}
			else if(idManten == Constants.MANT_CONTRACTTYPE){
				ContractTypeLogic contractTypeLogic = new ContractTypeLogic();
				Company company 					= CompanyLogic.searchByEmployee(user);
				
				list = contractTypeLogic.findByRelation(Contracttype.COMPANY, company);
			}
			else if(idManten == Constants.MANT_EXPENSEACCOUNTS){
				ExpenseaccountsLogic expenseaccountsLogic 	= new ExpenseaccountsLogic();
				Company company 						 	= CompanyLogic.searchByEmployee(user);
				
				list = expenseaccountsLogic.findByRelation(Expenseaccounts.COMPANY, company);
			}
			else if(idManten == Constants.MANT_OPERATIONACCOUNT){
				OperationaccountLogic operationaccountLogic = new OperationaccountLogic();
				Company company 						 	= CompanyLogic.searchByEmployee(user);
				
				list = operationaccountLogic.findByRelation(Operationaccount.COMPANY, company);
			}
			else if (idManten == Constants.MANT_FUNDINGSOURCE) {
				
				List<Fundingsource> listFundingSource = FundingsourceLogic.findByCompany(user);
				
				req.setAttribute("listFundingSource", listFundingSource);
			}	
			else if(idManten == Constants.MANT_CHANGETYPE){
				ChangeTypesLogic changeTypeLogic = new ChangeTypesLogic();
				Company company = CompanyLogic.searchByEmployee(user);
				
				list = changeTypeLogic.findByRelation(Changetype.COMPANY, company);
			}
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		req.setAttribute("list", list);
		req.setAttribute("idManten", idManten);
		req.setAttribute("title", idioma.getString("menu.maintenance"));
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		forward("/index.jsp?nextForm=maintenance/maintenance", req, resp);
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void consSkillsJX(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		int idEmployee	= ParamUtil.getInteger(req, Employee.IDEMPLOYEE, -1);		

		PrintWriter out			= resp.getWriter();
		
		try {
			List<Integer> skills = new ArrayList<Integer>();
			List<Skillsemployee> skillsDB = SkillsemployeeLogic.findByEmployee(new Employee(idEmployee));			

			for (Skillsemployee s : skillsDB) {
				skills.add(s.getSkill().getIdSkill());
			}				
			out.print(skills);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	/**
	 * 
	 * @param idManten
	 * @return
	 * @throws LogicException
	 */
	@SuppressWarnings("rawtypes")
	private List maintenanceCheck(int idManten, Employee user) throws Exception {
		List list = null;
		List<String> joins = null;
		Company company = CompanyLogic.searchByEmployee(user);
		
		switch (idManten) {
		case Constants.MANT_COMPANY:
			CompanyLogic companyLogic = new CompanyLogic();
			list = companyLogic.findAll();
			break;
			
		case Constants.MANT_PROGRAM:
			list = ProgramLogic.findAllWithManager();
			break;
			
		case Constants.MANT_CONTACT:
			ContactLogic contactLogic = new ContactLogic();
			joins = new ArrayList<String>();
			joins.add(Contact.COMPANY);
			list = contactLogic.findByRelation(Contact.COMPANY, company, joins);
			LOGGER.debug("Contact: " );
			break;
			
		case Constants.MANT_GEOGRAPHY:			
			GeographyLogic geoLogic = new GeographyLogic();
			list = geoLogic.findByRelation(Geography.COMPANY, company);
			break;
			
		case Constants.MANT_FUNDINGSOURCE:
			FundingsourceLogic funLogic = new FundingsourceLogic();
			list = funLogic.findByRelation(Fundingsource.COMPANY, company);
			break;	
			
		case Constants.MANT_DOCUMENTATION:
			DocumentationLogic docLogic = new DocumentationLogic();
			list = docLogic.findByRelation(Documentation.COMPANY, company);
			break;
			
		default: break;
		}
		return list;
	}
}
