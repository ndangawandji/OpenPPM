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

import org.apache.log4j.Logger;
import org.w3c.dom.Element;

public class ChartMSLine extends AbstractChart {
	
	static final Logger LOGGER = Logger.getLogger(ChartMSLine.class);
	
	private List<ChartDataSet> dataSets = new ArrayList<ChartDataSet>();
	protected List<String> categories = new ArrayList<String>();
	private String caption;
	
	public ChartMSLine(ResourceBundle idioma) throws ParserConfigurationException {
		super(idioma);
	}
	
	public void addCategory(String value) {
		
		this.categories.add(value);
	}
	
	public void addDataSet(ChartDataSet dataSet) {
		
		this.dataSets.add(dataSet);
	}
	
	@Override
	public void createXML() {
		
		Element root = getDocument().createElement("graph");
		
		if (caption != null) {root.setAttribute("caption", caption); }
		root.setAttribute("yaxismaxvalue",		"10");
		root.setAttribute("formatNumberScale",	"0");
		root.setAttribute("showLegend",			"1");
		root.setAttribute("showHoverCap",		"1");
		root.setAttribute("decimalPrecision",	"1");
		root.setAttribute("showValues",			"1");
		root.setAttribute("animation",			"1");
		root.setAttribute("numDivLines",		"3");
		root.setAttribute("numVDivLines",		"0");
		root.setAttribute("lineThickNess",		"3");
		root.setAttribute("rotateNames",		"0");
		
		getDocument().appendChild(root);
		
		// Create All categories
		Element categories = getDocument().createElement("categories");
		
		for (String value : this.categories) {
			Element category = createCategory(value);
			categories.appendChild(category);
		}
		root.appendChild(categories);
		
		// Create datasets
		for (ChartDataSet ds : dataSets) {
			
			Element dataset = getDocument().createElement("dataset");
			dataset.setAttribute("seriesName",	ds.getSeriesName());
			dataset.setAttribute("color",		ds.getColor());
			dataset.setAttribute("showValues",	ds.getShowValues());
			
			for (String value : ds.getListValues()) {
				
				Element set = createSet(value);
				dataset.appendChild(set);
			}
			
			root.appendChild(dataset);
		}
	}
	
	private Element createCategory(String value) {
		
		Element child = getDocument().createElement("category");
		child.setAttribute("name", value);
		
		return child;
	}
	
	private Element createSet(String value) {
		
		Element child = getDocument().createElement("set");
		child.setAttribute("value", value);
		
		return child;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public String getCaption() {
		return caption;
	}
}
