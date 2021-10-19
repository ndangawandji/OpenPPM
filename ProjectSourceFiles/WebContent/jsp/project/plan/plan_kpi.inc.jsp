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
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script language="javascript" type="text/javascript" >
<!--
var kpiTable;

readyMethods.add(function () {

	kpiTable = $('#tb_kpi').dataTable({
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"iDisplayLength": 50,
		"aoColumns": [ 
             { "bVisible": false }, 
             { "bVisible": false },
             { "sClass": "left" },
             { "sClass": "left" },
             { "sClass": "right" }, 
             { "sClass": "right" }, 
             { "sClass": "right" },
             { "sClass": "center", "bSortable": false }  
     	]
	});

	$('#tb_kpi tbody tr').live('click', function (event) {
		fnSetSelectable(kpiTable, this);
	});
	
	$("#projectUpperThreshold, #projectLowerThreshold").change(function() {
		
		var params = {
			accion: '<%=ProjectPlanServlet.JX_UPDATE_THRESHOLD%>',
			<%=Project.IDPROJECT%>: '${project.idProject}',
			<%=Project.LOWERTHRESHOLD%>: $("#projectLowerThreshold").val(),
			<%=Project.UPPERTHRESHOLD%>: $("#projectUpperThreshold").val()
		};
		planAjax.call(params);
	});
	
});
//-->
</script>

	
<fieldset id="kpi-table" class="level_1">
	<legend class="link" onclick="changeCookie('planKPI')"><fmt:message key="kpi.name"/></legend>
	<div class="buttons">
		<img id="planKPIBtn" onclick="changeCookie('planKPI', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="planKPI" class="hide" style="padding-top: 15px;">
		<table id="tb_kpi" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%"><fmt:message key="id" /></th>
					<th width="0%">&nbsp;</th>
					<th width="32%"><fmt:message key="kpi.metric" /></th>
					<th width="45%"><fmt:message key="kpi.definition" /></th>
					<th width="5%"><fmt:message key="kpi.upper_threshold" /></th>
					<th width="5%"><fmt:message key="kpi.lower_threshold" /></th>
					<th width="5%"><fmt:message key="kpi.weight" />&nbsp;%</th>
					<th width="8%">
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="addKpi()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="totalWeight" value="0"/>
				<c:forEach var="kpi" items="${project.projectkpis }">
					<c:set var="totalWeight" value="${kpi.weight + totalWeight}"/>
					<tr>
						<td>${kpi.idProjectKpi}</td>
						<td>${kpi.metrickpi.idMetricKpi}</td>
						<td>${tl:escape(kpi.metrickpi.name)}</td>
						<td>${tl:escape(kpi.metrickpi.definition)}</td>
						<td>${kpi.upperThreshold}</td>
						<td>${kpi.lowerThreshold}</td>
						<td>${kpi.weight}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<nobr>
									<img onclick="editKpi(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
									&nbsp;&nbsp;&nbsp;
									<img onclick="deleteKpi(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
								</nobr>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td><input type="text" class="campo right" id="projectUpperThreshold" value="${project.upperThreshold }"/></td>
					<td><input type="text" class="campo right" id="projectLowerThreshold" value="${project.lowerThreshold }"/></td>
					<td><div id="totalWeight" class="right">${totalWeight }</div></td>
					<td>&nbsp;</td>
				</tr>
			</tfoot>
		</table>
	</div>
</fieldset>
