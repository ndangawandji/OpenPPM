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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.servlets.ProjectServlet"%>
<%@page import="es.sm2.openppm.common.Constants"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="yes" var="fmtSi"/>
<fmt:message key="no" var="fmtNo"/>
<fmt:message key="msg.confirm" var="fmtConfirm"/>
<fmt:message key="msg.error.no_selected_file" var="error_no_selected_file" />
<fmt:message key="msg.error.no_selected_file_info" var="error_no_selected_file_msg" />

<% String type = (String)request.getParameter("documentationType"); %>

<script type="text/javascript">
<!--
function ajaxFileUpload() {	
	if($("#fileToUpload").val() == "") {
		alertUI("${error_no_selected_file}","${error_no_selected_file_msg}");
	}
	else {
		var f = document.forms["frm_file_upload"];
		$.ajaxFileUpload ({
			url: '<%=ProjectServlet.REFERENCE%>',
			secureuri: false,
			fileElementId: 'fileToUpload',
			dataType: 'json',			
			data: [['accion', f.accion.value], ['projectId', f.projectId.value],
			       ['docId', f.docId.value], ['docType', f.docType.value],
			       ['nRow', f.nRow.value]], 
			beforeSend: function () {$("#loading").show('fast');},
			success: function (data) {
				if (data.error) {
					alertUI("${fmt_error}",data.error);
				}
				else {				
					var dataRow = [
			   			data.<%=Documentproject.IDDOCUMENTPROJECT%>,              		
			   			escape(data.<%=Documentproject.NAME%>),
			   			'<nobr><img class="link" onclick="downloadDoc(' + data.<%=Documentproject.IDDOCUMENTPROJECT%> + ')" src="images/download.png" title="<fmt:message key="download"/>"/>&nbsp;&nbsp;' +
			   			'<img class="link" onclick="editDoc(this)" src="images/modify.png" title="<fmt:message key="edit"/>"/>&nbsp;&nbsp;' +
			   			'<img class="link" onclick="deleteDoc(this)" src="images/delete.jpg" title="<fmt:message key="delete"/>"/></nobr>'
			   		];
			   		
			   		if(f.nRow.value != "") {
			   			fileSystemTable.fnUpdateAndSelect(dataRow);
			   		}
			   		else {
			   			fileSystemTable.fnAddDataAndSelect(dataRow);
			   		}	   		
			   		
			   		$('#search-filesystem-popup').dialog('close');
			   		
			   		if(<%=type.equals(Constants.DOCUMENT_CLOSURE)%>) {
			   			toClosureProject();
			   		}
				}			
			},
			error: function (data, status, e) {
				alert(e);
			}
		});	
	}
}

function closeFileUpload() { $('#search-filesystem-popup').dialog('close'); }

readyMethods.add(function() {
	$("#search-filesystem-popup").dialog({
		autoOpen: false,
		width: 500,
		resizable: false,
		modal: true		
	});	
});
//-->
</script>

<div id="search-filesystem-popup" class="popup" style="overflow: hidden;">	
	<fieldset>
		<legend><fmt:message key="edit_activity" /></legend>
		
		<form id="frm_file_upload" name="frm_file_upload" method="POST" enctype="multipart/form-data" >
			<input type="hidden" id="accion" name="accion" value="" />
			<input type="hidden" id="projectId" name="projectId" value="${project.idProject}" />
			<input type="hidden" id="docId" name="docId" value="-1" />
			<input type="hidden" id="docType" name="docType" value="<%=type%>" />
			<input type="hidden" id="nRow" name="nRow" value="" />
			
			<table id="search-filesystem-table" border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr id="doc_name_row">
					<th class="left" width="10%"><fmt:message key="document.name"/>:&nbsp;</th>
					<td width="90%" id="name_column"></td>
				</tr>				
				<tr>
					<td colspan = 2>
						<input type="text" name="filesystem_path" id="filesystem_path" value="" style="width: 90%; border: 1px solid #000000;" readonly />
						<label class="file_change" style="margin-right:5px; *margin-top: -15px !important;">
							<input type="file" name="fileToUpload" id="fileToUpload" onChange="setFile(this,'filesystem_path');" style="width: 0;"/>
						</label>
					</td>					
				</tr>				 		
			</table>
		</form>		
	</fieldset>	
	<div class="right" style="margin-top:10px;">
		<a href="javascript:ajaxFileUpload();" class="boton"><fmt:message key="upload" /></a>
		<a href="javascript:closeFileUpload();" class="boton"><fmt:message key="cancel" /></a>
   	</div>			
</div>
