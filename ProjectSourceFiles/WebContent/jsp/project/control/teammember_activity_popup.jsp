<%------------------------------------------------------------------------------
 -  Customisation effectuer par Devoteam 
 - 
 -  Authors : xavier de Langautier
 -  Date : 2015/06/01
 - Popup qui affiche les assignements d'une activite par teammember
------------------------------------------------------------------------------%>
<%@page import="es.sm2.openppm.model.Teammember"%>   
<%@page import="es.sm2.openppm.model.Projectactivity"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<%@page import="es.sm2.openppm.servlets.ProjectControlServlet"%>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="error" var="fmt_error" />

<%-- Message for validations --%>
<fmt:message key="maintenance.error_msg_a" var="fmtEVRequired">
	<fmt:param><b><fmt:message key="activity.earned_value"/></b></fmt:param>
</fmt:message>
<fmt:message key="msg.error.max_value" var="fmtEVMax">
	<fmt:param><b><fmt:message key="activity.earned_value"/></b></fmt:param>
	<fmt:param>&nbsp;</fmt:param>
</fmt:message>

<script type="text/javascript">
function closeTeamMemberActivity() {
	$('div#teammember-activity-popup').dialog('close');
}


readyMethods.add(function() {
	$('div#teammember-activity-popup').dialog({
		autoOpen: false, 
		modal: true, 
		width: 600,
		resizable: false
	});
});

</script>

<div id="teammember-activity-popup" class="popup">

	<div id="teammember-activity-errors" class="ui-state-error ui-corner-all hide">
		<p>
			<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
			<strong><fmt:message key="msg.error_title"/></strong>
			&nbsp;(<b><span id="teammember-activity-numerrors"></span></b>)
		</p>
		<ol></ol>
	</div>

<%-- 	<form name="frm_teammember_activity" id="frm_teammember_activity" action="<%=ProjectControlServlet.REFERENCE%>" method="post"> --%>
	<form name="frm_teammember_activity" id="frm_teammember_activity" >
	
		<input type="hidden" name="id" value="" />
		<input type="hidden" name="accion" value="" />
		<input type="hidden" name="activity_id" value="" />
		
		<fieldset>
			<legend><fmt:message key="view_activity" /></legend>
	
			<table border="0" cellpadding="2" cellspacing="1" width="100%">
				<tr>
					<th class="left" colspan="2"><fmt:message key="activity.name" /></th>					
				</tr>
				<tr>
					<td colspan="2"><input type="text" id= "projectactivity_name" name="projectactivity_name" class="campo" readonly="readonly"/></td>
				</tr>
			</table>
				<table id="teammember_activity" class="tabledata" cellspacing="1" width="100%">   <!-- ajout pour tbody dynamique -->
					<thead>
					<tr>
						<th class="center" width="25%"><fmt:message key="team_member" /></th>
						<th class="center" width="25%"><fmt:message key="team_member.date_in" /></th>
						<th class="center" width="25%"><fmt:message key="team_member.date_out" /></th>
						<th class="center" width="25%"><fmt:message key="team_member.remaining_workload" /></th>
						<th class="center" width="20%"><fmt:message key="team_member.workload" /></th> 				
					</tr>
					</thead>
				    <tbody></tbody>    <%--   Insertion des valeurs dynamiquement --%>
    		</table>
    	</fieldset>
    	<div class="popButtons">
    		<a href="javascript:closeTeamMemberActivity();" class="boton"><fmt:message key="close"/></a>
    	</div>
    </form>
</div>
