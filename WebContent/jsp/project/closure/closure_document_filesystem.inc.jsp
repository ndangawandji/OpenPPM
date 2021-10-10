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
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--

var docRepositoryTable ;

function downloadDoc(id) {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectServlet.DOWNLOAD_DOC %>";
	f.idDocument.value = id;
	f.submit();
}

//When document is ready
readyMethods.add(function() {
	
	docRepositoryTable = $('#tb_doc_repository').dataTable({
		"oLanguage": datatable_language,		
		"bInfo": false,
		"bAutoWidth": false,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		"aoColumns": [
            { "bVisible": false },		              
            { "sClass": "left" },
            { "sClass": "left" },
            { "sClass": "center", "bSortable": false }
     	]
	});

	$('#tb_doc_repository tbody tr').live('click', function (event) {
		fnSetSelectable(docRepositoryTable , this);
	});
});
//-->
</script>

<fieldset class="level_1">
	<legend class="link" onclick="changeCookie('fieldClosureDoc')"><fmt:message key="closure.document_repository"/></legend>
	<div class="buttons">
		<img id="fieldClosureDocBtn" onclick="changeCookie('fieldClosureDoc', this)" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldClosureDoc" class="hide" style="padding-top:10px;">
		<table id="tb_doc_repository" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>
					<th width="25%"><fmt:message key="document_type"/></th>					
					<th width="70%"><fmt:message key="document_name"/></th>
					<th width="5%">&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="doc" items="${repository}">					
					<tr>
						<td>${doc.idDocumentProject}</td>
						<td><fmt:message key="documentation.${doc.type}"/></td>
						<td>${tl:escape(doc.name)}</td>
						<td>
							<img class="link" onclick="downloadDoc(${doc.idDocumentProject})" src="images/download.png" title="<fmt:message key="download"/>"/>							
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</fieldset>
