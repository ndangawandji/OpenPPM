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

import java.util.List;

public class ChartMSArea2DDataset extends ChartDataSet {

	private String showAreaBorder;
	private String areaBorderColor;
	
	public ChartMSArea2DDataset() {
		super();
	}
	
	/**
	 * @param seriesName
	 * @param color
	 * @param showValues
	 * @param alpha
	 * @param listValues
	 */
	public ChartMSArea2DDataset(String seriesName, String color,
			String showValues, String alpha, List<String> listValues,
			String showAreaBorder, String areaBorderColor) {
		super(seriesName, color, showValues, alpha, listValues);
		this.showAreaBorder = showAreaBorder;
		this.areaBorderColor = areaBorderColor;
	}

	/**
	 * @param seriesName
	 * @param color
	 * @param showValues
	 */
	public ChartMSArea2DDataset(String seriesName, String color,
			String showValues) {
		super(seriesName, color, showValues);
	}

	/**
	 * @return the showAreaBorder
	 */
	public String getShowAreaBorder() {
		return showAreaBorder;
	}
	/**
	 * @param showAreaBorder the showAreaBorder to set
	 */
	public void setShowAreaBorder(String showAreaBorder) {
		this.showAreaBorder = showAreaBorder;
	}
	/**
	 * @return the areaBorderColor
	 */
	public String getAreaBorderColor() {
		return areaBorderColor;
	}
	/**
	 * @param areaBorderColor the areaBorderColor to set
	 */
	public void setAreaBorderColor(String areaBorderColor) {
		this.areaBorderColor = areaBorderColor;
	}
	
	
	
}
