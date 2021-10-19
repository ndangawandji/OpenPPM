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

/**
 * @author daniel.casas
 * @version 1.0 - 29-mar-2010 12:15:16
 */
public class HtmlUtil {


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
	 * 
	 * @param text
	 * @return
	 */
	public static String unescape(String text) {

		if (text == null) {
			return null;
		}

		// Optimize this

		text = StringUtil.replace(text, "&lt;", "<");
		text = StringUtil.replace(text, "&gt;", ">");
		text = StringUtil.replace(text, "&amp;", "&");
		text = StringUtil.replace(text, "&#034;", "\"");
		text = StringUtil.replace(text, "&#039;", "'");

		return text;
	}
}
