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
<%@page import="es.sm2.openppm.utils.SecurityUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<%-- Message for confirmations --%>
<fmt:message key="msg.confirm_delete" var="msg_confirm_delete_program">
	<fmt:param><fmt:message key="maintenance.program"/></fmt:param>
</fmt:message>

<fmt:message key="msg.title_confirm_delete" var="msg_title_confirm_delete_program">
	<fmt:param><fmt:message key="maintenance.program"/></fmt:param>
</fmt:message>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtManagerRequired">
	<fmt:param><b><fmt:message key="maintenance.program.manager"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtCodeRequired">
	<fmt:param><b><fmt:message key="maintenance.program.code"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtNameRequired">
	<fmt:param><b><fmt:message key="maintenance.program.name"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtTitleRequired">
	<fmt:param><b><fmt:message key="maintenance.program.title"/></b></fmt:param>
</fmt:message>

<%-- Message for popup --%>
<fmt:message key="maintenance.program.new" var="new_program_title" />
<fmt:message key="maintenance.program.edit" var="edit_program_title" />

<script language="javascript" type="text/javascript" >
var programsTable;
var programValidator;

function addProgram() {
	var f = document.frm_program_pop;
	f.reset();
	f.id.value = "";
	confirmLink();
	$('#programs-popup legend').html('${new_program_title}');
	$('#programs-popup').dialog('open');
}

function saveProgram() {

	if (programValidator.form()) {
		
		loadingPopup();
		document.frm_program_pop.submit();
	}
}

function editProgram(element) {	
	
	var program = programsTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.frm_program_pop;
	
	f.program_id.value 			= program[0];	
	f.program_manager.value 	= program[12];
	f.program_code.value 		= unEscape(program[2]);
	f.program_name.value 		= unEscape(program[3]);
	f.program_title.value 		= unEscape(program[9]);

	$("#program_description").text(unEscape(program[4]));
	f.program_doc.value 		= program[10];
	f.budget.value 				= program[6];
	f.budgetYear.value	 		= unEscape(program[5]);
	f.actualCost.value	 		= program[7];
	f.budgetBottom.value 		= program[8];
	
	// Display followup info
	$('#programs-popup legend').html('${edit_program_title}');
	confirmLink();
	$('#programs-popup').dialog('open');
}

function deleteProgram(element) {
	
	confirmUI(
		'${msg_title_confirm_delete_program}','${msg_confirm_delete_program}',
		'<fmt:message key="yes"/>', '<fmt:message key="no"/>',
		function() {
			
			var program = programsTable.fnGetData( element.parentNode.parentNode );
			
			var f = document.frm_programs;
			f.accion.value	= "<%=ProgramServlet.DEL_PROGRAM %>";
			f.id.value		= program[0];
			
			loadingPopup();
			f.submit();
	});
}

function confirmLink() {
	$('#toggleEditLink').hide();
	$('#toggleALink').show();
	
	$('#program_doc_link')
		.text($('#program_doc').val())
		.attr('href',$('#program_doc').val());
}
function modifyLink() {

	$('#toggleALink').hide();
	$('#toggleEditLink').show();
}

function closeProgram() {
	$('div#programs-popup').dialog('close');
}
readyMethods.add(function () {

	programsTable = $('#tb_programs').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"iDisplayLength": 50,
		"aaSorting": [[ 0, "asc" ]],
		"bAutoWidth": false,
		"oTableTools": {
			"sRowSelect": "multi",
			"aButtons": [ "select_none" ]
		},
		"aoColumns": [ 
				{ "bVisible": false },
				{ "sClass": "left"},
	            { "sClass": "left"},
	            { "sClass": "left"},
	            { "sClass": "left"},
	            { "sClass": "center"},
	            { "sClass": "right"},
	            { "sClass": "right"},
	            { "sClass": "right"},
	            { "bVisible": false },						
				{ "bVisible": false  },			            
	            { "sClass": "center", "bSortable" : false },
	            { "bVisible": false}
      		]
	});

	$('div#programs-popup').dialog({ autoOpen: false, modal: true, width: 550, minWidth: 300, resizable: false });

	programValidator = $("#frm_program_pop").validate({
		errorContainer: $('div#program-errors'),
		errorLabelContainer: $("ol", $('div#program-errors')),
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#program-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			program_manager: { required: true },
			program_code: { required: true },
			program_name: { required: true },
			program_title: { required: true },
			program_description: { maxlength : 200 }
		},
		messages: {
			program_manager: { required: '${fmtManagerRequired}' },
			program_code: { required: '${fmtCodeRequired}' },
			program_name: { required: '${fmtNameRequired}' },
			program_title: { required: '${fmtTitleRequired}' }
		}
	});
});

</script>

<form id="frm_programs" name="frm_programs" method="post">
	<input type="hidden" name="accion" value="" />
	<input type="hidden" id="id" name="id" />
	
	<table width="100%">
		<tr>
			<td>
				<table id="tb_programs" class="tabledata" cellspacing="1" width="100%">
					<thead>
						<tr>
							 <th width="0%">&nbsp;</th>
							 <th width="15%"><fmt:message key="program.manager" /></th>
							 <th width="7%"><fmt:message key="program.code" /></th>
							 <th width="15%"><fmt:message key="program.name" /></th>
							 <th width="20%"><fmt:message key="program.description" /></th>
							 <th width="5%"><fmt:message key="program.budget_year" /></th>
							 <th width="10%"><fmt:message key="program.budget" /></th>
							 <th width="10%"><fmt:message key="program.actual_cost" /></th>
							 <th width="10%"><fmt:message key="program.budget_bottom_up" /></th>
							 <th width="0%"><fmt:message key="program.title" /></th>							 
							 <th width="0%"><fmt:message key="program.doc" /></th>							 
							 <th width="8%">
							 	<c:if test="<%=SecurityUtil.hasPermission(request, ProgramServlet.SAVE_PROGRAM) %>">
								 	<c:if test="${profile != role_pgm_manager}">
										<img onclick="addProgram()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
									</c:if>
								</c:if>
							 </th>
							 <th width="0%">&nbsp;</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="program" items="${list_programs}">
							<tr>
								<td>${program.idProgram}</td>
								<td>${tl:escape(program.employee.contact.fullName)}</td>
								<td>${tl:escape(program.programCode)}</td>
								<td>${tl:escape(program.programName)}</td>
								<td>${tl:escape(program.description)}</td>
								<td>${tl:escape(program.budgetYear)}</td>
								<td>${tl:toCurrency(program.budget)}</td>
								<td>${tl:toCurrency(program.sumActualCost)}</td>
								<td>${tl:toCurrency(program.budgetBottomUp)}</td>
								<td>${tl:escape(program.programTitle)}</td>								
								<td>${program.programDoc}</td>								
								<td>
									<c:if test="<%=SecurityUtil.hasPermission(request, ProgramServlet.SAVE_PROGRAM) %>">
										<img onclick="editProgram(this)" title="<fmt:message key="edit"/>" class="link" src="images/view.png">
										&nbsp;&nbsp;&nbsp;
									</c:if>
									<c:if test="<%=SecurityUtil.hasPermission(request, ProgramServlet.DEL_PROGRAM) %>">
										<img onclick="deleteProgram(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg">
									</c:if>
								</td>
								<td>${program.employee.idEmployee}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</td>
		</tr>
	</table>	
</form>

<%-- PROJECTS --%>
<jsp:include page="list/list_projects.inc.jsp" flush="true"/>

<div id="programs-popup">
	<div id="program-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="program-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_program_pop" id="frm_program_pop" method="post">
		<input type="hidden" name="program_id"/>
		<input type="hidden" name="accion" value="<%=ProgramServlet.SAVE_PROGRAM %>"/>
		
		<fieldset>
			<legend><fmt:message key="maintenance.program.new"/></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th width="50%"><fmt:message key="program.code" />&nbsp;*</th>
					<th width="50%"><fmt:message key="program.name" />&nbsp;*</th>					
				</tr>
				<tr>
					<td>
						<input type="text" name="program_code" class="campo" maxlength="20"
							<c:if test="${profile == role_pgm_manager}">
								disabled
							</c:if>
						/>
					</td>
					<td>
						<input type="text" name="program_name" class="campo" maxlength="50"
							<c:if test="${profile == role_pgm_manager}">
								disabled
							</c:if>
						/>
					</td>
				</tr>
				<tr>
					<th><fmt:message key="program.manager" />&nbsp;*</th>
					<th><fmt:message key="program.title" />&nbsp;*</th>					
				</tr>
				<tr>
					<td>
						<select class="campo" name="program_manager"
							<c:if test="${profile == role_pgm_manager}">
								disabled
							</c:if>
						>
							<option value=""><fmt:message key="select_opt" /></option>
							<c:forEach var="programManager" items="${list_employees}">
								<option value="${programManager.idEmployee}">${programManager.contact.fullName}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<input type="text" name="program_title" class="campo" maxlength="50"
							<c:if test="${profile == role_pgm_manager}">
								disabled
							</c:if>
						/>
					</td>				
				</tr>
				<tr>
					<th colspan = 2><fmt:message key="program.doc" /></th>					
				</tr>
				<tr>
					<td colspan = 2>
						<div id="toggleEditLink">
							<c:if test="<%=SecurityUtil.hasPermission(request, ProgramServlet.SAVE_PROGRAM) %>">
								<c:if test="${profile != role_pgm_manager}">
									<img style="width:16px;" src="images/approve.png" onclick="confirmLink()"/>
								</c:if>
							</c:if>
							<input type="text" name="program_doc" id="program_doc" style="width: 452px;" maxlength="200" class="campo"/>
						</div>
						<div id="toggleALink">
							<c:if test="<%=SecurityUtil.hasPermission(request, ProgramServlet.SAVE_PROGRAM) %>">
								<c:if test="${profile != role_pgm_manager}">
									<img style="width:16px;" src="images/modify.png" onclick="modifyLink()"/>
								</c:if>
							</c:if>
							<a href="" id="program_doc_link"></a>
						</div>
					</td>					
				</tr>
				<tr>
					<td colspan = 2>
						<table border="0" cellpadding="2" cellspacing="1" width="100%">
							<tr>
								<th width="25%"><fmt:message key="program.budget_year" /></th>
								<th width="25%"><fmt:message key="program.budget" /></th>
								<th width="25%"><fmt:message key="program.actual_cost" /></th>
								<th width="25%"><fmt:message key="program.budget_bottom_up" /></th>
							</tr>
							<tr>
								<td class="center">
									<input type="text" name="budgetYear" id="budgetYear" class="campo" maxlength="4" style="width: 32px;"
										<c:if test="${profile == role_pgm_manager}">
											disabled
										</c:if>
									/>
								</td>
								<td class="center">
									<input type="text" name="budget" id="budget" class="campo importe" style="width: 120px;"
										<c:if test="${profile == role_pgm_manager}">
											disabled
										</c:if>
									/>
								</td>								
								<td><input type="text" name="actualCost" id="actualCost" style="text-align: center;" class="importe" readonly/></td>
								<td><input type="text" name="budgetBottom" id="budgetBottom" style="text-align: center;" class="importe" readonly/></td>								
							</tr>
						</table>						
					</td>	
				</tr>
				<tr>
					<th colspan="2"><fmt:message key="program.description" /></th>
				</tr>
				<tr>
					<td colspan="2">
						<textarea name="program_description" id="program_description" class="campo" style="width:98%;" ></textarea>
					</td>
				</tr>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<c:if test="<%=SecurityUtil.hasPermission(request, ProgramServlet.SAVE_PROGRAM) %>">
				<a href="javascript:saveProgram();" class="boton"><fmt:message key="save" /></a>
			</c:if>
			<a href="javascript:closeProgram();" class="boton"><fmt:message key="close" /></a>
    	</div>
    </form>
</div>
