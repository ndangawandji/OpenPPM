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
package es.sm2.openppm.javabean;

import java.io.Serializable;
import java.util.List;

public class FiltroTabla implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer displayStart;
	private Integer displayLength;
	private List<DatoColumna> orden;
	private List<DatoColumna> filtro;
	private boolean infoTable = false;
	
	public FiltroTabla() {
		super();
	}
	
	public FiltroTabla(Integer displayStart, Integer displayLength) {
		super();
		this.displayStart = displayStart;
		this.displayLength = displayLength;
	}


	public FiltroTabla(Integer displayStart, Integer displayLength,
			List<DatoColumna> orden) {
		super();
		this.displayStart = displayStart;
		this.displayLength = displayLength;
		this.orden = orden;
	}


	public FiltroTabla(Integer displayStart, Integer displayLength,
			List<DatoColumna> orden, List<DatoColumna> filtroOR, boolean infoTable) {
		super();
		this.displayStart = displayStart;
		this.displayLength = displayLength;
		this.filtro = filtroOR;
		this.orden = orden;
		this.infoTable = infoTable;
	}
	
	public Integer getDisplayStart() {
		return displayStart;
	}

	public void setDisplayStart(Integer displayStart) {
		this.displayStart = displayStart;
	}

	public Integer getDisplayLength() {
		return displayLength;
	}

	public void setDisplayLength(Integer displayLength) {
		this.displayLength = displayLength;
	}

	public List<DatoColumna> getOrden() {
		return orden;
	}

	public void setOrden(List<DatoColumna> orden) {
		this.orden = orden;
	}

	public List<DatoColumna> getFiltro() {
		return filtro;
	}

	public void setFiltroOR(List<DatoColumna> filtro) {
		this.filtro = filtro;
	}

	public void setInfoTable(boolean infoTable) {
		this.infoTable = infoTable;
	}

	public boolean isInfoTable() {
		return infoTable;
	}

}
