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

public class ChartLine extends AbstractChart {
	
	static final Logger LOGGER = Logger.getLogger(ChartLine.class);
	
	private List<ChartElements> elements = new ArrayList<ChartElements>();
	private String color;
	private String caption;
	private String formatNumberScale;
	
	
	public ChartLine(ResourceBundle idioma) throws ParserConfigurationException {
		super(idioma);
		this.color = "688BB4";
		this.formatNumberScale = "1";
	}
	
	public ChartLine(ResourceBundle idioma, String caption, String color, String formatNumberScale) throws ParserConfigurationException {
		super(idioma);
		this.caption = caption;
		this.color = color;
		this.formatNumberScale = formatNumberScale;
	}
	
	public void addElement(String name, String value) {
		
		ChartElements set = new ChartElements(name, value);
		this.elements.add(set);
	}
	
	@Override
	public void createXML() {
		
		Element root = getDocument().createElement("graph");
		
		if (caption != null) { root.setAttribute("caption",		caption); }
		
		root.setAttribute("xAxisName",			getIdioma().getString("days"));
		root.setAttribute("yAxisName",			"");
		root.setAttribute("showNames",			"1");
		root.setAttribute("lineColor",			this.color);
		root.setAttribute("animation",			"1");
		root.setAttribute("showValues",			"1");
		root.setAttribute("rotateNames",		"0");
		root.setAttribute("divLineColor",		this.color);
		root.setAttribute("divLineAlpha",		"30");
		root.setAttribute("baseFontColor",		"000000");
		root.setAttribute("decimalPrecision",	"2");
		root.setAttribute("decimalSeparator",	",");
		root.setAttribute("showColumnShadow",	"1");
		root.setAttribute("canvasBorderColor",	"000000");
		root.setAttribute("formatNumberScale",	formatNumberScale);
		root.setAttribute("thousandSeparator",		".");
		root.setAttribute("AlternateHGridColor",	this.color);
		root.setAttribute("alternateHGridAlpha", 	"8");
		root.setAttribute("showAlternateHGridColor","1");

		getDocument().appendChild(root);
		
		for(ChartElements set : this.elements) {
			
			Element child = createChild(set.getName(), set.getValue());
			root.appendChild(child);
		}
	}
	
	/**
	 * Create child node
	 * @param name
	 * @param value
	 * @return
	 */
	private Element createChild(String name, String value) {
		
		Element child = getDocument().createElement("set");
		child.setAttribute("name", name);
		child.setAttribute("value", value);
		
		return child;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getColor() {
		return color;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public String getCaption() {
		return caption;
	}

	public void setFormatNumberScale(String formatNumberScale) {
		this.formatNumberScale = formatNumberScale;
	}

	public String getFormatNumberScale() {
		return formatNumberScale;
	}
}
