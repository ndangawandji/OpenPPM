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

import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.model.base.BaseProjectfollowup;
import es.sm2.openppm.utils.ValidateUtil;



/**
 * Model class Projectfollowup.
 * @author Hibernate Generator by Javier Hernandez
 */
public class Projectfollowup extends BaseProjectfollowup {

	private static final long serialVersionUID = 1L;
	private Integer daysToDate;
	
	public Projectfollowup() {
		super();
    }
    public Projectfollowup(Integer idProjectFollowup) {
		super(idProjectFollowup);
    }

    public Integer getDaysToDate() throws Exception {
    	
    	if (daysToDate == null) {
    		
	    	Project project			= ProjectLogic.findByFollowup(this);
	    	Projectactivity rootAct = project.getRootActivity();
	    	
	    	if (rootAct != null && rootAct.getActualInitDate() != null) {
	    		daysToDate = ValidateUtil.calculateWorkDays(rootAct.getActualInitDate(), getFollowupDate());
	    	}
	    	else if (rootAct != null && rootAct.getPlanInitDate() != null) {
	    		daysToDate = ValidateUtil.calculateWorkDays(rootAct.getPlanInitDate(), getFollowupDate());
	    	}
	    	else {
	    		daysToDate = ValidateUtil.calculateWorkDays(project.getPlannedInitDate(), getFollowupDate());
	    	}
    	}
    	return daysToDate;
    }
    
    public Double getCv() {
    	Double cv = null;

		if (getAc() != null && getEv() != null) {
			cv = getEv() - getAc();
		}
		return cv;
	}
	
	public Double getEac() {
		
		Double eac = null;

		if (getProject() != null && getProject().getBac() != null) {
			
			if ( getCpi() != null) {
				eac = (getProject().getBac() - (getEv()== null?0:getEv()))/getCpi() +(getAc() == null?0:getAc());
			}
		}
		return eac;
	}
	
	
	public Double getSpi() {
		Double spi = null;

		if (getEv() != null && getPv() != null && getPv() > 0) {
			spi = getEv() / getPv();
		}
		return spi;
	}
	
	public Double getSv() {
		Double sv = null;
		
		if (getEv() != null && getPv() != null) {
			sv = getEv() - getPv();
		}
		return sv;
	}
	
	public Double getCpi() {
		Double cpi = null;

		if (getAc() != null && getEv() != null && getAc() > 0) {
			cpi = getEv() / getAc();
		}
		return cpi;
	}
	
	public Double getPoc() {
		Double poc = null;

		if (getProject() != null && getProject().getBac() != null && getProject().getBac() > 0 && getEv() != null) {
			poc = getEv()/ getProject().getBac();
		}
		return poc;
	}
}

