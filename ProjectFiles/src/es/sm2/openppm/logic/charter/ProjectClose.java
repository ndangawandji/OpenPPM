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
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.odftoolkit.odfdom.doc.OdfDocument;
import org.odftoolkit.odfdom.doc.OdfTextDocument;
import org.odftoolkit.odfdom.incubator.search.TextNavigation;
import org.odftoolkit.odfdom.incubator.search.TextSelection;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.common.Settings;
import es.sm2.openppm.dao.ChecklistDAO;
import es.sm2.openppm.dao.DocumentprojectDAO;
import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.dao.ProjectCharterDAO;
import es.sm2.openppm.dao.ProjectCostsDAO;
import es.sm2.openppm.dao.ProjectDAO;
import es.sm2.openppm.dao.ProjectFollowupDAO;
import es.sm2.openppm.model.Checklist;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectassociation;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.model.Projectclosure;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Stakeholder;
import es.sm2.openppm.model.Workingcosts;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.utils.StringUtil;

/**
 * 
 * @author Dani
 *
 */
public class ProjectClose extends ProjectCloseTemplate {

	public final static Logger LOGGER = Logger.getLogger(ProjectClose.class);

	private static final String templateFilename = "es/sm2/openppm/templates/project_close_reverso_template.odt";
	
	@SuppressWarnings("unused")
	private ResourceBundle languageResource = null;

	/**
	 * 
	 */
	public File generateClose(ResourceBundle langResource, Project project, Projectcharter projectCharter, String...args) 
	throws Exception {
		
		File charterDocFile = null;
		
		this.languageResource = langResource;
		
		Session session 	= null;
		Transaction tx 		= null;
		
		try {
			session = SessionFactoryUtil.getInstance().getCurrentSession();
			tx = session.beginTransaction();
		
			ProjectActivityDAO projectActivityDAO	= new ProjectActivityDAO(session);
			ProjectFollowupDAO projectFollowupDAO	= new ProjectFollowupDAO(session);
			ProjectCostsDAO projectCostsDAO			= new ProjectCostsDAO(session);
			ProjectCharterDAO charterDAO			= new ProjectCharterDAO(session);
			ProjectDAO projectDAO					= new ProjectDAO(session);
			DocumentprojectDAO docProjDAO			= new DocumentprojectDAO(session);
			ChecklistDAO checklistDAO				= new ChecklistDAO(session);

			Project projectData	= projectDAO.findById(project.getIdProject(), false);
			
			Projectcharter projectCharterData = charterDAO.findById(projectCharter.getIdProjectCharter(), false);
		
			projectCharter.setProject(project);
			
			Projectactivity mainActivity = projectActivityDAO.consRootActivity(project);
			Projectfollowup lastFollowup = projectFollowupDAO.findLastByProject(project);
			List<Projectcosts> projectCostsList = projectCostsDAO.findDirectCostsByProject(project);
			List<Documentproject> projectDocs = docProjDAO.findByRelation(Documentproject.PROJECT, project);
			List<Checklist> checklists = checklistDAO.findByProject(project);
			
			// Generate Charter doc (.odt)
			charterDocFile = fillCharter (session, 
					projectData, projectCharterData, mainActivity, lastFollowup, projectCostsList, projectDocs, checklists, args);
			
			tx.commit();
		}
		catch (Exception e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		
		return charterDocFile;
	}
	
	
	@SuppressWarnings("rawtypes")
	private File fillCharter (Session session, 
			Project proj, Projectcharter projCharter, Projectactivity mainActivity, 
			Projectfollowup lastFollowup, List<Projectcosts> projectCostsList, 
			List<Documentproject> projectDocs, List<Checklist> checklists, String[] args) 
	throws Exception {
		
		
		// *********************************************************
		// Header Params (EMPTY)
		//
		HashMap<String,String> headerParams = new HashMap<String,String>();
		
		headerParams.put("PO", 					proj.getPerformingorg().getName());
		
		String customerName = (proj.getCustomer() != null) ? proj.getCustomer().getName() : "";
		headerParams.put ("Customer", 			customerName);
		
		String programName = (proj.getProgram()!=null)?proj.getProgram().getProgramName():"";
		headerParams.put("Program",				programName);

		String shortName = (proj.getChartLabel() != null) ? proj.getChartLabel() : "";
		headerParams.put("ProjectShortName",	shortName);
		
		headerParams.put("LoggedUser",		args[0]);

		String accountingCode = (proj.getAccountingCode() != null) ? proj.getAccountingCode() : "";
		headerParams.put("AccountingCode",		accountingCode);
		
		headerParams.put("ClosingDate",		proj.getEndDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getEndDate()) : "");
		
		// *********************************************************
		// Document Params
		//
		HashMap<String,String> docParams = new HashMap<String,String>();
		
		Projectclosure closure = null;
		
		if(proj.getProjectclosures().size() > 0) {
			List<Projectclosure> closures = new ArrayList<Projectclosure>(proj.getProjectclosures());
			closure = closures.get(0);
		}

		// 1. Identificacion
		//
		
		docParams.put("ProjectName",		proj.getProjectName() != null ? proj.getProjectName() : "");
		docParams.put("Priority",			(proj.getPriority() != null ? proj.getPriority() + " %" : ""));
		
		docParams.put("BaselineStart",		proj.getPlannedInitDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getPlannedInitDate()) : "");
		docParams.put("ActualStart",		proj.getInitDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getInitDate()) : "");
		docParams.put("BaselineFinish",		proj.getPlannedFinishDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getPlannedFinishDate()) : "");
		docParams.put("ActualFinish",		proj.getEndDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getEndDate()) : "");

		int desarrolloP = 0;
		int operacionesP = 0;
		int sistemasP = 0;
		int sumaP = 0;
		
		int desarrolloR = 0;
		int operacionesR = 0;
		int sistemasR = 0;
		int sumaR = 0;
		
		for (Workingcosts cost : proj.getWorkingcostses()) {
			if(cost.getResourceDepartment().equals(Settings.WORKING_COST_DEPARTMENTS[0])) {
				desarrolloP += (cost.getEffort()== null?0:cost.getEffort());
				desarrolloR += (cost.getRealEffort()== null?0:cost.getRealEffort());
			}
			else if(cost.getResourceDepartment().equals(Settings.WORKING_COST_DEPARTMENTS[1])) {
				operacionesP += (cost.getEffort()== null?0:cost.getEffort());
				operacionesR += (cost.getRealEffort()== null?0:cost.getRealEffort());
			}
			else if(cost.getResourceDepartment().equals(Settings.WORKING_COST_DEPARTMENTS[2])) {
				sistemasP += (cost.getEffort()== null?0:cost.getEffort());
				sistemasR += (cost.getRealEffort()== null?0:cost.getRealEffort());
			}
		}
		
		sumaP = desarrolloP + operacionesP + sistemasP;
		sumaR = desarrolloR + operacionesR + sistemasR;
		
		docParams.put("Horas1D",	desarrolloP + "");
		docParams.put("Horas1O",	operacionesP + "");
		docParams.put("Horas1S",		sistemasP + "");
		docParams.put("Suma1T",				sumaP + "");
		
		docParams.put("Horas2D",	desarrolloR + "");
		docParams.put("Horas2O",	operacionesR + "");
		docParams.put("Horas2S",		sistemasR + "");
		docParams.put("Suma2T",				sumaR + "");

		docParams.put ("Customer", 			customerName);
		
		String sponsorName = "";
		if ((proj.getEmployeeBySponsor()!=null) && (proj.getEmployeeBySponsor().getContact()!=null)) {
			sponsorName = proj.getEmployeeBySponsor().getContact().getFullName();
		}
		docParams.put ("Sponsor", 			sponsorName);
		
		String perfOrg = proj.getPerformingorg() != null && proj.getPerformingorg().getName() != null ? proj.getPerformingorg().getName() : "";
		docParams.put("PerfOrg", 				perfOrg);
		
		String projectManagerName = "";
		if (proj.getEmployeeByProjectManager()!=null) {
			projectManagerName = proj.getEmployeeByProjectManager().getContact().getFullName();
		}
		docParams.put("ProjectManager",	projectManagerName);
		
		// 2. Descripcion detallada

		String projectInclusions = projCharter.getSucessCriteria() != null ? projCharter.getSucessCriteria() : "";		
		docParams.put("ProjectInclusions",	projectInclusions);
		
		String projectExclusions = projCharter.getBusinessNeed() != null ? projCharter.getBusinessNeed() : "";
		docParams.put("ProjectExclusions",	projectExclusions);

		// 3. Resultados del proyecto		
		
		String projectResults = closure != null && closure.getProjectResults() != null ? closure.getProjectResults() : "";
		docParams.put("ProjectResults",	projectResults);
		
		// 4. Impacto tecnico		
		
		String technicalImpact = projCharter.getMainAssumptions() != null ? projCharter.getMainAssumptions() : "";
		docParams.put("TechnicalImpact",	technicalImpact);
		
		// 5. Colectivos afectados
		
		String businessImpact = projCharter.getMainConstraints() != null ? projCharter.getMainConstraints() : "";
		docParams.put("BusinessImpact",		businessImpact);
		
		// 6. Depende de proyectos
		
		List<Projectassociation> leads = new ArrayList<Projectassociation>(proj.getProjectassociationsForDependent());
		
		for (int i = 0; i < 7; i++)  {
			String name = "";
			if(i < leads.size()) {
				Projectassociation lead = leads.get(i);
				name = lead.getProjectByLead() != null && 
						lead.getProjectByLead().getProjectName() != null ? lead.getProjectByLead().getProjectName() : "";
			}
			docParams.put("LeadingProjects" + i, name);
		}
		
		// 7. Afecta a proyectos
		
		List<Projectassociation> dependents = new ArrayList<Projectassociation>(proj.getProjectassociationsForLead());
		
		for (int i = 0; i < 7; i++)  {			
			String name = "";			
			if(i < dependents.size()) {
				Projectassociation dependent = dependents.get(i);				
				name = dependent.getProjectByDependent() != null && 
						dependent.getProjectByDependent().getProjectName() != null ? dependent.getProjectByDependent().getProjectName() : "";
			}
			docParams.put("DependentProjects" + i, name);
		}
		
		// 8. Cumplimiento de Objetivos		
		
		String goalResults = closure != null && closure.getGoalAchievement() != null ? closure.getGoalAchievement() : "";
		docParams.put("GoalResults",	goalResults);
		
		// 9. Hitos significativos 
		
		List<Milestones> milestones = new ArrayList<Milestones>(proj.getMilestoneses());
		
		for (int iMilestone = 0; iMilestone < 10; iMilestone++)  {			
			String description = "";
			String plannedDate = "";
			String realDate = "";
			
			if(iMilestone < milestones.size()) {
				Milestones milestone = milestones.get(iMilestone);				
				description = milestone.getDescription() != null ? milestone.getDescription() : "";
				plannedDate = milestone.getPlanned() != null ? DateUtil.format(Constants.DATE_PATTERN, milestone.getPlanned()) : "";
				realDate = milestone.getAchieved() != null ? DateUtil.format(Constants.DATE_PATTERN, milestone.getAchieved()) : "";
			}
			docParams.put("MilestoneDescription" + iMilestone, description);
			docParams.put("DueDate" + iMilestone, plannedDate);
			docParams.put("ActualDate" + iMilestone, realDate);
		}
		
		// 10. Participantes (stakeholders)
		
		List<Stakeholder> stakeholders = new ArrayList<Stakeholder>(proj.getStakeholders());
		
		for (int iStakeholder = 0; iStakeholder < 10; iStakeholder++)  {
			
			String department = "";
			String name = "";
			String role = "";
			if(iStakeholder < stakeholders.size()) {
				Stakeholder stakeholder = stakeholders.get(iStakeholder);
				department = stakeholder.getDepartment() != null ? stakeholder.getDepartment() : "";
				name = stakeholder.getContactName() != null ? stakeholder.getContactName() : "";
				role = stakeholder.getProjectRole() != null ? stakeholder.getProjectRole() : "";
			}			
			docParams.put("StakeholderDep" + iStakeholder, department);
			docParams.put("Stakeholder" + iStakeholder, name);
			docParams.put("StakeholderRole" + iStakeholder, role);
		}
		
		// 11. Entregables
		
		for (int iChecks = 0; iChecks < 10; iChecks++)  {
			
			String deliverable = "";
			String date = "";
			String comments = "";
			if(iChecks < checklists.size()) {
				Checklist checklist = checklists.get(iChecks);
				deliverable = checklist.getWbsnode() != null && checklist.getWbsnode().getName() != null? checklist.getWbsnode().getName() : "";
				date = checklist.getActualizationDate() != null ? DateUtil.format(Constants.DATE_PATTERN, checklist.getActualizationDate()) : "";
				comments = checklist.getDescription() != null ? checklist.getDescription() : "";
			}			
			docParams.put("Deliverable" + iChecks, deliverable);
			docParams.put("DeliveryDate" + iChecks, date);
			docParams.put("DeliverableComment" + iChecks, comments);
		}
		
		// 12. Lecciones aprendidas		
		
		String lessonsLearned = closure != null && closure.getLessonsLearned() != null ? closure.getLessonsLearned() : "";
		docParams.put("LessonsLearned",	lessonsLearned);
		
		// 13. Document repository
				
		docParams.put("URLFSDoc", proj.getLinkDoc() != null ? proj.getLinkDoc() : "");
		docParams.put("CommentFSDoc", proj.getLinkComment() != null ? proj.getLinkComment() : "");
		
		String initDoc = "";
		String initComment = "";
		String riskDoc = "";
		String riskComment = "";
		String planDoc = "";
		String planComment = "";
		String contDoc = "";
		String contComment = "";
		String procDoc = "";
		String procComment = "";
		
		for (Documentproject doc : projectDocs) {
			if(doc.getType().equals(Constants.DOCUMENT_INITIATING) && doc.getLink() != null) {
				initDoc = doc.getLink();
				initComment = doc.getContentComment() != null ? doc.getContentComment() : "";
			}
			else if(doc.getType().equals(Constants.DOCUMENT_RISK) && doc.getLink() != null) {
				riskDoc = doc.getLink();
				riskComment = doc.getContentComment() != null ? doc.getContentComment() : "";
			}
			else if(doc.getType().equals(Constants.DOCUMENT_PLANNING) && doc.getLink() != null) {
				planDoc = doc.getLink();
				planComment = doc.getContentComment() != null ? doc.getContentComment() : "";
			}
			else if(doc.getType().equals(Constants.DOCUMENT_CONTROL) && doc.getLink() != null) {
				contDoc = doc.getLink();
				contComment = doc.getContentComment() != null ? doc.getContentComment() : "";
			}
			else if(doc.getType().equals(Constants.DOCUMENT_PROCUREMENT) && doc.getLink() != null) {
				procDoc = doc.getLink();
				procComment = doc.getContentComment() != null ? doc.getContentComment() : "";
			}
		}
		docParams.put("URLInitiationDoc", initDoc);
		docParams.put("CommentInitiationDoc", initComment);

		docParams.put("URLRiskDoc", riskDoc);
		docParams.put("CommentRiskDoc", riskComment);

		docParams.put("URLPlanningDoc", planDoc);
		docParams.put("CommentPlanningDoc", planComment);

		docParams.put("URLControlDoc", contDoc);
		docParams.put("CommentControlDoc", contComment);
		
		docParams.put("URLProcurementDoc", procDoc);
		docParams.put("CommentProcurementDoc", procComment);
		
		//
		// Generate odt document with the params
		//
		
		URL url = ProjectClose.class.getResource("/" + templateFilename);

		String fullTemplateFilename = "";
		
		if (url != null) {
			fullTemplateFilename = URLDecoder.decode(url.getFile(),"UTF-8");
		}
		
		OdfDocument doc = OdfTextDocument.loadDocument(fullTemplateFilename);
		
		Iterator itHeader = headerParams.entrySet().iterator();
		
		while (itHeader.hasNext()) {
			Map.Entry pairs = (Map.Entry)itHeader.next();
		    
			String key = (String)pairs.getKey();
			String value = (String)pairs.getValue();
		
			TextNavigation search = new TextNavigation (key, (OdfTextDocument)doc);
			
			while (search.hasNext()) {
				TextSelection item = (TextSelection)search.getCurrentItem();								
				item.replaceWith(value);
			}
		}
		
		Iterator itDoc = docParams.entrySet().iterator();
		
		while (itDoc.hasNext()) {
			Map.Entry pairs = (Map.Entry)itDoc.next();
		    
			String key = (String)pairs.getKey();
			String value = (String)pairs.getValue();
		
			TextNavigation search = new TextNavigation (key, (OdfTextDocument)doc);
			
			while (search.hasNext()) {
				TextSelection item = (TextSelection)search.getCurrentItem();
				item.replaceWith(value);
			}
		}
		
		File document = new File(outputFile+StringUtil.clearSlashes(proj.getProjectName()) + "_" + proj.getChartLabel() + ".odt");
		LOGGER.info("Absolute Path for file: "+document.getAbsolutePath());
		doc.save(document);
		
		return document;
	}
}
