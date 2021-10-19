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

import java.io.UnsupportedEncodingException;
import java.util.Set;

import net.sf.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;

import es.sm2.openppm.common.Constants;

public class JsonUtil {

	private JsonUtil() {}
	
	public static Gson getGson(String datePattern, Exclusion...classExclusions) {
		
		GsonBuilder gsonBuilder = new GsonBuilder()
			.setDateFormat(datePattern == null?Constants.DATE_PATTERN: datePattern)
			.setExclusionStrategies(classExclusions)
			.setExclusionStrategies(new Exclusion(Set.class))
			.serializeNulls();
		
		return gsonBuilder.create();
	}
	
	/**
	 * Pasa un objeto a JSON
	 * @param object
	 * @param classExclusions
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String toJSON(Object object,Exclusion...classExclusions) throws UnsupportedEncodingException {
		
		Gson gson = getGson(null, classExclusions);
		return gson.toJson(object);
	}
	
	/**
	 * Remove Lazy relations
	 * @param object
	 * @param type
	 * @param classExclusions
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static Object removeLazy(Object object,Class<?> type, Exclusion...classExclusions) throws UnsupportedEncodingException {
		
		Gson gson = getGson(null, classExclusions);
		JsonElement element = gson.toJsonTree(object);
		
		Object item = gson.fromJson(element, type);
		
		return item;
	}
	
	/**
	 * Pasa un objeto a JSON
	 * @param object
	 * @param classExclusions
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String toJSON(Object object, String datePattern ,Exclusion...classExclusions) throws UnsupportedEncodingException {

		Gson gson = getGson(datePattern, classExclusions);
		return gson.toJson(object);
	}
	
	/**
	 * Objeto JSON para llamadas void
	 * @return
	 */
	public static String infoTrue() {
		JSONObject info = new JSONObject();
		info.put(StringPool.INFO,StringPool.TRUE);
		return info.toString();
	}

	public static JSONObject toJSON(String key, Object value) {
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put(key,value);
		
		return jsonObject;
	}
	
}
