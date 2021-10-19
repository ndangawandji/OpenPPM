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
package es.sm2.openppm.plugins.msproject;

import java.io.IOException;
import java.io.InputStream;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.mpxj.ProjectFile;
import net.sf.mpxj.Task;
import net.sf.mpxj.mpp.MPPReader;
import net.sf.mpxj.reader.ProjectReader;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import es.sm2.openppm.servlets.AbstractGenericServlet;
import es.sm2.openppm.servlets.ErrorServlet;
import es.sm2.openppm.servlets.ProjectControlServlet;
import es.sm2.openppm.servlets.ProjectPlanServlet;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ParamUtil;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.StringPool;

public class MSProjectServlet extends AbstractGenericServlet {
	private static final long serialVersionUID = 1L;
       
	public final static Logger LOGGER = Logger.getLogger(MSProjectServlet.class);
	
	public final static String REFERENCE = "msproject";
	
	/***************** Actions ****************/
	public final static String LOAD_MPP 	= "load-mpp";
	public final static String UPDATE_MPP	= "update-mpp";	

    
	/**
	 * @see HttpServlet#service(HttpServletRequest req, HttpServletResponse resp)
	 */
    @SuppressWarnings("rawtypes")
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	super.service(req, resp);
    	
		String accion = ParamUtil.getString(req, "pluginAccion");
		Hashtable<String, FileItem> reqFields = null;
		
		if (ServletFileUpload.isMultipartContent(req) && StringPool.BLANK.equals(accion)) {	
			try {
				
				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemList = servletFileUpload.parseRequest(req);
				reqFields = parseFields(fileItemList);
				accion = reqFields.get("pluginAccion").getString();
				
			}
			catch (Exception e) { ExceptionUtil.evalueException(req, idioma, LOGGER, e); }
		}
		
		LOGGER.debug("Accion: " + accion);
		
		if (SecurityUtil.consUserRole(req) != -1) {

			/***************** Actions ****************/
			if (LOAD_MPP.equals(accion)) { loadMPP(req, resp, reqFields); }
			else if (UPDATE_MPP.equals(accion)) { updateMPP(req, resp, reqFields); }
		}
		else if (!isForward()) {
			forwardServlet(ErrorServlet.REFERENCE+"?accion=403", req, resp);
		}
	}
	
    /**
     * Load MSProject file
     * @param req
     * @param resp
     * @param reqFields
     * @throws IOException
     * @throws ServletException
     */
	private void loadMPP(HttpServletRequest req, HttpServletResponse resp, Hashtable<String, FileItem> reqFields)
			throws IOException, ServletException {

		ProjectReader reader = new MPPReader();
		ProjectFile msProject = null;
		List<Task> taskList = null;
		
		int idProject = Integer.parseInt(reqFields.get("id").getString());
		
		try {	
			FileItem dataFile = reqFields.get("file");

			InputStream inStream = dataFile.getInputStream();
			msProject = reader.read(inStream);
			
			taskList = msProject.getAllTasks();
			
			MSProjectLogic.loadTasks(taskList, idProject);
			
			info(req, "msproject.import");
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		req.setAttribute("id", idProject);
		forwardServlet(ProjectPlanServlet.REFERENCE, req, resp);
	}
   
	/**
     * Update activities dates and wbsNodes budget
     * @param req
     * @param resp
     * @param reqFields 
     * @throws IOException 
     * @throws ServletException 
     */
	private void updateMPP(HttpServletRequest req, HttpServletResponse resp, Hashtable<String, FileItem> reqFields) throws ServletException, IOException {
		
		ProjectReader reader = new MPPReader();
		ProjectFile msProject = null;
		List<Task> taskList = null;
		
		int idProject = Integer.parseInt(reqFields.get("id").getString());
		
		try {	
			FileItem dataFile = reqFields.get("file");

			InputStream inStream = dataFile.getInputStream();
			msProject = reader.read(inStream);
			
			taskList = msProject.getAllTasks();
			
			MSProjectLogic.updateTasks(taskList, idProject);
			
			info(req, "msproject.updated");
		}
		catch (Exception e) {
			ExceptionUtil.evalueException(req, idioma, LOGGER, e);
		}
		
		req.setAttribute("id", idProject);
		forwardServlet(ProjectControlServlet.REFERENCE, req, resp);
	}
}
