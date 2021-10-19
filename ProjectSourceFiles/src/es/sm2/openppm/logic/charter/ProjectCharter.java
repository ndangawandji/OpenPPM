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
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.odftoolkit.odfdom.doc.OdfDocument;
import org.odftoolkit.odfdom.doc.OdfTextDocument;
import org.odftoolkit.odfdom.incubator.search.TextNavigation;
import org.odftoolkit.odfdom.incubator.search.TextSelection;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.ChargescostsDAO;
import es.sm2.openppm.dao.DocumentprojectDAO;
import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.dao.ProjectCharterDAO;
import es.sm2.openppm.dao.ProjectCostsDAO;
import es.sm2.openppm.dao.ProjectDAO;
import es.sm2.openppm.dao.ProjectFollowupDAO;
import es.sm2.openppm.dao.WorkingcostsDAO;
import es.sm2.openppm.model.Chargescosts;
import es.sm2.openppm.model.Directcosts;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Workingcosts;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.utils.StringUtil;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * 
 * @author Dani
 *
 */
public class ProjectCharter extends ProjectCharterTemplate {

	public final static Logger LOGGER = Logger.getLogger(ProjectCharter.class);

	private static final String templateFilename = "es/sm2/openppm/templates/project_charter_reverso_template.odt";
	
	private ResourceBundle languageResource = null;


	/**
	 * 
	 */
	public File generateCharter(ResourceBundle langResource, Project project, Projectcharter projectCharter, String...args) 
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

			Project projectData	= projectDAO.findById(project.getIdProject(), false);
			
			Projectcharter projectCharterData = charterDAO.findById(projectCharter.getIdProjectCharter(), false);
		
			projectCharter.setProject(project);
			
			Projectactivity mainActivity = projectActivityDAO.consRootActivity(project);
			Projectfollowup lastFollowup = projectFollowupDAO.findLastByProject(project);
			List<Projectcosts> projectCostsList = projectCostsDAO.findDirectCostsByProject(project);
			
			// Generate Charter doc (.odt)
			charterDocFile = fillCharter (session, 
					projectData, projectCharterData, mainActivity, lastFollowup, projectCostsList);
			
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
	
	
	@SuppressWarnings({ "rawtypes", "unused" })
	private File fillCharter (Session session, 
			Project proj, Projectcharter projCharter, Projectactivity mainActivity, 
			Projectfollowup lastFollowup, List<Projectcosts> projectCostsList) 
	throws Exception {
		
		DocumentprojectDAO documentDAO = new DocumentprojectDAO(session);
		ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
		
		// Document Params
		//
		HashMap<String,String> docParams = new HashMap<String,String>();

		docParams.put("POName", proj.getPerformingorg() != null && proj.getPerformingorg().getName() != null ? proj.getPerformingorg().getName() : "");
		
		String projectShortName = "";
		if (proj.getChartLabel() != null) {
			projectShortName = proj.getChartLabel() + " - ";
		}
		docParams.put("ProjectShortName",	projectShortName);
		docParams.put("ProjectName",		proj.getProjectName() != null ? proj.getProjectName() : "");
		
		String budgetYear = "";
		if (proj.getBudgetYear() != null) {
			budgetYear = (proj.getBudgetYear() !=0 ) ? "" + proj.getBudgetYear() : "";
		}
		docParams.put("BudgetYear",			budgetYear);

		String accountingCode = (proj.getAccountingCode()!=null)?proj.getAccountingCode():"";
		docParams.put("AccountingCode",		accountingCode);
		
		String projectManagerName		= "";
		String projectManagerJobTitle	= "";
		
		if ((proj.getEmployeeByProjectManager()!=null) && (proj.getEmployeeByProjectManager()!=null)) {
			projectManagerName = proj.getEmployeeByProjectManager().getContact().getFullName();
			projectManagerJobTitle = proj.getEmployeeByProjectManager().getContact().getJobTitle();
		}
		docParams.put("ProjectManagerName",	projectManagerName);
		docParams.put("ProjectManagerJobTitle",	projectManagerName);
		
		String programName = (proj.getProgram()!=null)?proj.getProgram().getProgramName():"";
		docParams.put("ProgramName",		programName);
		
		if ((proj.getEmployeeBySponsor()!=null) && (proj.getEmployeeBySponsor().getContact()!=null)) {
			docParams.put("SponsorName",		proj.getEmployeeBySponsor().getContact().getFullName() != null ? proj.getEmployeeBySponsor().getContact().getFullName() : "");
			docParams.put("SponsorJobTitle",	proj.getEmployeeBySponsor().getContact().getJobTitle() != null ? proj.getEmployeeBySponsor().getContact().getJobTitle() : "");
		}
		else {
			docParams.put("SponsorName",		"");
			docParams.put("SponsorJobTitle",	"");
		}
		
		String customerName = (proj.getCustomer()!=null && proj.getCustomer().getName()!=null)?proj.getCustomer().getName():"";
		docParams.put("CustomerValue",			customerName);
		
		String categoryName = (proj.getCategory()!=null && proj.getCategory().getName() != null)?proj.getCategory().getName():"";
		docParams.put("CategoryValue",			categoryName);

		docParams.put("ProjectDescription",	projCharter.getSucessCriteria() != null ? projCharter.getSucessCriteria() : "");
		docParams.put("ProjectObjectives",	projCharter.getProjectObjectives() != null ? projCharter.getProjectObjectives() : "");
		String projectExclusions = projCharter.getBusinessNeed() != null ? projCharter.getBusinessNeed() : "";
		docParams.put("BusinessNeed",	projectExclusions);
		String businessImpact = projCharter.getMainConstraints() != null ? projCharter.getMainConstraints() : "";
		docParams.put("MainConstraints",		businessImpact);
		String mainRisks = projCharter.getMainRisks() != null ? projCharter.getMainRisks() : "";
		docParams.put("MainRisks",			mainRisks);
		String technicalImpact = projCharter.getMainAssumptions() != null ? projCharter.getMainAssumptions() : "";
		docParams.put("MainAssumptions",	technicalImpact);
		
		docParams.put("PlannedStartDate",	proj.getPlannedInitDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getPlannedInitDate()) : "");
		docParams.put("PlannedFinishDate",	proj.getPlannedFinishDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getPlannedFinishDate()) : "");
		docParams.put("SAC",				(proj.getDuration() != null?proj.getDuration()+"":""));
		
		
		ChargescostsDAO chargescostsDAO = new ChargescostsDAO(session);
		
		//
		// Sellers - Empresas Externas
		//
		List<Chargescosts> sellersCosts = chargescostsDAO.consChargescostsByProject(
				proj, Constants.SELLER_CHARGE_COST);
		
		double totalSellersCost = 0;
		
		int countSellers = 0;
		for (Chargescosts sellerCost : sellersCosts) {
			if (countSellers <= 2) {
				docParams.put("Seller"+(countSellers+1), 		sellerCost.getName() != null ? sellerCost.getName() : "");
				docParams.put("SellerCost"+(countSellers+1),	sellerCost.getCost() != null ? ""+ValidateUtil.toCurrencyWord(sellerCost.getCost()) : "");
				countSellers++;
			}
			totalSellersCost += sellerCost.getCost();
		}
		
		if (countSellers < 3) {
			for (int index=countSellers; index<3; index++) {
				docParams.put("Seller"+(index+1), 			"");
				docParams.put("SellerCost"+(index+1),	"");
			}
		}
		docParams.put("TotalSellersCost", "" + ValidateUtil.toCurrencyWord(totalSellersCost));
		
		// Expenses - Coste de infraestructura. 
		
		List<Chargescosts> infrastructureCosts = chargescostsDAO.consChargescostsByProject(
				proj, Constants.INFRASTRUCTURE_CHARGE_COST);
		
		double totalInfraestructureCost = 0;
		int countInfra = 0;
		for (Chargescosts infraCost : infrastructureCosts) {
			if (countInfra <= 2) {
				docParams.put("Infrastructure"+(countInfra+1), 			infraCost.getName());
				docParams.put("InfrastructureCost"+(countInfra+1),	""+ValidateUtil.toCurrencyWord(infraCost.getCost()));
				countInfra++;
			}
			totalInfraestructureCost += infraCost.getCost();
		}

		if (countInfra < 3) {
			for (int index=countInfra; index<3; index++) {
				docParams.put("Infrastructure"+(index+1), 			"");
				docParams.put("InfrastructureCost"+(index+1),	"");
			}
		}
		docParams.put("InfrastructureTotalCost", ""+ValidateUtil.toCurrencyWord(totalInfraestructureCost));
		
		// Expenses - Licencias. 
		
		List<Chargescosts> licensesCosts = chargescostsDAO.consChargescostsByProject(
				proj, Constants.LICENSE_CHARGE_COST);
		
		double totalLicensesCost = 0;
		int countLicense = 0;
		for (Chargescosts licenseCost : licensesCosts) {
			if (countLicense <= 2) {
				docParams.put("License"+(countLicense+1), 			licenseCost.getName());
				docParams.put("License"+(countLicense+1)+"Cost",	""+ValidateUtil.toCurrencyWord(licenseCost.getCost()));
				countLicense++;
			}
			totalLicensesCost += licenseCost.getCost();
		}
		
		if (countLicense < 3) {
			for (int index=countLicense; index<3; index++) {
				docParams.put("License"+(index+1), 			"");
				docParams.put("License"+(index+1)+"Cost",	"");
			}
		}
		docParams.put("LicensesCost", ""+ValidateUtil.toCurrencyWord(totalLicensesCost));
		double expenses = totalSellersCost + totalInfraestructureCost + totalLicensesCost;
		docParams.put("Expenses",	""+ValidateUtil.toCurrencyWord(expenses));

		// Personal interno asignado
		
		int totalEffort = 0;
		double totalWorkCost = 0;
		
		WorkingcostsDAO workingcostsDAO = new WorkingcostsDAO(session);
		List<Workingcosts> workingCostList = workingcostsDAO.consByProject(proj);
		int countWorking = 0;
		for (Workingcosts workingcost : workingCostList) {
			if (countWorking <= 2) {
				docParams.put("Name"+(countWorking+1), 			workingcost.getResourceName());
				docParams.put("Department"+(countWorking+1),	workingcost.getResourceDepartment());	
				docParams.put("Effort"+(countWorking+1), 		""+workingcost.getEffort());
				docParams.put("Rate"+(countWorking+1), 			""+ValidateUtil.toCurrencyWord(workingcost.getRate()));
				docParams.put("WorkCost"+(countWorking+1), 		""+ValidateUtil.toCurrencyWord(workingcost.getWorkCost()));
				countWorking++;
			}
			totalEffort += workingcost.getEffort();
			totalWorkCost += workingcost.getWorkCost();
		}
		if (countWorking < 3) {
			for (int index=countWorking; index<3; index++) {
				docParams.put("Name"+(index+1), 		"");
				docParams.put("Department"+(index+1),	"");	
				docParams.put("Effort"+(index+1), 		"");
				docParams.put("Rate"+(index+1), 		"");
				docParams.put("WorkCost"+(index+1), 	"");
			}
		}
		docParams.put("TotalEffort", 	""+totalEffort);
		docParams.put("WorkCosts",	""+ValidateUtil.toCurrencyWord(totalWorkCost));

		// Documentos adjuntos
		//
		Documentproject docInitiaintg = documentDAO.findByType(proj, Constants.DOCUMENT_INITIATING);
		Documentproject docPlanning = documentDAO.findByType(proj, Constants.DOCUMENT_PLANNING);
		
		String urlInvestment = (proj.getLinkDoc()!=null)?proj.getLinkDoc():"";
		String urlInitiating = (docInitiaintg != null?docInitiaintg.getLink():"");
		String urlPlanning = (docPlanning != null?docPlanning.getLink():"");

		docParams.put("URL_Investment", 		urlInvestment);
		docParams.put("URL_Initiating", 		urlInitiating);
		docParams.put("URL_PlanningSchedule",	urlPlanning);
		

		// ----------------------------------------------------------
		// REVERSO (Parametros que no estan en el anverso)
		// ----------------------------------------------------------
		
		docParams.put("ProjectStatus",	languageResource.getString("project_status."+proj.getStatus()));
		
		String actualInitDate = "";
		String plannedEndDate = "";
		Double poc = 0D; 
		double actualCost = 0;

		String baselineInitDate = proj.getPlannedInitDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getPlannedInitDate()) : "";
		String baselineEndDate = proj.getPlannedFinishDate() != null ? DateUtil.format(Constants.DATE_PATTERN, proj.getPlannedFinishDate()) : "";
		docParams.put("BaselineInitDate",	baselineInitDate);
		docParams.put("BaselineEndDate",	baselineEndDate);
		
		if (mainActivity != null) {
			
			actualInitDate = DateUtil.format(Constants.DATE_PATTERN, mainActivity.getActualInitDate());
			plannedEndDate = DateUtil.format(Constants.DATE_PATTERN, mainActivity.getActualEndDate());
			poc = activityDAO.calcPoc(mainActivity);
			poc = (poc == null ? 0 : poc);
			actualCost = (mainActivity.getAc() != null) ? mainActivity.getAc() : 0;
		}	
		
		docParams.put("ActualInitDate",		actualInitDate);
		docParams.put("PlannedEndDate",		plannedEndDate);
		docParams.put("POC",				ValidateUtil.toCurrency(poc) + "%");
		docParams.put("ActualCost",			ValidateUtil.toCurrencyWord(actualCost));
		
		double actualDirectCosts = 0;
		
		for (Projectcosts projectCost : projectCostsList) {
			
			Set<Directcosts> directCostsList = projectCost.getDirectcostses();
			for (Directcosts cost : directCostsList) {
				if (cost.getActual() != null) {
					actualDirectCosts += cost.getActual();
				}
			}
		}
		
		docParams.put("ActualDirectCosts",	ValidateUtil.toCurrencyWord(actualDirectCosts));

		String generalComments = "";
		String riskComments = "";
		String scheduleComments = "";
		String costComments = "";
		
		if (lastFollowup != null) {
			
			generalComments		= (lastFollowup.getGeneralComments()!=null)?lastFollowup.getGeneralComments():"";
			riskComments		= (lastFollowup.getRisksComments()!=null)?lastFollowup.getRisksComments():"";
			scheduleComments	= (lastFollowup.getScheduleComments()!=null)?lastFollowup.getScheduleComments():"";
			costComments		= (lastFollowup.getCostComments()!=null)?lastFollowup.getCostComments():"";
		}
		
		docParams.put("GeneralComments",	generalComments);
		docParams.put("RiskComments",	riskComments);
		docParams.put("ScheduleComments",	scheduleComments);
		docParams.put("CostComments",	costComments);
		
		//
		// Generate odt document with the params
		//
		URL url = ProjectCharter.class.getResource("/" + templateFilename);

		String fullTemplateFilename = "";
		
		if (url != null) {
			fullTemplateFilename = URLDecoder.decode(url.getFile(),"UTF-8");
		}
		
		OdfDocument doc = OdfTextDocument.loadDocument(fullTemplateFilename);
		
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
		
		File document = new File(
				outputFile +
				StringUtil.clearSlashes(proj.getProjectName()) + "_" + proj.getChartLabel() + ".odt");
		
		LOGGER.info("Absolute Path for file: "+document.getAbsolutePath());
		doc.save(document);

		return document;
	}
}
