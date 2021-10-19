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

<%@page import="es.sm2.openppm.servlets.ProjectRiskServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="probTrivial"><%=Constants.PROBABILITY_TRIVIAL%></c:set>
<c:set var="probMinor"><%=Constants.PROBABILITY_MINOR%></c:set>
<c:set var="probModerate"><%=Constants.PROBABILITY_MODERATE%></c:set>
<c:set var="probHigh"><%=Constants.PROBABILITY_HIGH%></c:set>
<c:set var="probSevere"><%=Constants.PROBABILITY_SEVERE%></c:set>

<c:set var="impTrivial"><%=Constants.IMPACT_TRIVIAL%></c:set>
<c:set var="impMinor"><%=Constants.IMPACT_MINOR%></c:set>
<c:set var="impModerate"><%=Constants.IMPACT_MODERATE%></c:set>
<c:set var="impHigh"><%=Constants.IMPACT_HIGH%></c:set>
<c:set var="impSevere"><%=Constants.IMPACT_SEVERE%></c:set>

<c:set var="riskOpportunity"><%=Constants.RISK_OPPORTUNITY%></c:set>
<c:set var="riskThreat"><%=Constants.RISK_THREAT%></c:set>

<c:set var="statusClose"><%=Constants.CHAR_CLOSED%></c:set>
<c:set var="statusOpen"><%=Constants.CHAR_OPEN%></c:set>

<div>&nbsp;</div>

<form name="frm_risk" id="frm_risk" method="post">
	<input type="hidden" name="id" value="${project.idProject}"/>
	<input type="hidden" name="risk_id" id="risk_id" value="${risk.idRisk}"/>
	<input type="hidden" name="accion" />
	
	<fieldset class="level_2">
		<legend><fmt:message key="risk"/></legend>
		
		<div id="risk-errors" class="ui-state-error ui-corner-all hide" style="margin-top: 15px;">		
			<p>
				<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
				<strong><fmt:message key="msg.error_title"/></strong>
				&nbsp;(<b><span id="risk-numerrors"></span></b>)
			</p>
			<ol></ol>
		</div>
		
		<div>&nbsp;</div>
		<%-- RISK DISCOVERY AND ASSESSMENT --%>
		<fieldset class="level_3">
			<legend class="link" onclick="changeCookie('field_risk_discovery')"><fmt:message key="risk.risk_discovery"/></legend>
			<div class="buttons">
				<img id="field_risk_discoveryBtn" onclick="changeCookie('field_risk_discovery', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="field_risk_discovery" class="hide" style="padding-top:10px;">
				<table id="tb_risk_discovery" border="0" cellpadding="2" cellspacing="1" width="100%">
					<tr>
						<th class="left" width="25%"><fmt:message key="risk.code"/>&nbsp;*</th>
						<td width="25%"><input type="text" name="risk_code" id="risk_code" class="campo" maxlength="5" value="${tl:escape(risk.riskCode)}"/></td>
						<th class="left" width="25%"><fmt:message key="risk.date_raised"/>&nbsp;*</th>						
						<td width="25%"><input type="text" name="date_raised" id="date_raised" class="campo fecha" value="<fmt:formatDate value="${risk.dateRaised }" pattern="${datePattern}"/>"/></td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.status"/>&nbsp;</th>
						<td>
							<select name="status" id="risk_status" class="campo">								
								<option value="<%=Constants.CHAR_OPEN%>"
									<c:if test="${risk.status eq statusOpen}">
										selected										
									</c:if>	
								><fmt:message key="risk.status.open" /></option>
								<option value="<%=Constants.CHAR_CLOSED %>"
									<c:if test="${risk.status eq statusClose}">
										selected										
									</c:if>	
								><fmt:message key="risk.status.closed" /></option>								
							</select>
						</td>
						<th class="left"><fmt:message key="risk.due_date"/>&nbsp;</th>
						<td><input type="text" name="due_date" id="due_date" class="campo fecha" value="<fmt:formatDate value="${risk.dueDate}" pattern="${datePattern}"/>" /></td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.name"/>&nbsp;*</th>
						<td colspan="3"><input type="text" name="risk_name" id="risk_name" class="campo" maxlength="50" value="${tl:escape(risk.riskName)}"/></td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.owner"/></th>
						<td colspan="3"><input type="text" name="owner" class="campo" maxlength="100" value="${tl:escape(risk.owner)}"/></td>
					</tr>
					<tr>
						<th colspan="4" class="left"><fmt:message key="risk.description"/></th>
					</tr>
					<tr>
						<td colspan="4"><textarea name="description" id="description" class="campo" style="width:98%;">${tl:escape(risk.description)}</textarea></td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.probability" /></th>
						<td>
							<select name="probability" id="risk_probability" class="campo">
								<option value=""><fmt:message key="select_opt" /></option>
								<option value="<%=Constants.PROBABILITY_TRIVIAL %>"
									<c:if test="${risk.probability eq probTrivial}">
										selected										
									</c:if>																		
								><fmt:message key="risk.probability.trivial" /></option>
								<option value="<%=Constants.PROBABILITY_MINOR %>"
									<c:if test="${risk.probability eq probMinor}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.minor" /></option>
								<option value="<%=Constants.PROBABILITY_MODERATE %>"
									<c:if test="${risk.probability eq probModerate}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.moderate" /></option>
								<option value="<%=Constants.PROBABILITY_HIGH %>"
									<c:if test="${risk.probability eq probHigh}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.high" /></option>
								<option value="<%=Constants.PROBABILITY_SEVERE %>"
									<c:if test="${risk.probability eq probSevere}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.severe" /></option>
							</select>
						</td>
						<th class="left"><fmt:message key="risk.impact" /></th>
						<td>
							<select name="impact" id="risk_impact" class="campo">
								<option value=""><fmt:message key="select_opt" /></option>
								<option value="<%=Constants.IMPACT_TRIVIAL %>"
									<c:if test="${risk.impact eq impTrivial}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.trivial" /></option>
								<option value="<%=Constants.IMPACT_MINOR %>"
									<c:if test="${risk.impact eq impMinor}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.minor" /></option>
								<option value="<%=Constants.IMPACT_MODERATE %>"
									<c:if test="${risk.impact eq impModerate}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.moderate" /></option>
								<option value="<%=Constants.IMPACT_HIGH %>"
									<c:if test="${risk.impact eq impHigh}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.high" /></option>
								<option value="<%=Constants.IMPACT_SEVERE %>"
									<c:if test="${risk.impact eq impSevere}">
										selected										
									</c:if>
								><fmt:message key="risk.probability.severe" /></option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.potential_cost" /></th>
						<td><input type="text" name="potential_cost" class="campo importe" style="width: 75%;" value="${risk.potentialCost}"/></td>
						<th class="left"><fmt:message key="risk.potential_delay" /></th>
						<td><input type="text" name="potential_delay" class="campo integerPositive" maxlength="5" style="width: 55%;" value="${tl:escape(risk.potentialDelay)}"/>&nbsp;<fmt:message key="days" /></td>
					</tr>
					<tr>
						<th class="left" colspan="4"><fmt:message key="risk.risk_trigger" /></th>
					</tr>
					<tr>
						<td colspan="4"><textarea name="risk_trigger" class="campo" style="width:98%;">${tl:escape(risk.riskTrigger)}</textarea></td>
					</tr>
					<tr>
						<th class="left" colspan="2">&nbsp;</th>
						<th class="left"><fmt:message key="risk.rating" /></th>
						<td id="risk_rating">&nbsp;</td>
					</tr>
				</table>
			</div>	
		</fieldset>
		
		<div>&nbsp;</div>
		
		<%-- RISK RESPONSE --%>
		<fieldset class="level_3">
			<legend class="link" onclick="changeCookie('field_risk_planning')"><fmt:message key="risk_planning"/></legend>
			<div class="buttons">
				<img id="field_risk_planningBtn" onclick="changeCookie('field_risk_planning', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="field_risk_planning" class="hide" style="padding-top:10px;">
				<table id="tb_risk_planning" border="0" cellpadding="2" cellspacing="1" width="100%">
					<tr>
						<th class="left" width="15%"><fmt:message key="risk.type"/></th>
						<td width="30%">
							<select name="risk_type" id="risk_type" class="campo">
								<option value="-1"><fmt:message key="select_opt" /></option>
								<option value="<%=Constants.RISK_OPPORTUNITY %>"
									<c:if test="${risk.riskType eq riskOpportunity}">
										selected										
									</c:if>
								><fmt:message key="risk.type.opportunity" /></option>
								<option value="<%=Constants.RISK_THREAT %>"
									<c:if test="${risk.riskType eq riskThreat}">
										selected										
									</c:if>
								><fmt:message key="risk.type.threat" /></option>
							</select>
						</td>
						<th width="10%">&nbsp;</th>
						<th class="left" width="15%"><fmt:message key="risk.response"/></th>
						<td width="30%">
							<select name="response" id="response" class="campo">
								<c:forEach var="category" items="${riskCategories}">
									<option id="response_${category.idRiskCategory}" 
											class="${category.riskType}" 
											value="${category.idRiskCategory}"											
											>${category.description}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th colspan="5" class="left"><fmt:message key="risk.response_description" /></th>
					</tr>
					<tr>
						<td colspan="5"><textarea name="response_description" id="response_description" class="campo" style="width:98%" >${tl:escape(risk.responseDescription)}</textarea></td>
					</tr>
					<tr>
						<th colspan="5" class="left"><fmt:message key="risk.mitigation_actions" /></th>
					</tr>
					<tr>
						<td colspan="5"><textarea name="mitigation_actions" id="mitigation_actions" class="campo" style="width:98%">${tl:escape(risk.mitigationActionsRequired)}</textarea></td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.mitigation_cost" /></th>
						<td><input type="text" name="mitigation_cost" id="mitigation_cost" class="campo importe" style="width: 75%;" value="${risk.plannedMitigationCost}"/></td>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<th colspan="5" class="left"><fmt:message key="risk.contingency_actions" /></th>
					</tr>
					<tr>
						<td colspan="5"><textarea name="contingency_actions" id="contingency_actions" class="campo" style="width:98%">${tl:escape(risk.contingencyActionsRequired)}</textarea></td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.contingency_cost" /></th>
						<td><input type="text" name="contingency_cost" id="contingency_cost" class="campo importe" style="width: 75%;" value="${risk.plannedContingencyCost}"/></td>
						<td colspan="3">&nbsp;</td>
					</tr>
					<tr>
						<th colspan="5" class="left"><fmt:message key="risk.residual_risk" /></th>
					</tr>
					<tr>
						<td colspan="5"><textarea name="residual_risk" id="residual_risk" class="campo" style="width:98%" >${tl:escape(risk.residualRisk)}</textarea></td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.residual_cost" /></th>
						<td><input type="text" name="residual_cost" id="residual_cost" class="campo importe" style="width: 75%;" value="${risk.residualCost}" /></td>
						<td colspan="3">&nbsp;</td>
					</tr>
				</table>
			</div>			
		</fieldset>
		
		<div>&nbsp;</div>
		
		<%-- RISK REASSESSMENT LOG --%>
		<fieldset class="level_3">
			<legend class="link" onclick="changeCookie('field_risk_reassessment_log')"><fmt:message key="risk.reassessment_log"/></legend>
			<div class="buttons">
				<img id="field_risk_reassessment_logBtn" onclick="changeCookie('field_risk_reassessment_log', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="field_risk_reassessment_log" class="hide" style="padding-top:10px;">			
				<table id="tb_risk_reassessment_log" width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<table id="tb_reassessment_logs" class="tabledata" cellspacing="1" width="100%">
								<thead>
									<tr>
										<th class="cabecera_tabla">&nbsp;</th>
										<th class="cabecera_tabla"><fmt:message key="date"/></th>
										<th class="cabecera_tabla"><fmt:message key="assumption_log.description_change"/></th>
										<th class="cabecera_tabla">
											<c:if test="${project.status ne status_closed and tl:hasPermission(user,project.status,tab)}">
												&nbsp;<img onclick="return addRiskReassessment();" title="<fmt:message key="add"/>" class="link" src="images/add.png">												
											</c:if>
									</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>					
				</table>
			</div>
		</fieldset>
		
		<div>&nbsp;</div>
		
		<%-- RISK FINAL DISPOSITION --%>
		<fieldset class="level_3">
			<legend class="link" onclick="changeCookie('field_risk_disposition')"><fmt:message key="risk.final_disposition"/></legend>
			<div class="buttons">
				<img id="field_risk_dispositionBtn" onclick="changeCookie('field_risk_disposition', this)" class="link" src="images/ico_mas.gif">
			</div>
			<div id="field_risk_disposition" class="hide" style="padding-top:10px;">			
				<table id="tb_risk_disposition" border="0" cellpadding="2" cellspacing="1" width="100%">
					<tr>
						<th class="left" width="25%"><fmt:message key="risk.materialized"/></th>
						<td width="25%">
							<input type="checkbox" name="materialized" id="materialized" style="width: 20px;"
								<c:if test="${risk.materialized eq true or risk.materialized eq 'true'}">
									checked
								</c:if>
							/>
						</td>
						<th class="left" width="25%"><fmt:message key="risk.materialized_date"/></th>
						<td width="25%">
							<input type="text" name="date_materialized" id="risk_date_materialized" class="campo fecha" value="<fmt:formatDate value="${risk.dateMaterialization }" pattern="${datePattern}"/>" />
						</td>
					</tr>
					<tr>
						<th class="left"><fmt:message key="risk.actual_cost" /></th>
						<td>
							<input type="text" name="actual_cost" id="risk_actual_cost" class="campo importe" style="width: 75%;" value="${risk.actualMaterializationCost}" />
						</td>
						<th class="left"><fmt:message key="risk.actual_delay" /></th>
						<td>
							<input type="text" name="actual_delay" id="risk_actual_delay" class="campo integerPositive" maxlength="5" style="width: 55%;" value="${tl:escape(risk.actualMaterializationDelay)}" />&nbsp;<fmt:message key="days" />
						</td>
					</tr>
					<tr>
						<th colspan="4" class="left"><fmt:message key="risk.final_comments" /></th>
					</tr>
					<tr>
						<td colspan="4"><textarea name="final_comments" id="risk_final_comments" class="campo" style="width:98%">${tl:escape(risk.finalComments)}</textarea></td>
					</tr>
				</table>
			</div>
		</fieldset>
		<div class="popButtons">
			<c:if test="${tl:hasPermission(user,project.status,tab)}">
				<a href="javascript:saveRisk();" class="boton"><fmt:message key="save" /></a>
			</c:if>  			
  			<a href="javascript:hide('frm_risk');" class="boton"><fmt:message key="close" /></a>
   		</div>
   	</fieldset>  	
</form>

<div id="reassessment-log-popup" class="popup">
	
	<div id="reassessment-log-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<strong><fmt:message key="msg.error_title"/></strong>
		&nbsp;(<b><span id="reassessment-log-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

	<form name="frm_reassessment_log" id="frm_reassessment_log" >
		<fieldset>
			<legend><fmt:message key="reassessment_log"/></legend>
		
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" width="30%"><fmt:message key="reassessment_log.date"/>&nbsp;*</th>
					<td width="70%">
						<input type="hidden" name="reassessment_log_id" />
						<input type="text" name="reassessment_log_date" id="reassessment_log_date" class="campo fecha" />
					</td>
				</tr>
				<tr>
					<th class="left" colspan="2"><fmt:message key="reassessment_log.change"/>&nbsp;*</th>
				</tr>
				<tr>
					<td colspan="2"><textarea name="reassessment_log_change" id="reassessment_log_change" class="campo" style="width:98%;"></textarea></td>
				</tr>
	   		</table>
	   	</fieldset>
	   	<c:if test="${tl:hasPermission(user,project.status,tab)}">
	   		<div class="popButtons">
	   			<input type="submit" class="boton" onclick="saveLogReassessment(); return false;" value="<fmt:message key="save" />" />
	   		</div>
	   	</c:if>	   	
   </form>
</div>
