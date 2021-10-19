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
<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>
<%@page import="es.sm2.openppm.model.Projectkpi"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtValueRequired">
	<fmt:param><b><fmt:message key="kpi.upper_threshold"/></b></fmt:param>
</fmt:message>

<script type="text/javascript">
<!--
var kpiValidator;

function editKpi(element) {

	var aData = kpiTable.fnGetData( element.parentNode.parentNode );
	
	var f = document.frm_kpi;
	f.reset();
	
	$('#oldScore').val(toNumber(aData[10]));
	
	f.<%=Projectkpi.IDPROJECTKPI%>.value	= aData[0];
	f.<%=Projectkpi.UPPERTHRESHOLD%>.value	= aData[5];
	f.<%=Projectkpi.LOWERTHRESHOLD%>.value	= aData[6];
	f.<%=Projectkpi.WEIGHT%>.value			= aData[8];
	f.<%=Projectkpi.VALUE%>.value			= aData[9];

	$('#kpi-popup').dialog('open');
}

function updateKpi() {

	if (kpiValidator.form()) {
		
		controlAjax.call($("#frm_kpi").serialize(), function (data) {

			var f = document.frm_kpi;
			
			var dataRow = kpiTable.fnGetSelectedData();
			
			dataRow[2] = '<span class="'+typeAdjustedValue(data.adjustedValue)+'">&nbsp;&nbsp;&nbsp;</span>';
			
			var total = parseFloat(toNumber($('#totalScore').text())) - parseFloat($('#oldScore').val()) + parseFloat(data.score);
			$('#totalScore').text(toCurrency(total));
			$('#totalValue').text(toCurrency(total));
			
			dataRow[7] = toCurrency(data.adjustedValue);
			dataRow[9] = f.<%=Projectkpi.VALUE%>.value;
			dataRow[10] = toCurrency(data.score);
			
			kpiTable.fnUpdateAndSelect(dataRow);
			
			calcTotalNormalicedValue();
			
			$('#kpi-popup').dialog('close');
		});
	}
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
			<%=Projectkpi.VALUE%>: { required: true }
		},
		messages: {
			<%=Projectkpi.VALUE%>: { required: '${fmtValueRequired}' }
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
	<form name="frm_kpi" id="frm_kpi" >
		<input type="hidden" name="accion" value="<%=ProjectControlServlet.JX_UPDATE_KPI%>"/>
		<input type="hidden" name="<%=Project.IDPROJECT%>" value="${project.idProject}"/>
		<input type="hidden" name="<%=Projectkpi.IDPROJECTKPI%>"/>
		<input type="hidden" id="oldScore"/>
		
		<fieldset>
			<legend><fmt:message key="kpi" /></legend>
		
			<table cellspacing="1" width="100%">
				<tr>
					<th width="25%"><fmt:message key="kpi.upper_threshold" /></th>
					<th width="25%"><fmt:message key="kpi.lower_threshold" /></th>
					<th width="25%"><fmt:message key="kpi.weight" />&nbsp;%</th>
					<th width="25%"><fmt:message key="kpi.value" />&nbsp;*</th>
				</tr>
				<tr>
					<td><input type="text" class="center" name="<%=Projectkpi.UPPERTHRESHOLD%>" readonly/></td>
					<td><input type="text" class="center" name="<%=Projectkpi.LOWERTHRESHOLD%>" readonly/></td>
					<td><input type="text" class="center" name="<%=Projectkpi.WEIGHT%>" readonly/></td>
					<td><input type="text" class="campo" name="<%=Projectkpi.VALUE%>"/></td>
				</tr>
    		</table>
    	</fieldset>
   		<div class="popButtons">
			<input type="submit" onclick="javascript:updateKpi(); return false;" class="boton" value="<fmt:message key="update"/>" />
   		</div>
    </form>
</div>
