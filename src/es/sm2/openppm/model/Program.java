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
package es.sm2.openppm.model;

import org.apache.log4j.Logger;

import es.sm2.openppm.logic.ProgramLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.model.base.BaseProgram;
import es.sm2.openppm.utils.ExceptionUtil;



/**
 * Model class Program.
 * @author Hibernate Generator by Javier Hernandez
 */
public class Program extends BaseProgram {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(Project.class);
	
	public Program() {
		super();
    }
    
    public Program(Integer idProgram) {
		super(idProgram);
    }
    
    public Double getBudgetBottomUp () {
    	Double budget = null;
		try {
			budget = ProjectLogic.calcBudgetBottomUp(this);
		}
    	catch (Exception e) {
			ExceptionUtil.sendToLogger(LOGGER, e, null);
		}
		return budget;
    }
    
    public Double getSumActualCost() {
    	Double cost = null;
		try {
			cost = ProgramLogic.calcActualCost(this);
		}
    	catch (Exception e) {
			ExceptionUtil.sendToLogger(LOGGER, e, null);
		}
		return cost;
    }
}

