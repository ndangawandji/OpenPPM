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
<%@page import="es.sm2.openppm.model.Metrickpi"%>
<%@page import="es.sm2.openppm.model.Projectkpi"%>
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtMetricRequired">
	<fmt:param><b><fmt:message key="kpi.metric"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtUpperRequired">
	<fmt:param><b><fmt:message key="kpi.upper_threshold"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtLowerRequired">
	<fmt:param><b><fmt:message key="kpi.lower_threshold"/></b></fmt:param>
</fmt:message>
<fmt:message key="maintenance.error_msg_a" var="fmtWeightRequired">
	<fmt:param><b><fmt:message key="kpi.weight"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.out_of_range" var="fmtWeightOutOfRange">
	<fmt:param><b><fmt:message key="kpi.weight"/></b></fmt:param>
	<fmt:param>0 - 100</fmt:param>
</fmt:message>
<fmt:message key="msg.error.not_equal_to" var="fmtLowerNotEqualTo">
	<fmt:param><b><fmt:message key="kpi.lower_threshold"/></b></fmt:param>
	<fmt:param><b><fmt:message key="kpi.upper_threshold"/></b></fmt:param>
</fmt:message>

<%-- Message for confirmation --%>
<fmt:message key="msg.confirm_delete" var="fmtKpiDeleteMsg">
	<fmt:param><fmt:message key="kpi"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="fmtKpiDeleteTitle">
	<fmt:param><fmt:message key="kpi"/></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var kpiValidator;

function addKpi() {
	var f = document.frm_kpi;
	f.reset();
	f.<%=Projectkpi.IDPROJECTKPI%>.value = '';
	$('#tempWeight').val('0');
	
	$('#kpi-popup').dialog('open');
}

function editKpi(element) {

	var aData = kpiTable.fnGetData( element.parentNode.parentNode.parentNode );
	
	var f = document.frm_kpi;
	f.reset();
	
	$('#tempWeight').val(aData[6]);
	
	f.<%=Projectkpi.IDPROJECTKPI%>.value	= aData[0];
	f.<%=Metrickpi.IDMETRICKPI%>.value	= aData[1];
	f.<%=Projectkpi.UPPERTHRESHOLD%>.value	= aData[4];
	f.<%=Projectkpi.LOWERTHRESHOLD%>.value	= aData[5];
	f.<%=Projectkpi.WEIGHT%>.value			= aData[6];

	$('#kpi-popup').dialog('open');
}

function saveKpi() {

	if (kpiValidator.form()) {
		
		planAjax.call($("#frm_kpi").serialize(), function (data) {

			var f		= document.frm_kpi;
			var idKpi	= f.<%=Metrickpi.IDMETRICKPI%>.value;
			
			var dataRow = [
				data.<%=Projectkpi.IDPROJECTKPI%>,
				f.<%=Metrickpi.IDMETRICKPI%>.value,
				(idKpi != ''?
					escape($(f.<%=Metrickpi.IDMETRICKPI%>).find('option:selected').text()):''),
				(idKpi != ''?$('#definition'+idKpi).val():''),
				f.<%=Projectkpi.UPPERTHRESHOLD%>.value,
				f.<%=Projectkpi.LOWERTHRESHOLD%>.value,
				f.<%=Projectkpi.WEIGHT%>.value,
				'<nobr><img onclick="editKpi(this)" title="<fmt:message key="view"/>" class="link" src="images/view.png">'+
				'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+
				'<img onclick="deleteKpi(this)" title="<fmt:message key="delete"/>" class="link" src="images/delete.jpg"></nobr>'
			];
			
			if (f.<%=Projectkpi.IDPROJECTKPI%>.value == '') { kpiTable.fnAddDataAndSelect(dataRow); }
			else { kpiTable.fnUpdateAndSelect(dataRow); }
			
			
			$('#totalWeight').text(parseFloat($('#totalWeight').text()) - parseFloat($('#tempWeight').val()) + parseFloat(f.<%=Projectkpi.WEIGHT%>.value));
			
			$('#kpi-popup').dialog('close');
		});
	}
}

function deleteKpi(element) {
	
	confirmUI(
		'${fmtKpiDeleteTitle}','${fmtKpiDeleteMsg}',
		'<fmt:message key="yes"/>', '<fmt:message key="no"/>',
		function() {
			
			var aData = kpiTable.fnGetData( element.parentNode.parentNode.parentNode );
			
			planAjax.call({
				accion : '<%=ProjectPlanServlet.JX_DELETE_KPI %>',
					<%=Projectkpi.IDPROJECTKPI%>: aData[0]
				},function(data) {
					
					$('#totalWeight').text(parseFloat($('#totalWeight').text()) - parseFloat(aData[6]));
					
					kpiTable.fnDeleteSelected();
			});
	});
}

readyMethods.add(function() {
	$('div#kpi-popup').dialog({ autoOpen: false, modal: true, width: 500, minWidth: 500, resizable: false });

	kpiValidator = $("#frm_kpi").validate({
		errorContainer: 'div#kpi-errors',
		errorLabelContainer: 'div#kpi-errors ol',
		wrapper: 'li',
		showErrors: function(errorMap, errorList) {
			$('span#kpi-numerrors').html(this.numberOfInvalids());
			this.defaultShowErrors();
		},
		rules: {
			<%=Metrickpi.IDMETRICKPI%>: { required: true },
			<%=Projectkpi.WEIGHT%>: { required: true, range: [0,100] },
			<%=Projectkpi.LOWERTHRESHOLD%>: { required: true, notEqualTo: '#<%=Projectkpi.UPPERTHRESHOLD%>'  },
			<%=Projectkpi.UPPERTHRESHOLD%>: { required: true }
		},
		messages: {
			<%=Metrickpi.IDMETRICKPI%>: { required: '${fmtMetricRequired}' },
			<%=Projectkpi.WEIGHT%>: { required: '${fmtWeightRequired}', range: '${fmtWeightOutOfRange}' },
			<%=Projectkpi.LOWERTHRESHOLD%>: { required: '${fmtLowerRequired}', notEqualTo :'${fmtLowerNotEqualTo}' },
			<%=Projectkpi.UPPERTHRESHOLD%>: { required: '${fmtUpperRequired}' }
		}
	});	
});
//-->
</script>

<div id="kpi-popup" class="popup">
	<div id="kpi-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="kpi-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>
	<form name="frm_kpi" id="frm_kpi" method="post">
		<input type="hidden" name="accion" value="<%=ProjectPlanServlet.JX_SAVE_KPI%>"/>
		<input type="hidden" name="<%=Project.IDPROJECT%>" value="${project.idProject}"/>
		<input type="hidden" name="<%=Projectkpi.IDPROJECTKPI%>"/>
		<input type="hidden" id="tempWeight">
		
		<fieldset>
			<legend><fmt:message key="kpi" /></legend>
		
			<table cellspacing="1" width="100%">
				<tr>
					<th colspan="3"><fmt:message key="kpi.metric" />&nbsp;*</th>
				</tr>
				<tr>
					<td colspan="3">
						<select name="<%=Metrickpi.IDMETRICKPI%>" class="campo">
							<option value=""><fmt:message key="select_opt" /></option>
							<c:forEach var="metricKpi" items="${metricKpis}">
								<option value="${metricKpi.idMetricKpi}">${metricKpi.name}</option>
							</c:forEach>
						</select>
						<c:forEach var="metricKpi" items="${metricKpis}">
							<input type="hidden" id="definition${metricKpi.idMetricKpi}" value="${tl:escape(metricKpi.definition)}"/>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th width="34%"><fmt:message key="kpi.upper_threshold" />&nbsp;*</th>
					<th width="33%"><fmt:message key="kpi.lower_threshold" />&nbsp;*</th>
					<th width="33%"><fmt:message key="kpi.weight" />&nbsp;%&nbsp;*</th>
				</tr>
				<tr>
					<td><input type="text" class="campo" name="<%=Projectkpi.UPPERTHRESHOLD%>" id="<%=Projectkpi.UPPERTHRESHOLD%>"/></td>
					<td><input type="text" class="campo" name="<%=Projectkpi.LOWERTHRESHOLD%>"/></td>
					<td><input type="text" class="campo integer" name="<%=Projectkpi.WEIGHT%>" /></td>
				</tr>
    		</table>
    	</fieldset>
   		<div class="popButtons">
   			<input type="submit" class="boton" onclick="saveKpi(); return false;" value="<fmt:message key="save"/>" />
   		</div>
    </form>
</div>
