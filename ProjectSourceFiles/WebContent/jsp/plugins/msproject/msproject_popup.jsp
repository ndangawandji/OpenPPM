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

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="yes" var="fmtYes"/>
<fmt:message key="no" var="fmtNo"/>
<fmt:message key="msg.confirm" var="fmtConfirm"/>

<script type="text/javascript">
<!--

function executeMSP() {
	$('#search-file-popup').dialog('close');
	loadingPopup();
	document.frm_file.submit();
}

function closeFilePop() { $("#search-file-popup").dialog('close'); }
function acceptMpp() {
	if (!$("#btnAcceptMpp" ).button( "option", "disabled")) {
		confirmUI('${fmtConfirm}',msgConfirm,'${fmtYes}','${fmtNo}', executeMSP)
	}
}

readyMethods.add(function() {

	$("#search-file-popup").dialog({
		autoOpen: false, width: 400,
		resizable: false, modal: true,
		height: 120,
		open: function() {
			$('#file').val('');
			$('#file_path').val('');
			$("#btnAcceptMpp" ).button( "option", "disabled", true );
		}
	});
	
	$('#file').change(function() {
		$('#file_path').val($(this).val());
		$("#btnAcceptMpp" ).button( "option", "disabled", false );
	});
});

//-->
</script>

<div id="search-file-popup" title="<fmt:message key="select_msproject" />" class="popup">
	<form name="frm_file"  id="frm_file" method="POST" enctype="multipart/form-data" >
		<input type="hidden" name="pluginAccion" value="" />
		<input type="hidden" id="id" name="id" value="" />
		<fieldset style="padding: 10px;">
	 		<input type="text" name="file_path" id="file_path" class="campo" style="width: 305px;" readonly />
			<label class="file_change" style="margin-right:5px; *margin-top: -15px !important;">
		 		<input type="file" id="file" name="file" class="file" style="width: 0;"/>
			</label>
		</fieldset>
	</form>
	<div class="popButtons">
		<a id="btnAcceptMpp" href="javascript:acceptMpp();" class="boton"><fmt:message key="accept" /></a>
		<a href="javascript:closeFilePop();" class="boton"><fmt:message key="cancel" /></a>
	</div>
</div>
