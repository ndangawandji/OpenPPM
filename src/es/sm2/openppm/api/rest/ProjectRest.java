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
/**
*
* Copyright (C) 2009-2012 SM2 BALEARES
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
* 
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
* See the GNU General Public License for more details.
* 
* You should have received a copy of the GNU General Public License
* along with this program. If not, see http://www.gnu.org/licenses/.
*
* For more information, please contact SM2 BALEARES.
* Mail: info@open-ppm.org
* Web: http://www.talaia-openppm.es/
*
* Authors : Javier Hernandez Castillo, Daniel Casas Lopez
*
*/
package es.sm2.openppm.api.rest;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.UriInfo;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.model.Category;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contracttype;
import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Fundingsource;
import es.sm2.openppm.model.Geography;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcalendar;
import es.sm2.openppm.utils.Exclusion;
import es.sm2.openppm.utils.JsonUtil;
import es.sm2.openppm.utils.SecurityUtil;

public class ProjectRest {

	private static final Logger LOGGER = Logger.getLogger(ProjectRest.class);
	
	@SuppressWarnings("unused")
	@Context
	private UriInfo uriInfo;
	@SuppressWarnings("unused")
	@Context
	private Request request;
	private Integer id;
	
	public ProjectRest(UriInfo uriInfo, Request request, Integer id) {
		this.uriInfo = uriInfo;
		this.request = request;
		this.id = id;
	}
	
	@GET
	@Produces({MediaType.APPLICATION_XML, MediaType.APPLICATION_JSON})
	public Project getById(
			@QueryParam("token") String token) throws Exception {
		
		LOGGER.debug("REST API CALL: getById");
		
		Employee user = SecurityUtil.consUserByToken(token);
		
		if (!ProjectLogic.hasPermission(new Project(id), user, Constants.TAB_INITIATION)) {
			throw new LogicException("You are not permission to see the project");
		}
		
		ProjectLogic projectLogic = new ProjectLogic();
		
		List<String> joins = new ArrayList<String>();
		joins.add(Project.EMPLOYEEBYSPONSOR);
		joins.add(Project.EMPLOYEEBYSPONSOR+"."+Employee.CONTACT);
		joins.add(Project.EMPLOYEEBYINVESTMENTMANAGER);
		joins.add(Project.EMPLOYEEBYINVESTMENTMANAGER+"."+Employee.CONTACT);
		joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER);
		joins.add(Project.EMPLOYEEBYFUNCTIONALMANAGER+"."+Employee.CONTACT);
		joins.add(Project.EMPLOYEEBYPROJECTMANAGER);
		joins.add(Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
		
		Project project = projectLogic.findById(Integer.valueOf(id), joins);
		
		List<String> nEx = new ArrayList<String>();
		nEx.add(Employee.EMPLOYEE);
		nEx.add(Employee.EMPLOYEES);
		
		Project item = (Project) JsonUtil.removeLazy(project, Project.class,
				new Exclusion(Employee.class, nEx),
				new Exclusion(Company.class),
				new Exclusion(Program.class),
				new Exclusion(Fundingsource.class),
				new Exclusion(Geography.class),
				new Exclusion(Performingorg.class),
				new Exclusion(Projectcalendar.class),
				new Exclusion(Customer.class),
				new Exclusion(Contracttype.class),
				new Exclusion(Category.class));
		
		if (item == null) throw new RuntimeException("Get: Project with " + id +  " not found");
		
		return item;
	}
	
}
