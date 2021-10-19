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
/******************************************************************************
 * Update : Devoteam XL 2015-04-22  user story 23  tri des organisation dans le popu Investment Manager
 *                 fonction :  viewInitProjects  tri des listes Performingorg, category
 *
  ******************************************************************************/
package es.sm2.openppm.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Order;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.javabean.ProjectInfoJavaBean;
import es.sm2.openppm.logic.CategoryLogic;
import es.sm2.openppm.logic.ChargescostsLogic;
import es.sm2.openppm.logic.CompanyLogic;
import es.sm2.openppm.logic.CustomerLogic;
import es.sm2.openppm.logic.CustomertypeLogic;
import es.sm2.openppm.logic.DocumentprojectLogic;
import es.sm2.openppm.logic.FundingsourceLogic;
import es.sm2.openppm.logic.GeographyLogic;
import es.sm2.openppm.logic.PerformingOrgLogic;
import es.sm2.openppm.logic.ProjectCharterLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.ResourceProfilesLogic;
import es.sm2.openppm.logic.StakeholderLogic;
import es.sm2.openppm.logic.WorkingcostsLogic;
import es.sm2.openppm.logic.charter.ProjectCharterTemplate;
import es.sm2.openppm.model.Category;
import es.sm2.openppm.model.Chargescosts;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contracttype;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Fundingsource;
import es.sm2.openppm.model.Geography;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Stakeholder;
import es.sm2.openppm.model.Workingcosts;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.StringUtil;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class ProjectInitiatingServlet
 */
public class ProjectInitServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
	
	private static final Logger LOGGER = Logger.getLogger(ProjectInitServlet.class);
	
	public final static String REFERENCE = "projectinit";

	/***************** Actions ****************/
	public final static String VIEW_INVESTMENT 		= "view-investment";
	public final static String VIEW_CHARTER 		= "view-charter";
	public final static String SAVE_STAKEHOLDER		= "save-stakeholder";
	public final static String DELETE_STAKEHOLDER 	= "delete-stakeholder";
	
	/************** Actions AJAX **************/
	public final static String JX_SAVE_PROJECT 				= "ajax-save-project";	
	public final static String JX_UPDATE_STAKEHOLDER_ORDER 	= "ajax-update-stakeholder-order";
	public final static String JX_SAVE_SELLERCOST			= "ajax-save-sellercost";
	public final static String JX_DELETE_SELLERCOST 		= "ajax-delete-sellercost";
	public final static String JX_SAVE_INFRASTRUCTURECOST	= "ajax-save-infrastructurecost";
	public final static String JX_DELETE_INFRASTRUCTURECOST = "ajax-delete-infrastructurecost";
	public final static String JX_SAVE_LICENSECOST			= "ajax-save-licensecost";
	public final static String JX_DELETE_LICENSECOST 		= "ajax-delete-licensecost";
	public final static String JX_SAVE_WORKINGCOST			= "ajax-save-workingcost";
	public final static String JX_DELETE_WORKINGCOST 		= "ajax-delete-workingcost";
	
   

	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1) {
			
			/***************** Actions ****************/
			if (accion == null || StringPool.BLANK.equals(accion) || VIEW_INVESTMENT.equals(accion)) {
				
				viewInitProject(req, resp, null, accion);
			}
			else if (VIEW_CHARTER.equals(accion)) { viewProjectCharter(req, resp); }
			else if (SAVE_STAKEHOLDER.equals(accion)) { saveStakeholder(req, resp); }
			else if (DELETE_STAKEHOLDER.equals(accion)) { deleteStakeholder(req, resp); }
			
			/************** Actions AJAX **************/
			else if (JX_SAVE_PROJECT.equals(accion)) { saveProjectJX(req, resp); }			
			else if (JX_UPDATE_STAKEHOLDER_ORDER.equals(accion)) { updateStakeholderOrderJX(req, resp); }
			else if (JX_SAVE_SELLERCOST.equals(accion)) { saveSellerCostJX(req, resp); }
			else if (JX_DELETE_SELLERCOST.equals(accion)) { deleteSellerCostJX(req, resp); }
			else if (JX_SAVE_INFRASTRUCTURECOST.equals(accion)) { saveInfrastructureCostJX(req, resp); }
			else if (JX_DELETE_INFRASTRUCTURECOST.equals(accion)) { deleteInfrastructureCostJX(req, resp); }
			else if (JX_SAVE_LICENSECOST.equals(accion)) { saveLicenseCostJX(req, resp); }
			else if (JX_DELETE_LICENSECOST.equals(accion)) { deleteLicenseCostJX(req, resp); }
			else if (JX_SAVE_WORKINGCOST.equals(accion)) { saveWorkingCostJX(req, resp); }
			else if (JX_DELETE_WORKINGCOST.equals(accion)) { deleteWorkingCostJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}

    
    /**
     * Delete Seller Cost
     * @param req
     * @param resp
     * @throws IOException
     */
    private void deleteSellerCostJX (HttpServletRequest req, HttpServletResponse resp) 
    throws IOException {

		int sellerId = ParamUtil.getInteger(req, "sel_id", -1);
		
		deleteChargeCostJX(req, resp, sellerId, "sellercost");
	}
    
    /**
     * Delete Infrastructure Cost
     * @param req
     * @param resp
     * @throws IOException
     */
    private void deleteInfrastructureCostJX (HttpServletRequest req, HttpServletResponse resp) 
    throws IOException {

		int sellerId = ParamUtil.getInteger(req, "inf_id", -1);
		
		deleteChargeCostJX(req, resp, sellerId, "infrastructurecost");
	}
    
    /**
     * Delete License Cost
     * @param req
     * @param resp
     * @throws IOException
     */
    private void deleteLicenseCostJX (HttpServletRequest req, HttpServletResponse resp) 
    throws IOException {

		int sellerId = ParamUtil.getInteger(req, "lic_id", -1);
		
		deleteChargeCostJX(req, resp, sellerId, "licensecost");
	}
    
    
    /**
     * Delete Charge Cost
     * @param req
     * @param resp
     * @param id
     * @throws IOException
     */
    private void deleteChargeCostJX (HttpServletRequest req, HttpServletResponse resp, int id, String key) 
    throws IOException {

    	PrintWriter out = resp.getWriter();

		try {
			ChargescostsLogic.deleteChargescosts(new Chargescosts(id));
			out.print(infoDeleted(key));
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}
    
    
    /**
     * Delete Stakeholder
     * @param req
     * @param resp
     * @throws IOException
     */
    private void deleteWorkingCostJX (HttpServletRequest req, HttpServletResponse resp) 
    throws IOException {

    	PrintWriter out = resp.getWriter();
		int wc_id = ParamUtil.getInteger(req, "wc_id", -1);
		try {
			WorkingcostsLogic.deleteWorkingcosts(new Workingcosts(wc_id));
			
			out.print(infoDeleted("direct_cost"));
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

    /**
     * Delete StakeHolder
     * @param req
     * @param resp
     * @throws IOException
     * @throws ServletException
     */
    private void deleteStakeholder(HttpServletRequest req,
			HttpServletResponse resp) throws IOException, ServletException {
    	
		int stk_id = ParamUtil.getInteger(req, "stk_id", -1);
		int project_id = ParamUtil.getInteger(req, "project_id", -1);
		
		try {
			StakeholderLogic.deleteStakeholder(new Stakeholder(stk_id));
		} 
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewInitProject(req, resp, project_id, null);
	}
    
    /**
     * 
     * @param req
     * @param resp
     * @throws IOException
     */
	private void updateStakeholderOrderJX(HttpServletRequest req, 
			HttpServletResponse resp) throws IOException {

    	PrintWriter out = resp.getWriter();
    	String idsStr	= ParamUtil.getString(req, "ids","");
    	int idProject	= ParamUtil.getInteger(req, "idProject");
		
		try {
			
			if (!ValidateUtil.isNull(idsStr)) {
				
				StakeholderLogic logic = new StakeholderLogic();
				List<Stakeholder> stakeholders = logic.findByProject(new Project(idProject), Order.asc(Stakeholder.ORDERTOSHOW), Order.asc(Stakeholder.IDSTAKEHOLDER));
				
				Integer[] ids = StringUtil.splitStrToIntegers(idsStr, null);
				
				int orderToShow = 1;
				for (Integer idStakeholder :ids) {
					
					Stakeholder stakeholder = logic.findById(idStakeholder);
					stakeholder.setOrderToShow(orderToShow++);
					logic.save(stakeholder);
				}
				
				for (Stakeholder stakeholder : stakeholders) {
					
					boolean update = true;
					int i = 0;
					while (update && i < ids.length) {
						if (ids[i].equals(stakeholder.getIdStakeholder())) { update = false; }
						i++;
					}
					if (update) {
						stakeholder.setOrderToShow(orderToShow++);
						logic.save(stakeholder);
					}
				}
			}
			out.print(info("msg.info.order_updated", new JSONObject(),"stakeholder"));
		} 
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}

    
    /**
     * Save Seller Cost
     * @param req
     * @param resp
     * @throws IOException
     */
	private void saveSellerCostJX (HttpServletRequest req, HttpServletResponse resp) 
	throws IOException {

		int idChargesCosts	= ParamUtil.getInteger	(req, "sel_id", -1);
		String name 		= ParamUtil.getString	(req, "sel_name", StringPool.BLANK);
		double cost 		= ParamUtil.getCurrency	(req, "sel_cost");

		Chargescosts chargescosts = new Chargescosts();
		
		if (idChargesCosts != -1) {
			chargescosts.setIdChargesCosts(idChargesCosts);
		}
		
		chargescosts.setName(name);
		chargescosts.setCost(cost);
		chargescosts.setIdChargeType(Constants.SELLER_CHARGE_COST);

		saveChargeCostJX (req, resp, chargescosts);
	}
	
	
    /**
     * Save Infrastructure Cost
     * @param req
     * @param resp
     * @throws IOException
     */
	private void saveInfrastructureCostJX (HttpServletRequest req, HttpServletResponse resp) 
	throws IOException {

		int idChargesCosts	= ParamUtil.getInteger	(req, "inf_id", -1);
		String name 		= ParamUtil.getString	(req, "inf_name", StringPool.BLANK);
		double cost 		= ParamUtil.getCurrency	(req, "inf_cost");

		Chargescosts chargescosts = new Chargescosts();
		
		if (idChargesCosts != -1) {
			chargescosts.setIdChargesCosts(idChargesCosts);
		}
		
		chargescosts.setName(name);
		chargescosts.setCost(cost);
		chargescosts.setIdChargeType(Constants.INFRASTRUCTURE_CHARGE_COST);

		saveChargeCostJX (req, resp, chargescosts);
	}
	
	
    /**
     * Save License Cost
     * @param req
     * @param resp
     * @throws IOException
     */
	private void saveLicenseCostJX (HttpServletRequest req, HttpServletResponse resp) 
	throws IOException {

		int idChargesCosts	= ParamUtil.getInteger	(req, "lic_id", -1);
		String name 		= ParamUtil.getString	(req, "lic_name", StringPool.BLANK);
		double cost 		= ParamUtil.getCurrency	(req, "lic_cost");

		Chargescosts chargescosts = new Chargescosts();
		
		if (idChargesCosts != -1) {
			chargescosts.setIdChargesCosts(idChargesCosts);
		}
		
		chargescosts.setName(name);
		chargescosts.setCost(cost);
		chargescosts.setIdChargeType(Constants.LICENSE_CHARGE_COST);

		saveChargeCostJX (req, resp, chargescosts);
	}
    
    
    /**
     * Save Charge Cost
     * @param req
     * @param resp
     * @throws IOException
     */
	private void saveChargeCostJX (HttpServletRequest req, HttpServletResponse resp, Chargescosts chargescosts) 
	throws IOException {

		PrintWriter out = resp.getWriter();
    	
		Integer idProject = ParamUtil.getInteger(req, "id", -1);
		
		try {
			chargescosts.setProject(new Project(idProject));
			ChargescostsLogic.saveChargescosts(chargescosts);
			
			JSONObject chargescostsJSON = new JSONObject();
			chargescostsJSON.put("id", chargescosts.getIdChargesCosts());
			
			out.print(chargescostsJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

    /**
     * Save Stakeholder
     * @param req
     * @param resp
     * @throws IOException
     */
	private void saveWorkingCostJX (HttpServletRequest req, HttpServletResponse resp) 
	throws IOException {

		PrintWriter out = resp.getWriter();
    	
		Integer idProject = ParamUtil.getInteger(req, "id", -1);
		
		try {
			Workingcosts workingcost = setWorkingcostFromRequest(req);	
			workingcost.setProject(new Project(idProject));
			WorkingcostsLogic.saveWorkingcosts(workingcost);
			
			JSONObject workingcostJSON = new JSONObject();
			workingcostJSON.put("id", workingcost.getIdWorkingCosts());
			
			out.print(workingcostJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}

	
	/**
	 * Save StakeHolder
	 * @param req
	 * @param resp
	 * @throws IOException
	 * @throws ServletException
	 */
	private void saveStakeholder(HttpServletRequest req,
			HttpServletResponse resp) throws IOException, ServletException {

		Integer project_id = ParamUtil.getInteger(req, "project_id", -1);
		
		try {
			Stakeholder stakeholder = setStakeholderFromRequest(req);	
			stakeholder.setProject(new Project(project_id));
			StakeholderLogic.saveStakeholder(stakeholder);			
			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewInitProject(req, resp, project_id, null);
	}
	

	/**
     * Save Project
     * @param req
     * @param resp
     * @throws IOException
     */
    private void saveProjectJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {

    	PrintWriter out = resp.getWriter();
    	
    	String leadProject		= ParamUtil.getString(req, "leadProject",null);
    	String dependentProject = ParamUtil.getString(req, "dependentProject",null);
    	
    	Integer[] idLeadProject		 = StringUtil.splitStrToIntegers(leadProject, null);
		Integer[] idDependentProject = StringUtil.splitStrToIntegers(dependentProject, null);
		
		Date plannedInitDate 		 = ParamUtil.getDate(req, "plannedInitDate", dateFormat, null);
		
		try {
			
			Project proj = setInitiatingProjectFromRequest(req);
			Projectcharter projCharter = setProjectCharterFromRequest(req);
			
			JSONObject projectJSON = new JSONObject();
			projectJSON.put("id", proj.getIdProject());
			
			List<String> newInfo = ProjectLogic.saveInitiatingProject(proj, projCharter, idLeadProject, idDependentProject, plannedInitDate);
			
			for (String inf : newInfo) { info(inf, projectJSON); }
			
			if (!ValidateUtil.isNull(proj.getAccountingCode()) && ProjectLogic.accountingCodeInUse(proj, getUser(req))) {
				info("msg.info.accounting_code_in_use", projectJSON, proj.getAccountingCode());
			}
			if (ProjectLogic.chartLabelInUse(proj, getUser(req))) {
				info("msg.info.in_use", projectJSON, "project.chart_label", proj.getChartLabel());
			}
			info("msg.saved.project", projectJSON);
			
			out.print(projectJSON);
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally {
			out.close();
		}
	}


	/**
	 * View Initiating Project
	 * @param req
	 * @param resp
	 * @param idProject
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewInitProject(HttpServletRequest req,
			HttpServletResponse resp, Integer idProject, String accion) throws ServletException, IOException {
		
		ProjectInfoJavaBean projectInfo = null;
		
		String type = ParamUtil.getString(req, "type");
		
		if (VIEW_INVESTMENT.equals(accion) || (Constants.TYPE_INVESTMENT+"").equals(type)) {
			req.setAttribute("type", Constants.TYPE_INVESTMENT);
		}
		
		if (idProject == null) {
			idProject = ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		}
		
		boolean hasPermission = false;
		
		try {
			
			hasPermission = SecurityUtil.hasPermission(req, new Project(idProject), Constants.TAB_INITIATION);
			
			if (hasPermission) {
				
				Employee user = SecurityUtil.consUser(req);
				Company company = CompanyLogic.searchByEmployee(user);
				
				ResourceProfilesLogic resourceProfilesLogic = new ResourceProfilesLogic();
				List<Resourceprofiles> profiles = resourceProfilesLogic.findAll();
				
				PerformingOrgLogic performingOrgLogic = new PerformingOrgLogic();
				
//            Devoteam XL 2015/04/22 user story 23  trie de la liste
//				List<Performingorg> perfOrgs = performingOrgLogic.findByRelation(Performingorg.COMPANY, company);
				List<Performingorg> perfOrgs = performingOrgLogic.findByRelation(Performingorg.COMPANY, company,Performingorg.NAME,Constants.ASCENDENT);
				
				projectInfo = ProjectLogic.findById(idProject, user.getPerformingorg(), company);
				
				List<Chargescosts> sellersCosts = ChargescostsLogic.consChargescostsByProject(
						new Project(idProject), Constants.SELLER_CHARGE_COST); 
				List<Chargescosts> infrastructureCosts = ChargescostsLogic.consChargescostsByProject(
						new Project(idProject), Constants.INFRASTRUCTURE_CHARGE_COST);
				List<Chargescosts> licensesCosts = ChargescostsLogic.consChargescostsByProject(
						new Project(idProject), Constants.LICENSE_CHARGE_COST);
				List<Documentproject> docs = null;
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					docs = new ArrayList<Documentproject>();
					docs.add(DocumentprojectLogic.findByType(projectInfo.getProject(), Constants.DOCUMENT_INITIATING));	
				}
				else {
					docs = DocumentprojectLogic.findListByType(projectInfo.getProject(), Constants.DOCUMENT_INITIATING);	
				}
				
				StakeholderLogic stakeholderLogic	= new StakeholderLogic();
				CategoryLogic categoryLogic			= new CategoryLogic();
				GeographyLogic geoLogic				= new GeographyLogic();				
				
				req.setAttribute("sellersCosts", sellersCosts);
				req.setAttribute("infrastructureCosts", infrastructureCosts);
				req.setAttribute("licensesCosts", licensesCosts);
				
				req.setAttribute("geographies", geoLogic.findByRelation(Geography.COMPANY, company));
//	            Devoteam XL 2015/04/22 user story 23  trie de la liste
//				req.setAttribute("categories", categoryLogic.findByRelation(Category.COMPANY, company));
				req.setAttribute("categories", categoryLogic.findByRelation(Category.COMPANY, company,Category.NAME,Constants.ASCENDENT));
				req.setAttribute("customers", CustomerLogic.searchByCompany(company));
				req.setAttribute("customertypes", CustomertypeLogic.findByCompany(user));
				req.setAttribute("project", projectInfo.getProject());
				req.setAttribute("stakeholders", stakeholderLogic.findByProject(projectInfo.getProject(), Order.asc(Stakeholder.ORDERTOSHOW), Order.asc(Stakeholder.IDSTAKEHOLDER)));
				req.setAttribute("projCharter", projectInfo.getProjectCharter());
				req.setAttribute("employees", projectInfo.getEmployees());
				req.setAttribute("programs", projectInfo.getPrograms());
				req.setAttribute("contractTypes", projectInfo.getContractTypes());
				req.setAttribute("profiles", profiles);
				req.setAttribute("perforgs", perfOrgs);
				req.setAttribute("fundingsources", FundingsourceLogic.findByCompany(user));
				
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					req.setAttribute("docs", docs.get(0));
				}
				else {
					req.setAttribute("docs", docs);	
				}
			}
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));
		
		if (hasPermission) {
			forward("/index.jsp?nextForm=project/initiation/initiating_project", req, resp);
		}
		else {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}


	/**
	 * View Project Charter
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void viewProjectCharter(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Integer idProject			= ParamUtil.getInteger(req, "id", -1);
		Integer idProjectCharter	= ParamUtil.getInteger(req, "idprojectcharter", -1);
		
		Project proj		= null;
		byte[] charterDoc	= null;
		boolean error		= false;
		
		try {
			
			proj = ProjectLogic.consProject(idProject);
			Projectcharter projCharter = ProjectCharterLogic.consProjectCharter(idProjectCharter);
			
			Employee user = SecurityUtil.consUser(req);
			
			ProjectCharterTemplate projCharterTemplate = ProjectCharterTemplate.getProjectChaterTemplate();
			
			File charterDocFile = projCharterTemplate.generateCharter(
					idioma, proj, projCharter, user.getContact().getFullName());

			if (charterDocFile != null) {
				charterDoc = DocumentUtils.getBytesFromFile(charterDocFile);
			}
		}
		catch (Exception e) {
			error = true;
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		if (charterDoc != null && !error) {
			sendFile(req, resp, charterDoc, proj.getProjectName() + "_" + proj.getAccountingCode() + Settings.PROJECT_CHARTER_EXTENSION);
		}
		else {
			viewInitProject(req, resp, proj.getIdProject(), null);
		}
	}
	

	/**
	 * Set Stakeholder instance from HTTPRequest parameters
	 * @param req
	 * @return
	 * @throws Exception 
	 */
	private Stakeholder setStakeholderFromRequest(HttpServletRequest req) throws Exception {
		Stakeholder stakeholder = null;
		
		int idStakeholder		= ParamUtil.getInteger(req, "stk_id", -1);
		String rol				= ParamUtil.getString(req, "stk_rol", StringPool.BLANK);
		Character classification= ParamUtil.getString (req, "stk_classification", StringPool.BLANK).charAt(0);
		Character type			= ParamUtil.getString (req, "stk_type", StringPool.BLANK).charAt(0);
		String businessNeed		= ParamUtil.getString(req, "stk_businessneed", StringPool.BLANK);
		String expectations		= ParamUtil.getString(req, "stk_expectations", StringPool.BLANK);
		String influence		= ParamUtil.getString(req, "stk_influence", StringPool.BLANK);
		String mgtStrategy		= ParamUtil.getString(req, "stk_mgtstrategy", StringPool.BLANK);
		String contactName		= ParamUtil.getString(req, "stk_contact_name", StringPool.BLANK);
		String department		= ParamUtil.getString(req, "stk_department", StringPool.BLANK);
		int order				= ParamUtil.getInteger(req, "stk_order", 100);	
		
		if (idStakeholder != -1 || !StringPool.BLANK.equals(contactName)
				|| !StringPool.BLANK.equals(rol) || !StringPool.BLANK.equals(classification) 
				|| !StringPool.BLANK.equals(businessNeed) || !StringPool.BLANK.equals(expectations)
				|| !StringPool.BLANK.equals(influence) || !StringPool.BLANK.equals(mgtStrategy))
		{
			stakeholder = new Stakeholder();
			
			if (idStakeholder != -1) {				
				StakeholderLogic logic = new StakeholderLogic();
				stakeholder = logic.findById(idStakeholder);
				order = stakeholder.getOrderToShow();
			}			
			
			stakeholder.setContactName(contactName);
			stakeholder.setProjectRole(rol);
			stakeholder.setClassification(classification);
			stakeholder.setType(type);
			stakeholder.setRequirements(businessNeed);
			stakeholder.setExpectations(expectations);
			stakeholder.setInfluence(influence);
			stakeholder.setMgtStrategy(mgtStrategy);
			stakeholder.setDepartment(department);
			stakeholder.setOrderToShow(order);
		}
		
		return stakeholder;
	}
	

	/**
	 * Set Workingcost instance from HTTPRequest parameters
	 * @param req
	 * @return
	 */
	private Workingcosts setWorkingcostFromRequest (HttpServletRequest req) {
		
		Workingcosts workingcost = null;

		int idWorkingCost			= ParamUtil.getInteger(req, "wc_id", -1);
		
		String resourceName			= ParamUtil.getString (req, "wc_resource", StringPool.BLANK);
		String resourceDepartment	= ParamUtil.getString (req, "wc_department", StringPool.BLANK);
		int effort					= ParamUtil.getInteger(req, "wc_effort", -1);
		int realEffort				= ParamUtil.getInteger(req, "wc_real_effort", 0);
		double rate					= ParamUtil.getCurrency (req, "wc_rate", -1d);
		Integer q1					= ParamUtil.getInteger(req, Workingcosts.Q1, null);
		Integer q2					= ParamUtil.getInteger(req, Workingcosts.Q2, null);
		Integer q3					= ParamUtil.getInteger(req, Workingcosts.Q3, null);
		Integer q4					= ParamUtil.getInteger(req, Workingcosts.Q4, null);

		if (idWorkingCost != -1 || effort != -1 || rate != -1) {

			workingcost = new Workingcosts();
			
			if (idWorkingCost != -1) {
				workingcost.setIdWorkingCosts(idWorkingCost);
			}
			
			workingcost.setResourceName(resourceName);
			workingcost.setResourceDepartment(resourceDepartment);
			workingcost.setEffort(effort);
			workingcost.setRealEffort(realEffort);
			workingcost.setRate(rate);
			workingcost.setWorkCost(effort * rate);
			workingcost.setQ1(q1);
			workingcost.setQ2(q2);
			workingcost.setQ3(q3);
			workingcost.setQ4(q4);
		}
		
		return workingcost;
	}

	
	/**
	 * Set Project instance from HTTPRequest parameters
	 * @param req
	 * @return
	 */
	private Project setInitiatingProjectFromRequest(HttpServletRequest req) {
		Project proj = null;
		Integer idProject = ParamUtil.getInteger(req, "id", -1);
		
		Date plannedFinishDate	= ParamUtil.getDate		(req, "plannedFinishDate", dateFormat, null);
		String projectName		= ParamUtil.getString	(req, "projectname", null);
		int idProgram			= ParamUtil.getInteger	(req, "program", -1);
		String accountingCode	= ParamUtil.getString	(req, Project.ACCOUNTINGCODE, null);
		int idPerfOrg			= ParamUtil.getInteger	(req, "perforg", -1);
		int idProjectManager	= ParamUtil.getInteger	(req, "projectmanager", -1);
		String chartLabel		= ParamUtil.getString(req, Project.CHARTLABEL);
		int idCustomer			= ParamUtil.getInteger	(req, "customer", -1);
		int idInvestmentManager	= ParamUtil.getInteger	(req, Project.EMPLOYEEBYINVESTMENTMANAGER, -1);
		int idFunctionalManager = ParamUtil.getInteger	(req, "functionalmanager", -1);
		int idSponsor			= ParamUtil.getInteger	(req, "sponsor", -1);
		int idContractType		= ParamUtil.getInteger	(req, "contracttype", -1);
		double tcv				= ParamUtil.getCurrency	(req, "tcv", -1);
		double ni				= ParamUtil.getCurrency	(req, "ni", -1);
		double bac				= ParamUtil.getCurrency	(req, "bac", -1);
		int probability			= ParamUtil.getInteger	(req, Project.PROBABILITY, 0);
		int duration			= ParamUtil.getInteger	(req, "sac", -1);
		int effort				= ParamUtil.getInteger	(req, "effort", -1);
		int idGeography			= ParamUtil.getInteger	(req, Project.GEOGRAPHY, -1);
		int priority			= ParamUtil.getInteger	(req, "strategic_value", 0);
		Integer budgetYear		= ParamUtil.getInteger	(req, Project.BUDGETYEAR, null);
		boolean traveling		= ParamUtil.getBoolean	(req, Project.ISGEOSELLING,false);
		boolean internalProject = ParamUtil.getBoolean	(req, "internalProject",false);
		int idCategory			= ParamUtil.getInteger	(req, Project.CATEGORY, -1);
		String linkDoc			= ParamUtil.getString(req, Project.LINKDOC);
		int idFundingSource		= ParamUtil.getInteger(req, Fundingsource.IDFUNDINGSOURCE,-1);
		
		Program program = null;
		if (idProgram != -1) {
			program = new Program();
			program.setIdProgram(idProgram);
		}
		
		Customer customer = null;
		if (idCustomer != -1) {
			customer = new Customer();
			customer.setIdCustomer(idCustomer);
		}
		
		Performingorg perforg = null;
		if (idPerfOrg != -1) {
			perforg = new Performingorg();
			perforg.setIdPerfOrg(idPerfOrg);
		}
		
		Employee projectManager = null;
		if (idProjectManager != -1) {
			projectManager = new Employee();
			projectManager.setIdEmployee(idProjectManager);
		}
		
		Employee functionalManager = null;
		if (idFunctionalManager != -1) {
			functionalManager = new Employee();
			functionalManager.setIdEmployee(idFunctionalManager);
		}
		
		Category category = null;
		if (idCategory != -1) { category = new Category(idCategory); }
		
		Geography geography = null;
		if (idGeography != -1) { geography = new Geography(idGeography); }
		
		Employee investmentManager = null;
		if (idInvestmentManager != -1) { investmentManager = new Employee(idInvestmentManager); }
		
		Employee sponsor = null;
		if (idSponsor != -1) {
			sponsor = new Employee();
			sponsor.setIdEmployee(idSponsor);
		}
		
		Contracttype contractType = null;
		if (idContractType != -1) {
			contractType = new Contracttype();
			contractType.setIdContractType(idContractType);
		}
		
		proj = new Project();
		if (idProject != -1) {
			try {
				proj = ProjectLogic.consProject(idProject);
			}
			catch (Exception ex) {
				proj.setIdProject(idProject);
			}
		}
		
		if (idFundingSource == -1) { proj.setFundingsource(null); }
		else { proj.setFundingsource(new Fundingsource(idFundingSource)); }
		
		proj.setChartLabel(ValidateUtil.isNull(chartLabel)?accountingCode:chartLabel);
		proj.setInternalProject(internalProject);
		proj.setIsGeoSelling(traveling);
		proj.setLinkDoc(linkDoc);
		proj.setCategory(category);
		proj.setGeography(geography);
		proj.setAccountingCode(accountingCode);
		
		proj.setPlannedFinishDate(plannedFinishDate);
		
		if (projectName != null) { // Don't update this field
			proj.setProjectName(projectName);
		}
		proj.setBudgetYear(budgetYear);
		proj.setProbability(probability);
		proj.setPriority(priority);
		proj.setProgram(program);
		proj.setCustomer(customer);
		proj.setPerformingorg(perforg);
		proj.setEmployeeByProjectManager(projectManager);
		proj.setEmployeeByFunctionalManager(functionalManager);
		proj.setEmployeeByInvestmentManager(investmentManager);
		proj.setEmployeeBySponsor(sponsor);
		proj.setContracttype(contractType);
		if (tcv != -1) { // Don't update this field
			proj.setTcv(tcv);
		}
		if (ni != -1) { // Don't update this field
			proj.setNetIncome(ni);
		}
		if (bac != -1) { // Don't update this field 
			proj.setBac(bac);
		}
		if (duration != -1) { // Don't update this field
			proj.setDuration(duration);
		}
		if (effort != -1) { // Don't update this field
			proj.setEffort(effort);
		}
		
		return proj;
	}
	
	
	/**
	 * Set ProjectCharter instance from HTTPRequest parameters
	 * @param req
	 * @return
	 * @throws LogicException 
	 */
	private Projectcharter setProjectCharterFromRequest(HttpServletRequest req) throws Exception {
		Projectcharter projCharter = null;
		
		Integer idProjectCharter	= ParamUtil.getInteger(req, "idprojectcharter", -1);
		
		String businessNeed			= ParamUtil.getString(req, "businessneed", StringPool.BLANK);
		String projectObjectives	= ParamUtil.getString(req, "projectobjectives", StringPool.BLANK);
		String sucessCriteria		= ParamUtil.getString(req, "successcriteria", StringPool.BLANK);
		String mainConstraints		= ParamUtil.getString(req, "mainconstraints", StringPool.BLANK);
		String mainAssumptions		= ParamUtil.getString(req, "mainassumptions", StringPool.BLANK);
		String mainRisks			= ParamUtil.getString(req, "mainrisks", StringPool.BLANK);

		projCharter = new Projectcharter();
		
		if (idProjectCharter != -1) {
			projCharter = ProjectCharterLogic.consProjectCharter(idProjectCharter);
		}

		projCharter.setBusinessNeed(businessNeed);
		projCharter.setProjectObjectives(projectObjectives);
		projCharter.setSucessCriteria(sucessCriteria);
		projCharter.setMainConstraints(mainConstraints);
		projCharter.setMainAssumptions(mainAssumptions);
		projCharter.setMainRisks(mainRisks);
		
		return projCharter;
	}
}
