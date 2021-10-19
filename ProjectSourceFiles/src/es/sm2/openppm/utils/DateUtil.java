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
/*
 *  Update : Devoteam Xavier de Langautier  Ajout de la fonction addDay
 */
package es.sm2.openppm.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.ResourceBundle;

import es.sm2.openppm.common.Constants;

public final class DateUtil {

	private DateUtil() {
		super();
	}
	
	/**
	 * Get Default Locale Calendar
	 * @return
	 */
	public static Calendar getCalendar() {
		Calendar cal = Calendar.getInstance(Constants.DEF_LOCALE);
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		
		return cal;
	}


//	 Devoteam Xavier de Langautier 2015/06/2
//	  fonction addDay
//	  PAram : Date
//	          nbJour :  Number of days to add
	
	public static Date addDay(Date date, int nbJour) { 
		  Calendar cal = DateUtil.getCalendar();
		  cal.setTime(date);
		  cal.add(Calendar.DAY_OF_MONTH, nbJour);
		  return cal.getTime();
	}
	
	public static String format(ResourceBundle idioma, Date date) {
		String str = "";
		if (date != null) {
			SimpleDateFormat df = new SimpleDateFormat(getDatePattern(idioma));
			str = df.format(date);
		}
		return str;
	}
	
	
	public static String format(String pattern, Date date) {
		String str = "";
		if (pattern != null && date != null) {
			SimpleDateFormat df = new SimpleDateFormat(pattern);
			str = df.format(date);
		}
		return str;
	}

	
	/**
	 * Return the first day of a given week date
	 * @param date
	 * @return
	 */
	public static Date getFirstWeekDay(Date date) {
		Calendar cal = DateUtil.getCalendar();
		cal.setTime(date);
		
		cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek());
		return cal.getTime();
	}
	
	
	/**
	 * Return the last day of a given week date
	 * @param date
	 * @return
	 */
	public static Date getLastWeekDay(Date date) {
		Calendar cal = DateUtil.getCalendar();
		cal.setTime(date);
		
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		return cal.getTime();
	}
	
	
	/**
	 * Return the last day of a given week date
	 * @param date
	 * @return
	 */
	public static Calendar getLastWeekDay(Calendar calendar) {
		Calendar cal = (Calendar)calendar.clone();
		cal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
		return cal;
	}
	
	
	/**
	 * Return the last day of month
	 * @param date
	 * @return
	 */
	public static Date getLastMonthDay(Date date) {
		Calendar cal = DateUtil.getCalendar();
		cal.setTime(date);
		cal.set(Calendar.DATE, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		return cal.getTime();
	}
	
	
	/**
	 * Return the first day of month
	 * @param date
	 * @return
	 */
	public static Date getFirstMonthDay(Date date) {
		Calendar cal = DateUtil.getCalendar();
		cal.setTime(date);
		cal.set(Calendar.DATE, 1);
		return cal.getTime();
	}

	
	/**
	 * Return Date Pattern for given idioma
	 * @param idioma
	 * @return
	 */
	public static String getDatePattern(ResourceBundle idioma) {

		return "dd/MM/yyyy";
	}

	
	/**
	 * Return Date Picker Pattern for given idioma
	 * @param idioma
	 * @return
	 */
	public static String getDatePickerPattern(ResourceBundle idioma) {

		return "dd/mm/yy";
	}

	
	/**
	 * Return months between two dates
	 * @param firstDate
	 * @param secondDate
	 * @return
	 */
	public static Integer monthsBetween(Date firstDate, Date secondDate) {
		Calendar first = DateUtil.getCalendar();
		first.setTime(firstDate);
		Calendar second = DateUtil.getCalendar();
		second.setTime(secondDate);
		
		Integer months = 0;
		
		while (first.before(second)) {
			months ++;
			first.add(Calendar.MONTH, 1);
		}
		
		return months;
	}
	
	/**
	 * Return days between two dates
	 * @param firstDate
	 * @param secondDate
	 * @return
	 */
	public static int daysBetween(Date firstDate, Date secondDate) {
		Calendar first = DateUtil.getCalendar();
		first.setTime(firstDate);
		Calendar second = DateUtil.getCalendar();
		second.setTime(secondDate);
		
		int days = 0;
		
		while (first.before(second)) {
			days ++;
			first.add(Calendar.DAY_OF_WEEK, 1);
		}
		
		return days;
	}

	/**
	 * Equals two dates, compare day to day, month to month and year to year
	 * @param calendar1
	 * @param calendar2
	 * @return
	 */
	public static boolean equals(Date date1, Date date2) {
		
		Calendar calendar1 = getCalendar();
		calendar1.setTime(date1);
		
		Calendar calendar2 = getCalendar();
		calendar2.setTime(date2);
		
		return equals(calendar1, calendar2);
	}
	
	/**
	 * Equals two calendar, compare day to day, month to month and year to year
	 * @param calendar1
	 * @param calendar2
	 * @return
	 */
	public static boolean equals(Calendar calendar1, Calendar calendar2) {
		
		int day1 = calendar1.get(Calendar.DAY_OF_MONTH);
		int day2 = calendar2.get(Calendar.DAY_OF_MONTH);
		
		int month1 = calendar1.get(Calendar.MONTH);
		int month2 = calendar2.get(Calendar.MONTH);
		
		int year1 = calendar1.get(Calendar.YEAR);
		int year2 = calendar2.get(Calendar.YEAR);
		
		return (day1 == day2 && month1 == month2 && year1 == year2);
	}

	public static boolean betweenWeek(Date since, Date until, Date day) {
		
		Date initWeek	= getFirstWeekDay(day);
		Date endWeek	= getLastWeekDay(day);
		
		return between(since, until, initWeek, endWeek);
	}
	
	public static boolean between(Date since, Date until, Date dateIn, Date dateOut) {
		
		return between(dateIn, dateOut, since) || between(dateIn, dateOut, until) || (since.before(dateIn) && until.after(dateOut));
	}
	
	public static boolean between(Date since, Date until, Date date) {
		
		return date != null && (!since.after(date) && !until.before(date));
	}

	public static boolean isWeekend(Calendar dateCal) {
		
		return (dateCal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY || dateCal.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY);
	}
}
