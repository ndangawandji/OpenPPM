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

/**
 * For call functions in one document ready
 */
$(document).ready(function() {

	$('#loading-ajax').ajaxStart(function(m) {
	  $(this).dialog('open');
	});

	$('#loading-ajax').ajaxStop(function() {
		if($(this).dialog('isOpen')) {
			$(this).dialog('close');
		}
	});
		
	// Execute all methods
	readyMethods.execute();
	
	setTextImporteEvents();
	setTextNumberOnlyEvents();
	
	// All a tags with class button are JQuery.Button
	$("a.boton, button.boton, button.DTTT_button, input[type=submit]").button();
	
	// Show fieldSet in cookie
	if ($.cookie('openppm.fieldSetCookieShow') != null) {
		$($.cookie('openppm.fieldSetCookieShow')).show();
		
		var aField = $.cookie('openppm.fieldSetCookieShow').split(",");
		for (var i = 0;i < aField.length; i++) {
			$(aField[i]+'Btn').attr('src','images/ico_menos.gif'); 
		}
	}
	
	//Para dar formato a todos los input file
	SI.Files.stylizeAll();
});
/*********************************************/
var console;
if (typeof console === 'undefined') {
	
	Console = function() { this.type = 'Debug IE'; };
	Console.prototype.log = function(value) {
		
		if (typeof alertUI === 'function') { alertUI('Debug: '+typeof value,value); }
		else { alert('Debug: '+typeof value +' - '+value); }
	};
	console = new Console();
}

function show(id) { $("#"+id).show('fast'); }
function hide(id) { $("#"+id).hide('fast'); }
function changeCookie(id, element) {
	if ($("#"+id).is(":visible")) {
		hideCookie(id);
		if (typeof element !== 'undefined') { $(element).attr('src','images/ico_mas.gif'); }
		else { $("#"+id+"Btn").attr('src','images/ico_mas.gif'); }
	}
	else {
		showCookie(id);
		if (typeof element !== 'undefined') { $(element).attr('src','images/ico_menos.gif'); }
		else { $("#"+id+"Btn").attr('src','images/ico_menos.gif'); }
	}
}
function changeIco(id, element, auxiliarFunction) {
	if ($("#"+id).is(":visible")) {
		hide(id);
		if (typeof element !== 'undefined' && element !== 'legend') { $(element).attr('src','images/ico_mas.gif'); }
		else { $("#"+id+"Btn").attr('src','images/ico_mas.gif'); }
	}
	else {
		show(id);
		if (typeof auxiliarFunction === 'function') { auxiliarFunction(); }
		if (typeof element !== 'undefined' && element !== 'legend') { $(element).attr('src','images/ico_menos.gif'); }
		else { $("#"+id+"Btn").attr('src','images/ico_menos.gif'); }
	}
}
function showCookie(id) {
	if (id != null) {
		id = '#'+id;
		var ids = $.cookie('openppm.fieldSetCookieShow');
		if (ids != null) {
			ids = ids.split(',');
			var insert = true;
			$(ids).each(function() { if (this == id) { return insert = false; } });
			if (insert) { ids.push(id); }
		}
		else { ids = id; }
		$.cookie('openppm.fieldSetCookieShow',ids, { expires: 365 });
		$(id).show('fast');
	}
}

function hideCookie(id) {
	if (id != null) {
		id = '#'+id;
		var ids = $.cookie('openppm.fieldSetCookieShow');
		if (ids != null) {
			ids = ids.split(',');
			$(ids).each(function(i) { if (this == id) { return ids.splice(i,1);} });
		}
		if (ids != null && ids.length > 0) { $.cookie('openppm.fieldSetCookieShow',ids, { expires: 365 });	}
		else { $.cookie('openppm.fieldSetCookieShow',null);}
	}
	$(id).hide('fast');
}

/**
 * Objeto genérico para llamadas de Ajax
 * @param _url
 * @param _msgError
 * @returns
 */
function AjaxCall(_url,_titleError,_type, _typeMethod) {
	this.url = _url || "";
	this.dataType = (typeof _type === 'undefined'?"json":_type);
	this.typeMethod = (typeof _typeMethod === 'undefined'?"POST":_typeMethod);
	this.titleError = (typeof _titleError === 'undefined'?"Error":_titleError);
	this.msgError = "Puede deberse ha que se ha perdido la sesion";
	this.msgParse = "El objeto obtenido esta mal formado";
}
AjaxCall.prototype.call = function(parametros,_success,_dataType) {
	
	var thiss = this;
	var dataType = (typeof _dataType === 'undefined'?thiss.dataType:_dataType);
	$.ajax({
		url: thiss.url,
		dataType: dataType,
		type: thiss.typeMethod,
		data: (parametros),
		success: function (data) {
			if (typeof data === 'undefined' || data == null) { alertUI(thiss.titleError,'Comunication refused'); }
			else if (typeof data.error === 'string') {alertUI(thiss.titleError,data.error);}
			else {
				try {
					if (typeof data.information !== 'undefined') {informationSuccess(data.information);}
					if (typeof _success === 'function'){ _success(data); };
				}
				catch(errorSuccess) {
					alertUI(thiss.titleError,'<b>'+errorSuccess+'</b><br><br>Function:<br>'+_success);
				}
			}
		},
		error: function(jqXHR, textStatus,errorThrown) {
			var message = (typeof errorThrown !== 'undefined'?errorThrown.message:(textStatus == 'parsererror'?thiss.msgParse+ ': ('+errorThrown+')':thiss.msgError));
			alertUI(thiss.titleError,message);
		}
	});
};


function toCurrency(num) {
	
	num = num+'';
	
	if (typeof num !== 'undefined' && num != '') {
		
		var sign;
		var cents;
		var i;
	
		//num = num.toString().replace(/\$|\,/g, '.');
		if (isNaN(num)) {
			num = "0";
		}
	
		sign = (num == (num = Math.abs(num)));
		num = Math.floor(num * 100 + 0.50000000001);
		cents = num % 100;
		num = Math.floor(num / 100).toString();
		if (cents < 10) {
			cents = '0' + cents;
		}
		for (i = 0; i < Math.floor((num.length - (1 + i)) / 3); i++) {
			num = num.substring(0, num.length - (4 * i + 3)) + '.' + num.substring(num.length - (4 * i + 3));
		}
		return (((sign) ? '' : '-') + num + ',' + cents);
	}
	return '';
}

function toNumber(currencyNum) {
	
	currencyNum = currencyNum.toString().replace(/\./g,"");
	currencyNum = currencyNum.toString().replace(/\,/g,".");

	if (isNaN(currencyNum)) {
		currencyNum = "0";
	}
	
	return currencyNum;
}

function selectMultiple(prefix, name) {
	if ($.cookie(prefix+name) != null) {
		
		var values = ($.cookie(prefix+name)).split(',');
		if (values.length > 0) {
			for (var i = 0; i < values.length;i++) {
				$("#"+name+" option[value="+values[i]+"]").attr('selected', 'selected');
			}
		}
		
	}
}

function escape(value) {
	if (value == null) {
		return '';
	}
	if(typeof value == "string") {
		value = value.replace(/&/g,"&amp;");
		value = value.replace(/</g,"&lt;");
		value = value.replace(/>/g,"&gt;");
		value = value.replace(/"/g,'&#034;');
		value = value.replace(/'/g,"&#039;");
		value = value.replace(/€/g,"&euro;");
	}
	return value;
}

function unEscape(value) {
	if (value == null) {
		return '';
	}
	
	if(typeof value == "string") {
		value = value.replace(/&amp;/g,"&");
		value = value.replace(/&lt;/g,"<");
		value = value.replace(/&gt;/g,">");
		value = value.replace(/&#034;/g,'"');
		value = value.replace(/&#039;/g,"'");
		value = value.replace(/&euro;/g,"€");	
	}	

	return value;
}

/****************** Eventos ***********************/

function setTextNumberOnlyEvents() {
	
	var $numbers = $('input:text.number');
	$numbers.attr("autocomplete","off");
	
	$numbers.bind({
		keydown: function(event) {
			if (!(((event.which == 67 || event.which == 86) && event.ctrlKey) || event.which == 46 || event.which == 8  || event.which == 9 || event.which == 37 || event.which == 39) &&
					!((event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105))) {

	                event.preventDefault();
	        }
		}
	});
}
function setTextImporteEvents() {
	
	var $importes = $('input:text.importe');
	
	// Todos los input de clase importe, deshabilitar el autocompletado
	$importes.attr("autocomplete","off");
	
	$importes.each(function() {
		$(this).val(toCurrency($(this).val()));
	});
	
	$importes.bind({
		
		keydown: function(event) {

			if (event.which == 110 || event.which == 190) {
				
				if ($(this).val().indexOf('.') != -1)  { event.preventDefault(); }
			}
			else if (($(this).hasClass('negativo') && event.which == 109)) {
				
				if ($(this).val().indexOf('-') != -1)  { event.preventDefault(); }
			}
			else if (!(((event.which == 67 || event.which == 86) && event.ctrlKey) || event.which == 46 || event.which == 8  || event.which == 9 || event.which == 37 || event.which == 39) &&
					!((event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105))) {

	                event.preventDefault();
	        }
		},
		
		focus: function(event) {
			if (!$(this).attr("readonly")) {
				this.value=toNumber(this.value);
			}
		},
		
		blur: function(event) {
			if (!$(this).attr("readonly")) {
				this.value=toCurrency(this.value);
			}
		}
	});
}
