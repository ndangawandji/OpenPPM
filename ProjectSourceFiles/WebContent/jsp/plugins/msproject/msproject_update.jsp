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

<%@page import="es.sm2.openppm.plugins.msproject.MSProjectServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<script type="text/javascript">
<!--

var msgCondirm;

function updateProjectBaseline(projectId) {
	
	msgConfirm = '<fmt:message key="msg.warning_update_msp"/>';
	
	var f = document.forms["frm_file"];
	f.action = "<%=MSProjectServlet.REFERENCE%>";
	f.pluginAccion.value = "<%=MSProjectServlet.UPDATE_MPP%>";
	f.id.value = projectId;
	
	$('#search-file-popup').dialog('open');
	
}
//-->
</script>

<a href="javascript:updateProjectBaseline('${project.idProject}');" class="boton">
	<fmt:message key="update_project_baseline" />
</a>
