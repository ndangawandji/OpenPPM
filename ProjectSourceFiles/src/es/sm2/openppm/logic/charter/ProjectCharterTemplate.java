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
package es.sm2.openppm.logic.charter;


import java.io.File;
import java.util.ResourceBundle;

import es.sm2.openppm.common.Settings;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.utils.ReflectUtil;


/**
 * Represents a project charter document implemented by a particular customer.
 * <br>
 * Subclasses should be immutable.
 *
 * @author Dani
 */
public abstract class ProjectCharterTemplate {

	
	protected static final String outputFile = Settings.TEMP_DIR_GENERATE_DOCS;
	
	/**
	 * Get an instance of the project charter template specified by the properties file.
	 *
	 * @return The specified ProjectCharterTemplate
	 * @throws LogicException If no project charter template was specified, or if it could not be instantiated.
	 */
	public static ProjectCharterTemplate getProjectChaterTemplate() throws LogicException {
		
		String projectCharterTemplateName = Settings.PROJECT_CHARTER_CLASSNAME;
		
		return instantiateProjectCharterTemplate ( projectCharterTemplateName );
	}


	private static ProjectCharterTemplate instantiateProjectCharterTemplate(String projectCharterTemplateName)
	throws LogicException {
		
		if ( projectCharterTemplateName == null ) {
			throw new LogicException( 
					"The project charter template was not set. " +
					"Set the property project.charter.template." );
		}
		try {
			return ( ProjectCharterTemplate ) ReflectUtil.classForName( projectCharterTemplateName ).newInstance();
		}
		catch ( ClassNotFoundException cnfe ) {
			throw new LogicException( 
					"Project charter template class not found: " + projectCharterTemplateName );
		}
		catch ( Exception e ) {
			throw new LogicException( 
					"Could not instantiate given project charter template class: " + projectCharterTemplateName );
		}
	}

	
	public abstract File generateCharter (ResourceBundle langResource, Project project, Projectcharter projectCharter, String...args) 
	throws Exception;	
}
