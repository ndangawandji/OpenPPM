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

import java.awt.BasicStroke;
import java.awt.Color;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.labels.ItemLabelAnchor;
import org.jfree.chart.labels.ItemLabelPosition;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.labels.StandardCategoryToolTipGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.renderer.category.CategoryStepRenderer;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.ui.RectangleInsets;
import org.jfree.ui.TextAnchor;

import es.sm2.openppm.utils.StringPool;

public class ChartFinancePlan
{

	private List<ChartFinancePlanValues> financeChart = new ArrayList<ChartFinancePlanValues>();
	
	public ChartFinancePlan() throws IOException {	
		super();
	}
 

	/**
	 * Create a data set for a jfreechart
	 * @param idioma 
	 * @param initDate
	 * @param plannedCloseDate
	 * @return Data set
	 * @throws ParseException
	 */
	private CategoryDataset createDataset(ResourceBundle idioma) throws ParseException {
		 
		 DefaultCategoryDataset categorydataset = new DefaultCategoryDataset();
		 
		 double value = 0;
		 
		 for (ChartFinancePlanValues item : financeChart) {
			 
			 value += Double.parseDouble(item.getPlannedAmount());
			 categorydataset.setValue(value, "oneSerie", item.getValue());
		 }
	     return categorydataset;
	 }

	/**.
	 * Define the characteristics of the different components
	 * @param idioma 
	 * @param categorydataset
	 * @return jfreechart
	 * @throws IOException
	 * @throws ParseException
	 */
	private JFreeChart createChart(ResourceBundle idioma, CategoryDataset categorydataset) throws IOException, ParseException {
		 
		
		ItemLabelPosition position = new ItemLabelPosition(ItemLabelAnchor.OUTSIDE10, TextAnchor.CENTER_RIGHT, TextAnchor.CENTER_RIGHT, 0.9);
		
	     CategoryStepRenderer categorysteprenderer = new CategoryStepRenderer(true);
	     categorysteprenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
	     categorysteprenderer.setSeriesItemLabelsVisible(0, true);
	     categorysteprenderer.setSeriesPositiveItemLabelPosition(0, position);
	     
	     categorysteprenderer.setBaseToolTipGenerator(new StandardCategoryToolTipGenerator());
	     
	     CategoryAxis categoryaxis = new CategoryAxis("");

	     categoryaxis.setLowerMargin(0.0D);
	     categoryaxis.setUpperMargin(0.0D);
	     
	     NumberAxis numberaxis = new NumberAxis(StringPool.BLANK);
	     numberaxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
	     numberaxis.setLabelAngle(0.0D);
	     numberaxis.setUpperMargin(0.5D);
	     
	     CategoryPlot categoryplot = new CategoryPlot(categorydataset, categoryaxis, numberaxis, categorysteprenderer);
	     
	     categoryplot.setRangePannable(true);
	     categoryplot.setAxisOffset(new RectangleInsets(5D, 5D, 5D, 5D));
	     categoryplot.setDomainGridlinesVisible(true);
	     categoryplot.setRangeGridlinesVisible(true);
	
	     CategoryStepRenderer rend = (CategoryStepRenderer) categoryplot.getRenderer();
	     rend.setSeriesPaint(0, new Color(104,139,180));
	     rend.setSeriesStroke(0, new BasicStroke(3.0f));
	     JFreeChart jfreechart = new JFreeChart("", categoryplot);
	     
	     return jfreechart;
	}
	 
	/**
	 * Return the chart to treat it in the servlet
	 * @param idioma 
	 * @param initDate
	 * @param plannedCloseDate
	 * @return jfreechart
	 * @throws IOException
	 * @throws ParseException
	 */
	public JFreeChart generateChart(ResourceBundle idioma) throws IOException, ParseException {
		 
		JFreeChart chart = createChart(idioma,createDataset(idioma));
		
		chart.getPlot().setBackgroundPaint(Color.WHITE);
		chart.getLegend().setVisible(false);
		chart.setBackgroundPaint(Color.WHITE);
		
		return chart;
	}
 
    public void addFinancePlan(ChartFinancePlanValues set) {
		this.financeChart.add(set);
	}
    
    public List<ChartFinancePlanValues> getFinanceChart() {
		return financeChart;
	}

	public void setFinanceChart(List<ChartFinancePlanValues> financeChart) {
		this.financeChart = financeChart;
	}

}
