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
package es.sm2.openppm.javabean;

import java.text.MessageFormat;
import java.util.ResourceBundle;

public class ParamResourceBundle {

	private String key;
	private Object[] arguments;
	private boolean black = false;
	
	public ParamResourceBundle(String key) {
		this.key = key;
	}
	
	public ParamResourceBundle(String key, Object...params) {
		this.key = key;
		this.arguments = params;
	}
	
	public ParamResourceBundle(String key,boolean black, Object...params) {
		this.key = key;
		this.arguments = params;
		this.black = black;
	}
	
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}
	
	public Object[] getArguments() {
		return arguments;
	}

	public void setArguments(Object[] arguments) {
		this.arguments = arguments;
	}

	public String toString(ResourceBundle bundle) {
		
		String reBundle = null;
		
		if (arguments == null || arguments.length == 0) {
			try { reBundle =  bundle.getString(key); }
			catch (Exception e){ reBundle = key; }
		}
		else {
			reBundle = MessageFormat.format(bundle.getString(key), arguments);
		}
		return reBundle;
	}
	
	public String getMessage(ResourceBundle bundle) {
		String msg = "";
		if (arguments != null) {
			
			if (arguments.length > 0) {
				
				Object[] values = new String[arguments.length];
				int i = 0;
				for (Object item : arguments) {
					try {
						values[i] = (black?"<b>":"")+bundle.getString((String)item)+(black?"</b>":"");
					}
					catch (Exception e){
						values[i] = (black?"<b>":"")+item+(black?"</b>":"");
					}
					i++;
				}
				this.arguments = values;
			}
			
			msg = toString(bundle);
		}
		else {
			msg = bundle.getString(this.key);
		}
		return msg;
	}

	public void setBlack(boolean black) {
		this.black = black;
	}

	public boolean isBlack() {
		return black;
	}
}
