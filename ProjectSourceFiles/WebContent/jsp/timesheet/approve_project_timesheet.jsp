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
 -  Updater : Cédric Ndanga Wandji
 -  Devoteam 03/06/2015 user story 27 : Adding of JSTL variables for the time sheet table viewed from the project manager.
--%>

<%@page import="es.sm2.openppm.utils.SettingUtil"%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="app1" scope="request" value="<%=Constants.TIMESTATUS_APP1 %>"/>
<c:set var="app2" scope="request" value="<%=Constants.TIMESTATUS_APP2 %>"/>
<c:set scope="request" var="btn_app1"><img onclick="javascript:approveTimeTracking(this);" title="<fmt:message key="approve"/>" class="ico link" src="images/approve.png"/>&nbsp;&nbsp;</c:set>
<c:set var="btn_comments" scope="request"><img onclick="javascript:viewComments(this);" title="<fmt:message key="comments.view"/>" class="ico link" src="images/comments_delete.png"/></c:set>
<c:set var="btn_reject" scope="request"><img onclick="javascript:rejectTimeTracking(this);" title="<fmt:message key="reject"/>" class="ico link" src="images/reject.png"/>&nbsp;&nbsp;</c:set>
<c:set var="approveRol"><%=SettingUtil.getApprovalRol(request) %></c:set>

<c:choose>
	<c:when test="<%=SettingUtil.getApprovalRol(request) > 0 %>"><c:set var="approveLevel">app2</c:set></c:when>
	<c:otherwise><c:set var="approveLevel">app3</c:set></c:otherwise>
</c:choose>

<%-- cnw us27 Definition of JSTL variables for using in the time sheet table JSP page (table_timesheet.inc.jsp) --%>
<c:set var="in_progress" scope="request"><%=Constants.ACTIVITYSTATUT_INPROGRESS%></c:set>
<c:set var="finished" scope="request"><%=Constants.ACTIVITYSTATUT_FINISHED%></c:set>
<c:set var="not_started" scope="request"><%=Constants.ACTIVITYSTATUT_NOTSTARTED%></c:set>
<c:set var="right" scope="request"><%=Constants.ESTIMATEDGAPSTATUT_RIGHT%></c:set>
<c:set var="exceeded" scope="request"><%=Constants.ESTIMATEDGAPSTATUT_EXCEEDED%></c:set>
<c:set var="overflow" scope="request"><%=Constants.ESTIMATEDGAPSTATUT_OVERFLOW%></c:set>
<c:set var="on_time" scope="request"><%=Constants.TIMESTATE_ONTIME%></c:set>
<c:set var="in_advance" scope="request"><%=Constants.TIMESTATE_INADVANCE%></c:set>
<c:set var="late" scope="request"><%=Constants.TIMESTATE_LATE%></c:set>

<script type="text/javascript">
<!--
var timesheetAjax = new AjaxCall('<%=TimeSheetServlet.REFERENCE%>','<fmt:message key="error"/>');
var employeesTable;

function changeWeek(accion) {
	
	var f = document.frm_timesheet;
	f.accion.value = accion;
	loadingPopup();
	f.submit();
}

function approveTimeTracking(element) {
	
	var aData = timeSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	
	confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				var params = {
					accion: '<%=TimeSheetServlet.JX_APPROVE_TIMESHEET%>',
					idTimeSheet: aData[1],
					comments: msg
				};
				
				timesheetAjax.call(params, function() {
					
					$('#changeStatus_'+aData[1]).text('<fmt:message key="applevel.${approveLevel}"/>');
					$('#changeButtons_'+aData[1]).html('<nobr>${approveLevel eq "app3"?btn_reject:""}${btn_comments}</nobr>');
				});
			}
	);
}

function rejectTimeTracking(element) {
	
	var aData = timeSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	
	confirmTextUI('<fmt:message key="reject"/>', '<fmt:message key="comments"/>',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				var params = {
					accion: '<%=TimeSheetServlet.JX_REJECT_TIMESHEET%>',
					idTimeSheet: aData[1],
					comments: msg
				};
				
				timesheetAjax.call(params, function() {
					
					timeSheetTable.fnDeleteSelected();
				});
			}
	);
}

function approveTimeTrackingAll() {
	confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				
				var f = document.frm_timesheet;
				f.accion.value = '<%=TimeSheetServlet.APPROVE_ALL_TIMESHEET%>';
				f.comments.value = msg;
				loadingPopup();
				f.submit();
			}
	);
}

function rejectTimeTrackingAll() {
	confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				
				var f = document.frm_timesheet;
				f.accion.value = '<%=TimeSheetServlet.REJECT_ALL_TIMESHEET%>';
				f.comments.value = msg;
				loadingPopup();
				f.submit();
			}
	);
}

function approveTimeTrackingSel() {
	
	if (employeesTable.fnGetSelectedsCol() == null) {
		alertUI('<fmt:message key="msg.info"/>','<fmt:message key="msg.info.selcet_row"/>');
	}
	else {
		confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
				'<fmt:message key="yes"/>','<fmt:message key="no"/>',
				function(msg) {
					
					var f = document.frm_timesheet;
					f.accion.value = '<%=TimeSheetServlet.APPROVE_SEL_TIMESHEET%>';
					f.comments.value = msg;
					f.idEmployees.value = employeesTable.fnGetSelectedsCol();
					f.idProjects.value = employeesTable.fnGetSelectedsCol(2);
					loadingPopup();
					f.submit();
				}
		);
	}
}

function rejectTimeTrackingSel() {
	
	if (employeesTable.fnGetSelectedsCol() == null) {
		alertUI('<fmt:message key="msg.info"/>','<fmt:message key="msg.info.selcet_row"/>');
	}
	else {
		confirmTextUI('<fmt:message key="reject"/>', '<fmt:message key="comments"/>',
				'<fmt:message key="yes"/>','<fmt:message key="no"/>',
				function(msg) {
					
					var f = document.frm_timesheet;
					f.accion.value = '<%=TimeSheetServlet.REJECT_SEL_TIMESHEET%>';
					f.comments.value = msg;
					f.idEmployees.value = employeesTable.fnGetSelectedsCol();
					f.idProjects.value = employeesTable.fnGetSelectedsCol(2);
					loadingPopup();
					f.submit();
				}
		);
	}
}

function viewTimeSheet(idEmployee, idProject) {
	
	var f = document.frm_timesheet;
	f.accion.value = '';
	f.idEmployee.value	= idEmployee;
	f.idProject.value	= idProject;
	loadingPopup();
	f.submit();
}

readyMethods.add(function() {
	
	employeesTable = $('#tb_employees').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"oTableTools": { "sRowSelect": "multi", "aButtons": [] },
		"aoColumns": [
              { "bVisible": false },
              { "sClass": "left", "sWidth": "40%" },
              { "bVisible": false },
              { "sClass": "left", "sWidth": "45%" },
              { "sClass": "center", "sWidth": "5%"},
              { "sClass": "center", "sWidth": "5%"},
              { "sClass": "center", "sWidth": "5%", "bSortable": false }
     	]
	});
	
	$("#filterProject").change( function() {
		employeesTable.fnFilter($("#filterProject").val(),2);
	});
});

//-->
</script>

<form name="frm_timesheet" id="frm_timesheet" action="<%=TimeSheetServlet.REFERENCE%>" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="comments" value="" />
	<input type="hidden" name="idEmployees" value="" />
	<input type="hidden" name="idProjects" value="" />
	<input type="hidden" name="idEmployee" value="${employee.idEmployee }" />
	<input type="hidden" name="idProject" value="${project.idProject }" />
	<input type="hidden" name="initDate" value="${initDate }" />
	<input type="hidden" name="endDate" value="${endDate }" />
	
	<fieldset>
		<table width="100%" border="0" cellpadding="7" cellspacing="1">
			<tr>
				<th width="5%"><fmt:message key="project"/>:</th>
				<td width="40%">
					<select id="filterProject" class="campo" style="width:100%;">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<c:forEach var="project" items="${projects }">
							<option value="${project.idProject }">${project.projectName }</option>
						</c:forEach>
					</select>
				</td>
				<td width="20%">&nbsp;</td>
				<th width="35%" align="right">
					<img src="images/after.ico" onclick="changeWeek('<%=TimeSheetServlet.PREVIOUS_WEEK_TIMESHEET%>')"/>
					&nbsp;${initDate}&nbsp;-&nbsp;${endDate}&nbsp;
						<img src="images/next.png" onclick="changeWeek('<%=TimeSheetServlet.NEXT_WEEK_TIMESHEET%>')"/>
				</th>
			</tr>
		</table>
		<table id="tb_employees" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th><fmt:message key="contact.fullname"/></th>
					<th>&nbsp;</th>
					<th><fmt:message key="project"/></th>
					<th><fmt:message key="status"/></th>
					<th><fmt:message key="total"/></th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="approval" items="${approvals }">
					<tr>
						<td>${approval[0] }</td> <%-- idEmployee --%>
						<td>${tl:escape(approval[1]) }</td> <%-- Name Employee--%>
						<td>${approval[2] }</td> <%-- idProject --%>
						<td>${tl:escape(approval[3]) }</td> <%-- Project Name--%>
						<td><fmt:message key="applevel.${tl:getStatusResource(approval[0], approval[2], initTypeDate, endTypeDate, app1, approveLevel, user) }"/></td>
						<td>${tl:toCurrency(tl:getHoursResource(approval[0], approval[2], initTypeDate, endTypeDate, user, approveRol)) }</td>
						<td><img src="images/view.png" onclick="viewTimeSheet(${approval[0] }${not empty approval[2] ?",":"" }${approval[2] })" title="<fmt:message key="view"/>"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div>&nbsp;</div>
		<div>
			<a class="button_img position_right" href="javascript:rejectTimeTrackingSel();"><img src="images/reject.png"/><span><fmt:message key="reject"/></span></a>
			<a class="button_img position_right" href="javascript:approveTimeTrackingSel();"><img src="images/approve.png"/><span><fmt:message key="approve"/></span></a>
		</div>
		<div>&nbsp;</div>
		<c:if test="${timeSheets ne null and not empty timeSheets}">
			<fieldset>
				<legend>${tl:escape(employee.contact.fullName) } - ${tl:escape(project.projectName) }</legend>
				<div>&nbsp;</div>
				<table width="100%" border="0" cellpadding="7" cellspacing="1">
					<tr>
						<th width="5%">
							<c:if test="<%=SettingUtil.getApprovalRol(request) > 0%>">
								<fmt:message key="filter"/>:
							</c:if>
						</th>
						<td width="40%">
							<c:if test="<%=SettingUtil.getApprovalRol(request) > 0%>">
								<select id="filter" class="campo" style="width:100%;">
									<option value="" selected><fmt:message key="select_opt"/></option>
									<option value="<fmt:message key="applevel.app1"/>"><fmt:message key="applevel.app1_desc" /></option>
										<option value="<fmt:message key="applevel.app2"/>"><fmt:message key="applevel.app2_desc" /></option>
								</select>
							</c:if>
						</td>
						<td width="20%">&nbsp;</td>
						<th width="35%" align="right">
							<img src="images/after.ico" onclick="changeWeek('<%=TimeSheetServlet.PREVIOUS_WEEK_TIMESHEET%>')"/>
							&nbsp;${initDate}&nbsp;-&nbsp;${endDate}&nbsp;
							<img src="images/next.png" onclick="changeWeek('<%=TimeSheetServlet.NEXT_WEEK_TIMESHEET%>')"/>
						</th>
					</tr>
				</table>
				
				<%-- TIME SHEET TABLE --%>
				<jsp:include page="common/table_timesheet.inc.jsp" flush="false"/>
				
				<table width="100%" cellpadding="4" cellspacing="1">
					<tr>
						<td><input type="text" class="ui-corner-all notWorkDay" style="width:16px;height:14px;border:1px solid black;margin:2px;" />&nbsp;<fmt:message key="calendar.non_working"/></td>
						<td><input type="text" class="ui-corner-all nonWorkingDay" style="width:16px;height:14px;border:1px solid black;margin:2px;" />&nbsp;<fmt:message key="calendar.non_default_work_week"/></td>
						<td><input type="text" class="ui-corner-all exceptionDay" style="width:16px;height:14px;border:1px solid black;margin:2px;"/>&nbsp;<fmt:message key="calendar.exception_day"/></td>
						<td width="25%">&nbsp;</td>
					</tr>
					<tr>
						<td style="font-size: 9px;"><b><fmt:message key="applevel.app1" />:</b>&nbsp;<fmt:message key="applevel.app1_desc" /></td>
						<c:if test="<%=SettingUtil.getApprovalRol(request) > 0%>">
							<td style="font-size: 9px;"><b><fmt:message key="applevel.app2" />:</b>&nbsp;<fmt:message key="applevel.app2_desc" /></td>
						</c:if>
						<td colspan="2">&nbsp;</td>
					</tr>
				</table>
			</fieldset>
			<div style="padding: 15px;">
				<a class="button_img position_right" href="javascript:rejectTimeTrackingAll();"><img src="images/reject.png"/><span><fmt:message key="reject.all"/></span></a>
				<a class="button_img position_right" href="javascript:approveTimeTrackingAll();"><img src="images/approve.png"/><span><fmt:message key="approve.all"/></span></a>
			</div>
		</c:if>
	</fieldset>
</form>
<jsp:include page="common/comments.inc.jsp" flush="true"/>
