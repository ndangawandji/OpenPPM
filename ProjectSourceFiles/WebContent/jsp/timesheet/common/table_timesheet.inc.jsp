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
 - Devoteam, 28/05/2015, user story 26 : adding of total_hours class for not summing of hours'sum and estimated gap value in the JavaScript function calcHours()
 - Devoteam, 28/05/2015, user story 26 : adding  4 columns for assignment statement.
 - Devoteam, 02/06/2015, user story 26 : adding value_hour_sheet class css in the Effort control column to adjust value input.
 
--%>

<%@page import="es.sm2.openppm.utils.SettingUtil"%>
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>
<%@page import="es.sm2.openppm.model.Timesheet"%>
<%@page import="es.sm2.openppm.servlets.TimeSheetServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--
var timeSheetTable;

function calcHours() {
	
	var total = 0;
	var totalDays = [0,0,0,0,0,0,0];
	
	$(timeSheetTable.fnGetNodes()).each(function() {

		var hours = 0;
		$(this).find('input.total_hours').each(function(i) { // cnw us26 changing 'input.campo' to 'input.total_hours'
			hours += Number($(this).val());
			totalDays[i] += Number($(this).val());
		});
		$(this).find('.total').text(hours.toFixed(1));
		total += hours;
	});
	
	$(totalDays).each(function(i) { $('#total_'+(i+1)).text(this.toFixed(1)+""); });
	$('#total_week').text(total.toFixed(1));
	
}

function sumColumn(column) {
	
	var hours = 0;
	$(column).each(function() { hours += Number($(this).val());	});
	 return hours;
}

function changeWeek(accion) {
	
	var f = document.frm_timesheet;
	f.accion.value = accion;
	loadingPopup();
	f.submit();
}

readyMethods.add(function() {
	
	timeSheetTable = $('#tb_timesheet').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"sPaginationType": "full_numbers",
		"iDisplayLength": 50,
		"aoColumns": [
              { "bVisible": false },
              { "bVisible": false },
              { "sClass": "left", "sWidth": "27%" },
              { "sClass": "center", "sWidth": "5%", "bSortable": false},
              { "sClass": "center", "sWidth": "5%", "bSortable": false},
              { "sClass": "center", "sWidth": "5%", "bSortable": false},
              { "sClass": "center", "sWidth": "5%", "bSortable": false},
              { "sClass": "center", "sWidth": "5%", "bSortable": false},
              { "sClass": "center", "sWidth": "5%", "bSortable": false}, 
              { "sClass": "center", "sWidth": "5%", "bSortable": false},
              { "sClass": "center", "sWidth": "5%"},
              { "sClass": "center", "sWidth": "5%"},      
              { "sClass": "center", "sWidth": "5%"},						// adding activity state column cnw us26     
              { "sClass": "center", "sWidth": "5%"},						// adding estimated gap  column cnw us26      
              { "sClass": "center", "sWidth": "10%", "bSortable": false },	// adding time state column     cnw us26
              //{ "sClass": "center", "sWidth": "5%"},	   					another column for the editing of the assignment statement cnw
              { "sClass": "center", "sWidth": "8%"},
              { "bVisible": false }
     	],
     	"fnDrawCallback": function ( oSettings ) {
            if ( oSettings.aiDisplay.length == 0 ) { return; }
             
            var nTrs = $('#tb_timesheet tbody tr');
            var iColspan = nTrs[0].getElementsByTagName('td').length;
            var sLastGroup = "";
            for ( var i=0 ; i<nTrs.length ; i++ ) {
                var iDisplayIndex = oSettings._iDisplayStart + i;
                var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[0];
                if ( sGroup != sLastGroup ) {
                    var nGroup = document.createElement( 'tr' );
                    var nCell = document.createElement( 'td' );
                    nCell.colSpan = iColspan;
                    nCell.className = "groupRow";
                    nCell.innerHTML = sGroup;
                    nGroup.appendChild( nCell );
                    nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
                    sLastGroup = sGroup;
                }
            }
        },
        "aoColumnDefs": [
			{ "bVisible": false, "aTargets": [ 0 ] }
		],
		"aaSortingFixed": [[ 0, 'asc' ]],
		"aaSorting": [[ 2, 'asc' ]],
        "sDom": 'lfr<"giveHeight"t>ip'
	});
	
	$('#tb_timesheet tbody tr').live('click', function (event) {
		timeSheetTable.fnSetSelectable(this,'selected_internal');
	});
	
	$("#filter").change( function() {
		timeSheetTable.fnFilter($("#filter").val(),11);
	});
	
	timeSheetTable.fnResetAllFilters();
	
	calcHours();
});

//-->
</script>

<table id="tb_timesheet" class="tabledata" cellspacing="1" width="100%">
	<thead>
		<tr>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th>&nbsp;</th>
			<th><fmt:message key="week.monday_short"/></th>
			<th><fmt:message key="week.tuesday_short"/></th>
			<th><fmt:message key="week.wednesday_short"/></th>
			<th><fmt:message key="week.thursday_short"/></th>
			<th><fmt:message key="week.friday_short"/></th>
			<th><fmt:message key="week.saturday_short"/></th>
			<th><fmt:message key="week.sunday_short"/></th>
			<th><fmt:message key="total"/></th>
			<th><fmt:message key="status"/></th>
			<th><fmt:message key="timesheet.state"/></th>  <!-- adding activity state column cnw us26 -->
			<th><fmt:message key="timesheet.gap"/></th>    <!-- adding estimated gap column cnw us26 -->
			<th><fmt:message key="timesheet.time"/></th>   <!-- adding time state column cnw us26 -->
			<!-- <th></th> -->							   <!-- another column for the assignment statement cnw -->
			<th>&nbsp;</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_RESOURCE) %>">
				<c:set var="userTime" value="${user }"/>
			</c:when>
			<c:otherwise>
				<c:set var="userTime" value="${employee }"/>
			</c:otherwise>
		</c:choose>
		<c:set var="approvalRol" value="<%=SettingUtil.getApprovalRol(request)%>"/>
		<c:set var="userRol" value="<%=SecurityUtil.consUserRole(request)%>"/>
		<c:forEach var="timeSheet" items="${timeSheets}">
			<tr>
				<td>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null }"><b><fmt:message key="timesheet.activity"/></b></c:when>
						<c:otherwise><b><fmt:message key="timesheet.operation"/></b></c:otherwise>
					</c:choose>
				</td>
				<td>${timeSheet.idTimeSheet}</td>
				<td>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null }">
							<c:if test="<%=!SecurityUtil.isUserInRole(request, Constants.ROLE_PM) %>">
								${tl:escape(timeSheet.projectactivity.project.projectName) }&nbsp;-&nbsp;
							</c:if>
							${tl:escape(timeSheet.projectactivity.activityName) }
						</c:when>
						<c:otherwise>${tl:escape(timeSheet.operation.operationName) }</c:otherwise>
					</c:choose>
				</td>
				<td>
					<input type="hidden" name="idTimeSheet" value="${timeSheet.idTimeSheet}"/>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null and tl:isExceptionDay(timeSheet.initDate, 0, timeSheet.projectactivity.idActivity, user.idEmployee) }">
							<c:set var="classException">exceptionDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:when test="${timeSheet.projectactivity ne null and !tl:isWorkDay(timeSheet.initDate, 0, timeSheet.projectactivity.idActivity, userTime) }">
							<c:set var="classException">notWorkDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="classException"></c:set>
							<c:set var="readonly"></c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" maxlength="4" name="day1_${timeSheet.idTimeSheet}" id="day1_${timeSheet.idTimeSheet}" class="ui-corner-all hour_sheet day1 campo ${classException } total_hours" value='${classException eq "notWorkDay"?"":timeSheet.hoursDay1}' ${timeSheet.status eq app0?readonly:"readonly"}/>
				</td>
				<td>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null and tl:isExceptionDay(timeSheet.initDate, 1, timeSheet.projectactivity.idActivity, user.idEmployee) }">
							<c:set var="classException">exceptionDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:when test="${timeSheet.projectactivity ne null and !tl:isWorkDay(timeSheet.initDate, 1, timeSheet.projectactivity.idActivity, userTime) }">
							<c:set var="classException">notWorkDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:otherwise>	
							<c:set var="classException"></c:set>
							<c:set var="readonly"></c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" maxlength="4" name="day2_${timeSheet.idTimeSheet}" id="day2_${timeSheet.idTimeSheet}" class="ui-corner-all hour_sheet day2 campo ${classException } total_hours" value='${classException eq "notWorkDay"?"":timeSheet.hoursDay2}' ${timeSheet.status eq app0?readonly:"readonly"}/>
				</td>
				<td>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null and tl:isExceptionDay(timeSheet.initDate, 2, timeSheet.projectactivity.idActivity, user.idEmployee) }">
							<c:set var="classException">exceptionDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:when test="${timeSheet.projectactivity ne null and !tl:isWorkDay(timeSheet.initDate, 2, timeSheet.projectactivity.idActivity, userTime) }">
							<c:set var="classException">notWorkDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="classException"></c:set>
							<c:set var="readonly"></c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" maxlength="4" name="day3_${timeSheet.idTimeSheet}" id="day3_${timeSheet.idTimeSheet}" class="ui-corner-all hour_sheet day3 campo ${classException } total_hours" value='${classException eq "notWorkDay"?"":timeSheet.hoursDay3}' ${timeSheet.status eq app0?readonly:"readonly"}/>
				</td>
				<td>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null and tl:isExceptionDay(timeSheet.initDate, 3, timeSheet.projectactivity.idActivity, user.idEmployee) }">
							<c:set var="classException">exceptionDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:when test="${timeSheet.projectactivity ne null and !tl:isWorkDay(timeSheet.initDate, 3, timeSheet.projectactivity.idActivity, userTime) }">
							<c:set var="classException">notWorkDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="classException"></c:set>
							<c:set var="readonly"></c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" maxlength="4" name="day4_${timeSheet.idTimeSheet}" id="day4_${timeSheet.idTimeSheet}" class="ui-corner-all hour_sheet day4 campo ${classException } total_hours" value='${classException eq "notWorkDay"?"":timeSheet.hoursDay4}' ${timeSheet.status eq app0?readonly:"readonly"}/>
				</td>
				<td>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null and tl:isExceptionDay(timeSheet.initDate, 4, timeSheet.projectactivity.idActivity, user.idEmployee) }">
							<c:set var="classException">exceptionDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:when test="${timeSheet.projectactivity ne null and !tl:isWorkDay(timeSheet.initDate, 4, timeSheet.projectactivity.idActivity, userTime) }">
							<c:set var="classException">notWorkDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="classException"></c:set>
							<c:set var="readonly"></c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" maxlength="4" name="day5_${timeSheet.idTimeSheet}" id="day5_${timeSheet.idTimeSheet}" class="ui-corner-all hour_sheet day5 campo ${classException } total_hours" value='${classException eq "notWorkDay"?"":timeSheet.hoursDay5}' ${timeSheet.status eq app0?readonly:"readonly"}/>
				</td>
				<td>
					<c:set var="readonly">readonly</c:set>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null and tl:isExceptionDay(timeSheet.initDate, 5, timeSheet.projectactivity.idActivity, user.idEmployee) }">
							<c:set var="classException">exceptionDay</c:set>
						</c:when>
						<c:when test="${timeSheet.projectactivity ne null and !tl:isWorkDay(timeSheet.initDate, 5, timeSheet.projectactivity.idActivity, userTime) }">
							<c:set var="classException">notWorkDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="classException">nonWorkingDay</c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" maxlength="4" name="day6_${timeSheet.idTimeSheet}" id="day6_${timeSheet.idTimeSheet}" class="ui-corner-all hour_sheet day6 campo ${classException } total_hours" value='${classException eq "notWorkDay"?"":timeSheet.hoursDay6}' ${timeSheet.status eq app0?readonly:"readonly"}/>
				</td>
				<td>
					<c:set var="readonly">readonly</c:set>
					<c:choose>
						<c:when test="${timeSheet.projectactivity ne null and tl:isExceptionDay(timeSheet.initDate, 6, timeSheet.projectactivity.idActivity, user.idEmployee) }">
							<c:set var="classException">exceptionDay</c:set>
						</c:when>
						<c:when test="${timeSheet.projectactivity ne null and !tl:isWorkDay(timeSheet.initDate, 6, timeSheet.projectactivity.idActivity, userTime) }">
							<c:set var="classException">notWorkDay</c:set>
							<c:set var="readonly">readonly</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="classException">nonWorkingDay</c:set>
						</c:otherwise>
					</c:choose>
					<input type="text" maxlength="4" name="day7_${timeSheet.idTimeSheet}" id="day7_${timeSheet.idTimeSheet}" class="ui-corner-all hour_sheet day7 campo ${classException } total_hours" value='${classException eq "notWorkDay"?"":timeSheet.hoursDay7}' ${timeSheet.status eq app0?readonly:"readonly"}/>
				</td>
				<td class="total">0</td>
				<td id="changeStatus_${timeSheet.idTimeSheet}">
					<fmt:message key="applevel.${timeSheet.status }"/>
				</td>
				<c:if test="${timeSheet.status eq app0}"><!-- if time sheet is not yet approved by the team member, shows the select list for editing of the assignment statement cnw us26  -->
					<td id="activity_state_${timeSheet.idTimeSheet}">
						<select name="timesheet_activity_state_${timeSheet.idTimeSheet}" id="timesheet_activity_state_${timeSheet.idTimeSheet}" class="campo">
							<option value="<%=Constants.ACTIVITYSTATUT_FINISHED%>"><fmt:message key="timesheet.finished"/></option>
							<option value="<%=Constants.ACTIVITYSTATUT_INPROGRESS%>" selected="selected"><fmt:message key="timesheet.in_progress"/></option>
							<option value="<%=Constants.ACTIVITYSTATUT_NOTSTARTED%>"><fmt:message key="timesheet.not_started"/></option>
						</select>
					</td>
					<td id="estimated_gap_${timeSheet.idTimeSheet}" class="value_hour_sheet"> <!-- cnw us26 Adding of value_hour_sheet class css -->
						<%-- <select name="timesheet_estimated_gap_${timeSheet.idTimeSheet}" id="timesheet_estimated_gap_${timeSheet.idTimeSheet}" class="campo">
							<option value="<%=Constants.ESTIMATEDGAPSTATUT_RIGHT%>" selected="selected"><fmt:message key="timesheet.right"/></option>
							<option value="<%=Constants.ESTIMATEDGAPSTATUT_EXCEEDED%>"><fmt:message key="timesheet.exceeded"/></option>
							<option value="<%=Constants.ESTIMATEDGAPSTATUT_OVERFLOW%>"><fmt:message key="timesheet.overflow"/></option>
						</select> --%>
						<input type="text" maxlength="4" name="timesheet_estimated_gap_value_${timeSheet.idTimeSheet}" id="timesheet_estimated_gap_value_${timeSheet.idTimeSheet}" class="campo" placeholder="<fmt:message key="timesheet.gap_value"/>"
						       value="${timeSheet.estimatedGapValue}">
					</td>
					<td id="time_${timeSheet.idTimeSheet}">
						<select name="timesheet_time_${timeSheet.idTimeSheet}" id="timesheet_time_${timeSheet.idTimeSheet}" class="campo">
							<option value="<%=Constants.TIMESTATE_ONTIME%>" selected="selected"><fmt:message key="timesheet.on_time"/></option>
							<option value="<%=Constants.TIMESTATE_INADVANCE%>"><fmt:message key="timesheet.in_advance"/></option>
							<option value="<%=Constants.TIMESTATE_LATE%>"><fmt:message key="timesheet.late"/></option>
						</select>
					</td>
				</c:if>
				<c:if test="${timeSheet.status ne app0}"><!-- else shows the assignment statement cnw us26 -->
					<td>
						<c:if test="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_PM) %>">
							
						</c:if>
						<c:if test="${timeSheet.activityState eq finished}"><fmt:message key="timesheet.finished"/></c:if>
						<c:if test="${timeSheet.activityState eq in_progress}"><fmt:message key="timesheet.in_progress"/></c:if>
						<c:if test="${timeSheet.activityState eq not_started}"><fmt:message key="timesheet.not_started"/></c:if>
						<c:if test="${timeSheet.activityState eq null}"><fmt:message key="timesheet.statement_not_defined"/></c:if>
					</td>
					<td>
						<%-- <c:if test="${timeSheet.estimatedGap eq right}"><fmt:message key="timesheet.right"/></c:if>
						<c:if test="${timeSheet.estimatedGap eq exceeded}"><fmt:message key="timesheet.exceeded"/></c:if>
						<c:if test="${timeSheet.estimatedGap eq overflow}"><fmt:message key="timesheet.overflow"/></c:if> --%>
						<c:if test="${timeSheet.estimatedGapValue ne null}">${timeSheet.estimatedGapValue}</c:if>
						<c:if test="${timeSheet.estimatedGapValue eq null}"><fmt:message key="timesheet.statement_not_defined"/></c:if>
					</td>
					<td>
						<c:if test="${timeSheet.time eq on_time}"><fmt:message key="timesheet.on_time"/></c:if>
						<c:if test="${timeSheet.time eq in_advance}"><fmt:message key="timesheet.in_advance"/></c:if>
						<c:if test="${timeSheet.time eq late}"><fmt:message key="timesheet.late"/></c:if>
						<c:if test="${timeSheet.time eq null}"><fmt:message key="timesheet.statement_not_defined"/></c:if>
					</td>
				</c:if>
				<!--  
				<td id="statementButtons_${timeSheet.idTimeSheet}"><!-- Another column for the editing of the assignment statement cnw 
					<c:if test="${timeSheet.status eq app0}"><!-- cnw  
						${btn_editStatement}
					</c:if>
					<c:if test="${timeSheet.status ne app0}"><!-- cnw 
						${btn_viewStatement}
					</c:if>
				</td>
				-->
				<!-- Approving, saving, and comments buttons for the time sheet -->
				<td id="changeButtons_${timeSheet.idTimeSheet}">
					<nobr>
						<c:if test="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_RESOURCE) %>">
							<c:if test="${timeSheet.status eq app0 }">
								${btn_app0 }
								<c:if test="${timeSheet.projectactivity eq null }">
									<img onclick="javascript:deleteOperation(this);" title="<fmt:message key="delete"/>" class="ico link" src="images/delete.jpg"/>
								</c:if>
							</c:if>
						</c:if>
						<c:if test="<%=SecurityUtil.isUserInRole(request, Constants.ROLE_PM) %>">
							<c:choose>
								<c:when test="${timeSheet.status eq app1 }">${btn_reject }${btn_app1 }</c:when>
								<c:when test="<%=SettingUtil.getApprovalRol(request) == 0 %>">${btn_reject }</c:when>
							</c:choose>
						</c:if>
						<c:if test="${approvalRol eq userRol}">
							<c:if test="${timeSheet.status eq app2 }">${btn_app2 }</c:if>
							${btn_reject }
						</c:if>
						${btn_comments }
					</nobr>
				</td>
				<td><fmt:message key="applevel.${timeSheet.status }"/></td>
			</tr>
		</c:forEach>
	</tbody>
	<tfoot>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td id="total_1" class="day_total">0</td>
			<td id="total_2" class="day_total">0</td>
			<td id="total_3" class="day_total">0</td>
			<td id="total_4" class="day_total">0</td>
			<td id="total_5" class="day_total">0</td>
			<td id="total_6" class="day_total">0</td>
			<td id="total_7" class="day_total">0</td>
			<td id="total_week" class="total_week">0</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</tfoot>
</table>
