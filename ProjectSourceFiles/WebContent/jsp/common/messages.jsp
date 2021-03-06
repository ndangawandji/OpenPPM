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
<%@page import="es.sm2.openppm.common.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@page import="es.sm2.openppm.exceptions.LogicException"%>

<c:choose>
	<c:when test="${locale ne null and not empty locale  }">
		<fmt:setLocale value="${locale}" scope="request"/>
	</c:when>
	<c:otherwise>
		<fmt:setLocale value="<%=Constants.DEF_LOCALE %>" scope="request"/>
	</c:otherwise>
</c:choose>

<c:if test="${error != null }">
	<div id="errorJava" style="margin-bottom: 10px; padding: 0pt 0.7em;" class="ui-state-error ui-corner-all"> 
		<p>
			<span style="float: left; margin-right: 0.3em;" class="ui-icon ui-icon-alert"></span> 
			<strong><fmt:message key="msg.error"/>: </strong>
			<img src="images/reject.png" style="float:right; margin-right:10px;" onclick="hide('errorJava');" class="link">
		</p>
		<p>${error}</p>
	</div>
</c:if>

<div id="loading-ajax" class="hide">
    <div class="x-dlg-hd"><fmt:message key="msg.processing"/></div>
	<div class="x-dlg-bd">
		<div class="x-dlg-tab" title="">
			<div class="ui-autocomplete-loading" style="font-size:1.25em; font-weight:800;"><fmt:message key="msg.please_wait"/></div>
		</div>
	</div>
</div>

<script type="text/javascript">
$('#loading-ajax').dialog({ autoOpen: true, resizable: false, height: 100, width: 200, modal: true, closeOnEscape: false });

var cuentaAtrasTime = <%=Constants.TIME_SESSION%>; // In minutes
var adviseSessionTime = <%=Constants.TIME_SESSION_ADVISE%>; // In minutes
var timerSesion;
function closeSesion() {
	location.href="./login?accion=logoff";
}
function alertCloseSesion() {
	v_cuentaAtrasTime = cuentaAtrasTime;
	cuentaAtras();
	$('#page-timeout').show('fast');
	timerAlertSesion = setTimeout("closeSesion()", cuentaAtrasTime*60*1000);
}
function enlargeSesion() {
	clearTimeout(timerAlertSesion);
	clearTimeout(timerSesion);
	
	$.ajax({ url: '<%=UtilServlet.REFERENCE%>', dataType: 'json', data: ({ accion: "ajax-enlarge-session" }) });
	
	$('#page-timeout').hide('fast');
	timerSesion = setTimeout("alertCloseSesion()", adviseSessionTime*60*1000);
	
	return false;
}
function cuentaAtras() {
	$('#session-time-expire').attr('value', v_cuentaAtrasTime);
	v_cuentaAtrasTime--;
	setTimeout("cuentaAtras()", 60*1000); // Refresh minutes
}

var isVisible = false;
var infoTimer;
function informationSuccessReq() {
	isVisible = true;
	$("#information_success").show('clip');
	infoTimer = setTimeout("informationSuccessHide()",(<%=Constants.INFO_TIME_DEFAULT%>*1000));
}
function informationSuccess(msg, secons) {
	
	secons = secons || 0;
	var timeOut = (secons > <%=Constants.INFO_TIME_DEFAULT%>?secons:<%=Constants.INFO_TIME_DEFAULT%>);
	var info = $("#information_success_msg").html();
	
	if (typeof msg === 'object' && msg.length) {
		$(msg).each(function() {$("#information_success_msg").append('<li>'+this+'</li>');});
	}
	else {
		$("#information_success_msg").append('<li>'+msg+'</li>');
	}
	
	if (info == '') {
		isVisible = true;
		$("#information_success").show('scale');
	}
	
	clearTimeout(infoTimer);
	infoTimer = setTimeout("informationSuccessHide()",(timeOut*1000));
}
function informationSuccessHide() {
	if (isVisible) {
		isVisible = false;
		$("#information_success").hide('scale');
	}
	$("#information_success_msg").html('');
}

function loadingPopup() { $('#loading-ajax').dialog('open'); }

readyMethods.add(function() {
	
	timerSesion = setTimeout("alertCloseSesion()", adviseSessionTime*60*1000);
	
	$('#dialog-confirm').dialog({ autoOpen: false, modal: true });
	$('#dialog-error').dialog({ autoOpen: false, modal: true });
	$('#dialogConfirmText').dialog({ autoOpen: false, modal: true, width:500 });
	
	if($('#loading-ajax').dialog('isOpen')) {
		$('#loading-ajax').dialog('close');
	}
	<%if (request.getAttribute("information") != null) { %>
		informationSuccessReq();
	<%}%>
});
</script>

<div id="dialog-error" class="hide">
	<p>
		<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
	</p>
	<p id="dialog-error-msg"></p>
</div>

<div id="dialog-confirm" class="hide">
	<p>
		<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
	</p>
	<p id="dialog-confirm-msg"></p>
</div>
<div id="dialogConfirmText" class="hide">
	<p>
		<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span>
	</p>
	<p id="dialogConfirmTextMsg"></p>
	<div>
		<textarea style="width: 95%" id="textInfoPopup" class="campo" rows="5"></textarea>
	</div>
</div>
