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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.common.Settings"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--

var workingCostsTable;

readyMethods.add(function() {
	workingCostsTable = $('#tb_workingcosts').dataTable({
		"oLanguage": datatable_language,
		"bPaginate": false,
		"bLengthChange": false,
		"bFilter": false,
		"aoColumns": [ 
   				  { "bVisible": false },
	              { "bVisible": true }, 
	              { "bVisible": true }, 
	              { "sClass": "right"},
	              { "sClass": "right"},
	              { "bVisible": false },
	              { "bVisible": false },
	              { "bVisible": false },
	              { "bVisible": false },
	              { "bVisible": false },
	              { "sClass": "center", "bSortable": false }
	              
		]
	});

	$('#tb_workingcosts tbody tr').live('click', function (event) {
		fnSetSelectable(workingCostsTable, this);
	} );	
});
//-->
</script>

<fieldset class="level_1">
	<legend class="link" onclick="changeCookie('fieldClousureReport')"><fmt:message key="closure.report"/></legend>
	<div class="buttons">
		<img id="fieldClousureReportBtn" onclick="changeCookie('fieldClousureReport', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldClousureReport" class="hide" style="padding-top:10px;">
		<c:if test="${close_classname ne ''}">
			<div align="right" style="margin-right: 10px;">
				<a href="javascript:generateProjectClose();" class="boton"><fmt:message key="generate_closure_report" /></a>
			</div>
		</c:if>
		<table width="100%">
			<tr>
				<th class="left"><fmt:message key="closure.project_results" /></th>
				<th class="left"><fmt:message key="closure.goal_achievement" /></th>
			</tr>
			<tr>
				<td class="center">
					<textarea name="projectResults" class="campo show_scroll" rows="8" style="width:90%;">${closure.projectResults}</textarea>
				</td>
				<td class="center">
					<textarea name="goalAchievement" id="goalAchievement" class="campo show_scroll" rows="8" style="width:90%;">${closure.goalAchievement}</textarea>
				</td>
			</tr>
		</table>
		<div class="hColor" style="margin-top: 10px;"><fmt:message key="working_hours" /></div>			
		<table id="tb_workingcosts" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th width="34%"><fmt:message key="workingcosts.resource" /></th>
					<th width="31%"><fmt:message key="workingcosts.department" /></th>
					<th width="10%"><fmt:message key="workingcosts.planned_hours" /></th>
					<th width="10%"><fmt:message key="workingcosts.actual_hours" /></th>
					<th width="0%"><fmt:message key="workingcosts.unit_rate" /></th>						
					<th width="0%"><fmt:message key="workingcosts.q1" /></th>
					<th width="0%"><fmt:message key="workingcosts.q2" /></th>
					<th width="0%"><fmt:message key="workingcosts.q3" /></th>
					<th width="0%"><fmt:message key="workingcosts.q4" /></th>										
					<th width="5%">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="workingcosts" items="${project.workingcostses}">
				<tr>
					<td>${workingcosts.idWorkingCosts}</td>
					<td>${tl:escape(workingcosts.resourceName)}</td>
					<td>${tl:escape(workingcosts.resourceDepartment)}</td>
					<td>${workingcosts.effort}</td>
					<td>${workingcosts.realEffort}</td>		
					<td>${tl:toCurrency(workingcosts.rate)}</td>
					<td>${workingcosts.q1}</td>
					<td>${workingcosts.q2}</td>
					<td>${workingcosts.q3}</td>
					<td>${workingcosts.q4}</td>								
					<td>
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="viewWorkingCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">							
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>			
	</div>
</fieldset>
