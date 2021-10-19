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
package es.sm2.openppm.charts;

/**
 * @author javier.hernandez
 *
 */
public class ChartGanttCategory {
	private String start;
	private String end;
	private String align;
	private String name;
	private String isBold;
	
	public ChartGanttCategory() { 
		this.isBold = "1";
		this.align = "center";
	}
	public ChartGanttCategory(String start, String end, String name) {
		this.start = start;
		this.end = end;
		this.align = "center";
		this.name = name;
		this.isBold = "1";
	}

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getAlign() {
		return align;
	}

	public void setAlign(String align) {
		this.align = align;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIsBold() {
		return isBold;
	}

	public void setIsBold(String isBold) {
		this.isBold = isBold;
	}
}
