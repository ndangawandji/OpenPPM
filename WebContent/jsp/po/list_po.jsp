<%--
 - Author : Cédric Ndanga.
 - Created 29/06/2015
 - Openppm versius Devoteam, user story 17
--%>

<%@page import="es.sm2.openppm.utils.SecurityUtil" %>
<%@page import="es.sm2.openppm.servlets.PurchaseorderServlet" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored ="false"%>

<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@taglib uri="Utilidades" prefix="tl" %>

<fmt:setLocale value="${locale}" scope="request"/>

<fmt:message key="purchaseorder.new_purchase" var="new_purchase_order" />
<c:set var="btnCreate"><fmt:message key="purchaseorder.btn_create" /></c:set>

<script type="text/javascript" >
var purchaseOrderTable;
var poAjax = new AjaxCall('<%=PurchaseorderServlet.REFERENCE%>','<fmt:message key="error" />');

function newPurchaseOrder() {
	$('div#po-popup legend').html('${new_purchase_order}');
	$('div#po-popup').dialog('open');
}

function deletePO() {
	
}

readyMethods.add(function () {
	
	purchaseOrderTable = $('#tb_po').dataTable({
		"sDom": 'T<"clear">lfrtip',
		"oLanguage": datatable_language,
		"bInfo": false,
		"iDisplayLength": 50,
		"sPaginationType": "full_numbers",
		"oTableTools": {
			"sRowSelect": "multi",
			"aButtons": [
	             {
	            	 "sExtends" : "text",
	            	 "sButtonText" : "${btnCreate}", 
	            	 "fnClick" : function createPurchaseOrder(nButton, oConfig, oFlash) { newPurchaseOrder(); }
	             }  
             ]
		},
		"aoColumns": [ 
            { "sClass": "center" },
            { "sClass": "left", "bSortable": true },
            { "sClass": "right", "bSortable": true },
            { "sClass": "center", "bSortable": true },
            { "sClass": "left", "bSortable": true },
            { "sClass": "center", "bSortable": false}
   		],
		/* "fnDrawCallback": function ( oSettings ) {
            if ( oSettings.aiDisplay.length == 0 ) {return;}
            var nTrs = $('#tb_po tbody tr');
            var iColspan = nTrs[0].getElementsByTagName('td').length;
            var sLastGroup = "";
            for ( var i=0 ; i<nTrs.length ; i++ ) {
                var iDisplayIndex = oSettings._iDisplayStart + i;
                var sGroup = oSettings.aoData[ oSettings.aiDisplay[iDisplayIndex] ]._aData[0];
                if ( sGroup != sLastGroup ) {
                    var nGroup = document.createElement( 'tr' );
                    var nCell = document.createElement( 'td' );
                    nCell.colSpan = iColspan;
                    nCell.className = "groupRow";
                    nCell.innerHTML = sGroup;
                    nGroup.appendChild( nCell );
                    nTrs[i].parentNode.insertBefore( nGroup, nTrs[i] );
                    sLastGroup = sGroup;
                }
            }
        }, */
        "aoColumnDefs": [
			{ "bVisible": true, "aTargets": [ 0 ] }
		],
		//"aaSortingFixed": [[ 0, 'asc' ]],
		//"aaSorting": [[ 2, 'asc' ]]
	});
	
});
</script>

<!-- Form to download a file -->
<form name="frm_po_dvt" id="frm_po_dvt" method="post"> 
	<input type="hidden" name="accion" value="" />	
	<input type="hidden" id="idDocument" name="idDocument" />

	<fieldset style="margin-bottom: 15px; padding-top: 10px; padding-bottom: 5px;">
		<div class="hColor">
			<table id="tb_po" class="tabledata" cellspacing="1" width="100%">
				<thead>
					<tr>
						<th width="10%"><fmt:message key="purchaseorder.reference" /></th>
				    	<th width="30%"><fmt:message key="purchaseorder.name" /></th>
				    	<th width="15%"><fmt:message key="purchaseorder.cost" /></th>
				    	<th width="12%"><fmt:message key="purchaseorder.reception_date" /></th>
				    	<th width="28%"><fmt:message key="purchaseorder.customer" /></th>
				    	<th width="5%"></th>
			  		</tr>
				</thead>
				<tbody>
					<c:forEach var="purchaseOrder" items="${purchaseOrders}">
						<tr>
							<td>${purchaseOrder.purchaseRef}</td>
			    			<td>${purchaseOrder.purchaseName}</td>
			    			<td>${purchaseOrder.purchaseCost}</td>
			    			<td><fmt:formatDate value="${purchaseOrder.receptionDate}" pattern="${datePattern}" /></td>
			    			<td>${purchaseOrder.customer.name}</td>
			    			<td><img src="images/delete.jpg" alt="<fmt:message key="delete" />" title="<fmt:message key="delete" />" class="ico link" onclick="deletePO()"></td>
			  			</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</fieldset>
<%-- <jsp:include page="common/filter_investment.jsp" flush="true"> --%>
<%-- 	<jsp:param value="investmentsTable" name="table"/> --%>
<%-- </jsp:include> --%>


</form>

<jsp:include page="edit_po_popup.jsp" flush="true" />

 