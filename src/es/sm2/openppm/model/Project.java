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

import javax.xml.bind.annotation.XmlRootElement;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.logic.ProjectActivityLogic;
import es.sm2.openppm.logic.ProjectFollowupLogic;
import es.sm2.openppm.logic.ProjectLogic;
import es.sm2.openppm.model.base.BaseProject;
import es.sm2.openppm.utils.ExceptionUtil;



/**
 * Model class Project.
 * @author Hibernate Generator by Javier Hernandez
 */
@XmlRootElement
public class Project extends BaseProject {

	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(Project.class);
	
    public Project() {
		super();
    }
    public Project(Integer idProject) {
		super(idProject);
    }

    /**
     * Cons Root Activity (Do Not use in any logic class)
     * @return
     * @throws Exception
     */
    public Projectactivity getRootActivity() throws Exception {
    	
    	Projectactivity root = null;
    	try {
    		
    		root = ProjectActivityLogic.consRootActivity(this);
        	
    		if (root == null) {
    			root = new Projectactivity();
    			ExceptionUtil.sendToLogger(LOGGER, "No hay actividad principal", this);
    		}
    	}
    	catch (Exception e) {
			ExceptionUtil.sendToLogger(LOGGER, e, null);
		}
    	
    	return root;
    }
    
    public Projectfollowup getLastFollowup() throws Exception{
    	
    	return ProjectFollowupLogic.findLastByProject(this);
    }
    
    public double getPOC() throws Exception {
    	
    	Double poc = null;
    	try {
    		Projectactivity rootActivity = getRootActivity();
    		if (rootActivity != null) {
    			poc = rootActivity.getPocCalc();
    		}
    		else {
    			ExceptionUtil.sendToLogger(LOGGER, "No hay actividad principal", this);
    		}
    	}
    	catch (Exception e) {
			ExceptionUtil.sendToLogger(LOGGER, e, null);
		}
    	return (poc == null?0:poc);
    }
    
    public double getPOC(Session session) throws Exception {
    	
    	Double poc = null;
    	try {
    		ProjectActivityDAO activityDAO	= new ProjectActivityDAO(session);
        	Projectactivity rootActivity	= activityDAO.consRootActivity(this);
        	
    		if (rootActivity != null) {
    			poc = activityDAO.calcPoc(rootActivity);
    		}
    		else {
    			ExceptionUtil.sendToLogger(LOGGER, "No hay actividad principal", this);
    		}
    	}
    	catch (Exception e) {
			ExceptionUtil.sendToLogger(LOGGER, e, null);
		}
    	return (poc == null?0:poc);
    }
    
	public Double getExternalCosts() {
		
		Double costs = null;
		try {
			costs = ProjectLogic.calcExternalCosts(this);
		}
    	catch (Exception e) {
			ExceptionUtil.sendToLogger(LOGGER, e, null);
		}
		
		return (costs == 0?null:costs);
	}
}

