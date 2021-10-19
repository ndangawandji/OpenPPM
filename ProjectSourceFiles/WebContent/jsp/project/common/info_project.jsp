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

<c:choose>
	<c:when test="${tl:hasPermission(user,project.status,tab)}">				
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			readyMethods.add(function() {
				$('.campo').attr('disabled','disabled');
				$('.campo').css({'background-color': '#FFFFFF'});
				$(':checkbox').attr('disabled','disabled');
				$(':input.alwaysEditable').attr('disabled','');
				$(':input[type=hidden]').attr('disabled','');
			});
		</script>
	</c:otherwise>
</c:choose>

<table width="100%" style="margin-bottom:15px;">
    <tr>
        <th class="center" width="7%" style="vertical-align: bottom;"><fmt:message key="status" /></th>
        <th class="left" width="14%" style="vertical-align: bottom;"><fmt:message key="program" /></th>
        <th class="left" width="20%" style="vertical-align: bottom;"><fmt:message key="project_name" /></th>                
        <th class="left" width="14%" style="vertical-align: bottom;"><fmt:message key="project_manager" /></th>
        <th class="center" width="7%" style="vertical-align: bottom;"><fmt:message key="project.accounting_code" /></th>                
        <th class="center" width="7%" style="vertical-align: bottom;"><fmt:message key="project.date.initiation" /></th>
        <th class="center" width="7%" style="vertical-align: bottom;"><fmt:message key="project.date.planning" /></th>
        <th class="center" width="7%" style="vertical-align: bottom;"><fmt:message key="project.date.execution" /></th>
        <th class="center" width="7%" style="vertical-align: bottom;"><fmt:message key="project.date.closing" /></th>                                                
    </tr>
    <tr>
        <td class="center" style="vertical-align: top;">
	        <c:choose>
				<c:when test="${type eq typeInvestment}">
				   <fmt:message key="investments.status.${project.investmentStatus}" />
				</c:when>
				<c:otherwise>
				   <fmt:message key="project_status.${project.status}" />
				</c:otherwise>
			</c:choose>
        </td>
        <td class="left" style="vertical-align: top;">${project.program.programName }</td>
        <td class="left" style="vertical-align: top;"><b>${project.projectName }</b></td>                
        <td class="left" style="vertical-align: top;">${project.employeeByProjectManager.contact.fullName }</td>
        <td class="center" style="vertical-align: top;">${project.accountingCode }</td>
        <td class="center" style="vertical-align: top;"><fmt:formatDate value="${project.initDate}" pattern="${datePattern}" /></td>
        <td class="center" style="vertical-align: top;"><fmt:formatDate value="${project.planDate}" pattern="${datePattern}" /></td>
        <td class="center" style="vertical-align: top;"><fmt:formatDate value="${project.execDate}" pattern="${datePattern}" /></td>                                                
        <td class="center" style="vertical-align: top;"><fmt:formatDate value="${project.endDate}" pattern="${datePattern}" /></td>                                                
    </tr>
</table>
