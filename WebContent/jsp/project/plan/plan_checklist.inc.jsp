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

<script type="text/javascript">
<!--
var checklistTable;

readyMethods.add(function() {

	checklistTable = $('#tb_checklist').dataTable({
		"oLanguage": datatable_language,
		"sPaginationType": "full_numbers",
		"bAutoWidth": false,
		"iDisplayLength": 50,
		"aaSorting": [[ 2, "asc" ]],
		"bInfo": false,
		"aoColumns": [
			  { "bVisible": false },
			  { "bVisible": false },
              { "sClass": "left" },
              { "sClass": "left" },
			  { "sClass": "left" },
              { "sClass": "center", "bSortable": false }
      		]
	});

	$('#tb_checklist tbody tr').live('click', function (event) {
		fnSetSelectable(checklistTable, this);
	});
});

//-->
</script>

<div class="hColor" style="margin-top:10px;">
	<fmt:message key="deliverables"/>
</div>
<table id="tb_checklist" class="tabledata" cellspacing="1" width="100%">
	<thead>
		<tr>
			<th width="0%">&nbsp;</th>
			<th width="0%">&nbsp;</th>
			<th width="40%"><fmt:message key="wbs.wbs"/></th>
			<th width="10%"><fmt:message key="checklists.code"/></th>
			<th width="42%"><fmt:message key="checklists.desc"/></th>
			<th width="8%">
				<c:if test="${tl:hasPermission(user,project.status,tab)}">
					<img src="images/add.png" class="link" onclick="addChecklist()" title="<fmt:message key="add"/>" />
				</c:if>
			</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="checklist" items="${checklists}">
			<tr>
				<td>${checklist.idChecklist}</td>
				<td>${checklist.wbsnode.idWbsnode}</td>
				<td>${tl:escape(checklist.wbsnode.code)} ${tl:escape(checklist.wbsnode.name)}</td>
				<td>${tl:escape(checklist.code)}</td>
				<td>${tl:escape(checklist.description)}</td>
				<td>
					<c:if test="${tl:hasPermission(user,project.status,tab)}">
						<img onclick="editChecklist(this)" class="link" src="images/view.png" title="<fmt:message key="view"/>"/>
						&nbsp;&nbsp;&nbsp;
						<img src="images/delete.jpg" class="link" onclick="deleteChecklist(this)" title="<fmt:message key="delete"/>" />
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
