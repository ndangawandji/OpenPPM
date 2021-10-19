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
 * Update : Devoteam Xavier de Langautie 2015-05-29
 *          User story 15   Calcul du reste à faire sur l'activité
 *          Ajout des methodes sur le workload
 */
/*
 * Updater : Cedric Ndanga Wandji
 * Devoteam 10/06/2015 user story 40 : adding activity workload updated as java property.
 */
package es.sm2.openppm.model;

import org.apache.log4j.Logger;

import es.sm2.openppm.logic.ProjectActivityLogic;
import es.sm2.openppm.model.base.BaseProjectactivity;
import es.sm2.openppm.utils.ExceptionUtil;



/**
 * Model class Projectactivity.
 * @author Hibernate Generator by Javier Hernandez
 */
public class Projectactivity extends BaseProjectactivity {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(Projectactivity.class);
	
	private double remainingWorkload;
	private Double actualWorkload;			// cnw us40, activity workload updated
	
    public Projectactivity() {
		super();
    }
    public Projectactivity(Integer idActivity) {
		super(idActivity);
    }

    public Double getPocCalc() throws Exception {
    	
    	Double poc = null;
    	try {
    		poc = ProjectActivityLogic.calcPoc(this);
    	}
    	catch (Exception e) {
    		ExceptionUtil.sendToLogger(LOGGER, e, null);
		}
    	return poc;
    }
	/**
	 * @return the Remaining workload (in days)
	 */
	public double getRemainingWorkload() {
		return remainingWorkload;
	}
	
	/**
	 * @param   the Remaining workload to set in days
	 */
	public void setRemainingWorkload(double remainingWorkload) {
		
		this.remainingWorkload = remainingWorkload; 
	}
	
	/**
	 * @author Cedric Ndanga
	 * user story 40
	 * @return the actualWorkload
	 */
	public Double getActualWorkload() {
		return actualWorkload;
	}
	/**
	 * @author Cedric Ndanga
	 * user story 40
	 * @param actualWorkload the actualWorkload to set
	 */
	public void setActualWorkload(Double actualWorkload) {
		this.actualWorkload = actualWorkload;
	}
	
	/**
	 * @param  the Remaining workload to add  in days
	 */
	public void addRemainingWorkload(double remainingWorkload) {
		this.remainingWorkload += remainingWorkload;
	}
}

