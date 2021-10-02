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
<script>
$(document).ready(function() {
	$('.btitle').bt({
		fill: '#F9FBFF',
		cssStyles: {color: '#343C4E', width: 'auto'},
		width: 250,
		padding: 10,
		cornerRadius: 5,
		spikeLength: 15,
		spikeGirth: 5,
		shadow: true,
		positions: 'top'
	});
});
</script>
<div style="width: 918px; padding-top:5px;">
	<div style="float: left; width: 250px; overflow: hidden;">
		<table class="tabledataScroll" width="100%">
			<thead>
				<tr>
					<th style="border-radius: 5px 5px 0 0 !important;">${titleTable }</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memberFte" items="${ftEs }">
					<tr>
						<td>
							<nobr>
								<c:choose>
									<c:when test="${memberFte.project eq null }">
										${tl:escape(memberFte.member.skill.name) }&nbsp;<span class="btitle" title="${tl:escape(memberFte.projectNames)}"><fmt:message key="view"/>&nbsp;<fmt:message key="projects"/></span>
									</c:when>
									<c:otherwise>${tl:escape(memberFte.project.projectName) } (${tl:escape(memberFte.project.employeeByProjectManager.contact.fullName) })</c:otherwise>
								</c:choose>
							</nobr>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div style="overflow: auto; float: left; width: 520px;">
		<table class="tabledataScroll" width="100%">
			<thead>
				<tr>
					<c:forEach var="dateHead" items="${listDates}">
						<th><nobr>${dateHead }</nobr></th>
					</c:forEach>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memberFte" items="${ftEs}">
					<tr>
						<c:forEach var="fte" items="${memberFte.ftes }">
							<c:choose>
								<c:when test="${fte > 0}"><td class="center ${fte > 100?"red":"" }">${fte }%</td></c:when>
								<c:otherwise><td></td></c:otherwise>																
							</c:choose>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
