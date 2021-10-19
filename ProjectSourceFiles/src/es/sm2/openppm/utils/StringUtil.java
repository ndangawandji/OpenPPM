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


public final class StringUtil {

	private StringUtil() {
		super();
	}
	
	public static String cut(String s, int length) {
		
		if (s != null && length >= 0 && s.length() > length) {
			return s.substring(0,length);
		}
		return s;
	}
	
	public static String shorten(String s, int length) {
		return shorten(s, length, "...");
	}

	public static String shorten(String s, String suffix) {
		return shorten(s, 20, suffix);
	}

	public static String shorten(String s, int length, String suffix) {
		
		StringBuilder sb = null;

		if (s != null && suffix != null && s.length() > length) {
			for (int j = length; j >= 0; j--) {
				if (Character.isWhitespace(s.charAt(j))) {
					length = j;

					break;
				}
			}

			sb = new StringBuilder();
			
			sb.append(s.substring(0, length));
			sb.append(suffix);

		}

		return (sb == null ? null : sb.toString());
	}

	public static String upperCase(String s) {
		return (s == null ? null : s.toUpperCase());
	}

	public static String upperCaseFirstLetter(String s) {
		char[] chars = s.toCharArray();

		if ((chars[0] >= 97) && (chars[0] <= 122)) {
			chars[0] = (char)(chars[0] - 32);
		}

		return new String(chars);
	}

	
	public static String replace(String s, String oldSub, String newSub) {
		if ((s == null) || (oldSub == null) || (newSub == null)) {
			return null;
		}

		int y = s.indexOf(oldSub);

		if (y >= 0) {

			// The number 5 is arbitrary and is used as extra padding to reduce
			// buffer expansion

			StringBuilder sb = new StringBuilder(
				s.length() + 5 * newSub.length());

			int length = oldSub.length();
			int x = 0;

			while (x <= y) {
				sb.append(s.substring(x, y));
				sb.append(newSub);

				x = y + length;
				y = s.indexOf(oldSub, x);
			}

			sb.append(s.substring(x));

			return sb.toString();
		}
		else {
			return s;
		}
	}
	
	
	/**
	 *   
	 * @param num
	 * @param length
	 * @return
	 */
	public static String fillWithZeros (int num, int length) {
        
        return fill (num, length, '0');
    }
	
	
	/**
	 *   
	 * @param str
	 * @param length
	 * @return
	 */
	public static String fillWithZeros (String str, int length) {
        
        return fill (str, length, '0');
    }

	
	/**
	 *   
	 * @param num
	 * @param length
	 * @param c
	 * @return
	 */
	public static String fill(int num, int length, char c) {
        String sNumero;
        for (sNumero = StringPool.BLANK + num; sNumero.length() < length; sNumero = c + sNumero);
        return sNumero;
    }
	
	
	/**
	 *   
	 * @param str
	 * @param length
	 * @param c
	 * @return
	 */
	public static String fill(String str, int length, char c) {
        String sNumero;
        for (sNumero = StringPool.BLANK + str; sNumero.length() < length; sNumero = c + sNumero);
        return sNumero;
    }
	
	
	/**
	 * 
	 * @param f
	 * @return
	 */
	public static String formatEuro(Double f) {
		if(f == null) { return StringPool.BLANK; }
		return String.format("%.2f", f);
	}

	/**
	 * Parse null to String Blank
	 * @param object
	 * @return
	 */
	public static Object nullEmpty(Object object) {
		return (object == null?StringPool.BLANK:object);
	}
	

	/**
	 * Parse a string comma separated values in an Integer array 
	 * @param str
	 * @return
	 */
	public static Integer[] splitStrToIntegers(String str, Integer max) {
		
		Integer[] integerArray = null;
		if (str != null && !str.equalsIgnoreCase("")){
			String[] strArray = str.split(",");
			integerArray = new Integer[strArray.length];
			for (int i=0; i<strArray.length; i++) {
				if (max != null && i >= max ) { break; }
				integerArray[i] = Integer.parseInt(strArray[i]);
			}
		}
		return integerArray;
	}
	
	public static int lengthIntegers(String str) {
		
		int length = 0;
		
	    if (str != null && !str.equalsIgnoreCase("")){
	         String[] strArray = str.split(",");
	         length =  strArray.length;
	    }
	    return length;
	}
	
	public static String clearSlashes (String name) {
		String s;
		s = name.replace(":", "-");
		s = s.replace("\\", "-");
		return s.replace("/", "-");		
	}
}
