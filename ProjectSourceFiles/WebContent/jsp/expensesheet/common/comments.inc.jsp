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
<%@page import="es.sm2.openppm.model.Expensesheetcomment"%>
<%@page import="es.sm2.openppm.servlets.ExpenseSheetServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--
var commentsTable;

function viewComments(element) {
	
	var aData = expenseSheetTable.fnGetData(element.parentNode.parentNode.parentNode);
	
	var params = {
		accion: '<%=ExpenseSheetServlet.JX_VIEW_COMMENTS%>',
		idExpenseSheet: aData[1]
	};
	expenseSheetAjax.call(params, function(data) {
		
		commentsTable.fnClearTable();
		
		$(data).each(function() {
			
			var row = [
			       this.<%=Expensesheetcomment.COMMENTDATE%>,
			       keyStatus(this.<%=Expensesheetcomment.PREVIOUSSTATUS%>),
			       keyStatus(this.<%=Expensesheetcomment.ACTUALSTATUS%>),
			       escape(this.<%=Expensesheetcomment.CONTENTCOMMENT%>)
			];
			
			commentsTable.fnAddData(row);
		});
		$('div#comments-popup').dialog('open');
	});
}

function keyStatus(key) {
	
	var value;
	
	if (key == '<%=Constants.EXPENSE_STATUS_APP0%>') { value = '<fmt:message key="applevel.app0"/>'; }
	else if (key == '<%=Constants.EXPENSE_STATUS_APP1%>') { value = '<fmt:message key="applevel.app1"/>'; }
	else if (key == '<%=Constants.EXPENSE_STATUS_APP2%>') { value = '<fmt:message key="applevel.app2"/>'; }
	else if (key == '<%=Constants.EXPENSE_STATUS_APP3%>') { value = '<fmt:message key="applevel.app3"/>'; }
	
	return value;
}

function closeComments(idTimeSheet) { $('div#comments-popup').dialog('close'); }

readyMethods.add(function() {
	
	commentsTable = $('#tb_comments').dataTable({
		"oLanguage": datatable_language,
		"bInfo": false,
		"sPaginationType": "full_numbers",
		"bAutoWidth": false,
		"iDisplayLength": 50,
		"aoColumns": [
              { "sClass": "center" },
              { "sClass": "center" },
              { "sClass": "center" },
              { "sClass": "left" }
     	]
	});
	
	$('div#comments-popup').dialog({ autoOpen: false, modal: true, width: 800, resizable: false });
});

//-->
</script>

<div id="comments-popup" class="popup">
	<fieldset>
		<legend><fmt:message key="comments"/></legend>
		<div>&nbsp;</div>
		<table id="tb_comments" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="15%"><fmt:message key="date"/></th>
					<th width="10%"><fmt:message key="state.previous"/></th>
					<th width="10%"><fmt:message key="state.next"/></th>
					<th width="65%"><fmt:message key="comments"/></th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</fieldset>
	<div class="popButtons">
		<a href="javascript:closeComments();" class="boton"><fmt:message key="close"/></a>
	</div>
</div>
