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
import java.util.ArrayList;
import java.util.List;

public class ChartStacked {
	private String yAxisName;
	private String rotateNames;
	private String showColumnShadow;
	private String caption;
	private String decimalPrecision;
	private String numDivLines;
	private String showValues;
	private List<String> categories = new ArrayList<String>();
	private List<ChartDataSet> dataSets = new ArrayList<ChartDataSet>();
	private String showLegend;
	
	
	/**
	 * Initialize parameters
	 * @param yAxisName
	 * @param caption
	 */
	
	public ChartStacked(String yAxisName, String caption) {
		this.yAxisName = yAxisName;
		this.rotateNames = "1";
		this.showColumnShadow = "0";
		this.caption = caption;
		this.decimalPrecision = "1";
		this.numDivLines = "6";
		this.showValues = "1";
		this.showLegend = "1";
	}

	/**
	 * @return the categories
	 */
	public List<String> getCategories() {
		return categories;
	}

	/**
	 * @param categories the categories to set
	 */
	public void setCategories(List<String> categories) {
		this.categories = categories;
	}

	/**
	 * @return the yAxisName
	 */
	public String getYAxisName() {
		return yAxisName;
	}

	/**
	 * @return the rotateNames
	 */
	public String getRotateNames() {
		return rotateNames;
	}

	/**
	 * @return the showColumnShadow
	 */
	public String getShowColumnShadow() {
		return showColumnShadow;
	}

	/**
	 * @return the caption
	 */
	public String getCaption() {
		return caption;
	}

	/**
	 * @return the decimalPrecision
	 */
	public String getDecimalPrecision() {
		return decimalPrecision;
	}

	/**
	 * @return the numDivLines
	 */
	public String getNumDivLines() {
		return numDivLines;
	}

	/**
	 * @return the showValues
	 */
	public String getShowValues() {
		return showValues;
	}

	/**
	 * @param dataSets the dataSets to set
	 */
	public void setDataSets(List<ChartDataSet> dataSets) {
		this.dataSets = dataSets;
	}

	public void setYAxisName(String yAxisName) {
		this.yAxisName = yAxisName;
	}

	public void setRotateNames(String rotateNames) {
		this.rotateNames = rotateNames;
	}

	public void setShowColumnShadow(String showColumnShadow) {
		this.showColumnShadow = showColumnShadow;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}

	public void setDecimalPrecision(String decimalPrecision) {
		this.decimalPrecision = decimalPrecision;
	}

	public void setNumDivLines(String numDivLines) {
		this.numDivLines = numDivLines;
	}

	public void setShowValues(String showValues) {
		this.showValues = showValues;
	}

	public void addCategory(String category) {
		this.categories.add(category);
	}

	public List<ChartDataSet> getDataSets() {
		return dataSets;
	}

	public void addDataSet(ChartDataSet dataSet) {
		this.dataSets.add(dataSet);
	}
	
	/**
	 * Creating the xml needed to chart
	 * @param double1 
	 * @return Xml Chart
	 */
	public String generateXML(Double maxValue) {
		StringBuilder dataXML = new StringBuilder();
		
		dataXML.append(
				"<graph yAxisName=\""+yAxisName+"\" formatNumberScale=\"0\" showhovercap=\"0\" rotateNames=\""+rotateNames+
				"\" showColumnShadow=\""+showColumnShadow+"\" caption=\""+caption+"\" decimalPrecision=\""+decimalPrecision
				+"\" yAxisMaxValue=\""+maxValue+"\" numDivLines=\""+numDivLines+"\" showValues=\""+showValues+"\"  showLegend='"+showLegend+"'><categories>");
		
		for (String category : categories) {
			dataXML.append("<category name=\""+category+"\"/>");
		}
		
		dataXML.append("</categories>");
			
		for (ChartDataSet dataSet : dataSets) {
			dataXML.append(
					"<dataset seriesName=\""+dataSet.getSeriesName()+"\" color=\""+dataSet.getColor()+
					"\" showValues=\""+dataSet.getShowValues()+"\" alpha=\""+dataSet.getAlpha()+"\" >");
			
			for (String set : dataSet.getListValues()) {
				dataXML.append("<set value=\""+set+"\"/>");
			}
			
			dataXML.append("</dataset>");
		}
		
		dataXML.append("</graph>");
		
		return dataXML.toString();
	}

	public void setShowLegend(String showLegend) {
		this.showLegend = showLegend;
	}

	public String getShowLegend() {
		return showLegend;
	}
}
