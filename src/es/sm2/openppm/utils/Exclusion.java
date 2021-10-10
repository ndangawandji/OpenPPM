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

import java.util.ArrayList;
import java.util.List;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;

public class Exclusion implements ExclusionStrategy {
	
//	private static final Logger LOGGER = Logger.getLogger(Exclusion.class);
	
	private final Class<?> typeToSkip;
	private final List<String> nameExlusion;
	
	public Exclusion(Class<?> typeToSkip) {
		this.typeToSkip = typeToSkip;
		this.nameExlusion = new ArrayList<String>();
	}
	
	public Exclusion(Class<?> typeToSkip, List<String> nameExlusion) {
		
		this.nameExlusion = nameExlusion;
		this.typeToSkip = typeToSkip;
    }

    public boolean shouldSkipClass(Class<?> clazz) {
    
    	boolean exclusion = false;
		
		if (nameExlusion.isEmpty()) {
			exclusion = typeToSkip.equals(clazz);
		}
		return exclusion;
    }

	public boolean shouldSkipField(FieldAttributes f) {
		
		boolean exclusion = false;
		
		if (nameExlusion.isEmpty()) {
			exclusion = typeToSkip.equals(f.getDeclaredClass());
		}
		else {
			
//			LOGGER.debug("Name for Exclusion: "+f.getName());
//			LOGGER.debug("Exclusion Class: "+typeToSkip.equals(f.getDeclaredClass()));
//			LOGGER.debug("Exclusion Name: "+nameExlusion.contains(f.getName()));
			
			exclusion = (typeToSkip.equals(f.getDeclaredClass()) && nameExlusion.contains(f.getName()));
		}
		return exclusion;
	}  
}
