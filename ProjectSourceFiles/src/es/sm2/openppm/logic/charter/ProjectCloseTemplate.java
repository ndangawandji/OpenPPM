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
 * Represents a project close document implemented by a particular customer.
 * <br>
 * Subclasses should be immutable.
 *
 * @author Dani
 */
public abstract class ProjectCloseTemplate {

	protected static final String outputFile = Settings.TEMP_DIR_GENERATE_DOCS;
	
	/**
	 * Get an instance of the project close template specified by the properties file.
	 *
	 * @return The specified ProjectCloseTemplate
	 * @throws LogicException If no project close template was specified, or if it could not be instantiated.
	 */
	public static ProjectCloseTemplate getProjectCloseTemplate() throws LogicException {
		
		String projectCloseTemplateName = Settings.PROJECT_CLOSE_CLASSNAME;
		
		return instantiateProjectCloseTemplate ( projectCloseTemplateName );
	}


	private static ProjectCloseTemplate instantiateProjectCloseTemplate(String projectCloseTemplateName)
	throws LogicException {
		
		if ( projectCloseTemplateName == null ) {
			throw new LogicException( 
					"The project close template was not set. " +
					"Set the property project.close.template." );
		}
		try {
			return ( ProjectCloseTemplate ) ReflectUtil.classForName( projectCloseTemplateName ).newInstance();
		}
		catch ( ClassNotFoundException cnfe ) {
			throw new LogicException( 
					"Project close template class not found: " + projectCloseTemplateName );
		}
		catch ( Exception e ) {
			throw new LogicException( 
					"Could not instantiate given project close template class: " + projectCloseTemplateName );
		}
	}

	
	public abstract File generateClose (ResourceBundle langResource, Project project, Projectcharter projectCharter, String...args) 
	throws Exception;	
}
