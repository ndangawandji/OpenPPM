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

import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Element;

public class StackedColumn2D extends AbstractChart {

	private List<String> categories		= new ArrayList<String>();
	private List<ChartDataSet> dataSets = new ArrayList<ChartDataSet>();
	private String yAxisMaxValue;
	private String yAxisName;
	private String caption;
	
	public StackedColumn2D(ResourceBundle idioma)
	throws ParserConfigurationException {
		super(idioma);
		this.yAxisMaxValue = "5";
	}
	
	@Override
	public void createXML() {
		
		Element root = getDocument().createElement("graph");
		
		if (yAxisName != null) { root.setAttribute("yAxisName",	yAxisName); }
		if (caption != null) { root.setAttribute("caption",		caption); }
		
		root.setAttribute("formatNumberScale",	"0");
		root.setAttribute("showhovercap",		"0");
		root.setAttribute("rotateNames",		"1");
		root.setAttribute("showColumnShadow",	"1");
		root.setAttribute("decimalPrecision",	"1");
		root.setAttribute("yAxisMaxValue",		yAxisMaxValue);
		root.setAttribute("numDivLines",		"6");
		root.setAttribute("showValues",			"1");
		root.setAttribute("showLegend",			"1");

		getDocument().appendChild(root);
		
		Element categories = getDocument().createElement("categories");
		
		for(String name : this.categories) {
			
			Element category = getDocument().createElement("category");
			category.setAttribute("name", name);
			
			categories.appendChild(category);
		}
		root.appendChild(categories);
		
		for (ChartDataSet dataSet : dataSets) {
			
			Element dataset = getDocument().createElement("dataset");
			dataset.setAttribute("seriesName", dataSet.getSeriesName());
			dataset.setAttribute("color", dataSet.getColor());
			dataset.setAttribute("showValues", dataSet.getShowValues());
			dataset.setAttribute("alpha", dataSet.getAlpha());
			
			for (String value : dataSet.getListValues()) {
				
				Element set = getDocument().createElement("set");
				set.setAttribute("value", value);
				
				dataset.appendChild(set);
			}
			root.appendChild(dataset);
		}
		
	}
	
	public void addDataSet(ChartDataSet dataSet) {
		this.dataSets.add(dataSet);
	}
	
	public void addCategory(String category) {
		this.categories.add(category);
	}

	public void setCategories(List<String> categories) {
		this.categories = categories;
	}

	public List<String> getCategories() {
		return categories;
	}
	
	public String getyAxisMaxValue() {
		return yAxisMaxValue;
	}

	public void setyAxisMaxValue(String yAxisMaxValue) {
		this.yAxisMaxValue = yAxisMaxValue;
	}
}
