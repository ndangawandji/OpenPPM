<%@page import="es.sm2.openppm.common.Constants" %>
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet" %>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--
var aDataStatement;

/* function getActivityState(timesheetState_1, timesheetState_2, timesheetState_3) {
	
	var stateValue;
	
	if($(timesheetState_1).is(":checked")) {
		
		stateValue = $(timesheetState_1).val();
	}
	else if($(timesheetState_2).is(":checked")) {
		
		stateValue = $(timesheetState_2).val();
	}
	else($(timesheetState_3).is(":checked")) {
		
		stateValue = $(timesheetState_3).val();
	}
	return stateValue;
}

function saveStatement() {
	
	var f = document.frm_statement;
	
	
	
	alert(activityState);
	
		
} */

function editStatement(element) {
	
	aDataStatement = timeSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	alert("hhhhhhhhhhhhhhhhhhhhh");
	$('#statement-popup').dialog('open');
}

readyMethods.add(function(){
	$('div#statement-popup').dialog({ autoOpen: false, modal: true, width: 400, minWidth: 700, resizable: false });
	$('#bntSaveStatement').click(function(){
		var activityState;
		var estimatedGap;
		var estimatedGapValue;
		var time;
		activityState = getActivityState("#timesheet_inprogress", "#timesheet_finished", "#timesheet_notstarted");
		alert(activityState);
		$('#statement-popup').dialog('close');
		estimatedGap = getActivityState("#timesheet_right", "#timesheet_exceeded", "#timesheet_overflow");
		time = getActivityState("#timesheet_ontime", "#timesheet_inadvance", "#timesheet_late");
	});
	
});
//-->
</script>

<div id="statement-popup" class="">
	<div id="statement-errors">
	</div>
	<form action="<%=TimeSheetServlet.REFERENCE%>" method="post" name="frm_statement" id="frm_statement">
		<input type="hidden" name="idTimesheet_statement">
		<fieldset id="activity_state">
			<legend>Activity state</legend>
			<input type="radio" name="timesheet_activity" value="<%=Constants.ACTIVITYSTATUT_INPROGRESS%>" id="timesheet_inprogress"><label><fmt:message key="timesheet.in_progress"/></label><br>
			<input type="radio" name="timesheet_activity" value="<%=Constants.ACTIVITYSTATUT_FINISHED%>" id="timesheet_finished"><label><fmt:message key="timesheet.finished"/></label><br>
			<input type="radio" name="timesheet_activity" value="<%=Constants.ACTIVITYSTATUT_NOTSTARTED%>" id="timesheet_notstarted"><label><fmt:message key="timesheet.not_started"/></label><br>
		</fieldset>
		<fieldset id="estimated_gap">
			<legend>Estimated gap</legend>
			<input type="radio" name="timesheet_gap" value="<%=Constants.ESTIMATEDGAPSTATUT_RIGHT%>" id="timesheet_right"><label><fmt:message key="timesheet.right"/></label><br>
			<input type="radio" name="timesheet_gap" value="<%=Constants.ESTIMATEDGAPSTATUT_EXCEEDED%>" id="timesheet_excedeed"><label><fmt:message key="timesheet.exceeded"/></label><br>
			<input type="radio" name="timesheet_gap" value="<%=Constants.ESTIMATEDGAPSTATUT_OVERFLOW%>" id="timesheet_overflow"><label><fmt:message key="timesheet.overflow"/></label><br>
			<label><fmt:message key="timesheet.gap"/></label><input type="text" name="timesheet_estimated_gap_value" id="timesheet_estimated_gap_value" class="campo" placeholder="">
		</fieldset>
		<fieldset id="time">
			<legend>Time</legend>
			<input type="radio" name="timesheet_time" value="<%=Constants.TIMESTATE_ONTIME%>" id="timesheet_ontime"><label><fmt:message key="timesheet.on_time"/></label><br>
			<input type="radio" name="timesheet_time" value="<%=Constants.TIMESTATE_INADVANCE%>" id="timesheet_inadvance"><label><fmt:message key="timesheet.in_advance"/></label><br>
			<input type="radio" name="timesheet_time" value="<%=Constants.TIMESTATE_LATE%>" id="timesheet_late"><label><fmt:message key="timesheet.late"/></label><br>
		</fieldset>
		<a href="#" id="bntSaveStatement" class="boton"><fmt:message key="timesheet.save_statement"/></a>
	</form>
</div>