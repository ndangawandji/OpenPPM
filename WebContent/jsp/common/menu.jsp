<%------------------------------------------------------------------------------
 -  Copyright (C) 2009-2012 SM2 BALEARES
 -  This program is free software: you can redistribute it and/or modify
 -  it under the terms of the GNU General Public License as published by
 -  the Free Software Foundation, either version 3 of the License, or
 -  (at your option) any later version.
 -  
 -  This program is distributed in the hope that it will be useful,
 -  but WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 -  See the GNU General Public License for more details.
 -  
 -  You should have received a copy of the GNU General Public License
 -  along with this program. If not, see http://www.gnu.org/licenses/.
 - 
 -  For more information, please contact SM2 BALEARES.
 -  Mail: info@open-ppm.org
 -  Web: http://www.talaia-openppm.es/
 - 
 -  Authors : Javier Hernandez Castillo, Daniel Casas Lopez
------------------------------------------------------------------------------%>
<%--
 - Updater : Cedric Ndanga Wandji
 - Devoteam, 29/06/2015, user story 17 : adding Purchase Order menu
--%>
<%@page import="es.sm2.openppm.utils.SettingUtil"%>
<%@page import="es.sm2.openppm.model.Employee"%>
<%@page import="es.sm2.openppm.servlets.AssignmentServlet"%>
<%@page import="es.sm2.openppm.servlets.ExpenseSheetServlet"%>
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet"%>
<%@page import="es.sm2.openppm.servlets.ResourceServlet"%>
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>
<%@page import="es.sm2.openppm.servlets.MaintenanceServlet"%>
<%@page import="es.sm2.openppm.servlets.CalendarServlet"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@page import="es.sm2.openppm.servlets.PurchaseorderServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@taglib uri="http://java.sun.com/jstl/fmt"		prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt"	prefix="c" %>

<% Employee user = (Employee)request.getSession().getAttribute("user"); %>

<fmt:setLocale value="${locale}" scope="request"/>
<script>
	function viewOptionMenu(action, accion) {
		var f = document.frm_menu;
		f.action = action;
		f.accion.value = accion;
		loadingPopup();
		f.submit();
	}
</script>
<form name="frm_menu" method="post" action="">
	<input type="hidden" name="accion" value=""/>
</form>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="26" background="images/fondo_menu_sup.gif">
		<table width="950" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td>
					<ul class="sf-menu">
					
					<%--  *********************  --%>
					<%--  ***** Menus PMO *****  --%>
					
					<c:if test="${param.idProfile == role_pmo}">
						
						<%--  Menu Investments --%>
						<li>
							<a href="./projects?accion=<%=ProjectServlet.LIST_INVESTMENTS %>" class="menu_sup"><fmt:message key="menu.investments" /></a>
						</li>
						
						<%--  Menu Projects --%>
						<li>
							<a href="./projects" class="menu_sup"><fmt:message key="menu.projects" /></a>
						</li>
						
						<%--  Menu Programs --%>
						<li>
							<a href="./<%=ProgramServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.programs"/></a>
						</li>
						
						<c:if test="<%=SettingUtil.getApprovalRol(request) == user.getResourceprofiles().getIdProfile() %>">
							<%--  Menu Time & Expense Approvals --%>
							<li>
								<a href="./<%=TimeSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.time_approvals"/></a>
							</li>
							<li>
								<a href="./<%=ExpenseSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.expense_approvals"/></a>
							</li>
						</c:if>
						
						<%--  Menu Organizational Project Assets (OPA) --%>
						<li>
							<a href="#" class="menu_sup"><fmt:message key="menu.organizational_project_assets"/></a>
							
							<ul>
								<li>
									<a href="<%=CalendarServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.base_calendar"/></a>
								</li>
								<li>
									<a href="<%=MaintenanceServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.maintenance" /></a>
								</li>
							</ul>

						</li>

					</c:if>
					
					<%--  ************************************  --%>
					<%--  ***** Menus PORFOLIO MANAGER *****  --%>
					
					<c:if test="${param.idProfile == role_porf_manager}">
						
						<%--  Menu Investments --%>
						<li>
							<a href="./projects?accion=<%=ProjectServlet.LIST_INVESTMENTS %>" class="menu_sup"><fmt:message key="menu.investments" /></a>
						</li>
						
						<%--  Menu Projects --%>
						<li>
							<a href="./projects" class="menu_sup"><fmt:message key="menu.projects" /></a>
						</li>
						
						<%--  Menu Programs --%>
						<li>
							<a href="./<%=ProgramServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.programs"/></a>
						</li>
					
					</c:if>
					
					<%--  ************************************  --%>
					<%--  ***** Menus FUNCTIONAL MANAGER *****  --%>
					
					<c:if test="${param.idProfile == role_fun_manager}">
						
						<%--  Menu Investments --%>
						<li>
							<a href="./projects?accion=<%=ProjectServlet.LIST_INVESTMENTS %>" class="menu_sup"><fmt:message key="menu.investments" /></a>
						</li>
						
						<%--  Menu Projects --%>
						<li>
							<a href="./projects" class="menu_sup"><fmt:message key="menu.projects" /></a>
						</li>
						
						<%--  Menu Programs --%>
						<li>
							<a href="./<%=ProgramServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.programs"/></a>
						</li>
						
						<%-- cnw us17 Menu PO --%>
						<li>
							<a href="./<%=PurchaseorderServlet.REFERENCE%>" class="menu_sup"><fmt:message key="menu.purchaseorder" /></a>
						</li>
						
						<c:if test="<%=SettingUtil.getApprovalRol(request) == user.getResourceprofiles().getIdProfile() %>">
							<%--  Menu Time & Expense Approvals --%>
							<li>
								<a href="./<%=TimeSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.time_approvals"/></a>
							</li>
							<li>
								<a href="./<%=ExpenseSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.expense_approvals"/></a>
							</li>
						</c:if>
					</c:if>
					
					<%--  *************************  --%>
					<%--  ***** Menus SPONSOR *****  --%>
					
					<c:if test="${param.idProfile == role_sponsor}">
						
						<%--  Menu Investments --%>
						<li>
							<a href="./projects?accion=<%=ProjectServlet.LIST_INVESTMENTS %>" class="menu_sup"><fmt:message key="menu.investments" /></a>
						</li>
						
						<%--  Menu Projects --%>
						<li>
							<a href="./projects" class="menu_sup"><fmt:message key="menu.projects" /></a>
						</li>
						
					</c:if>
					
					<%--  ************************************  --%>
					<%--  ***** Menus INVESTMENT MANAGER *****  --%>
					
					<c:if test="${param.idProfile == role_inv_manager}">
					
						<%--  Menu Investments --%>
						<li>
							<a href="./projects?accion=<%=ProjectServlet.LIST_INVESTMENTS %>" class="menu_sup"><fmt:message key="menu.investments" /></a>
						</li>
						
					</c:if>
					
					<%--  **********************************  --%>
					<%--  ***** Menus RESOURCE MANAGER *****  --%>
					
					<c:if test="${param.idProfile == role_res_manager}">
						
						<%--  Menu Assignations Approvals --%>
						<li>
							<a href="./<%=ResourceServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.assignations_approvals"/></a>
						</li>
						
						<%--  Menu Resource Capacity Planning --%>
						<li>
							<a href="javascript:viewOptionMenu('<%=ResourceServlet.REFERENCE %>','<%=ResourceServlet.VIEW_CAPACITY_PLANNING %>');" class="menu_sup"><fmt:message key="menu.resource_capacity_planning"/></a>
						</li>
						
					</c:if>
					
					<%--  *********************************  --%>
					<%--  ***** Menus PROGRAM MANAGER *****  --%>
					
					<c:if test="${param.idProfile == role_pgm_manager}">
						
						<%--  Menu Investments --%>
						<li>
							<a href="./projects?accion=<%=ProjectServlet.LIST_INVESTMENTS %>" class="menu_sup"><fmt:message key="menu.investments" /></a>
						</li>
						
						<%--  Menu Projects --%>
						<li>
							<a href="./projects" class="menu_sup"><fmt:message key="menu.projects" /></a>
						</li>
						
						<%--  Menu Programs --%>
						<li>
							<a href="<%=ProgramServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.programs"/></a>
						</li>
					
					</c:if>
					
					<%--  *********************************  --%>
					<%--  ***** Menus PROJECT MANAGER *****  --%>
					
					<c:if test="${param.idProfile == role_prj_manager}">
					
						<%--  Menu Projects --%>
						<li>
							<a href="./projects" class="menu_sup"><fmt:message key="menu.projects" /></a>
						</li>
					
						<%--  Menu Time & Expense Approvals --%>
						<li>
							<a href="./<%=TimeSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.time_approvals"/></a>
						</li>
						<li>
							<a href="./<%=ExpenseSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.expense_approvals"/></a>
						</li>

					</c:if>
					
					<%--  **************************  --%>
					<%--  ***** Menus RESOURCE *****  --%>
					
					<c:if test="${param.idProfile == role_resource}">
					
						<%--  Assignments --%>
						<li>
							<a href="./<%=AssignmentServlet.REFERENCE %>" class="menu_sup"><fmt:message key="assignments"/></a>
						</li>
					
						<%--  Menu Time Sheet --%>
						<li>
							<a href="./<%=TimeSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.time_sheet"/></a>
						</li>
						
						<%--  Menu Expense Sheet --%>
						<li>
							<a href="./<%=ExpenseSheetServlet.REFERENCE %>" class="menu_sup"><fmt:message key="menu.expenses_sheet"/></a>
						</li>
					
					</c:if>
					
					</ul>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
