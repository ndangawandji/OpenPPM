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
<%@page import="es.sm2.openppm.model.Fundingsource"%>
<%@page import="es.sm2.openppm.model.Geography"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.model.Category"%>
<%@page import="es.sm2.openppm.model.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--
var custType;

function applyFilter() {
	$('#ids').val(${param.table}.fnGetSelectedsCol());
	$.cookie('investment.ids', $("#ids").val(), { expires: 365 });
	${param.table}.fnDraw();
	
	$.cookie('investment.invApr', $("#invApr").attr('checked'), { expires: 365 });
	$.cookie('projects.statusClo', $("#invClo").attr('checked'), { expires: 365 });
	$.cookie('projects.statusIni', $("#invIna").attr('checked'), { expires: 365 });
	$.cookie('investment.invRej', $("#invRej").attr('checked'), { expires: 365 });
	$.cookie('investment.invInP', $("#invInP").attr('checked'), { expires: 365 });
	$.cookie('projects.filterInternal', $("#filterInternal").attr('checked'), { expires: 365 });
	
	$.cookie('projects.filter_start', $("#filter_start").val(), { expires: 365 });
	$.cookie('projects.filter_finish', $("#filter_finish").val(), { expires: 365 });
	
	$.cookie('projects.idCustomerType', $("#idCustomerType").val(), { expires: 365 });
	$.cookie('projects.idCustomer', $("#idCustomer").val(), { expires: 365 });
	$.cookie('projects.<%=Category.IDCATEGORY %>', $("#<%=Category.IDCATEGORY %>").val(), { expires: 365 });
	$.cookie('projects.idProgram', $("#idProgram").val(), { expires: 365 });
	$.cookie('projects.idPM', $("#idPM").val(), { expires: 365 });
	$.cookie('projects.idSponsor', $("#idSponsor").val(), { expires: 365 });
	$.cookie('projects.idSeller', $("#idSeller").val(), { expires: 365 });
	$.cookie('geography.idGeography', $("#<%=Geography.IDGEOGRAPHY%>").val(), { expires: 365 });
	$.cookie('fundingsource.idFundingSource', $("#<%=Fundingsource.IDFUNDINGSOURCE%>").val(), { expires: 365 });
	
	$.cookie('projects.<%=Project.BUDGETYEAR %>', $("#<%=Project.BUDGETYEAR %>").val(), { expires: 365 });
	$.cookie('projects.<%=Project.PROJECTNAME %>', $("#<%=Project.PROJECTNAME %>").val(), { expires: 365 });
}
function resetFilter() {
	
	$.cookie('investment.ids', null);
	
	$("#invApr").attr('checked','');
	$("#invClo").attr('checked','');
	$("#invIna").attr('checked','');
	$("#invRej").attr('checked','');
	$("#invInP").attr('checked','checked');
	$("#filterInternal").attr('checked','');
	$.cookie('investment.invApr', null);
	$.cookie('investment.invRej', null);
	$.cookie('projects.statusIni', null);
	$.cookie('projects.statusClo', null);
	$.cookie('investment.invInP', null);
	$.cookie('projects.filterInternal', null);
	
	$("#filter_start").val('');
	$("#filter_finish").val('');
	$.cookie('projects.filter_start', null);
	$.cookie('projects.filter_finish', null);
	
	$("#idCustomerType").val('');
	custType.filterSelect('filter');
	$("#idCustomer").val('');
	$("#<%=Category.IDCATEGORY %>").val('');
	$("#idProgram").val('');
	$("#idPM").val('');
	$("#idSponsor").val('');
	$("#idSeller").val('');
	$("#<%=Geography.IDGEOGRAPHY%>").val('');
	$("#<%=Fundingsource.IDFUNDINGSOURCE%>").val('');
	
	$.cookie('projects.idCustomerType', null);
	$.cookie('projects.idCustomer', null);
	$.cookie('projects.<%=Category.IDCATEGORY %>', null);
	$.cookie('projects.idProgram', null);
	$.cookie('projects.idSponsor', null);
	$.cookie('projects.idPM', null);
	$.cookie('projects.idSeller', null);
	$.cookie('geography.idGeography', null);
	$.cookie('fundingsource.idFundingSource', null);
	
	$("#<%=Project.BUDGETYEAR %>").val('');
	$("#<%=Project.PROJECTNAME %>").val('');
	$.cookie('projects.<%=Project.BUDGETYEAR %>', null);
	$.cookie('projects.<%=Project.PROJECTNAME %>', null);
}

function advancedFilter() {
	$('#advancedFilter').toggle('blind');
}

function loadFilterState() {
	
	$("#ids").val($.cookie('investment.ids'));
	
	if ($.cookie('investment.invApr') != null && $.cookie('investment.invApr') == 'true') {
		$("#invApr").attr('checked','checked');
	}
	if ($.cookie('projects.statusClo') != null && $.cookie('projects.statusClo') == 'true') {
		$("#invClo").attr('checked','checked');
	}
	if ($.cookie('projects.statusIni') != null && $.cookie('projects.statusIni') == 'true') {
		$("#invIna").attr('checked','checked');
	}
	if ($.cookie('investment.invRej') != null && $.cookie('investment.invRej') == 'true') {
		$("#invRej").attr('checked','checked');
	}
	if ($.cookie('investment.invInP') == 'false') {
		$("#invInP").attr('checked','');
	}
	else {
		$("#invInP").attr('checked','checked');
	}
	if ($.cookie('projects.filterInternal') != null && $.cookie('projects.filterInternal') == 'true') {
		$("#filterInternal").attr('checked','checked');
	}
	
	selectMultiple('projects.','idCustomerType');
	selectMultiple('projects.','idCustomer');
	selectMultiple('projects.','<%=Category.IDCATEGORY %>');
	selectMultiple('projects.','idProgram');
	selectMultiple('projects.','idPM');
	selectMultiple('projects.','idSponsor');
	selectMultiple('projects.','idSeller');
	
	if ($.cookie('geography.idGeography') != null) {
		$("#<%=Geography.IDGEOGRAPHY%>").val($.cookie('geography.idGeography'));
	}
	if ($.cookie('projects.filter_start') != null) {
		$("#filter_start").val($.cookie('projects.filter_start'));
	}
	if ($.cookie('projects.filter_finish') != null) {
		$("#filter_finish").val($.cookie('projects.filter_finish'));
	}
	if ($.cookie('projects.<%=Project.BUDGETYEAR %>') != null) {
		$("#<%=Project.BUDGETYEAR %>").val($.cookie('projects.<%=Project.BUDGETYEAR %>'));
	}
	if ($.cookie('projects.<%=Project.PROJECTNAME %>') != null) {
		$("#<%=Project.PROJECTNAME %>").val($.cookie('projects.<%=Project.PROJECTNAME %>'));
	}
	if ($.cookie('fundingsource.idFundingSource') != null) {
		$("#<%=Fundingsource.IDFUNDINGSOURCE %>").val($.cookie('fundingsource.idFundingSource'));
	}
}

readyMethods.add(function() {
	
	var dates = $('#filter_start, #filter_finish').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "filter_start" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			dates.not(this).datepicker("option", option, date);
		}
	});
});
//-->
</script>
<fieldset style="margin-bottom: 15px; padding-top:10px; ">
	<table width="100%">
		<tr>
			<td width="12%">
				<b><fmt:message key="filter" />:&nbsp;<a class="advancedFilter" href="javascript:advancedFilter();"><fmt:message key="filter.advanced"/></a></b>
			</td>
			<td width="12%">
				<input type="checkbox" name="filter" id="invInP" value="<%=Constants.INVESTMENT_IN_PROCESS %>" style="width:20px;"/>&nbsp;
				<fmt:message key="investments.status.P" />
			</td>
			<td width="12%">
				<input type="checkbox" name="filter" id="invApr" value="<%=Constants.INVESTMENT_APPROVED %>" style="width:20px;"/>&nbsp;
				<fmt:message key="investments.status.A" />
			</td>
			<td width="12%">
				<input type="checkbox" name="filter" id="invClo" value="<%=Constants.INVESTMENT_CLOSED %>" style="width:20px;"/>&nbsp;
				<fmt:message key="investments.status.C" />
			</td>
			<td width="12%">
				<input type="checkbox" name="filter" id="invIna" value="<%=Constants.INVESTMENT_INACTIVATED %>" style="width:20px;"/>&nbsp;
				<fmt:message key="investments.status.I" />
			</td>
			<td width="12%">
				<input type="checkbox" name="filter" id="invRej" value="<%=Constants.INVESTMENT_REJECTED %>" style="width:20px;"/>&nbsp;
				<fmt:message key="investments.status.R" />
			</td>
			<td class="right">
				<input type="submit" class="boton" onclick="applyFilter()" style="width: 95px;" value="<fmt:message key="filter.apply" />"/>
				<a href="javascript:resetFilter();" class="boton"><fmt:message key="filter.reset" /></a>
			</td>
		</tr>
		<tr>
			<td>
				<b><fmt:message key="search" />:</b>
			</td>
			<td colspan="4">
				<input type="text" id="<%=Project.PROJECTNAME %>" class="campo" style="width: 300px;">
			</td>
			<th id="filterColumnSelected" class="hide" colspan="2"><fmt:message key="msg.info.filter_column_selected"/></th>
		</tr>
	</table>
	<div>&nbsp;</div>
	<table width="100%" class="center hide" id="advancedFilter">
		<tr>
			<th width="25%"><fmt:message key="customer_type" /></th>
			<th width="25%"><fmt:message key="customer" /></th>
			<th width="25%"><fmt:message key="program" /></th>
			<th width="25%"><fmt:message key="project_manager" /></th>
		</tr>
		<tr>
			<td>
				<select id="idCustomerType" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="type" items="${cusType }">
						<option value="${type.idCustomerType }">${type.name }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="idCustomer" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="customer" items="${customers }">
						<option value="${customer.idCustomer }" class="${customer.customertype.idCustomerType }">${customer.name }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="idProgram" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="program" items="${programs }">
						<option value="${program.idProgram}">${program.programName }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="idPM" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="pm" items="${projectManagers }">
						<option value="${pm.idEmployee}">${pm.contact.fullName }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<th width="25%"><fmt:message key="category" /></th>
			<th width="25%"><fmt:message key="geography" /></th>
			<th width="25%"><fmt:message key="seller" /></th>
			<th width="25%"><fmt:message key="sponsor" /></th>
		</tr>
		<tr>
			<td>
				<select id="<%=Category.IDCATEGORY %>" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="category" items="${categories }">
						<option value="${category.idCategory }">${category.name }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="<%=Geography.IDGEOGRAPHY%>" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="geography" items="${geographys }">
						<option value="${geography.idGeography }">${geography.name }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="idSeller" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="seller" items="${sellers }">
						<option value="${seller.idSeller }">${seller.name }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="idSponsor" style="height: 72px;" multiple="multiple" class="campo">
					<c:forEach var="sponsor" items="${sponsors }">
						<option value="${sponsor.idEmployee}">${sponsor.contact.fullName }</option>
					</c:forEach>
				</select>
			</td>
		<tr>
			<td colspan="4">
				<table width="100%" class="center">
					<tr>
						<td width="80%" colspan="4">&nbsp;</td>
						<th width="20%"><fmt:message key="funding_source"/></th>
					</tr>
					<tr>
						<td align="center" style="padding-right: 11px;">
							<fmt:message key="dates.since"/>:&nbsp;
							<input type="text" name="filter_start" id="filter_start" class="campo fecha" />
						</td>
						<td align="center" style="padding-right: 11px;">
							<fmt:message key="dates.until"/>:&nbsp;
							<input type="text" name="filter_finish" id="filter_finish" class="campo fecha" />
						</td>
						<td align="center">
							<fmt:message key="project.budget_year" />
							<input type="text" class="campo" id="<%=Project.BUDGETYEAR %>" style="width:32px;" maxlength="4"/>
						</td>
						<td align="center">
							<input type="checkbox" id="filterInternal" style="width:20px;"  />&nbsp;
							<fmt:message key="project.internal" />
						</td>
						<td align="center">
							<select id="<%=Fundingsource.IDFUNDINGSOURCE %>" class="campo">
								<option value=""><fmt:message key="select_opt"/></option>
								<c:forEach var="fundingSource" items="${fundingSources }">
									<option value="${fundingSource.idFundingSource}">${fundingSource.name }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</fieldset>
