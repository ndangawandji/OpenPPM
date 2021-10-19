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


import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public final class ParamUtil {
	
	private ParamUtil() {
		super();
	}
	
	private static Logger logger = Logger.getLogger(ParamUtil.class);

	public static boolean getBoolean(HttpServletRequest request, String param) {
		return GetterUtil.getBoolean(request.getParameter(param));
	}

	public static boolean getBoolean(
		HttpServletRequest request, String param, boolean defaultValue) {

		return get(request, param, defaultValue);
	}

	public static boolean[] getBooleanValues(
		HttpServletRequest request, String param) {

		return getBooleanValues(request, param, new boolean[0]);
	}

	public static boolean[] getBooleanValues(
		HttpServletRequest request, String param, boolean[] defaultValue) {

		return GetterUtil.getBooleanValues(
			request.getParameterValues(param), defaultValue);
	}

	public static Date getDate(
		HttpServletRequest request, String param, DateFormat df) {

		return GetterUtil.getDate(request.getParameter(param), df);
	}

	public static Date getDate(
		HttpServletRequest request, String param, DateFormat df,
		Date defaultValue) {

		return get(request, param, df, defaultValue);
	}

	public static double getDouble(HttpServletRequest request, String param) {
		return GetterUtil.getDouble(request.getParameter(param));
	}

	public static Double getDouble(
		HttpServletRequest request, String param, Double defaultValue) {

		return get(request, param, defaultValue);
	}

	public static double[] getDoubleValues(
		HttpServletRequest request, String param) {

		return getDoubleValues(request, param, new double[0]);
	}

	public static double[] getDoubleValues(
		HttpServletRequest request, String param, double[] defaultValue) {

		return GetterUtil.getDoubleValues(
			request.getParameterValues(param), defaultValue);
	}

	public static float getFloat(HttpServletRequest request, String param) {
		return GetterUtil.getFloat(request.getParameter(param));
	}

	public static float getFloat(
		HttpServletRequest request, String param, float defaultValue) {

		return get(request, param, defaultValue);
	}

	public static float[] getFloatValues(
		HttpServletRequest request, String param) {

		return getFloatValues(request, param, new float[0]);
	}

	public static float[] getFloatValues(
		HttpServletRequest request, String param, float[] defaultValue) {

		return GetterUtil.getFloatValues(
			request.getParameterValues(param), defaultValue);
	}

	public static int getInteger(HttpServletRequest request, String param) {
		return GetterUtil.getInteger(request.getParameter(param));
	}

	public static int getInteger(
		HttpServletRequest request, String param, int defaultValue) {

		return get(request, param, defaultValue);
	}
	
	public static Integer getInteger(
			HttpServletRequest request, String param, Integer defaultValue) {

			return get(request, param, defaultValue);
		}

	public static int[] getIntegerValues(
		HttpServletRequest request, String param) {

		return getIntegerValues(request, param, new int[0]);
	}

	public static int[] getIntegerValues(
		HttpServletRequest request, String param, int[] defaultValue) {

		return GetterUtil.getIntegerValues(
			request.getParameterValues(param), defaultValue);
	}

	public static long getLong(HttpServletRequest request, String param) {
		return GetterUtil.getLong(request.getParameter(param));
	}

	public static long getLong(
		HttpServletRequest request, String param, long defaultValue) {

		return get(request, param, defaultValue);
	}

	public static long[] getLongValues(
		HttpServletRequest request, String param) {

		return getLongValues(request, param, new long[0]);
	}

	public static long[] getLongValues(
		HttpServletRequest request, String param, long[] defaultValue) {

		return GetterUtil.getLongValues(
			request.getParameterValues(param), defaultValue);
	}

	public static short getShort(HttpServletRequest request, String param) {
		return GetterUtil.getShort(request.getParameter(param));
	}

	public static short getShort(
		HttpServletRequest request, String param, short defaultValue) {

		return get(request, param, defaultValue);
	}

	public static short[] getShortValues(
		HttpServletRequest request, String param) {

		return getShortValues(request, param, new short[0]);
	}

	public static short[] getShortValues(
		HttpServletRequest request, String param, short[] defaultValue) {

		return GetterUtil.getShortValues(
			request.getParameterValues(param), defaultValue);
	}

	public static Character getCharacter(HttpServletRequest req, String param) {
		return GetterUtil.getCharacter(req.getParameter(param));
	}

	public static Character getCharacter(
		HttpServletRequest req, String param, Character defaultValue) {

		return get(req, param, defaultValue);
	}

	public static Character[] getCharValues(
		HttpServletRequest req, String param) {

		return getCharValues(req, param, new Character[0]);
	}

	public static Character[] getCharValues(
		HttpServletRequest req, String param, Character[] defaultValue) {

		return GetterUtil.getCharValues(
			req.getParameterValues(param), defaultValue);
	}
	
	public static double getCurrency (HttpServletRequest req, String param) {
		return GetterUtil.getCurrency(req.getParameter(param));
	}

	public static Double getCurrency(
			HttpServletRequest req, String param, Double defaultValue) {
		
		return GetterUtil.getCurrency(req.getParameter(param), defaultValue);
	}
	
	public static double getCurrency(
		HttpServletRequest req, String param, double defaultValue) {

		return GetterUtil.getCurrency(req.getParameter(param), defaultValue);
	}
	
	public static Character get(
		HttpServletRequest req, String param, Character defaultValue) {

		return GetterUtil.get(req.getParameter(param), defaultValue);
	}
	
	public static String getString(HttpServletRequest req, String param) {
		return GetterUtil.getString(req.getParameter(param));
	}

	public static String getString(
		HttpServletRequest req, String param, String defaultValue) {

		return get(req, param, defaultValue);
	}
	
	public static String[] getStringValues(
		HttpServletRequest request, String param, String[] defaultValue) {

		return GetterUtil.getStringValues(
			request.getParameterValues(param), defaultValue);
	}

	public static boolean get(
		HttpServletRequest request, String param, boolean defaultValue) {

		return GetterUtil.get(request.getParameter(param), defaultValue);
	}

	public static Date get(
		HttpServletRequest request, String param, DateFormat df,
		Date defaultValue) {

		return GetterUtil.get(request.getParameter(param), df, defaultValue);
	}

	public static Double get(
		HttpServletRequest request, String param, Double defaultValue) {

		return GetterUtil.get(request.getParameter(param), defaultValue);
	}

	public static float get(
		HttpServletRequest request, String param, float defaultValue) {

		return GetterUtil.get(request.getParameter(param), defaultValue);
	}
	
	public static int get(
			HttpServletRequest request, String param, int defaultValue) {
		
		return GetterUtil.get(request.getParameter(param), defaultValue);
	}

	public static Integer get(
		HttpServletRequest request, String param, Integer defaultValue) {

		return GetterUtil.get(request.getParameter(param), defaultValue);
	}

	public static long get(
		HttpServletRequest request, String param, long defaultValue) {

		return GetterUtil.get(request.getParameter(param), defaultValue);
	}

	public static short get(
		HttpServletRequest request, String param, short defaultValue) {

		return GetterUtil.get(request.getParameter(param), defaultValue);
	}

	public static String get(
		HttpServletRequest request, String param, String defaultValue) {

		String returnValue =
			GetterUtil.get(request.getParameter(param), defaultValue);

		if (returnValue != null) {
			return returnValue.trim();
		}

		return null;
	}

	public static Integer[] getIntegerList(
		HttpServletRequest req, String param) {

		return getIntegerList(req, param, new Integer[0]);
	}

	public static Integer[] getIntegerList(
		HttpServletRequest req, String param, Integer[] defaultValue) {

		return GetterUtil.getIntegerList(
			req.getParameterValues(param), defaultValue);
	}
	
	@SuppressWarnings("unchecked")
	public static void print(HttpServletRequest request) {
		Enumeration<String> enu = request.getParameterNames();

		while (enu.hasMoreElements()) {
			String param = enu.nextElement();

			String[] values = request.getParameterValues(param);

			for (int i = 0; i < values.length; i++) {
				logger.debug(param + "[" + i + "] = " + values[i]);
			}
		}
	}
	
	@SuppressWarnings("unchecked")
	public static Map<String, String> getAllParameters(HttpServletRequest request) {
		Map<String, String> parameters = new HashMap<String, String>();
		Enumeration<String> enu = request.getParameterNames();

		while (enu.hasMoreElements()) {
			String param = enu.nextElement();

			String[] values = request.getParameterValues(param);

			for (int i = 0; i < values.length; i++) {
				parameters.put(param, values[i]);
			}
		}
		
		return parameters;
	}

}
