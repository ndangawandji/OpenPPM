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
<%@page import="es.sm2.openppm.servlets.UtilServlet"%>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://granule.com/tags" prefix="g" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<%@page import="es.sm2.openppm.common.Constants"%>
<%@page import="es.sm2.openppm.common.Settings"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<link rel="shortcut icon" href="images/favicon.ico" >

<link type="text/css" href="css/redmond/jquery-ui-1.8rc3.custom.css" rel="stylesheet" />
<link type="text/css" href="css/jquery.treeview.css" rel="stylesheet" />
<link type="text/css" href="css/submenu.superfish.css" rel="stylesheet" />
<link type="text/css" href="css/tabledata.css" rel="stylesheet" />
<link type="text/css" href="css/TableTools.css" rel="stylesheet" />
<link type="text/css" href="css/flag.css" rel="stylesheet" />
<link href="css/plantilla.css" rel="stylesheet" type="text/css">
<link href="css/openppm.css" rel="stylesheet" type="text/css">
<!-- 
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
 -->
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8rc3.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/jquery.metadata.js"></script>
<script type="text/javascript" src="js/jquery.cookie.js"></script>
<script type="text/javascript" src="js/ZeroClipboard.js"></script>
<script type="text/javascript" src="js/TableTools.min.js"></script>
<script type="text/javascript" src="js/wbs/jquery.treeview.js"></script>
<script type="text/javascript" src="js/jquery.submenu.superfish.js"></script>
<script type="text/javascript" src="js/util.js"></script>
<script type="text/javascript" src="js/jquery.openppm-ext.js"></script>
<script type="text/javascript" src="js/FusionCharts.js"></script>
<script type="text/javascript" src="js/si.files.js"></script>
<script type="text/javascript" src="js/dataTables_ext.js"></script>
<script type="text/javascript" src="js/FixedColumns.min.js"></script>
<script type="text/javascript" src="js/jquery.bt.min.js"></script>
<script type="text/javascript" src="js/functions.js"></script>
<script type="text/javascript" src="js/jquery.filterSelect.js"></script>
<script type="text/javascript" src="js/ajaxfileupload.js"></script>
<c:set var="settingCompressJS" value="<%=Settings.PERFORMANCE_COMPRESS_JS %>"/>

<%-- JQPLOT --%>
<%-- excanvas is required only for IE versions below 9 --%>
<!--[if IE]>
<script language="javascript" type="text/javascript" src="js/jqPLOT/excanvas.min.js"></script>
<![endif]-->
<script language="javascript" type="text/javascript" src="js/jqPLOT/jquery.jqplot.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/jquery.jqplot.css" />
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.barRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.highlighter.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.cursor.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.pointLabels.min.js"></script>
<script type="text/javascript" src="js/jqPLOT/plugins/jqplot.bubbleRenderer.min.js"></script>

<c:choose>
	<c:when test="${settingCompressJS && param.compresJS }">
		<g:compress>
			<script language="JavaScript">
			<!--
				<%--For call functions in one document read--%>
				function ReadyMethod () { this.methods = new Array(); }
				ReadyMethod.prototype.add = function(method) { this.methods.push(method); };
				ReadyMethod.prototype.execute = function() { $(this.methods).each(function() { this(); }); };
				var readyMethods = new ReadyMethod();
				jQuery.validator.addClassRules("importe", { maxlength: <%=Constants.MAX_CURRENCY%> });
				var utilAjax = new AjaxCall('<%=UtilServlet.REFERENCE%>','<fmt:message key="error" />');
				function selectRol() { document.forms["form_change_rol"].submit(); }
				readyMethods.add(function () { $('ul.sf-menu').superfish(); });
			//-->
			</script>
		</g:compress>
	</c:when>
	<c:otherwise>
		<script language="JavaScript">
		<!--
			<%--Same Code--%>
			function ReadyMethod () { this.methods = new Array(); }
			ReadyMethod.prototype.add = function(method) { this.methods.push(method); };
			ReadyMethod.prototype.execute = function() { $(this.methods).each(function() { this(); }); };
			var readyMethods = new ReadyMethod();
			jQuery.validator.addClassRules("importe", { maxlength: <%=Constants.MAX_CURRENCY%> });
			var utilAjax = new AjaxCall('<%=UtilServlet.REFERENCE%>','<fmt:message key="error" />');
			function selectRol() { document.forms["form_change_rol"].submit(); }
			readyMethods.add(function () { $('ul.sf-menu').superfish(); });
		//-->
		</script>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${tl:isNull(user.contact.locale)}">
		<c:set var="extLocale"><%=Settings.LOCALE_LANGUAGE_DEFAULT%>_<%=Settings.LOCALE_COUNTRY_DEFAULT%></c:set>
	</c:when>
	<c:otherwise><c:set var="extLocale" value="${user.contact.locale}"/></c:otherwise>
</c:choose>

<script type="text/javascript" src="js/language/${extLocale }.js"></script>
<script type="text/javascript" src="js/language/jquery.ui.datepicker-${extLocale }.js"></script>

<!--[if IE]>
	<script type="text/javascript" src="js/excanvas-compressed.js"></script>
<![endif]-->
