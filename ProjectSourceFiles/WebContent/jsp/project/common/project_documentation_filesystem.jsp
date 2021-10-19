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
<%@page import="es.sm2.openppm.model.Documentproject"%>
<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:message key="yes" var="msg_yes" />
<fmt:message key="no" var="msg_no" />
<fmt:message key="msg.confirm_delete" var="msg_delete_document">
	<fmt:param><fmt:message key="document"/></fmt:param>
</fmt:message>
<fmt:message key="msg.title_confirm_delete" var="msg_title_delete_document">
	<fmt:param><fmt:message key="document"/></fmt:param>
</fmt:message>
<fmt:message key="maintenance.document.new_document" var="new_document_title" />
<fmt:message key="maintenance.document.edit_document" var="edit_document_title" />

<fmt:setLocale value="${locale}" scope="request"/>
<% String type = (String)request.getParameter("documentationType"); %>

<script type="text/javascript">
<!--

var fileSystemTable;

function setFile(dest, src) {
	$("#"+src).val($(dest).val());
}

function addFileSystem() {
	var f = document.forms["frm_file_upload"];	
	f.accion.value = "<%=ProjectServlet.JX_UPLOAD_FILESYSTEM%>";
	f.filesystem_path.value = "";
	f.fileToUpload.value = "";
	f.docId.value = "-1";	
	f.nRow.value = "";
	f.projectId.value = $("#<%=Documentproject.PROJECT%>_${param.documentationType}").val();
	$('#search-filesystem-popup legend').html('${new_document_title}');
	$('#doc_name_row').hide();
	$('#search-filesystem-popup').dialog('open');	
}

function downloadDoc(id) {
	var f = document.forms["frm_project"];
	f.action = "<%=ProjectServlet.REFERENCE%>";
	f.accion.value = "<%=ProjectServlet.DOWNLOAD_DOC %>";
	f.idDocument.value = id;
	f.submit();
	return false;
}

function editDoc(element) {	
	var doc;
	if(fileSystemTable.fnGetData( element.parentNode.parentNode) != null) {	
		doc = fileSystemTable.fnGetData( element.parentNode.parentNode );	
	}		
	else {
		doc = fileSystemTable.fnGetData( element.parentNode.parentNode.parentNode );
	}
	var f = document.forms["frm_file_upload"];	
	f.accion.value = "<%=ProjectServlet.JX_UPLOAD_FILESYSTEM%>";
	f.filesystem_path.value = "";
	f.fileToUpload.value = "";
	f.docId.value = doc[0];
	f.nRow.value = "n";
	f.projectId.value = $("#<%=Documentproject.PROJECT%>_${param.documentationType}").val();
	$('#search-filesystem-popup legend').html('${edit_document_title}');
	$('#doc_name_row').show();
	$('#name_column').text(doc[1]);
	$('#search-filesystem-popup').dialog('open');	
}

function deleteDoc(element) {
	
	confirmUI(
		'${msg_title_delete_doc}','${msg_delete_document}',
		'<fmt:message key="yes"/>', '<fmt:message key="no"/>',
		function() {
			
			var doc;
			if(fileSystemTable.fnGetData( element.parentNode.parentNode) != null) {	
				doc = fileSystemTable.fnGetData( element.parentNode.parentNode );	
			}		
			else {
				doc = fileSystemTable.fnGetData( element.parentNode.parentNode.parentNode );
			}	
			
			projectAjax.call({
					accion : '<%=ProjectServlet.JX_DELETE_DOC %>',
					<%=Documentproject.IDDOCUMENTPROJECT%>: doc[0]
				},function(data) {				
					fileSystemTable.fnDeleteSelected();
			   		
					if(<%=type.equals(Constants.DOCUMENT_CLOSURE)%>) {
						toClosureProject();
			   		}
			});
	});
}

//When document is ready
readyMethods.add(function() {
	
	fileSystemTable = $('#tb_filesystem').dataTable({
		"oLanguage": datatable_language,
		"bFilter": false,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"aaSorting": [[ 1, "asc" ]],
		"aoColumns": [
		              { "bVisible": false },		              
		              { "sClass": "left"},
		              { "sClass": "center", "bSortable": false }
		      		]
	});

	$('#tb_filesystem tbody tr').live('click', function (event) {
		fnSetSelectable(fileSystemTable, this);
	});
});
//-->
</script>
<form name="form_document_project_${param.documentationType }" id="form_document_project_${param.documentationType }" action="<%=ProjectServlet.REFERENCE%>" method="post">
	<input type="hidden" name="accion" value="<%=ProjectServlet.JX_SAVE_DOCUMENT%>"/>
	<input type="hidden" name="<%=Documentproject.TYPE%>" value="${param.documentationType }"/>
	<input type="hidden" name="<%=Documentproject.IDDOCUMENTPROJECT%>" id="<%=Documentproject.IDDOCUMENTPROJECT%>" value=""/>
	<input type="hidden" name="<%=Documentproject.PROJECT%>" id="<%=Documentproject.PROJECT%>_${param.documentationType}" value="${project.idProject }"/>

	<fieldset style="margin-top:10px;" class="level_1">		
		<div class="hColor">${param.documentationTitle }</div>
		<table id="tb_filesystem" class="tabledata" cellspacing="1" width="100%">
			<thead>
				<tr>
					<th width="0%">&nbsp;</th>					
					<th width="90%"><fmt:message key="document_name"/></th>
					<th width="10%">
						<c:if test="${tl:hasPermission(user,project.status,tab)}">
							<img onclick="addFileSystem()" title="<fmt:message key="add"/>" class="link" src="images/add.png">
						</c:if>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="doc" items="${docs}">					
					<tr>
						<td>${doc.idDocumentProject}</td>
						<td>${tl:escape(doc.name)}</td>
						<td>
							<img class="link" onclick="downloadDoc(${doc.idDocumentProject})" src="images/download.png" title="<fmt:message key="download"/>"/>&nbsp;
							<c:if test="${tl:hasPermission(user,project.status,tab)}">
								<img class="link" onclick="editDoc(this)" src="images/modify.png" title="<fmt:message key="edit"/>"/>&nbsp;
								<img class="link" onclick="deleteDoc(this)" src="images/delete.jpg" title="<fmt:message key="delete"/>"/>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</fieldset>
</form>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<jsp:include page="search_filesystem_popup.jsp" flush="true" />
</c:if>
