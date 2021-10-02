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
package es.sm2.openppm.notify;

import java.util.List;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.logic.MilestoneLogic;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.servlets.HomeServlet;
import es.sm2.openppm.utils.EmailUtil;
import es.sm2.openppm.utils.ExceptionUtil;
import es.sm2.openppm.utils.ValidateUtil;

public class MilestoneNotify implements Job {

	public final static Logger LOGGER = Logger.getLogger(HomeServlet.class);
	
	public MilestoneNotify() {}
	
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
		try {
			List<Milestones> milestones = MilestoneLogic.findForNotify();
			
			for (Milestones milestone : milestones) {
				
				Contact contact = milestone.getProject().getEmployeeByProjectManager().getContact();
				
				if (Settings.MAIL_NOTIFICATION && !ValidateUtil.isNull(contact.getEmail())) {
					
					String subject = "[OpenPPM] - Milestone Notify - Project: " + milestone.getProject().getProjectName();					
					EmailUtil email = new EmailUtil(Constants.EMAIL_USER, contact.getEmail());
					email.setSubject(subject);
					email.setBodyText(milestone.getNotificationText());
					email.send();
					LOGGER.info("Send notification milestone to:"+contact.getFullName());
				}
				else if (Settings.MAIL_NOTIFICATION) {
					LOGGER.error(contact.getFullName()+" not mail configured for milestone notification");
				}
			}
		}
		catch (Exception e) { ExceptionUtil.sendToLogger(LOGGER, e, null); }
	}

}
