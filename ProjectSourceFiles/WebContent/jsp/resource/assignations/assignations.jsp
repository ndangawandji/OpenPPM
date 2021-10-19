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
<%@page import="es.sm2.openppm.servlets.ProjectPlanServlet"%>
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.model.Contact"%>
<%@page import="es.sm2.openppm.model.Teammember"%>
<%@page import="es.sm2.openppm.servlets.ResourceServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script language="javascript" type="text/javascript" >
<!--
var resourceAjax = new AjaxCall('<%=ResourceServlet.REFERENCE%>','<fmt:message key="error" />');
var planAjax = new AjaxCall('<%=ProjectPlanServlet.REFERENCE%>','<fmt:message key="error" />');
var resourceTable;

function buttonsResource(data) {
	return '<img onclick="viewResource('+data[0]+')" title="<fmt:message key="view"/>" class="link" src="images/view.png">';
}

function actionApplyFilter() {
	resourceTable.fnDraw();
}
readyMethods.add(function () {
	
	loadFilterState();
	
	resourceTable = $('#tb_resource').dataTable({
		"bServerSide": true,
		"sPaginationType": "full_numbers",
		"oLanguage": datatable_language,
		"aaSorting": [[5,'desc']],
		"bFilter": false,
		"iDisplayLength": 50,
		"sAjaxSource": '<%=ResourceServlet.REFERENCE%>',
		"fnRowCallback": function( nRow, aData) {
			$('td:eq(9)', nRow).html(buttonsResource(aData));
			return nRow;
		},
		"fnServerData": function ( sSource, aoData, fnCallback ) {
			
			aoData.push( { "name": "accion", "value": "<%=ResourceServlet.JX_FILTER_ASSIGNATIONS%>" } );
			aoData.push( { "name": "<%=Contact.FULLNAME%>", "value": $('#<%=Contact.FULLNAME%>').val() } );
			aoData.push( { "name": "<%=Teammember.DATEIN %>", "value": $('#since').val() } );
			aoData.push( { "name": "<%=Teammember.DATEOUT %>", "value": $('#until').val() } );
			aoData.push( { "name": "<%=Project.EMPLOYEEBYPROJECTMANAGER%>", "value": $('#<%=Project.EMPLOYEEBYPROJECTMANAGER%>').val()+"" } );
			aoData.push( { "name": "skill.idSkill", "value": $('#<%=Teammember.SKILL %>').val()+"" } );
			
			var checkboxs = document.getElementsByName('filter');

		    for(var i = 0, inp; inp = checkboxs[i]; i++) {
		        if (inp.type.toLowerCase() == 'checkbox' && inp.checked) {
					aoData.push( { "name": "<%=Teammember.STATUS%>", "value": inp.value } );
		        }
		    }
		    resourceAjax.call(aoData,fnCallback);
		},
		"aoColumns": [ 
	            { "bVisible": false }, 
	            { "sClass": "left" },
	            { "sClass": "left" },
	            { "sClass": "left" },
	            { "sClass": "left" },
	            { "sClass": "left" },
	            { "sClass": "left" },
	            { "sClass": "center" },
	            { "sClass": "center" },
	            { "sClass": "center" },
	            { "sClass": "center", "bSortable": false }
      		]
	});
});
//-->
</script>

<form id="frm_resource" name="frm_resource" method="post">
	<input type="hidden" name="accion" value="" />
	
	<jsp:include page="../common/filters.inc.jsp" flush="true"/>
	<div>
		<table id="tb_resource" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th>&nbsp;</th>
					<th width="8%"><fmt:message key="status" /></th>
					<th width="13%"><fmt:message key="contact.fullname" /></th>
					<th width="11%"><fmt:message key="skill" /></th>
					<th width="13%"><fmt:message key="project" /></th>
					<th width="14%"><fmt:message key="activity" /></th>
					<th width="14%"><fmt:message key="project_manager" /></th>
					<th width="8%"><fmt:message key="team_member.date_in" /></th>
					<th width="8%"><fmt:message key="team_member.date_out" /></th>
					<th width="8%"><fmt:message key="team_member.fte" /></th>
					<th width="3%">&nbsp;</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</form>
<div>&nbsp;</div>

<jsp:include page="resource_popup.jsp" flush="true"/>
<jsp:include page="search_resource_popup.jsp" flush="true"/>
