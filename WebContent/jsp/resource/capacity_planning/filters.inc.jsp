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
<%@page import="es.sm2.openppm.utils.StringPool"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.model.Contact"%>
<%@page import="es.sm2.openppm.model.Teammember"%>
<%@page import="es.sm2.openppm.servlets.ResourceServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script language="javascript" type="text/javascript" >
<!--
function applyFilter() {
	
	actionApplyFilter();
	
	$.cookie('resource.statusAssigned', 	$("#<%=Constants.RESOURCE_ASSIGNED%>").attr('checked'), { expires: 365 });
	$.cookie('resource.statusPreAssigned',	$("#<%=Constants.RESOURCE_PRE_ASSIGNED %>").attr('checked'), { expires: 365 });
	$.cookie('resource.statusProposed', 	$("#<%=Constants.RESOURCE_PROPOSED %>").attr('checked'), { expires: 365 });
	$.cookie('resource.statusReleased', 	$("#<%=Constants.RESOURCE_RELEASED %>").attr('checked'), { expires: 365 });
	$.cookie('resource.statusTurnedDown', 	$("#<%=Constants.RESOURCE_TURNED_DOWN %>").attr('checked'), { expires: 365 });
	
	$.cookie('resource.name', $("#<%=Contact.FULLNAME%>").val(), { expires: 365 });
	$.cookie('resource.since', $("#since").val(), { expires: 365 });
	$.cookie('resource.until', $("#until").val(), { expires: 365 });
	$.cookie('resource.orderName', $("#orderName").val(), { expires: 365 });

	$.cookie('resource.<%=Project.ENTITY%>', $("#<%=Project.ENTITY%>").val(), { expires: 365 });
	$.cookie('resource.<%=Project.EMPLOYEEBYPROJECTMANAGER%>', $("#<%=Project.EMPLOYEEBYPROJECTMANAGER%>").val(), { expires: 365 });
	$.cookie('resource.<%=Teammember.SKILL%>', $("#<%=Teammember.SKILL%>").val(), { expires: 365 });
	
	return false;
}

function resetFilter() {
	
	$("#<%=Constants.RESOURCE_PRE_ASSIGNED %>").attr('checked','checked');
	$("#<%=Constants.RESOURCE_ASSIGNED%>").attr('checked','');
	$("#<%=Constants.RESOURCE_PROPOSED %>").attr('checked','');
	$("#<%=Constants.RESOURCE_RELEASED %>").attr('checked','');
	$("#<%=Constants.RESOURCE_TURNED_DOWN %>").attr('checked','');
	
	$("#<%=Contact.FULLNAME%>").val('');
	$("#since").val('');
	$("#until").val('');
	$("#orderName").val('');

	$("#<%=Project.ENTITY%>").val('');
	$("#<%=Project.EMPLOYEEBYPROJECTMANAGER%>").val('');
	$("#<%=Teammember.SKILL%>").val('');
	
	$.cookie('resource.statusAssigned', 	null);
	$.cookie('resource.statusPreAssigned',	null);
	$.cookie('resource.statusProposed', 	null);
	$.cookie('resource.statusReleased', 	null);
	$.cookie('resource.statusTurnedDown', 	null);
	
	$.cookie('resource.name', null);
	$.cookie('resource.since', null);
	$.cookie('resource.until', null);
	$.cookie('resource.orderName', null);

	$.cookie('resource.<%=Project.ENTITY%>', null);
	$.cookie('resource.<%=Project.EMPLOYEEBYPROJECTMANAGER%>', null);
	$.cookie('resource.<%=Teammember.SKILL%>', null);
}

function loadFilterState() {
	
	$("#<%=Constants.RESOURCE_PRE_ASSIGNED %>")	.attr('checked',$.cookie('resource.statusPreAssigned') == 'true'?'checked':'');   
	$("#<%=Constants.RESOURCE_ASSIGNED%>")		.attr('checked',$.cookie('resource.statusAssigned') == 'true'?'checked':'');                  
	$("#<%=Constants.RESOURCE_PROPOSED %>")	 	.attr('checked',$.cookie('resource.statusProposed') == 'true'?'checked':'');                 
	$("#<%=Constants.RESOURCE_RELEASED %>")	 	.attr('checked',$.cookie('resource.statusReleased') == 'true'?'checked':'');                 
	$("#<%=Constants.RESOURCE_TURNED_DOWN %>")	.attr('checked',$.cookie('resource.statusTurnedDown') == 'true'?'checked':'');              
	
	$("#<%=Contact.FULLNAME%>").val($.cookie('resource.name' ) != null?$.cookie('resource.name' ):'');
	$("#since").val($.cookie('resource.since') != null?$.cookie('resource.since'):'');
	$("#until").val($.cookie('resource.until') != null?$.cookie('resource.until'):'');
	$("#orderName").val($.cookie('resource.orderName') != null?$.cookie('resource.orderName'):'');
	
	selectMultiple('resource.','<%=Project.ENTITY%>');
	selectMultiple('resource.','<%=Project.EMPLOYEEBYPROJECTMANAGER%>');
	selectMultiple('resource.','<%=Teammember.SKILL%>');
	
}

function advancedFilter() { $('#advancedFilter').toggle('blind'); }

readyMethods.add(function () {
	
	var sinceUntil = $('#since, #until').datepicker({
		dateFormat: '${datePickerPattern}',
		firstDay: 1,
		showOn: 'button',
		buttonImage: 'images/calendario.png',
		buttonImageOnly: true,
		changeMonth: true,
		onSelect: function(selectedDate) {
			var option = this.id == "since" ? "minDate" : "maxDate";
			var instance = $(this).data("datepicker");
			var date = $.datepicker.parseDate(instance.settings.dateFormat || $.datepicker._defaults.dateFormat, selectedDate, instance.settings);
			sinceUntil.not(this).datepicker("option", option, date);
		}
	});
});
//-->
</script>

<fieldset style="margin-bottom: 15px; padding-top:10px; ">
	<table width="100%" cellpadding="1" cellspacing="1">
		<tr>
			<td>
				<b><fmt:message key="filter" />:&nbsp;<a class="advancedFilter" href="javascript:advancedFilter();"><fmt:message key="filter.advanced"/></a></b>
			</td>
			<td>
				<input type="checkbox" name="filter" id="<%=Constants.RESOURCE_ASSIGNED %>" value="<%=Constants.RESOURCE_ASSIGNED %>" style="width:20px;"/>&nbsp;<fmt:message key="resource.assigned"/>
			</td>
			<td>
				<input type="checkbox" name="filter" id="<%=Constants.RESOURCE_PRE_ASSIGNED %>" value="<%=Constants.RESOURCE_PRE_ASSIGNED %>" style="width:20px;"/>&nbsp;<fmt:message key="resource.preassigned"/>
			</td>
			<td>
				<input type="checkbox" name="filter" id="<%=Constants.RESOURCE_RELEASED %>" value="<%=Constants.RESOURCE_RELEASED %>" style="width:20px;"/>&nbsp;<fmt:message key="resource.released"/>
			</td>
			<td>
				<input type="checkbox" name="filter" id="<%=Constants.RESOURCE_PROPOSED %>" value="<%=Constants.RESOURCE_PROPOSED %>" style="width:20px;"/>&nbsp;<fmt:message key="resource.proposed"/>
			</td>
			<td>
				<input type="checkbox" name="filter" id="<%=Constants.RESOURCE_TURNED_DOWN %>" value="<%=Constants.RESOURCE_TURNED_DOWN %>" style="width:20px;"/>&nbsp;<fmt:message key="resource.turneddown"/>
			</td>
			<td class="right">
				<input type="submit" class="boton" onclick="return applyFilter()" style="width: 95px;" value="<fmt:message key="filter.apply" />"/>
				<a href="javascript:resetFilter();" class="boton"><fmt:message key="filter.reset" /></a>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td><b><fmt:message key="contact.fullname"/>:</b></td>
			<td colspan="2"><input type="text" id="<%=Contact.FULLNAME%>" name="<%=Contact.FULLNAME%>" class="campo"/></td>
			<td colspan="3" class="center">
				<b><fmt:message key="dates.since"/>:&nbsp;</b>
				<input type="text" name="since" id="since" class="campo fecha" />
				<b>&nbsp;&nbsp;&nbsp;<fmt:message key="dates.until"/>:&nbsp;</b>
				<input type="text" name="until" id="until" class="campo fecha" />
			</td>
			<td class="left">
				<nobr>
					<b><fmt:message key="order"/>:</b>&nbsp;
					<select name="orderName" id="orderName" class="campo" style="width: 100px;">
						<option value="<%=Constants.ASCENDENT%>"><fmt:message key="order.asc"/></option>
						<option value="<%=Constants.DESCENDENT%>"><fmt:message key="order.desc"/></option>
					</select>
				</nobr>
			</td>
		</tr>
	</table>
	<div>&nbsp;</div>
	<table width="100%" class="center hide" id="advancedFilter">
		<tr>
			<th width="34%"><fmt:message key="projects"/></th>
			<th width="33%"><fmt:message key="project_manager"/></th>
			<th width="33%"><fmt:message key="skill"/></th>
		</tr>
		<tr>
			<td>
				<select id="<%=Project.ENTITY%>" name="<%=Project.ENTITY%>" class="campo" multiple style="height: 72px;">
					<c:forEach var="project" items="${projects }">
						<option value="${project.idProject }">${project.projectName }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="<%=Project.EMPLOYEEBYPROJECTMANAGER%>" name="<%=Project.EMPLOYEEBYPROJECTMANAGER%>" class="campo" multiple style="height: 72px;">
					<c:forEach var="pm" items="${projectManagers }">
						<option value="${pm.idEmployee }">${pm.contact.fullName }</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<select id="<%=Teammember.SKILL%>" name="<%=Teammember.SKILL%>" class="campo" multiple style="height: 72px;">
					<c:forEach var="skill" items="${skills }">
						<option value="${skill.idSkill }">${skill.name }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
	</table>
</fieldset>
