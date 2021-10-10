/*******************************************************************************
 *  Copyright (C) 2009-2012 SM2 BALEARES
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *  
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *  See the GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see http://www.gnu.org/licenses/.
 * 
 *  For more information, please contact SM2 BALEARES.
 *  Mail: info@open-ppm.org
 *  Web: http://www.talaia-openppm.es/
 * 
 *  Authors : Javier Hernandez Castillo, Daniel Casas Lopez
 ******************************************************************************/

$.fn.dataTableExt.oApi.fnFindData = function (oSettings, value, iCol) {
	
	var table = this;
	var i = iCol || 0;
	var rowReturn = null;
	
	$(oSettings.aoData).each(function (){
		
		var row = table.fnGetData( this.nTr);
		if (row[i] == value) { rowReturn = row; return row; }
	});
	return rowReturn;
};

$.fn.dataTableExt.oApi.fnGetSelectedCol = function (oSettings, iCol) {
	var i = iCol || 0;
	var aData = this.fnGetSelectedData();
	if (aData != null) {
		return aData[i];
	}
	return null;
};

$.fn.dataTableExt.oApi.fnGetSelectedsCol = function (oSettings, iCol) {
	var i = iCol || 0;
	var aData = this.fnGetSelectedsData();
	if (aData != null) {
		var columns = '';
		$(aData).each(function (){
			
			columns += (columns == ''?'':',')+this[i];
		});
		return columns;
	}
	return null;
};

$.fn.dataTableExt.oApi.fnGetSelected = function (oSettings) {
	var aReturn = new Array();
	$(oSettings.aoData).each(function (){
		if ($(this.nTr).hasClass('row_selected') || $(this.nTr).hasClass('DTTT_selected') || $(this.nTr).hasClass('selected_internal')) {
			aReturn.push( this.nTr );
		}
	});
	return aReturn;
};

$.fn.dataTableExt.oApi.fnGetSelectedPos = function (oSettings) {
	var selected = this.fnGetSelected();
	if (selected.length > 0) {
		
		return this.fnGetPosition(selected[0]);
	}
	else {
		return null;
	}
};

$.fn.dataTableExt.oApi.fnGetSelectedsData = function () {
	var aReturn = new Array();
	var table = this;
	var anSelected = this.fnGetSelected();
	if (anSelected.length > 0) {
		
		$(anSelected).each(function (){
			
			var aPos = table.fnGetPosition( this );
			aReturn.push(table.fnGetData( aPos ));
		});
		
		return aReturn;
	}
	else {
		return null;
	}
};

$.fn.dataTableExt.oApi.fnGetSelectedData = function () {
	var anSelected = this.fnGetSelected();
	if (anSelected.length > 0) {
		var aPos = this.fnGetPosition( anSelected[0] );
		var aData = this.fnGetData( aPos );
		
		
		
		return aData;
	}
	else {
		return null;
	}
};
$.fn.dataTableExt.oApi.fnRemoveSelected = function (oSettings) {
	
	$(oSettings.aoData).each(function (){
		$(this.nTr).removeClass('row_selected');
	});
};

$.fn.dataTableExt.oApi.fnSetSelectable = function (oSettings,tr, className) {
	
	var classSelected = (typeof className === 'undefined'?'row_selected':className); 
	
	if (!$(tr).hasClass('dataTables_empty')) {
		var selected = !$(tr).hasClass(classSelected);
			
		$(oSettings.aoData).each(function (){
			if (tr != this.nTr) { $(this.nTr).removeClass(classSelected); }
		});

		if (selected) {
			$(tr).addClass(classSelected);
		}
	}
};

$.fn.dataTableExt.oApi.fnAddDataAndSelect = function (oSettings,data) {
	
	var column = this.fnAddData(data);
	var tr = oSettings.aoData[column].nTr;
	this.fnSetSelectable(tr);
	this.fnPageChange('last');
};

$.fn.dataTableExt.oApi.fnDisplayStart = function ( oSettings, iStart, bRedraw )
{
	if ( typeof bRedraw == 'undefined' )
	{
		bRedraw = true;
	}
	
	oSettings._iDisplayStart = iStart;
	oSettings.oApi._fnCalculateEnd( oSettings );
	
	if ( bRedraw )
	{
		oSettings.oApi._fnDraw( oSettings );
	}
};

$.fn.dataTableExt.oApi.fnDeleteSelected = function () {
	
	var row = this.fnGetSelectedPos();
	if (row != null) {
		
		this.fnDeleteRow( row, null, true );
	}
};

$.fn.dataTableExt.oApi.fnUpdateAndSelect = function (oSettings,data,row,int) {
	
	var iStart = oSettings._iDisplayStart;
	var row = (row > 0?row:this.fnGetSelectedPos());
	var int = (int > 0?int:0);
	
	this.fnUpdate(data,row,int);
	
	var tr = oSettings.aoData[row].nTr;
	this.fnSetSelectable(tr);
	this.fnDisplayStart(iStart);
};

$.fn.dataTableExt.oApi.fnUpdateRow = function (oSettings,data,row,int) {
	
	var row = (row > 0?row:this.fnGetSelectedPos());
	var int = (int > 0?int:0);
	
	this.fnUpdate(data,row,int);
};
