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

<%@page import="es.sm2.openppm.common.Constants"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<c:choose>
	<c:when test="${locale ne null and not empty locale  }">
		<fmt:setLocale value="${locale}" scope="request"/>
	</c:when>
	<c:otherwise>
		<fmt:setLocale value="<%=Constants.DEF_LOCALE %>" scope="request"/>
	</c:otherwise>
</c:choose>

<div style="border-radius: 0 0 5px 5px; width: 1000px; margin: 0pt auto; background-image: url('images/fondo_pagina.gif');" class="center">
	<div style=" width: 982px; margin:0 auto;" class="pie">
		<a href="#" onclick="return aboutPopup();" style="color:white;text-decoration:none;"><fmt:message key="title"></fmt:message> - v<%=Constants.VERSION_APP %></a>
	</div>
</div>
