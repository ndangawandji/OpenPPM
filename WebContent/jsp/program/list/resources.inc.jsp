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
<%@page import="es.sm2.openppm.servlets.ProgramServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored ="false"%>
	
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<fmt:setLocale value="${locale}" scope="request"/>

<script language="javascript" type="text/javascript" >
<!--
function infoSalesForecast() {
	infoTable = true;
	funcInfoTable = showSalesForecast;
	projectsTable.fnDraw();
}

function showSalesForecast(dat) {
	
	programAjax.call({
		accion: "<%=ProgramServlet.JX_CONS_SALES_FORECAST%>",
		ids: dat.ids
	}, function(data) {
		if (typeof data.xml === 'undefined') { $("#salesForecastChart").html('<fmt:message key="data_not_found"/>'); }
		else { 
			var chartSales = new FusionCharts("FusionCharts/FCF_Area2D.swf", "SalesId", 850, 450); 
		    chartSales.setDataXML(data.xml);    
		    chartSales.render("salesForecastChart");
		}
		show('fieldPrgSalesForecast');
	});
}
//-->
</script>

<%-- RESOURCES --%>
<fieldset>
	<%--
	<legend class="link" onclick="changeIco('fieldPrgSalesForecast', 'legend', infoSalesForecast)"><fmt:message key="resources"/></legend>
	--%>
	<legend class="link" onclick="informationSuccess('Not Available')" ><fmt:message key="resources"/></legend>
	<div class="buttons">
	<%--
		<img id="fieldPrgSalesForecastBtn" onclick="changeIco('fieldPrgSalesForecast', this, infoSalesForecast)" class="link" src="images/ico_mas.gif">
	--%>
		<img id="fieldPrgSalesForecastBtn" onclick="informationSuccess('Not Available')" class="link" src="images/ico_mas.gif">
	</div>
	<div id="fieldPrgSalesForecast" style="margin-top: 20px;" class="hide">
		<div style="margin-left:30px; margin-bottom:10px;">
			<a href="javascript:infoSalesForecast();" class="boton"><fmt:message key="chart.refresh"/></a>
		</div>
		<div class="center">
			<div id="salesForecastChart"></div>
		</div>
	</div>
</fieldset>
