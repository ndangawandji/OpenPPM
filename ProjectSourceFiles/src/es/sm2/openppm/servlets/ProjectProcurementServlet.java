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
/*
 *  Updater : Cedric Ndanga Wandji
 *  Devoteam 20/06/2015 user story 17 : updating viewPMProcurementProject() java method
 */
package es.sm2.openppm.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Order;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.javabean.ProcurementBudget;
import es.sm2.openppm.logic.ActivitysellerLogic;
import es.sm2.openppm.logic.DocumentprojectLogic;
import es.sm2.openppm.logic.ProcurementpaymentsLogic;
import es.sm2.openppm.logic.ProjectActivityLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.logic.PurchaseorderLogic;
import es.sm2.openppm.logic.SellerLogic;
import es.sm2.openppm.model.Activityseller;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Procurementpayments;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Purchaseorder;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.utils.DocumentUtils;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;

/**
 * Servlet implementation class ProjectServer
 */
public class ProjectProcurementServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	private static final Logger LOGGER = Logger.getLogger(ProjectProcurementServlet.class);	
	
	public final static String REFERENCE = "projectprocurement";
	
	/***************** Actions ****************/
	public final static String SAVE_SOW							= "save-sow";	
	public final static String SAVE_WORK						= "save-work";
	public final static String SAVE_SELLER						= "save-seller";
	public final static String SAVE_PAYMENT						= "save-payment";
	public final static String DELETE_SELLER					= "delete-seller";
	public final static String DELETE_PAYMENT					= "delete-payment";
	/************** Actions AJAX **************/	
	public final static String JX_CONS_SELLER_ACTIVITIES		= "ajax-cons-seller-act";
    
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "accion");		
		
		if (SecurityUtil.consUserRole(req) != -1) {
			
			LOGGER.debug("Accion: " + accion);
			
			/***************** Actions ****************/
			if (accion == null || StringPool.BLANK.equals(accion)){viewPMProcurementProject(req, resp);}
			else if (SAVE_SOW.equals(accion)) {saveSow(req, resp);}			
			else if (SAVE_WORK.equals(accion)) {saveWork(req, resp);}
			else if (SAVE_SELLER.equals(accion)) {saveSeller(req, resp);}
			else if (SAVE_PAYMENT.equals(accion)) {savePayment(req, resp);}
			else if (DELETE_SELLER.equals(accion)) {deleteSeller(req, resp);}
			else if (DELETE_PAYMENT.equals(accion)) {deletePayment(req, resp);}
			
			/************** Actions AJAX **************/
			else if (JX_CONS_SELLER_ACTIVITIES.equals(accion)) { consSellerActivitiesJX(req, resp); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
        
	/**
	 * Recover Procurement-Project info and forward to procurement_project.jsp
	 *  
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 * @updater cnw us17
	 */
	private void viewPMProcurementProject(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException 
	{
		// Information to recover
		Project project = null;
		List<Seller> sellers = null;
		List<Seller> procurementSellers = null;	
		List<Activityseller> activitySellers = null;
		List<Procurementpayments> procPayments = null;
		List<ProcurementBudget> procBudgets = null;
		List<Documentproject> docs			= null;
		List<Projectactivity> projActivities = null;
		List<Purchaseorder> purchaseOrders = null;
		
		Integer idProject		= ParamUtil.getInteger(req, "id", (Integer)req.getSession().getAttribute("idProject"));
		boolean hasPermission	= false;
		
		try {
			
			hasPermission = SecurityUtil.hasPermission(req, new Project(idProject), Constants.TAB_PROCURAMENT);
			
			if (hasPermission) {
				List<String> joins = new ArrayList<String>();
				joins.add(Project.PROGRAM);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
				joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);		
				
				project = ProjectLogic.consProject(new Project(idProject), joins);
				
				sellers = SellerLogic.findAllOrdered(Order.asc(Seller.NAME));
				procurementSellers = SellerLogic.findByProcurement(project, Order.asc(Seller.NAME));			
				
				joins = new ArrayList<String>();
				joins.add(Activityseller.PROJECTACTIVITY);
				joins.add(Activityseller.SELLER);			
				activitySellers = ActivitysellerLogic.consActivitySellerByProject(project, joins);
				
				joins = new ArrayList<String>();			
				joins.add(Procurementpayments.SELLER);
				procPayments = ProcurementpaymentsLogic.consProcurementPaymentsByProject(project, joins);
				procBudgets = ProcurementpaymentsLogic.consProcurementBudgetsByProject(project, joins);
				
				joins = new ArrayList<String>();			
				joins.add(Activityseller.SELLER);
				procPayments = ProcurementpaymentsLogic.consProcurementPaymentsByProject(project, joins);
				procBudgets = ProcurementpaymentsLogic.consProcurementBudgetsByProject(project, joins);
				
				joins = new ArrayList<String>();		// cnw us17
				joins.add(Projectactivity.PROJECT);		// cnw us17
				joins.add(Projectactivity.WBSNODE);		// cnw us17
				projActivities = ProjectActivityLogic.consActivities(project, joins);		// cnw us17
				
				PurchaseorderLogic purchaseLogic = new PurchaseorderLogic();	// cnw us17
				purchaseOrders = purchaseLogic.findAll();		// cnw us17
				
				if(Constants.DOCUMENT_STORAGE.equals("link")) {
					docs = new ArrayList<Documentproject>();
					docs.add(DocumentprojectLogic.findByType(project,Constants.DOCUMENT_PROCUREMENT));	
				}
				else {
					docs = DocumentprojectLogic.findListByType(project, Constants.DOCUMENT_PROCUREMENT);	
				}	
			}
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		if (hasPermission) {
			req.setAttribute("project", project);
			req.setAttribute("projActivities", projActivities);				// cnw us17
			req.setAttribute("sellers", sellers);
			req.setAttribute("procurementSellers", procurementSellers);		
			req.setAttribute("activitySellers", activitySellers);
			req.setAttribute("procPayments", procPayments);
			req.setAttribute("procBudgets", procBudgets);
			req.setAttribute("purchaseOrders", purchaseOrders);		// cnw us17
			if(Constants.DOCUMENT_STORAGE.equals("link")) {
				req.setAttribute("docs", docs.get(0));
			}
			else {
				req.setAttribute("docs", docs);	
			}
			
			req.setAttribute("documentationList", DocumentUtils.getDocumentationList(req));			
			forward("/index.jsp?nextForm=project/procurement/procurement_project", req, resp);
		}
		else {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
	/**
	 * Save Sow & selection data from procurement_project.jsp
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveSow(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {

		Integer id		 	= ParamUtil.getInteger(req, "idSow", -1);
		Integer idSeller 	= ParamUtil.getInteger(req, Activityseller.SELLER, -1);
		Integer idActivity 	= ParamUtil.getInteger(req, Activityseller.PROJECTACTIVITY, -1);
		String sow 			= ParamUtil.getString(req, Activityseller.STATEMENTOFWORK, StringPool.BLANK);
		String documents	= ParamUtil.getString(req, Activityseller.PROCUREMENTDOCUMENTS, StringPool.BLANK);
		
		try {
			
			SellerLogic sellerLogic = new SellerLogic();
			
			if (idSeller == -1 || idActivity == -1) {
				throw new Exception(idioma.getString("msg.error.data"));
			}
			
			Activityseller actSeller = new Activityseller();
			
			if(id != -1) {
				actSeller = ActivitysellerLogic.findById(id, false);
			}
			
			actSeller.setSeller(sellerLogic.findById(idSeller, false));
			actSeller.setProjectactivity(ProjectActivityLogic.consActivity(idActivity));
			actSeller.setStatementOfWork(sow);
			actSeller.setProcurementDocuments(documents);
			
			ActivitysellerLogic.saveActivityseller(actSeller);			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewPMProcurementProject(req, resp);
	}
	
	/**
	 * Save Work Schedule data from procurement_project.jsp
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveWork(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {

		Integer id		 	= ParamUtil.getInteger(req, "idWork", -1);
		Integer idSeller 	= ParamUtil.getInteger(req, Activityseller.SELLER, -1);		
		Date baseStart 		= ParamUtil.getDate(req, Activityseller.BASELINESTART, dateFormat, null);
		Date start	 		= ParamUtil.getDate(req, Activityseller.STARTDATE, dateFormat, null);
		Date baseFinish		= ParamUtil.getDate(req, Activityseller.BASELINEFINISH, dateFormat, null);
		Date finish 		= ParamUtil.getDate(req, Activityseller.FINISHDATE, dateFormat, null);
		String info			= ParamUtil.getString(req, Activityseller.WORKSCHEDULEINFO, StringPool.BLANK);
		
		try {
			
			SellerLogic sellerLogic = new SellerLogic();
			
			if (idSeller == -1) {
				throw new Exception(idioma.getString("msg.error.data"));
			}
			
			Activityseller actSeller = new Activityseller();
			
			actSeller = ActivitysellerLogic.findById(id, false);
			
			actSeller.setSeller(sellerLogic.findById(idSeller, false));
			actSeller.setBaselineStart(baseStart);
			actSeller.setStartDate(start);
			actSeller.setBaselineFinish(baseFinish);
			actSeller.setFinishDate(finish);
			actSeller.setWorkScheduleInfo(info);			
			
			ActivitysellerLogic.saveActivityseller(actSeller);			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewPMProcurementProject(req, resp);
	}
	
	/**
	 * Save Seller Performance data from procurement_project.jsp
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void saveSeller(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {

		Integer id		 	= ParamUtil.getInteger(req, "idActSeller", -1);
		Integer idSeller 	= ParamUtil.getInteger(req, Activityseller.SELLER, -1);
		String info			= ParamUtil.getString(req, Activityseller.SELLERPERFORMANCEINFO, StringPool.BLANK);

		try {
			
			SellerLogic sellerLogic = new SellerLogic();
			
			if (idSeller == -1) {
				throw new Exception(idioma.getString("msg.error.data"));
			}
			
			Activityseller actSeller = new Activityseller();
			
			actSeller = ActivitysellerLogic.findById(id, false);
			
			actSeller.setSeller(sellerLogic.findById(idSeller, false));			
			actSeller.setSellerPerformanceInfo(info);			
			
			ActivitysellerLogic.saveActivityseller(actSeller);			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewPMProcurementProject(req, resp);
	}
	
	/**
	 * Save Procurement Payment data from procurement_project.jsp
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void savePayment(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {

		Integer id		 	= ParamUtil.getInteger(req, "idPayment", -1);
		Integer idProject 	= ParamUtil.getInteger(req, "id", -1);
		Integer idSeller 	= ParamUtil.getInteger(req, Procurementpayments.SELLER, -1);		
		String order		= ParamUtil.getString(req, Procurementpayments.PURCHASEORDER, StringPool.BLANK);
		Date plannedDate	= ParamUtil.getDate(req, Procurementpayments.PLANNEDDATE, dateFormat, null);
		Date actualDate		= ParamUtil.getDate(req, Procurementpayments.ACTUALDATE, dateFormat, null);
		Double plannedPay 	= ParamUtil.getCurrency(req, Procurementpayments.PLANNEDPAYMENT, 0);
		Double actualPay 	= ParamUtil.getCurrency(req, Procurementpayments.ACTUALPAYMENT, 0);
		String info			= ParamUtil.getString(req, Procurementpayments.PAYMENTSCHEDULEINFO, StringPool.BLANK);
		
		try {
			
			ProcurementpaymentsLogic procurementpaymentsLogic = new ProcurementpaymentsLogic();
			
			SellerLogic sellerLogic = new SellerLogic();
			
			if (idSeller == -1 || idProject == -1) {
				throw new Exception(idioma.getString("msg.error.data"));
			}
			
			Procurementpayments payment = new Procurementpayments();
			
			if(id != -1) {
				payment = procurementpaymentsLogic.findById(id, false);
			}
			
			payment.setSeller(sellerLogic.findById(idSeller, false));
			payment.setProject(ProjectLogic.consProject(idProject));
			payment.setPurchaseOrder(order);
			payment.setPlannedDate(plannedDate);
			payment.setActualDate(actualDate);
			payment.setPlannedPayment(plannedPay);
			payment.setActualPayment(actualPay);
			payment.setPaymentScheduleInfo(info);
			
			procurementpaymentsLogic.save(payment);			
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewPMProcurementProject(req, resp);
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deleteSeller(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			Integer idSeller = ParamUtil.get(req, "idSeller", -1);
			
			ActivitysellerLogic.deleteActivityseller(ActivitysellerLogic.findById(idSeller, false));
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		
		viewPMProcurementProject(req, resp);			
	}
	
	/**
	 * 
	 * @param req
	 * @param resp
	 * @throws ServletException
	 * @throws IOException
	 */
	private void deletePayment(HttpServletRequest req, 
			HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			Integer idPayment = ParamUtil.get(req, "idPayment", -1);
			
			ProcurementpaymentsLogic procurementpaymentsLogic = new ProcurementpaymentsLogic();
			procurementpaymentsLogic.delete(procurementpaymentsLogic.findById(idPayment));
		}
		catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
	
		viewPMProcurementProject(req, resp);			
	}
	
	/**
	 * List not assigned activities to seller
	 * 
	 * @param req
	 * @param resp
	 * @throws IOException
	 */
	private void consSellerActivitiesJX(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		PrintWriter out = resp.getWriter();
		
		try {
			
			int idProject	= ParamUtil.getInteger(req, Project.IDPROJECT, -1);
			int idSeller	= ParamUtil.getInteger(req, Seller.IDSELLER,-1);
			
			List<Object[]> activities = ProjectActivityLogic.consNoAssignedActivities(new Seller(idSeller), new Project(idProject), Order.asc(Projectactivity.ACTIVITYNAME));
			
			out.print(JsonUtil.toJSON(activities));
		}
		catch (Exception e) { ExceptionUtil.evalueExceptionJX(out, req, idioma, LOGGER, e); }
		finally { out.close(); }
	}
}
