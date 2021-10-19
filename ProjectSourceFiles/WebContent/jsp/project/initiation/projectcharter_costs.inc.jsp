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
<%@page import="es.sm2.openppm.common.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--

var sellersCostsTable;
var infrastructuresCostsTable;
var licensesCostsTable;
var workingCostsTable;

//When document is ready
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
	              { "sClass": "right"},
	              { "sClass": "center", "bVisible": <%=Settings.SHOW_QUARTERS%> }, 
	              { "sClass": "center", "bVisible": <%=Settings.SHOW_QUARTERS%> }, 
	              { "sClass": "center", "bVisible": <%=Settings.SHOW_QUARTERS%> }, 
	              { "sClass": "center", "bVisible": <%=Settings.SHOW_QUARTERS%> },
	              { "bVisible": false },
	              { "sClass": "center", "bSortable": false }
	              
		]
	});

	$('#tb_workingcosts tbody tr').live('click', function (event) {
		fnSetSelectable(workingCostsTable, this);
	} );

	
	sellersCostsTable = $('#tb_sellerscosts').dataTable({
		"oLanguage": datatable_language,
		"bPaginate": false,
		"bLengthChange": false,
		"bFilter": false,
		"aoColumns": [ { "bVisible": false }, { "bVisible": true }, { "sClass": "right"}, { "sClass": "center", "bSortable": false } ]
	});

	$('#tb_sellerscosts tbody tr').live('click', function (event) {
		fnSetSelectable(sellersCostsTable, this);
	} );
	
	infrastructuresCostsTable = $('#tb_infrastructurecosts').dataTable({
		"oLanguage": datatable_language,
		"bPaginate": false,
		"bLengthChange": false,
		"bFilter": false,
		"aoColumns": [ { "bVisible": false }, { "bVisible": true }, { "sClass": "right"}, { "sClass": "center", "bSortable": false } ]
	});

	$('#tb_infrastructurecosts tbody tr').live('click', function (event) {
		fnSetSelectable(infrastructuresCostsTable, this);
	} );
	
	licensesCostsTable = $('#tb_licensescosts').dataTable({
		"oLanguage": datatable_language,
		"bPaginate": false,
		"bLengthChange": false,
		"bFilter": false,
		"aoColumns": [ { "bVisible": false }, { "bVisible": true }, { "sClass": "right"}, { "sClass": "center", "bSortable": false } ]
	});

	$('#tb_licensescosts tbody tr').live('click', function (event) {
		fnSetSelectable(licensesCostsTable, this);
	} );
});

//-->
</script>

<table width="100%">

	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<!--  SELLERS COSTS -->

	<c:forEach var="sellercost" items="${sellersCosts}">
		<c:set var="totalsellerscost" value="${totalsellerscost + sellercost.cost}" />
	</c:forEach>

	<tr>
		<th width="50%"><fmt:message key="sellerscosts" /></th>
		<th width="50%" align="right">
			<fmt:message key="total" />:&nbsp;<span id="totalsellerscosts">${tl:toCurrency(totalsellerscost)}</span>
		</th>
	</tr>
	<tr>
		<td colspan="2">
		
			<table id="tb_sellerscosts" class="tabledata" cellspacing="1" width="100%">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th width="72%"><fmt:message key="sellerscosts.name" /></th>
						<th width="20%"><fmt:message key="sellerscosts.cost" /></th>
						<th width="8%">
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="newSellerCost()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
							</c:if>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="sellercost" items="${sellersCosts}">
					<tr>
						<td>${sellercost.idChargesCosts}</td>
						<td>${sellercost.name}</td>
						<td>${tl:toCurrency(sellercost.cost)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="viewSellerCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
								<img onclick="deleteSellerCost(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</td>
	</tr>
	
	<!--  INFRASTRUCTURE COSTS -->

	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<c:forEach var="infrastructurecost" items="${infrastructureCosts}">
		<c:set var="totalinfrastructurecost" value="${totalinfrastructurecost + infrastructurecost.cost}" />
	</c:forEach>

	<tr>
		<th width="50%"><fmt:message key="infrastructurecosts" /></th>
		<th width="50%" align="right">
			<fmt:message key="total" />:&nbsp;<span id="totalinfrastructurecosts">${tl:toCurrency(totalinfrastructurecost)}</span>
		</th>
	</tr>
	<tr>
		<td colspan="2">
			<table id="tb_infrastructurecosts" class="tabledata" cellspacing="1" width="100%">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th width="72%"><fmt:message key="infrastructurecosts.name" /></th>
						<th width="20%"><fmt:message key="infrastructurecosts.cost" /></th>
						<th width="8%">
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="newInfrastructureCost()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
							</c:if>
						</th>
					</tr>
				</thead>
					<c:forEach var="infrastructurecost" items="${infrastructureCosts}">
					<tr>
						<td>${infrastructurecost.idChargesCosts}</td>
						<td>${infrastructurecost.name}</td>
						<td>${tl:toCurrency(infrastructurecost.cost)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="viewInfrastructureCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
								<img onclick="deleteInfrastructureCost(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
							</c:if>
						</td>
					</tr>
					</c:forEach>
			</table>
		</td>
	</tr>
	
	<!--  LICENSES COSTS -->

	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<c:forEach var="licensecost" items="${licensesCosts}">
		<c:set var="totallicensescost" value="${totallicensescost + licensecost.cost}" />
	</c:forEach>

	<tr>
		<th width="50%"><fmt:message key="licensescosts" /></th>
		<th width="50%" align="right">
			<fmt:message key="total" />:&nbsp;<span id="totallicensescosts">${tl:toCurrency(totallicensescost)}</span>
		</th>
	</tr>
	<tr>
		<td colspan="2">
			<table id="tb_licensescosts" class="tabledata" cellspacing="1" width="100%">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th width="72%"><fmt:message key="licensescosts.name" /></th>
						<th width="20%"><fmt:message key="licensescosts.cost" /></th>
						<th width="8%">
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="newLicenseCost()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
							</c:if>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="licensecost" items="${licensesCosts}">
					<tr>
						<td>${licensecost.idChargesCosts}</td>
						<td>${licensecost.name}</td>
						<td>${tl:toCurrency(licensecost.cost)}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="viewLicenseCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;&nbsp;
								<img onclick="deleteLicenseCost(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</td>
	</tr>
	
	<!--  DIRECT COSTS -->

	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>

	<c:forEach var="workingcosts" items="${project.workingcostses}">
		<c:set var="totaleffort" value="${totaleffort + workingcosts.effort}" />
		<c:set var="totalworkingcost" value="${totalworkingcost + workingcosts.workCost}" />
	</c:forEach>

	<tr>
		<th width="50%"><fmt:message key="direct_costs" /></th>
		<th width="50%" align="right">
			<table width="100%">
				<tr>
					<th width="60%" align="right">
					<fmt:message key="workingcosts.units" />:&nbsp;<span id="totaleffort">${totaleffort}</span>
					</th>
					<th width="40%" align="right">
					<fmt:message key="total" />:&nbsp;<span id="totalworkingcosts">${tl:toCurrency(totalworkingcost)}</span>
					</th>
				</tr>
			</table>
		</th>
	</tr>
	<tr>
		<td colspan="2">
			<table id="tb_workingcosts" class="tabledata" cellspacing="1" width="100%">
				<thead>
					<tr>		
						<th>&nbsp;</th>
						<th width="31%"><fmt:message key="workingcosts.resource" /></th>
						<th width="31%"><fmt:message key="workingcosts.department" /></th>
						<th width="10%"><fmt:message key="workingcosts.units" /></th>
						<th width="10%"><fmt:message key="workingcosts.unit_rate" /></th>
						<th width="10%"><fmt:message key="workingcosts.cost" /></th>
						<th width="0%"><fmt:message key="workingcosts.q1" /></th>
						<th width="0%"><fmt:message key="workingcosts.q2" /></th>
						<th width="0%"><fmt:message key="workingcosts.q3" /></th>
						<th width="0%"><fmt:message key="workingcosts.q4" /></th>
						<th width="0%"><fmt:message key="workingcosts.actual_hours" /></th>
						<th width="8%">
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="newWorkingCost()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
							</c:if>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="workingcosts" items="${project.workingcostses}">
					<tr>
						<td>${workingcosts.idWorkingCosts}</td>
						<td>${tl:escape(workingcosts.resourceName)}</td>
						<td>${tl:escape(workingcosts.resourceDepartment)}</td>
						<td>${workingcosts.effort}</td>
						<td>${tl:toCurrency(workingcosts.rate)}</td>
						<td>${tl:toCurrency(workingcosts.workCost)}</td>
						<td>${workingcosts.q1}</td>
						<td>${workingcosts.q2}</td>
						<td>${workingcosts.q3}</td>
						<td>${workingcosts.q4}</td>
						<td>${workingcosts.realEffort}</td>
						<td>
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img onclick="viewWorkingCost(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">
								&nbsp;&nbsp;
								<img onclick="deleteWorkingCost(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
							</c:if>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</td>
	</tr>
</table>
