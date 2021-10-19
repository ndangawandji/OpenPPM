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

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<c:set var="viewDoc"/>

<c:if test="${tl:hasPermission(user,project.status,tab)}">
	<c:set var="viewDoc"><img onclick="viewDocumentation(this);" title="<fmt:message key="view"/>" class="link" src="images/view.png"></c:set>
</c:if>

<script type="text/javascript">
<!--

var docRepositoryTable ;

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
            { "sClass": "left", "bSortable": false },
            { "sClass": "left", "bSortable": false },
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
					<th width="20%"><fmt:message key="document_type"/></th>					
					<th width="25%"><fmt:message key="document_name"/></th>
					<th width="50%"><fmt:message key="document_comment"/></th>
					<th width="5%">&nbsp;</th>
				</tr>
			</thead>
			<c:if test="${not tl:isNull(project.linkDoc) }">
				<tr>
					<th>-1</th>
					<th><fmt:message key="document_link"/></th>
					<td><a target="_blank" href="${tl:escape(project.linkDoc) }">${tl:escape(project.linkDoc) }</a></td>
					<td>${project.linkComment}</td>
					<td>${viewDoc}</td>	
				</tr>
			</c:if>
			<c:if test="${docInv ne null and not tl:isNull(docInv.link) }">
				<tr>
					<td>${docInv.idDocumentProject}</td>
					<th width="25%"><fmt:message key="documentation.investment"/></th>
					<td><a target="_blank" href="${tl:escape(docInv.link) }">${tl:escape(docInv.link) }</a></td>
					<td>${docInv.contentComment}</td>
					<td>${viewDoc}</td>
				</tr>
			</c:if>
			<c:if test="${docInit ne null and not tl:isNull(docInit.link) }">
				<tr>
					<td>${docInit.idDocumentProject}</td>
					<th width="25%"><fmt:message key="documentation.initiating"/></th>
					<td><a target="_blank" href="${tl:escape(docInit.link) }">${tl:escape(docInit.link) }</a></td>
					<td>${docInit.contentComment}</td>
					<td>${viewDoc}</td>
				</tr>
			</c:if>
			<c:if test="${docRisk ne null and not tl:isNull(docRisk.link)}">
				<tr>
					<td>${docRisk.idDocumentProject}</td>
					<th width="25%"><fmt:message key="documentation.risk"/></th>
					<td><a target="_blank" href="${tl:escape(docRisk.link) }">${tl:escape(docRisk.link) }</a></td>
					<td>${docRisk.contentComment}</td>
					<td>${viewDoc}</td>
				</tr>
			</c:if>
			<c:if test="${docPlan ne null and not tl:isNull(docPlan.link)}">
				<tr>
					<td>${docPlan.idDocumentProject}</td>
					<th width="25%"><fmt:message key="documentation.planning"/></th>
					<td><a target="_blank" href="${tl:escape(docPlan.link) }">${tl:escape(docPlan.link) }</a></td>
					<td>${docPlan.contentComment}</td>
					<td>${viewDoc}</td>
				</tr>
			</c:if>
			<c:if test="${docControl ne null and not tl:isNull(docControl.link)}">
				<tr>
					<td>${docControl.idDocumentProject}</td>
					<th width="25%"><fmt:message key="documentation.control"/></th>
					<td><a target="_blank" href="${tl:escape(docControl.link) }">${tl:escape(docControl.link) }</a></td>
					<td>${docControl.contentComment}</td>
					<td>${viewDoc}</td>
				</tr>
			</c:if>
			<c:if test="${docProcurement ne null and not tl:isNull(docProcurement.link) }">
				<tr>
					<td>${docProcurement.idDocumentProject}</td>
					<th width="25%"><fmt:message key="documentation.procurement"/></th>					
					<td><a target="_blank" href="${tl:escape(docProcurement.link) }">${tl:escape(docProcurement.link) }</a></td>
					<td>${docProcurement.contentComment}</td>
					<td>${viewDoc}</td>
				</tr>
			</c:if>
			<c:if test="${docClosure ne null and not tl:isNull(docClosure.link) }">
				<tr>
					<td>${docClosure.idDocumentProject}</td>
					<th width="25%"><fmt:message key="documentation.closure"/></th>					
					<td><a target="_blank" href="${tl:escape(docClosure.link) }">${tl:escape(docClosure.link) }</a></td>
					<td>${docClosure.contentComment}</td>
					<td>${viewDoc}</td>
				</tr>
			</c:if>
		</table>
	</div>
</fieldset>
