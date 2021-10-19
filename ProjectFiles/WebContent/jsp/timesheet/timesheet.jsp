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
 - Updater : Cédric Ndanga Wandji
 - Devoteam 2015/04/07 user story 19 : updating function approveTimeTracking(element)
 - Devoteam 2015/05/28 user story 26 : updating saveTimeTracking(element) and approveTimeTracking(element) JavaScript functions
--%>
<%@page import="es.sm2.openppm.utils.SettingUtil"%>
<%@page import="es.sm2.openppm.common.Settings"%>
<%@page import="es.sm2.openppm.model.Timesheet"%>
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="allow_working_non_labor" var="msgNonLaborDay"/>
<fmt:message key="restore_calendar_exceptions" var="msgRestoreCalendar"/>

<%-- Message for Confirmations --%>
<fmt:message key="msg.confirm_delete" var="msgConfirmDeleteOperation">
	<fmt:param><fmt:message key="operation"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msgTitleConfirmDeleteOperation">
	<fmt:param><fmt:message key="operation"/></fmt:param>
</fmt:message>

<c:set var="app0" scope="request" value="<%=Constants.TIMESTATUS_APP0 %>"/>
<c:set var="app1" scope="request" value="<%=Constants.TIMESTATUS_APP1 %>"/>
<c:if test="${not editDisabled }">
	<c:set scope="request" var="btn_app0"><img onclick="javascript:saveTimeTracking(this);" title="<fmt:message key="save"/>" class="ico link" src="images/save.png"/>&nbsp;&nbsp;<img onclick="javascript:approveTimeTracking(this);" title="<fmt:message key="approve"/>" class="ico link" src="images/approve.png"/>&nbsp;&nbsp;</c:set>
</c:if>
<%-- cnw 
<c:set var="btn_editStatement" scope="request"><img src="images/ico_gesitona_tiempo.gif" alt="#" onclick="javascript:editStatement(this);" title="<fmt:message key="timesheet.edit_statement"/>" class="ico link"></c:set>
<c:set var="btn_viewStatement" scope="request"><img src="images/view.png" alt="#" onclick="viewStatement()" title="<fmt:message key="timesheet.view_statement"/>" class="ico link"></c:set>
--%>
<c:set var="btn_comments" scope="request"><img onclick="javascript:viewComments(this);" title="<fmt:message key="comments.view"/>" class="ico link" src="images/comments_delete.png"/></c:set>

<%-- cnw us26 Definition of JSTL variables for using message texts in the JavaScript --%>
<c:set var="activity_inprogress" scope="request"><fmt:message key="timesheet.in_progress"/></c:set>
<c:set var="activity_finished" scope="request"><fmt:message key="timesheet.finished"/></c:set>
<c:set var="activity_notstarted" scope="request"><fmt:message key="timesheet.not_started"/></c:set>
<c:set var="activity_inadvance" scope="request"><fmt:message key="timesheet.in_advance"/></c:set>
<c:set var="activity_ontime" scope="request"><fmt:message key="timesheet.on_time"/></c:set>
<c:set var="activity_late" scope="request"><fmt:message key="timesheet.late"/></c:set>
<c:set var="activity_right" scope="request"><fmt:message key="timesheet.right"/></c:set>
<c:set var="activity_exceeded" scope="request"><fmt:message key="timesheet.exceeded"/></c:set>
<c:set var="activity_overflow" scope="request"><fmt:message key="timesheet.overflow"/></c:set>

<%-- cnw us26 Definition of JSTL variables for using in the time sheet table JSP page (table_timesheet.inc.jsp) --%>
<c:set var="in_progress" scope="request"><%=Constants.ACTIVITYSTATUT_INPROGRESS%></c:set>
<c:set var="finished" scope="request"><%=Constants.ACTIVITYSTATUT_FINISHED%></c:set>
<c:set var="not_started" scope="request"><%=Constants.ACTIVITYSTATUT_NOTSTARTED%></c:set>
<c:set var="right" scope="request"><%=Constants.ESTIMATEDGAPSTATUT_RIGHT%></c:set>
<c:set var="exceeded" scope="request"><%=Constants.ESTIMATEDGAPSTATUT_EXCEEDED%></c:set>
<c:set var="overflow" scope="request"><%=Constants.ESTIMATEDGAPSTATUT_OVERFLOW%></c:set>
<c:set var="on_time" scope="request"><%=Constants.TIMESTATE_ONTIME%></c:set>
<c:set var="in_advance" scope="request"><%=Constants.TIMESTATE_INADVANCE%></c:set>
<c:set var="late" scope="request"><%=Constants.TIMESTATE_LATE%></c:set>

<style>

</style>

<script type="text/javascript">
<!--
var timesheetAjax = new AjaxCall('<%=TimeSheetServlet.REFERENCE%>','<fmt:message key="error"/>');

function saveTimeTrackingAll() {
	
	var f = document.frm_timesheet;
	f.accion.value = '<%=TimeSheetServlet.SAVE_ALL_TIMESHEET%>';
	loadingPopup();
	f.submit();
}
function deleteOperation(element) {

	var aData = timeSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	
	confirmUI('${msgTitleConfirmDeleteOperation}', '${msgConfirmDeleteOperation}',
			'<fmt:message key="yes"/>','<fmt:message key="no"/>',
			function(msg) {
				
				var f = document.frm_timesheet;
				f.accion.value = '<%=TimeSheetServlet.DEL_OPERATION%>';
				f.idTimeSheetOperation.value = aData[1];
				loadingPopup();
				f.submit();
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

function saveTimeTracking(element) {
	
	var aData = timeSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	
	//building the AJAX request by configuring AJAX parameters
	var params = {
		accion: '<%=TimeSheetServlet.JX_SAVE_TIMESHEET%>',
		idTimeSheet: aData[1],
		activity_state: $("#timesheet_activity_state_"+aData[1]).val(),				// cnw us26 configuring the activity state parameter
		//estimated_gap: $("#timesheet_estimated_gap_"+aData[1]).val(),				// cnw us26 configuring the estimated gap parameter
		estimated_gap_value: $("#timesheet_estimated_gap_value_"+aData[1]).val(),	// cnw us26 configuring the estimated gap value parameter
		time: $("#timesheet_time_"+aData[1]).val(),									// cnw us26 configuring the time state parameter
		day1: $('#day1_'+aData[1]).val(),
		day2: $('#day2_'+aData[1]).val(),
		day3: $('#day3_'+aData[1]).val(),
		day4: $('#day4_'+aData[1]).val(),
		day5: $('#day5_'+aData[1]).val(),
		day6: $('#day6_'+aData[1]).val(),
		day7: $('#day7_'+aData[1]).val()
	};
	
	timesheetAjax.call(params);
}
function approveTimeTracking(element) {
	
	var aData = timeSheetTable.fnGetData(element.parentNode.parentNode.parentNode);

	var total = 0;
	total += Number($('#day1_'+aData[1]).val());
	total += Number($('#day2_'+aData[1]).val());
	total += Number($('#day3_'+aData[1]).val());
	total += Number($('#day4_'+aData[1]).val());
	total += Number($('#day5_'+aData[1]).val());
	total += Number($('#day6_'+aData[1]).val());
	total += Number($('#day7_'+aData[1]).val());

	// ndanga 2015/04/07 userstory 19 (autorisation de valider une activité sans charge. Suppression du test ci-dessous)
	//if (total > 0) { 
		confirmTextUI('<fmt:message key="approve"/>', '<fmt:message key="comments"/>',
				'<fmt:message key="yes"/>','<fmt:message key="no"/>',
				function(msg) {
					//building the AJAX request by configuring AJAX parameters
					var params = {
						accion: '<%=TimeSheetServlet.JX_APPROVE_TIMESHEET%>',
						idTimeSheet: aData[1],
						activity_state: $("#timesheet_activity_state_"+aData[1]).val(),				// cnw us26 configuring the activity state parameter
						estimated_gap_value: $("#timesheet_estimated_gap_value_"+aData[1]).val(),	// cnw us26 configuring the estimated gap value parameter
						time: $("#timesheet_time_"+aData[1]).val(),									// cnw us26 configuring the time state parameter
						day1: $('#day1_'+aData[1]).val(),
						day2: $('#day2_'+aData[1]).val(),
						day3: $('#day3_'+aData[1]).val(),
						day4: $('#day4_'+aData[1]).val(),
						day5: $('#day5_'+aData[1]).val(),
						day6: $('#day6_'+aData[1]).val(),
						day7: $('#day7_'+aData[1]).val(),
						comments: msg
					};
					
					timesheetAjax.call(params, function(data) {
	
						$(element.parentNode.parentNode.parentNode)
							.find('input.hour_sheet:not([readonly])')
							.attr('readonly','readonly');
						
						$('#changeStatus_'+aData[1]).text(data.status);
						$('#changeButtons_'+aData[1]).html('<nobr>${btn_comments}</nobr>');
						
						// cnw us26 if choosing "In progress", print "In progress" in the time sheet table (table_timesheet.inc.jsp)
						if(data.activity_state == '<%=Constants.ACTIVITYSTATUT_INPROGRESS%>') {
							$("#activity_state_"+aData[1]).html('${activity_inprogress}');
						}
						else if(data.activity_state == '<%=Constants.ACTIVITYSTATUT_FINISHED%>') {
							$("#activity_state_"+aData[1]).html('${activity_finished}');
						}
						else {
							$("#activity_state_"+aData[1]).html('${activity_notstarted}');
						}
						// cnw us26 if choosing "Right", print "Right" in the time sheet table (table_timesheet.inc.jsp)
						$("#estimated_gap_"+aData[1]).html(data.estimated_gap_value);
						// cnw us26 if choosing "On time", print "On time" in the time sheet table (table_timesheet.inc.jsp)
						if(data.time == '<%=Constants.TIMESTATE_ONTIME%>') {
							$("#time_"+aData[1]).html('${activity_ontime}');
						}
						else if(data.time == '<%=Constants.TIMESTATE_INADVANCE%>') {
							$("#time_"+aData[1]).html('${activity_inadvance}');
						}
						else {
							$("#time_"+aData[1]).html('${activity_late}');
						}
					});
				}
		);
	//}
	//else { alertUI('<fmt:message key="error"/>','<fmt:message key="msg.error.no_hours"/>'); }
}

function allowNonLabor() {
	$('input.exceptionDay, input.nonWorkingDay').each(function() {
		$(this).attr('readonly', false);
	});
	$('a#non_labor span').html('${msgRestoreCalendar}');
	$('a#non_labor').unbind();
	$('a#non_labor').click(function() { restoreCalendar();});
}

function restoreCalendar() {
	$('input.exceptionDay, input.nonWorkingDay').each(function() {
		$(this).attr('readonly', true);
	});

	$('a#non_labor span').html('${msgNonLaborDay}');
	$('a#non_labor').unbind();
	$('a#non_labor').click(function() { allowNonLabor();});
}

readyMethods.add(function() {
	
	$('#non_labor').click(function() { allowNonLabor(); });
	$('#clearHours').click(function() { $('input.hour_sheet:not([readonly])').val(''); });
	$(".campo").change( function() { calcHours(); });
	
});

//-->
</script>

<form name="frm_timesheet" id="frm_timesheet" action="<%=TimeSheetServlet.REFERENCE%>" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" name="comments" value="" />
	<input type="hidden" name="idOperation" value="" />
	<input type="hidden" name="idTimeSheetOperation" value="" />
	<input type="hidden" name="initDate" value="${initDate }" />
	<input type="hidden" name="endDate" value="${endDate }" />
	
	<fieldset>
		<table width="100%" border="0" cellpadding="7" cellspacing="1">
			<tr>
				<th width="5%"><fmt:message key="filter"/>:</th>
				<td width="30%">
					<select id="filter" class="campo" style="width:100%;">
						<option value="" selected><fmt:message key="select_opt"/></option>
						<option value="<fmt:message key="applevel.app0"/>"><fmt:message key="applevel.app0_desc" /></option>
						<option value="<fmt:message key="applevel.app1"/>"><fmt:message key="applevel.app1_desc" /></option>
						<c:if test="<%=SettingUtil.getApprovalRol(request) > 0%>">
							<option value="<fmt:message key="applevel.app2"/>"><fmt:message key="applevel.app2_desc" /></option>
						</c:if>
						<option value="<fmt:message key="applevel.app3"/>"><fmt:message key="applevel.app3_desc" /></option>
					</select>
				</td>
				<td width="35%" style="text-align: right;">
				</td>
				<th width="30%" align="right">
					<img src="images/after.ico" onclick="changeWeek('<%=TimeSheetServlet.PREVIOUS_WEEK_TIMESHEET%>')"/>
					&nbsp;${initDate}&nbsp;-&nbsp;${endDate}&nbsp;
					<c:choose>
						<c:when test="${nextDisabled}"><img src="images/next_disabled.png"/></c:when>
						<c:otherwise><img src="images/next.png" onclick="changeWeek('<%=TimeSheetServlet.NEXT_WEEK_TIMESHEET%>')"/></c:otherwise>
					</c:choose>
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
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td style="font-size: 9px;"><b><fmt:message key="applevel.app0" />:</b>&nbsp;<fmt:message key="applevel.app0_desc" /></td>
				<td style="font-size: 9px;"><b><fmt:message key="applevel.app1" />:</b>&nbsp;<fmt:message key="applevel.app1_desc" /></td>
				<c:if test="<%=SettingUtil.getApprovalRol(request) > 0%>">
					<td style="font-size: 9px;"><b><fmt:message key="applevel.app2" />:</b>&nbsp;<fmt:message key="applevel.app2_desc" /></td>
				</c:if>
				<td style="font-size: 9px;"><b><fmt:message key="applevel.app3" />:</b>&nbsp;<fmt:message key="applevel.app3_desc" /></td>
			</tr>
		</table>
	</fieldset>
	<div style="padding: 15px;">
		<c:if test="${not editDisabled }">
			<a class="button_img position_right" href="javascript:approveTimeTrackingAll();"><img src="images/approve.png"/><span><fmt:message key="approve.all"/></span></a>
			<a class="button_img position_right" href="javascript:saveTimeTrackingAll();"><img src="images/save.png"/><span><fmt:message key="save.all"/></span></a>
			<a class="button_img position_right" href="#" id="clearHours"><img src="images/undo.png"/><span><fmt:message key="clear_all_hours"/></span></a>
			<a class="button_img position_right" href="#" id="non_labor"><img src="images/calendar.png"/><span><fmt:message key="allow_working_non_labor"/></span></a>
			<a class="button_img position_right" href="javascript:addNewOperation();"><img src="images/add_proj.png"/><span><fmt:message key="add_operation"/></span></a>
		</c:if>
	</div>
</form>
<jsp:include page="operation_popup.jsp" flush="true"/>
<jsp:include page="common/comments.inc.jsp" flush="true"/>
<%-- <jsp:include page="common/statement_timesheet_popup.jsp" flush="true"/> --%>
