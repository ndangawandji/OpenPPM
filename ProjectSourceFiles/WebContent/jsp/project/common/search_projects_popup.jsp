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
<%@page import="es.sm2.openppm.model.Project"%>
<%@page import="es.sm2.openppm.servlets.UtilServlet"%>
<%@page import="es.sm2.openppm.model.Documentproject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--
var idSelectForAdd;
var searchProjectsTable;

function openSearchProject(idSelect) {
	
	var f = document.frm_search_project;
	idSelectForAdd = idSelect;
	$("#search-projects-popup").dialog('open');
}

function searchProject() {
	
	utilAjax.call($('#frm_search_project').serialize(),function(data){
		
		searchProjectsTable.fnClearTable();
		
		for (var i = 0; i < data.length; i++) {
			
			if ((data[i].<%=Project.IDPROJECT%>+'') != '${project.idProject}') {
				searchProjectsTable.fnAddData([
						data[i].<%=Project.IDPROJECT%>,
						escape(data[i].<%=Project.PROJECTNAME%>),
						escape(data[i].<%=Project.ACCOUNTINGCODE%>),
						escape(data[i].<%=Project.CHARTLABEL%>)
					]);
			}
		}
		$('#searchName').focus();
	});
}
function addProjectSelected() {
	
	
	var selecteds = searchProjectsTable.fnGetSelectedsData();
	
	$(selecteds).each(function() {
		$(idSelectForAdd).append('<option value="'+this[0]+'">'+this[1]+'</option>');
	});
	
	$("#search-projects-popup").dialog('close');
}

function closeSearchProjects() { $('#search-projects-popup').dialog('close'); }

readyMethods.add(function() {
	$("#search-projects-popup").dialog({
		autoOpen: false,
		width: 600,
		resizable: false,
		modal: true,
		open: function(event, ui) { $('#searchName').focus(); }
	});
	
	searchProjectsTable = $('#tb_searchproject').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"oLanguage": datatable_language,
		"sPaginationType": "full_numbers",
		"bFilter": false,
		"oTableTools": { "sRowSelect": "multi", "aButtons": [] },
		"iDisplayLength": 50,
		"aoColumns": [
			{ "bVisible": false },
			{  "sClass": "left" },
			{ "sClass": "left"},
			{  "sClass": "left" }
		]
	});
});
//-->
</script>

<div id="search-projects-popup" class="popup">	
	<fieldset>
		<legend><fmt:message key="menu.projects" /></legend>
		
		<form id="frm_search_project" name="frm_search_project" onsubmit="searchProject; return false;">
			<input type="hidden" id="accion" name="accion" value="<%=UtilServlet.JX_SEARCH_PROJECTS %>" />
			
			<table cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<td>
						<b><fmt:message key="search" />:</b>
					</td>
					<td colspan="4">
						<input type="text" name="<%=Project.PROJECTNAME %>" id="searchName" class="campo" style="width: 350px;">
					</td>
					<td>
						<a href="javascript:searchProject();" class="boton"><fmt:message key="filter.apply" /></a>
					</td>
				</tr>		 		
			</table>
			<div>&nbsp;</div>
			<table id="tb_searchproject" class="tabledata" cellspacing="1" width="100%">
				<thead>
					<tr>
						<th>&nbsp;</th>
						<th width="60%"><fmt:message key="project" /></th>
						<th width="20%"><fmt:message key="project.accounting_code" /></th>
						<th width="20%"><fmt:message key="project.chart_label" /></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</form>		
	</fieldset>	
	<div class="popButtons">
		<a href="javascript:addProjectSelected();" class="boton"><fmt:message key="add" /></a>
		<a href="javascript:closeSearchProjects();" class="boton"><fmt:message key="cancel" /></a>
   	</div>			
</div>
