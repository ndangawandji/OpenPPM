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
package es.sm2.openppm.utils;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.logic.ProjectcalendarLogic;
import es.sm2.openppm.logic.TeamMemberLogic;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Projectfollowup;


public class ValidateUtil {

	public final static Logger LOGGER = Logger.getLogger(ValidateUtil.class);
	
	private ValidateUtil() {}
	
	public static int numOfCulumnsForProject() {
		
		int columns = 0;
		
		if (Settings.PROJECT_COL_RAG			 ) { columns++; }
		if (Settings.PROJECT_COL_STATUS			 ) { columns++; }
		if (Settings.PROJECT_COL_ACCOUNTING_CODE ) { columns++; }
		if (Settings.PROJECT_COL_PROJECT_NAME	 ) { columns++; }
		if (Settings.PROJECT_COL_SHORT_NAME		 ) { columns++; }
		if (Settings.PROJECT_COL_BUDGET			 ) { columns++; }
		if (Settings.PROJECT_COL_PRIORITY		 ) { columns++; }
		if (Settings.PROJECT_COL_POC			 ) { columns++; }
		if (Settings.PROJECT_COL_BASELINE_START	 ) { columns++; }
		if (Settings.PROJECT_COL_BASELINE_FINISH ) { columns++; }
		if (Settings.PROJECT_COL_START			 ) { columns++; }
		if (Settings.PROJECT_COL_FINISH			 ) { columns++; }
		if (Settings.PROJECT_COL_AC	 			 ) { columns++; }
		if (Settings.PROJECT_COL_INTERNAL_EFFORT ) { columns++; }
		if (Settings.PROJECT_COL_EXTERNAL_COST	 ) { columns++; }
		
		return columns;
	}
	
	public static int numOfCulumnsForInvestment() {
		
		int columns = 0;
		
		if (Settings.INVESTMENT_COL_STATUS			) { columns++; }
		if (Settings.INVESTMENT_COL_ACCOUNTING_CODE	) { columns++; }
		if (Settings.INVESTMENT_COL_NAME			) { columns++; }
		if (Settings.INVESTMENT_COL_SHORT_NAME		) { columns++; }
		if (Settings.INVESTMENT_COL_BUDGET			) { columns++; }
		if (Settings.INVESTMENT_COL_PRIORITY		) { columns++; }
		if (Settings.INVESTMENT_COL_PROBABILITY		) { columns++; }
		if (Settings.INVESTMENT_COL_BASELINE_START	) { columns++; }
		if (Settings.INVESTMENT_COL_BASELINE_FINISH	) { columns++; }
		if (Settings.INVESTMENT_COL_START			) { columns++; }
		if (Settings.INVESTMENT_COL_FINISH			) { columns++; }
		if (Settings.INVESTMENT_COL_INTERNAL_EFFORT ) { columns++; }
		if (Settings.INVESTMENT_COL_EXTERNAL_COST	) { columns++; }

		return columns;
	}
	
	public static String toPercent(Double doubleValue) {
		
		DecimalFormat df = new DecimalFormat("###.##%");
		df.setMaximumFractionDigits(2);
		df.setMinimumFractionDigits(2);
		
		String formatDouble		 = "";
		
		if (doubleValue != null) {
			formatDouble = df.format(doubleValue);
		}
		return formatDouble;
	}
	
	/**
	 * Value is null, equals empty or "null" return True
	 * @param value
	 * @return
	 */
	public static boolean isNull(String value) {

		boolean isNull = true;
		
		value = (value==null?value:value.trim());
		
		if (value != null && !"".equals(value)
				&& !"NULL".equals(value.toUpperCase())) { isNull = false; }
		
		return isNull;
	}
	
	/**
	 * Is not null return first value otherwise second value
	 * @param value
	 * @param other
	 * @return
	 */
	public static String isNullCh(String value, String other) {
		
		return (isNull(value)?other:value);
	}
	
	/**
	 * Check if is Exception day in project
	 * @param initDate
	 * @param dayOfWeek
	 * @param idActivity
	 * @return
	 */
	public static boolean isExceptionDay(Date initDate, Integer dayOfWeek, Integer idActivity, Integer idEmployee) {
		
		ProjectcalendarLogic projectcalendarLogic = new ProjectcalendarLogic();
		
		boolean isException = false;
		try {
			
			isException = projectcalendarLogic.isException(initDate, dayOfWeek, idActivity, idEmployee);
		}
		catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
		
		return isException;
	}
	
	/**
	 * Check if employee is assigned in these day on the project activity
	 * @param initDate
	 * @param dayOfWeek
	 * @param idActivity
	 * @param employee
	 * @return
	 */
	public static boolean isWorkDay(Date initDate, Integer dayOfWeek, Integer idActivity, Employee employee) {

		TeamMemberLogic memberLogic = new TeamMemberLogic();
		
		boolean isWorkDay = false;
		try {
			
			isWorkDay = memberLogic.isWorkDay(initDate, dayOfWeek, idActivity, employee);
		}
		catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
		
		return isWorkDay;
	}
	
	/**
	 * Default false
	 * @param value
	 * @param other
	 * @return
	 */
	public static boolean defBoolean(Boolean value) {
		
		return (value==null?false:value);
	}
	
	/**
	 * Parse double value to currency format
	 * @param objectValue
	 * @return
	 */
	public static String toCurrency(Object objectValue) {
		
		String value ="";
		double doubleValue = 0;
		
		if (objectValue instanceof Double) {
			doubleValue = (Double)objectValue;
		}
		else if (objectValue instanceof String) {
			doubleValue = Double.parseDouble((String)objectValue);
		}
		
		if (objectValue == null) {
			value = "";
		}
		else {
			NumberFormat numberFormat 	= NumberFormat.getNumberInstance(Constants.DEF_LOCALE_NUMBER);
			numberFormat.setMinimumFractionDigits(2);
			numberFormat.setMaximumFractionDigits(2);
			
			value = numberFormat.format(doubleValue);
		}
		
		return value;
	}
	
	/**
	 * Parse double value to currency format
	 * @param doubleValue
	 * @return
	 */
	public static String toCurrencyWord(Double doubleValue) {
		
		String value;
		NumberFormat numberFormat 	= NumberFormat.getNumberInstance(Constants.DEF_LOCALE_NUMBER);
		numberFormat.setMinimumFractionDigits(0);
		numberFormat.setMaximumFractionDigits(0);
		
		if (doubleValue == null) {
			value = numberFormat.format(new Double(0));
		}
		else {
			value = numberFormat.format(doubleValue);
		}
		
		return value + "";
	}
	
	/**
	 * Count work days from initDate to endDate.
	 * @param initDate
	 * @param endDate
	 * @return
	 */
	public static Integer calculateWorkDays(Date initDate, Date endDate) {
		
		Integer cont = null;
		
		if (initDate != null && endDate != null) {
			
			Calendar fecIni = DateUtil.getCalendar();
			fecIni.setTime(initDate);
			Calendar fecFin = DateUtil.getCalendar();
			fecFin.setTime(endDate);
			fecFin.add(Calendar.DAY_OF_MONTH, 1);
			
			cont = 0;
			
			while (fecIni.before(fecFin)) {
				int diaSemIni = fecIni.get(Calendar.DAY_OF_WEEK);
				
				if (diaSemIni != Calendar.SATURDAY && diaSemIni != Calendar.SUNDAY) {
					cont ++;
				}
				fecIni.add(Calendar.DAY_OF_MONTH, 1);
			}
			return (cont == 0?1:cont);
		}
		return cont;
	}
	
	/**
	 * 
	 * @param text
	 * @return
	 */
	public static String escape(String text) {

		if (text == null) {
			return null;
		}

		StringBuilder sb = new StringBuilder(text.length());

		for (int i = 0; i < text.length(); i++) {
			char c = text.charAt(i);

			switch (c) {
				case '<':
					sb.append("&lt;");

					break;

				case '>':
					sb.append("&gt;");

					break;

				case '&':
					sb.append("&amp;");

					break;

				case '"':
					sb.append("&#034;");

					break;

				case '\'':
				case 146:
					sb.append("&#039;");

					break;
					
				case 128:
					sb.append("&euro;");

					break;	
					
				default:
					sb.append(c);

					break;
			}
		}

		return sb.toString();
	}
	
	/**
	 * Calculate ES
	 * @param list
	 * @param followup
	 * @return
	 * @throws Exception 
	 */
	public static Double getES(List<Projectfollowup> list, Projectfollowup followup) throws Exception {
		
		Integer minWorkdays = null;
		Double minPv = null;
		
		Projectfollowup f0 = null;
		Projectfollowup f1 = null;
		
		Double ev = followup.getEv();
		Double es = null;
		
		if (ev != null) {
				
			// Get Followup fot T0, PV0 and Min Days to date
			for (Projectfollowup item : list) {
				if (item.getPv()!= null) {
					if (minPv == null || (item.getPv() >= minPv && item.getPv() <= ev)) {
						minPv = item.getPv();
						f0 = item;
					}
					
					// Min Days to Date
					Integer daysToDate = item.getDaysToDate();
					daysToDate = (daysToDate == null?0:daysToDate);
					
					if (minWorkdays == null || minWorkdays > daysToDate) {
						minWorkdays = daysToDate;
					}
				}
			}
			
			// Get followup for T1 PV1
			for (Projectfollowup item : list) {
				if (item.getPv()!= null && 
						((f1 == null && f0.getPv() < item.getPv()) ||
						(f1 != null && f0.getPv() < item.getPv() && f1.getPv() > item.getPv()))) {
					f1 = item;
				}
			}
			
			if (minPv != null && minPv > ev) { es = (minWorkdays == null?null:minWorkdays.doubleValue()); }
			else {
				double t0 = (f0 != null && f0.getDaysToDate() != null?f0.getDaysToDate():0);
				double t1 = (f1 != null && f1.getDaysToDate() != null?f1.getDaysToDate():0);
				
				double pv0 = (f0 != null?f0.getPv():0);
				double pv1 = (f1 != null?f1.getPv():0);
				
				if ((pv1-pv0) != 0) {
					es = t0+(t1-t0)*(ev-pv0)/(pv1-pv0);
				}
			}
		}
		return es;
	}
}
