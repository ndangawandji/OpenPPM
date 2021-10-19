package es.sm2.openppm.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import es.sm2.openppm.logic.CustomerLogic;
import es.sm2.openppm.logic.PurchaseorderLogic;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Purchaseorder;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * Servlet implementation class PurchaseorderServlet
 */
public class PurchaseorderServlet extends AbstractGenericServlet {
	
	private static final long serialVersionUID = 1L;
	
	public final static Logger LOGGER = Logger.getLogger(ProjectServlet.class);
	
	public static String REFERENCE = "purchaseorders";
	
	public static String SAVE_PO_JX = "save-po-jx";

 
	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		super.service(request, response);
		
		String accion = ParamUtil.getString(request, "accion");
		Hashtable<String, FileItem> reqFields = null;		
		
		if (SecurityUtil.consUserRole(request) != -1) {
			if(ServletFileUpload.isMultipartContent(request) && StringPool.BLANK.equals(accion)) {		
				try {
					ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
					List<?> fileItemList = servletFileUpload.parseRequest(request);
					reqFields = parseFields(fileItemList);
					accion = reqFields.get("accion").getString();										
				} 
				catch (FileUploadException e) {
					LOGGER.error(StringPool.ERROR, e);
					request.setAttribute(StringPool.ERROR, e.getMessage());
				}
			}		
			
			LOGGER.debug("Accion: " + accion);
			
			/***************** Actions ****************/
			if (ValidateUtil.isNull(accion)) {
				viewPO(request, response);
			}
			

			/*********** Actions AJAX ************/
			if(accion.equals(SAVE_PO_JX)) {savePO(request, response);}
			
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", request, response);
		}
	}
	
	private void viewPO(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<Customer> customers = null;
		List<Purchaseorder> purchaseOrders = null;
		PurchaseorderLogic purchaseLogic = new PurchaseorderLogic();
		
		try {
			purchaseOrders = purchaseLogic.findAll();
			customers = CustomerLogic.findAllOrder();
			
		} catch (Exception e) {
			
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		req.setAttribute("purchaseOrders", purchaseOrders);
		req.setAttribute("customers", customers);
		req.setAttribute("title", idioma.getString("purchaseorders"));
		forward("/index.jsp?nextForm=po/list_po", req, resp);
	}
	
	private void savePO(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		LOGGER.debug("Gloire a YHWH !");
		String purchaseRef = ParamUtil.getString(req, "po_ref", null);
		String purchaseName = ParamUtil.getString(req, "po_name", null);
		double purchaseCost = ParamUtil.getDouble(req, "po_cost", null);
		Date receptionDate = ParamUtil.getDate(req, "po_reception_date", dateFormat);
		Integer idCustomer = ParamUtil.getInteger(req, "po_customer", null);
		
		Purchaseorder purchase = new Purchaseorder();
		purchase.setPurchaseRef(purchaseRef);
		purchase.setPurchaseName(purchaseName);
		purchase.setReceptionDate(receptionDate);
		purchase.setPurchaseCost(purchaseCost);
		
		try {
			Customer customer = new Customer();
			customer = CustomerLogic.findById(idCustomer, false);
			purchase.setCustomer(customer);
			PurchaseorderLogic.savePO(purchase);
			viewPO(req, resp);
		} 
		catch (Exception e) {
			LOGGER.debug("Oups !");
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
	}

}
