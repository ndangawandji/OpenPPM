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
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.model.Documentproject"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="tab" scope="request"><%=Constants.TAB_INVESTMENT%></c:set>
<c:set var="documentStorage"><%=es.sm2.openppm.common.Constants.DOCUMENT_STORAGE%></c:set>

<script type="text/javascript">
<!--
var investmentValidator;

function openApproveInvestment(idProject) {
	var oTT = TableTools.fnGetInstance( 'tb_investments' );
	oTT.fnSelectNone();
	
	projectAjax.call({
			accion: "<%=ProjectServlet.JX_CONS_PROJECT %>",
			<%=Project.IDPROJECT%>: idProject
		}, function (data) {
									
			document.forms["frm_investment"].reset();
			$('#res_info').text('');
			
			$('#<%=Project.IDPROJECT%>').val(idProject);
			$('#<%=Documentproject.PROJECT%>_<%=Constants.DOCUMENT_INVESTMENT %>').val(idProject);
			
			if('${documentStorage}' == '<%=Constants.LINK%>'){
				
				$('#a_link<%=Constants.DOCUMENT_INVESTMENT %>').text("");								
				$('#res_document_link<%=Constants.DOCUMENT_INVESTMENT %>').val("");
				
				if (data.docs != null && data.docs.link != '' && 
						data.docs.link != null) {
					confirmLink(data.docs.idDocumentProject, data.docs.link);
				}
				else {
					modifyLink();
				}
			}
			else if('${documentStorage}' == '<%=Constants.FILE_SYSTEM%>'){
				fileSystemTable.fnClearTable();
				if (data.docs.length > 0) {					
					for (var i = 0; i < data.docs.length; i++) {					
						fileSystemTable.fnAddData([
							data.docs[i].<%=Documentproject.IDDOCUMENTPROJECT%>,
							escape(data.docs[i].<%=Documentproject.NAME%>),
							'<nobr><img class="link" onclick="downloadDoc(' + data.docs[i].<%=Documentproject.IDDOCUMENTPROJECT%> + ')" src="images/download.png" title="<fmt:message key="download"/>"/>&nbsp;&nbsp;' +
				   			'<img class="link" onclick="editDoc(this)" src="images/modify.png" title="<fmt:message key="edit"/>"/>&nbsp;&nbsp;' +
				   			'<img class="link" onclick="deleteDoc(this)" src="images/delete.jpg" title="<fmt:message key="delete"/>"/></nobr>'
	      				]);
					}
				}
			}
			
			
			$('#buttonCloseCancel').hide();
			$('#resultN, #resultS, #resultX').attr("disabled", "disabled");
			
			if (data.<%=Project.INVESTMENTSTATUS%> == '<%=Constants.INVESTMENT_APPROVED%>') {
				winProposal();
				$('#res_num_competitors').val(data.<%=Project.NUMCOMPETITORS%>);
				$('#res_final_position').val(data.<%=Project.FINALPOSITION%>);
				$('#res_info').text(data.<%=Project.CLIENTCOMMENTS%>);
			}
			else if (data.<%=Project.INVESTMENTSTATUS%> == '<%=Constants.INVESTMENT_REJECTED%>') {
				loseProposal();
				$('#res_final_position').val(data.<%=Project.FINALPOSITION%>);
				$('#res_num_competitors').val(data.<%=Project.NUMCOMPETITORS%>);
				$('#res_info').text(data.<%=Project.CLIENTCOMMENTS%>);
				$('#buttonCloseCancel').show();
			}
			else if (data.<%=Project.INVESTMENTSTATUS%> == '<%=Constants.INVESTMENT_INACTIVATED%>') {
				cancelProposal();
				$('#res_info').text(data.<%=Project.CLIENTCOMMENTS%>);
				$('#buttonCloseCancel').show();
			}
			else {
				$('#resultN, #resultS, #resultX').attr("disabled", "");
				$('#resultN, #resultS, #resultX').attr("checked", "");
				
				$('#tb_result_info, #tb_result_common').hide();
				$('#buttonInv').show();
			}
			$('#buttonApprove, #buttonReject, #buttonCancel').hide();
			
			$('#investment-popup').dialog('open');
	});
}

function winProposal() {
	// Proposal win, hide lose and cancel table

	$('#resultN, #resultX').attr("checked", "");
	$('#resultS').attr("checked", "checked");

	$('#tb_result_common, #buttonApprove, #tb_result_info').show();
	$('#buttonReject, #buttonCancel').hide();
	
	$('#res_num_competitors').val('');
	$('#res_final_position').val('1');
	$('#res_final_position').attr('readonly', 'readonly');
}

function loseProposal() {
	// Proposal losed, hide win and cancel table

	$('#resultN').attr("checked", "checked");
	$('#resultS').attr("checked", "");
	$('#resultX').attr("checked", "");

	$('#buttonApprove, #buttonCancel').hide();
	$('#tb_result_common, #buttonReject, #tb_result_info').show();
	
	$('#res_final_position').val("1");
	$('#res_final_position').attr('readonly', '');
	$('#res_num_competitors').val('');
}

function cancelProposal() {
	$('#resultN, #resultS').attr("checked", "");
	$('#resultX').attr("checked", "checked");
	$('#buttonCancel, #tb_result_info').show();
	$('#tb_result_common, #buttonApprove, #buttonReject').hide();
}

function updateInvestment(accion) {	
	if (investmentValidator.form()) {		
		document.frm_investment.accion.value=accion;		
		projectAjax.call($('#frm_investment').serialize(), function (data) {
			investmentsTable.fnDraw();
			$('#investment-popup').dialog('close');
		});
	}
}
function approveInvestment() {	
	updateInvestment("<%=ProjectServlet.JX_APPROVE_INVESTMENT%>");
	$('#dialog-confirm').dialog("close");
}
function rejectInvestment() {
	updateInvestment("<%=ProjectServlet.JX_REJECT_INVESTMENT%>");
	$('#dialog-confirm').dialog("close");
}
function cancelInvestment() {
	updateInvestment("<%=ProjectServlet.JX_CANCEL_INVESTMENT%>");
}
function resetInvestment() {
	updateInvestment("<%=ProjectServlet.JX_RESET_INVESTMENT%>");
}

function confirmLink(idDoc, link) {
	$('#toggleEditLink<%=Constants.DOCUMENT_INVESTMENT %>').hide();
	$('#toggleALink<%=Constants.DOCUMENT_INVESTMENT %>').show();
	
	$("#<%=Documentproject.IDDOCUMENTPROJECT%>").val(idDoc);
	
	$('#a_link<%=Constants.DOCUMENT_INVESTMENT %>')
		.text(link)
		.attr('href',link);
	
	$('#res_document_link<%=Constants.DOCUMENT_INVESTMENT %>').val(link);	
}

function modifyLink() {
	$('#toggleEditLink<%=Constants.DOCUMENT_INVESTMENT %>').show();
	$('#toggleALink<%=Constants.DOCUMENT_INVESTMENT %>').hide();	
}

readyMethods.add(function() {
	$('div#investment-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 600, 
		resizable: false,
		open: function(event, ui) { investmentValidator.resetForm(); }
	});
	
	investmentValidator = $("#frm_investment").validate({
		errorContainer: 'div#investment-errors',
		errorLabelContainer: 'div#investment-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#investment-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Project.CLIENTCOMMENTS %>: { maxlength: 1000 }
		}
	});
});
//-->
</script>

<div id="investment-popup" class="popup">
	<div id="investment-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="investment-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	
	<fieldset>
		<legend><fmt:message key="result_proposal" /></legend>
		<form id="frm_investment" name="frm_investment" method="post">
			<input type="hidden" name="<%=Project.IDPROJECT%>" id="<%=Project.IDPROJECT%>"/>
			<input type="hidden" name="accion"/>		
			<table width="100%">
				<tr>
					<td style="width:25%">
							<input type="radio" name="result" id="resultS" value="S" style="width:14px;" onclick="winProposal();" />
						<label for="resultS">
							<img src="images/approve.png" width="16px" height="16px" style="vertical-align:bottom" />
							<fmt:message key="investments.approve"/>
						</label>
					</td>
					<td style="width:25%">
						<input type="radio" name="result" id="resultN" value="N" style="width:14px;" onclick="loseProposal();" />
						<label for="resultN">
							<img src="images/ico_down.jpg" width="16px" height="16px" style="vertical-align:bottom" />
							<fmt:message key="investments.reject"/>
						</label>
					</td>
					<td style="width:50%">
						<input type="radio" name="result" id="resultX" value="X" style="width:14px;" onClick="cancelProposal();" />
						<label for="resultX">
							<img src="images/reject.png" width="16px" height="16px" style="vertical-align:bottom" />
							<fmt:message key="investments.inactive"/>
						</label>
					</td>
				</tr>				
				<tr>
					<td colspan="3">
						<table width="100%" id="tb_result_common" style="display:none;">
							<tr>
								<th class="left" width="50%"><fmt:message key="proposal.final_position"/></th>
								<th class="left" width="50%"><fmt:message key="proposal.num_competitors"/></th>
							</tr>
							<tr>
								<td class="center">
									<input type="text" name="<%=Project.FINALPOSITION %>" id="res_final_position" class="campo integer" />
								</td>
								<td class="center">
									<input type="text" name="<%=Project.NUMCOMPETITORS %>" id="res_num_competitors" class="campo integer"/>
								</td>
							</tr>
						</table>
						<table width="100%" id="tb_result_info" style="display:none;">
							<tr>
								<th class="left" style="width:25%"><fmt:message key="investment.relevant_information"/></th>								
							</tr>
							<tr>
								<td style="width:75%">
									<textarea name="<%=Project.CLIENTCOMMENTS %>" id="res_info" class="campo"style="width:100%;" cols="90" rows="6"></textarea>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>		
	</fieldset>
	<fmt:message var="documentationTitle" key="documentation.investment"/>
	<jsp:include page="project_documentation_${documentStorage}.jsp">
		<jsp:param name="documentationType" value="<%=Constants.DOCUMENT_INVESTMENT %>"/>
		<jsp:param name="documentationTitle" value="${documentationTitle }"/>
	</jsp:include>
	<div class="popButtons">
		<a href="#" id="buttonApprove" class="boton" onclick="approveInvestment();"><fmt:message key="investment.approve"/></a>
		<a href="#" id="buttonReject" class="boton" onclick="rejectInvestment();"><fmt:message key="investment.reject" /></a>
		<a href="#" id="buttonCancel" class="boton" onclick="cancelInvestment();"><fmt:message key="investment.cancel" /></a>
		<a href="#" id="buttonCloseCancel" class="boton" onclick="return resetInvestment();"><fmt:message key="investment.reset" /></a>
	</div>
</div>
