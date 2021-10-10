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
 * 
 */
package es.sm2.openppm.charts;

/**
 * @author javier.hernandez
 *
 */
public class ChartDataSetPL extends ChartDataSet {

	public ChartDataSetPL(String seriesName, String color,String value1, String value2, String Value3, int type) {
		super();
		
		this.seriesName = seriesName;
		this.color = color;
		this.showValues = "1";
		this.alpha = "100";
		switch (type) {
			case 1: {
				listValues.add(value1);
				listValues.add("0");
				listValues.add("0");
				listValues.add(value2);
				listValues.add("0");
				listValues.add("0");
			}
			case 2: {
				listValues.add("0");
				listValues.add(value1);
				listValues.add(value2);
				listValues.add("0");
				listValues.add(Value3);
				listValues.add("0");
			}
			case 3: {
				for (int i = 0; i < 5; i++) { 
					if (i == 4) { listValues.add(value1); }
					else { listValues.add("0"); } 
				}
			}
			case 4: {
				for (int i = 0; i < 5; i++) { 
					if (i == 1) { listValues.add(value1); }
					else { listValues.add("0"); } 
				}
			}
			case 5: {
				for (int i = 0; i < 5; i++) { 
					if (i == 2) { listValues.add(value1); }
					else { listValues.add("0"); } 
				}
			}
			case 6: {
				for (int i = 0; i < 5; i++) { listValues.add("0"); }
				listValues.add(value1);
			}
			default: break;
		}
	}
}
