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
 *  
 *  Updater : Cédric Ndanga
 ******************************************************************************/
/**
 * Update : Cédric Ndanga
 * Devoteam, 2015/04/09, userstory 10 : adding property days
 * Devoteam, 2015/04/09, userstory 10 : adding method daysByPeriod(Date since, Date until)
 * 
 * Update : Xavier de Langautier
 * Devoteam, 2015/04/25, userstory 9 : Add remaining_duration (Reste à faire ), method RDUByPeriod(date since, Date until)
 * 
 */

package es.sm2.openppm.model;

import java.util.Date;


import org.apache.log4j.Logger;

import es.sm2.openppm.model.base.BaseTeammember;
import es.sm2.openppm.servlets.AssignmentServlet;

/**
 * Model class Teammember.
 * @author Hibernate Generator by Javier Hernandez
 */
public class Teammember extends BaseTeammember {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(AssignmentServlet.class);
	
	public final static String DAYS = "days"; 
	
	private float days;  // Propriété qui contient le nombre de jours d'un team member sur une activité
	private double remainingWorkload;

    public Teammember() {
		super();
    }
    
    public Teammember(Integer idTeamMember) {
		super(idTeamMember);
    }
    
    public float daysByPeriod(Date since, Date until) {
    	
    	float numberOfDays = (float)( (until.getTime() - since.getTime()) / (1000 * 60 * 60 * 24) ) + 1f ;
    	return (numberOfDays ) ;
    	
    }
    
	/**
	 * @return the days
	 */
	public float getDays() {
		return days;
	}
	
	/**
	 * @param days the days to set
	 */
	public void setDays(float days) {
		this.days = days;
	}
	

    
	/**
	 * @return the Remaining workload 
	 */
	public double getRemainingWorkload() {
		return remainingWorkload;
	}
	
	/**
	 * @param days the Remaining Duration  to set
	 */
	public void setRemainingWorkload(double remainingWorkload) {
		
		this.remainingWorkload = remainingWorkload; 
	}
	
	/**
	 * @param days the Remaining Duration  to set
	 */
	public void addRemainingWorkload(double remainingWorkload) {
		this.remainingWorkload += remainingWorkload;
	}
}

