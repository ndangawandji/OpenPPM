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
package es.sm2.openppm.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import es.sm2.openppm.common.Constants;
import es.sm2.openppm.exceptions.AssumptionNotFoundException;
import es.sm2.openppm.exceptions.BudgetAccountNotFoundException;
import es.sm2.openppm.exceptions.CategoryNotFoundException;
import es.sm2.openppm.exceptions.CompanyNotFoundException;
import es.sm2.openppm.exceptions.ContactNotFoundException;
import es.sm2.openppm.exceptions.ContracttypeNotFoundException;
import es.sm2.openppm.exceptions.EmployeeNotFoundException;
import es.sm2.openppm.exceptions.ExpenseaccountNotFoundException;
import es.sm2.openppm.exceptions.FollowupNotFoundException;
import es.sm2.openppm.exceptions.GeographyNotFoundException;
import es.sm2.openppm.exceptions.IssueNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.exceptions.OperationNotFoundException;
import es.sm2.openppm.exceptions.OperationaccountNotFoundException;
import es.sm2.openppm.exceptions.PerfOrgNotFoundException;
import es.sm2.openppm.exceptions.ProgramNotFoundException;
import es.sm2.openppm.exceptions.RiskNotFoundException;
import es.sm2.openppm.exceptions.TeammemberNotFoundException;
import es.sm2.openppm.javabean.TeamMembersFTEs;
import es.sm2.openppm.model.Assumptionreassessmentlog;
import es.sm2.openppm.model.Assumptionregister;
import es.sm2.openppm.model.Budgetaccounts;
import es.sm2.openppm.model.Category;
import es.sm2.openppm.model.Changecontrol;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Contracttype;
import es.sm2.openppm.model.Documentproject;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expenseaccounts;
import es.sm2.openppm.model.Geography;
import es.sm2.openppm.model.Incomes;
import es.sm2.openppm.model.Issuelog;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Operation;
import es.sm2.openppm.model.Operationaccount;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Projectkpi;
import es.sm2.openppm.model.Riskreassessmentlog;
import es.sm2.openppm.model.Riskregister;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.model.Skillsemployee;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Wbsnode;

public final class JSONModelUtil {

	/**
	 * Get JSON Object from project followup
	 * @param followup
	 * @param project If is not null, set followup properties: project_name, cv, vac, tv, tvac
	 * @return
	 * @throws Exception
	 */
	public static JSONObject followupToJSON(ResourceBundle idioma, Projectfollowup followup, Project project) throws Exception {
		if (followup == null) {
			throw new FollowupNotFoundException();
		}
		
		JSONObject followupJSON = new JSONObject();
		followupJSON.put("id", followup.getIdProjectFollowup());
		
		if (project != null) {
			
			followupJSON.put("project_name", project.getProjectName());
			followupJSON.put("cv", ValidateUtil.toPercent(followup.getCv()));
		}
		
		followupJSON.put("cpi", ValidateUtil.toPercent(followup.getCpi()));
		followupJSON.put("spi", ValidateUtil.toPercent(followup.getSpi()));
		followupJSON.put("poc", ValidateUtil.toPercent(followup.getPoc()));
		
		followupJSON.put("ev", followup.getEv());
		followupJSON.put("ac", followup.getAc());
		followupJSON.put("date", DateUtil.format(idioma, followup.getFollowupDate()));
		
		Integer daysToDate		= followup.getDaysToDate();
		String daysToDateStr	= (daysToDate == null?StringPool.BLANK:daysToDate.toString());
		
		followupJSON.put("daysToDate", daysToDateStr);
		followupJSON.put("pv", followup.getPv());
		
		followupJSON.put("general_status", followup.getGeneralFlag() == null ? StringPool.BLANK : followup.getGeneralFlag());
		followupJSON.put("general_desc", followup.getGeneralComments() == null ? StringPool.BLANK : followup.getGeneralComments());
		followupJSON.put("risk_status", followup.getRiskFlag() == null ? StringPool.BLANK : followup.getRiskFlag());
		followupJSON.put("risk_desc", followup.getRisksComments() == null ? StringPool.BLANK : followup.getRisksComments());
		followupJSON.put("schedule_status", followup.getScheduleFlag() == null ? StringPool.BLANK : followup.getScheduleFlag());
		followupJSON.put("schedule_desc", followup.getScheduleComments() == null ? StringPool.BLANK : followup.getScheduleComments());
		followupJSON.put("cost_status", followup.getCostFlag() == null ? StringPool.BLANK : followup.getCostFlag());
		followupJSON.put("cost_desc", followup.getCostComments() == null ? StringPool.BLANK : followup.getCostComments());
		
		return followupJSON;
	}
	
	
	/**
	 * Project Followup to JSON
	 * @param idioma
	 * @param followup
	 * @return
	 * @throws LogicException
	 */
	public static JSONObject followupToJSON(ResourceBundle idioma, Projectfollowup followup) throws LogicException {
		
		JSONObject followupJSON = new JSONObject();
		
		if (followup != null) {
			followupJSON.put("date", DateUtil.format(idioma, followup.getFollowupDate()));
			
			followupJSON.put("general_status", followup.getGeneralFlag() == null ? StringPool.BLANK : followup.getGeneralFlag());
			followupJSON.put("general_desc", followup.getGeneralComments() == null ? StringPool.BLANK : followup.getGeneralComments());
			followupJSON.put("risk_status", followup.getRiskFlag() == null ? StringPool.BLANK : followup.getRiskFlag());
			followupJSON.put("risk_desc", followup.getRisksComments() == null ? StringPool.BLANK : followup.getRisksComments());
			followupJSON.put("schedule_status", followup.getScheduleFlag() == null ? StringPool.BLANK : followup.getScheduleFlag());
			followupJSON.put("schedule_desc", followup.getScheduleComments() == null ? StringPool.BLANK : followup.getScheduleComments());
			followupJSON.put("cost_status", followup.getCostFlag() == null ? StringPool.BLANK : followup.getCostFlag());
			followupJSON.put("cost_desc", followup.getCostComments() == null ? StringPool.BLANK : followup.getCostComments());
		}
		
		return followupJSON;
	}
	
	
	/**
	 * Get JSON Object from project activity
	 * @param activity
	 * @return
	 * @throws Exception
	 */
	public static JSONObject activityToJSON(ResourceBundle idioma, Projectactivity activity) throws Exception {
		if (activity == null) {
			throw new NoDataFoundException();
		}
		
		JSONObject activityJSON = new JSONObject();
		activityJSON.put("id", activity.getIdActivity());
		activityJSON.put("name", activity.getActivityName());
		activityJSON.put("plan_init_date", DateUtil.format(idioma, activity.getPlanInitDate()));
		activityJSON.put("plan_end_date", DateUtil.format(idioma, activity.getPlanEndDate()));
		activityJSON.put("init_date", DateUtil.format(idioma, activity.getActualInitDate()));
		activityJSON.put("end_date", DateUtil.format(idioma, activity.getActualEndDate()));
		activityJSON.put("ev", activity.getEv());
		
		activityJSON.put("wp", activity.getWbsnode().getIdWbsnode());
		activityJSON.put("dictionary", activity.getWbsdictionary());
		
		return activityJSON;
	}
	
	/**
	 * Get JSON Object from project milestone
	 * @param milestone
	 * @return
	 * @throws Exception
	 */
	public static JSONObject milestoneToJSON(ResourceBundle idioma, Milestones milestone) throws Exception {
		if (milestone == null) {
			throw new NoDataFoundException();
		}
		
		JSONObject milestoneJSON = new JSONObject();
		milestoneJSON.put("id", milestone.getIdMilestone());
		milestoneJSON.put("label", milestone.getLabel());
		if (milestone.getProjectactivity() != null) {
			milestoneJSON.put("activity_name", milestone.getProjectactivity().getActivityName());
			milestoneJSON.put("idActivity", milestone.getProjectactivity().getIdActivity());
		}
		milestoneJSON.put("achieved", DateUtil.format(idioma, milestone.getAchieved()));
		
		milestoneJSON.put("planned", DateUtil.format(idioma, milestone.getPlanned()));
		milestoneJSON.put("report_type", milestone.getReportType());
		milestoneJSON.put("description", milestone.getDescription());
		
		return milestoneJSON;
	}
	
	
	/**
	 * Get JSON Object from project change control
	 * @param change
	 * @return
	 * @throws Exception
	 */
	public static JSONObject changeControlToJSON(ResourceBundle idioma, Changecontrol change) throws Exception {
		if (change == null) {
			throw new NoDataFoundException();
		}
		
		JSONObject changeJSON = new JSONObject();
		changeJSON.put("id", change.getIdChange());
		changeJSON.put("desc", change.getDescription());
		changeJSON.put("priority", change.getPriority());
		changeJSON.put("date", DateUtil.format(idioma, change.getChangeDate()));
		changeJSON.put("originator", change.getOriginator());
		changeJSON.put("type_desc", change.getChangetype().getDescription());
		changeJSON.put("type", change.getChangetype().getIdChangeType());
		changeJSON.put("solution", change.getRecommendedSolution());
		changeJSON.put("wbsnode", change.getWbsnode() != null ? change.getWbsnode().getIdWbsnode() : StringPool.BLANK);
		changeJSON.put("impact", change.getImpactDescription());
		changeJSON.put("effort", change.getEstimatedEffort());
		changeJSON.put("cost", change.getEstimatedCost());
		changeJSON.put("resolution", change.getResolution() != null ? change.getResolution() : StringPool.BLANK);
		changeJSON.put("resolution_date", DateUtil.format(idioma, change.getResolutionDate()));
		changeJSON.put("resolution_reason", change.getResolutionReason());
		
		return changeJSON;
	}


	/**
	 * Get JSON Object from income
	 * @param income
	 * @return
	 * @throws Exception
	 */
	public static JSONObject incomeToJSON(ResourceBundle idioma, Incomes income) throws Exception {
		if (income == null) {
			throw new NoDataFoundException();
		}
		
		Integer planDaysToDate	= income.getPlanDaysToDate();
		Integer actDaysToDate	= income.getActDaysToDate();
		
		JSONObject incomeJSON = new JSONObject();
		incomeJSON.put("id", income.getIdIncome());
		incomeJSON.put("planned_date", DateUtil.format(idioma, income.getPlannedBillDate()));
		incomeJSON.put("planDaysToDate", planDaysToDate == null?"":planDaysToDate);
		incomeJSON.put("actDaysToDate", actDaysToDate == null?"":actDaysToDate);
		incomeJSON.put("planned_amount", income.getPlannedBillAmmount());
		incomeJSON.put("description", income.getPlannedDescription());
		
		return incomeJSON;
	}
	
	
	/**
	 * Get JSON Object from employee
	 * @param employee
	 * @return
	 * @throws Exception
	 */
	public static JSONObject employeeToJSON(ResourceBundle idioma, Employee employee) throws Exception {
		if (employee == null) {
			throw new EmployeeNotFoundException();
		}
	
		JSONObject JSONEmployee = new JSONObject();
		JSONEmployee.put("id",	employee.getIdEmployee());
		JSONEmployee.put("contact_id", employee.getContact().getIdContact());
		JSONEmployee.put("name", employee.getContact().getFileAs());
		JSONEmployee.put("fullname", employee.getContact().getFullName());
		JSONEmployee.put(Contact.BUSINESSPHONE, employee.getContact().getBusinessPhone());
		JSONEmployee.put(Contact.MOBILEPHONE, employee.getContact().getMobilePhone());
		JSONEmployee.put(Contact.EMAIL, employee.getContact().getEmail());
		if (employee.getResourceprofiles() != null) { 
			JSONEmployee.put("profile", employee.getResourceprofiles().getProfileName());
			JSONEmployee.put("idProfile", employee.getResourceprofiles().getIdProfile());
		}
		else {
			JSONEmployee.put("profile", StringPool.SPACE);
			JSONEmployee.put("idProfile", -1);
		}
		if (employee.getEmployee() != null) { 
			JSONEmployee.put("resource_manager", employee.getEmployee().getContact().getFullName());
			JSONEmployee.put("idManager", employee.getIdEmployee());
		}
		else {
			JSONEmployee.put("idManager", -1);
			JSONEmployee.put("resource_manager", StringPool.SPACE);
			JSONEmployee.put("business_line", StringPool.SPACE);
		}
		
		if (employee.getCostRate() != null) {
			JSONEmployee.put("cost_rate", employee.getCostRate()); 
		}
		else { 
			JSONEmployee.put("cost_rate", 0); 
		}
		
		if (employee.getPerformingorg() != null) { 
			JSONEmployee.put("performing_org", employee.getPerformingorg().getName());
			JSONEmployee.put("idPerfOrg", employee.getPerformingorg().getIdPerfOrg());
		}
		else {
			JSONEmployee.put("performing_org", StringPool.SPACE);
			JSONEmployee.put("idPerfOrg", -1);
		}
		if (employee.getProfileDate() != null) { 
			JSONEmployee.put("profileDate", DateUtil.format(idioma, employee.getProfileDate()));
		}
		else {
			JSONEmployee.put("profileDate", StringPool.SPACE);
		}

		if (employee.getSkillsemployees() != null) {
			
			StringBuilder skills = new StringBuilder();
			String skill = null;
			
			JSONArray skillArray = new JSONArray();
			
			for (Skillsemployee listSkill: employee.getSkillsemployees()) {
				if (skill == null) {
					skills.append(listSkill.getSkill().getName());
					skill = listSkill.getSkill().getName();
				}
				else { skills.append("<br>" + listSkill.getSkill().getName()); }
				
				JSONObject skillJSON = new JSONObject();
				skillJSON.put(Skill.NAME, listSkill.getSkill().getName());
				skillJSON.put(Skill.IDSKILL, listSkill.getSkill().getIdSkill());
				skillArray.add(skillJSON);
			}
			
			JSONEmployee.put("skillArray", skillArray);
			if (skill == null) {
				JSONEmployee.put("skills", StringPool.SPACE);
				JSONEmployee.put("skill", StringPool.SPACE);
			}
			else {
				JSONEmployee.put("skills", skills.toString());
				JSONEmployee.put("skill", skill);
			}
		}
		else {
			JSONEmployee.put("skills", StringPool.SPACE);
			JSONEmployee.put("skill", StringPool.SPACE);
		}
		return JSONEmployee;
	}
	
	
	/**
	 * Get JSON Object from employee
	 * @param employee
	 * @return
	 * @throws Exception
	 */
	public static JSONObject simpleEmployeeToJSON(ResourceBundle idioma, Employee employee) throws Exception {
		if (employee == null) {
			throw new EmployeeNotFoundException();
		}
	
		JSONObject JSONEmployee = new JSONObject();
		JSONEmployee.put("id",	employee.getIdEmployee());
		JSONEmployee.put("contact_id", employee.getContact().getIdContact());
		JSONEmployee.put("name", employee.getContact().getFileAs());
		JSONEmployee.put("fullname", employee.getContact().getFullName());
		if (employee.getResourceprofiles() != null) { 
			JSONEmployee.put("profile", employee.getResourceprofiles().getProfileName());
			JSONEmployee.put("idProfile", employee.getResourceprofiles().getIdProfile());
		}
		else {
			JSONEmployee.put("profile", StringPool.SPACE);
			JSONEmployee.put("idProfile", -1);
		}
		if (employee.getEmployee() != null) { 
			JSONEmployee.put("resource_manager", employee.getEmployee().getContact().getFullName());
			JSONEmployee.put("idManager", employee.getEmployee().getIdEmployee());
		}
		else {
			JSONEmployee.put("idManager", -1);
			JSONEmployee.put("resource_manager", StringPool.SPACE);
			JSONEmployee.put("business_line", StringPool.SPACE);
		}
		if (employee.getCostRate() != null) {
			JSONEmployee.put("cost_rate", employee.getCostRate()); 
		}
		else { 
			JSONEmployee.put("cost_rate", 0); 
		}
		
		if (employee.getPerformingorg() != null) { 
			JSONEmployee.put("performance_org", employee.getPerformingorg().getName());
			JSONEmployee.put("idPerfOrg", employee.getPerformingorg().getIdPerfOrg());
		}
		else {
			JSONEmployee.put("performance_org", StringPool.SPACE);
			JSONEmployee.put("idPerfOrg", -1);
		}
		JSONEmployee.put("profileDate", DateUtil.format(idioma, employee.getProfileDate())); 

		return JSONEmployee;
	}
	
	
	public static JSONObject employeeContactToJSON(Employee employee) throws Exception {
		if (employee == null) {
			throw new EmployeeNotFoundException();
		}
	
		JSONObject JSONEmployee = new JSONObject();
		JSONEmployee.put("fullname", employee.getContact().getFullName());
		JSONEmployee.put("company", employee.getContact().getCompany().getName());
		JSONEmployee.put("jobtitle", employee.getContact().getJobTitle());
		JSONEmployee.put("email", employee.getContact().getEmail());
		JSONEmployee.put("fileas", employee.getContact().getFileAs());
		JSONEmployee.put("businessphone", employee.getContact().getBusinessPhone());
		JSONEmployee.put("mobilephone", employee.getContact().getMobilePhone());
		JSONEmployee.put("businessadress", employee.getContact().getBusinessAddress());
		JSONEmployee.put("notes", employee.getContact().getNotes());
		
		return JSONEmployee;
	}
	
	/**
	 * Get JSON Object from performing organization
	 * @param perforg
	 * @return
	 * @throws Exception
	 */
	public static JSONObject perforgToJSON(Performingorg perforg) throws Exception {
		if (perforg == null) {
			throw new PerfOrgNotFoundException();
		}
		
		JSONObject JSONPerforg = new JSONObject();
		JSONPerforg.put("id",	perforg.getIdPerfOrg());
		JSONPerforg.put("name",	perforg.getName());
		JSONPerforg.put("company_id", perforg.getCompany().getIdCompany());
		
		return JSONPerforg;
	}
	
	
	/**
	 * Get JSON Object from company
	 * @param company
	 * @return
	 * @throws Exception
	 */
	public static JSONObject companyToJSON(Company company) throws Exception {
		if (company == null) {
			throw new CompanyNotFoundException();
		}
		
		JSONObject JSONCompany = new JSONObject();
		JSONCompany.put("id",	company.getIdCompany());
		JSONCompany.put("name",	company.getName());
		
		return JSONCompany;
	}


	/**
	 * Get JSON Object from Wbsnode
	 * @param wbs
	 * @return
	 * @throws Exception
	 */
	public static JSONObject wbsnodeTOJSON(Wbsnode wbs) throws Exception {
		if (wbs == null) {
			throw new NoDataFoundException();
		}
		
		JSONObject JSONWbsnode = new JSONObject();
		JSONWbsnode.put("id",	wbs.getIdWbsnode());
		JSONWbsnode.put("name",	wbs.getName());
		JSONWbsnode.put("desc",	wbs.getDescription());
		JSONWbsnode.put("ca", wbs.getIsControlAccount());
		JSONWbsnode.put("budget", wbs.getBudget());
		if (wbs.getWbsnode() != null) {
			JSONWbsnode.put("parent_id", wbs.getWbsnode().getIdWbsnode());
		}
		return JSONWbsnode;
	}


	/**
	 * Get JSON Object from Team Member
	 * @param member
	 * @return
	 */
	public static JSONObject memberToJSON(ResourceBundle idioma, Teammember member) throws Exception {
		if (member == null) {
			throw new TeammemberNotFoundException();
		}
		
		JSONObject JSONMember = new JSONObject();
		JSONMember.put("id",	member.getIdTeamMember());
		JSONMember.put("idemployee",	member.getEmployee().getIdEmployee());
		JSONMember.put("fte",	member.getFte());
		JSONMember.put("date_in",	DateUtil.format(idioma, member.getDateIn()));
		JSONMember.put("date_out", DateUtil.format(idioma, member.getDateOut()));
		JSONMember.put("contact_fullname", member.getEmployee().getContact().getFullName());
		JSONMember.put("jobTitle", member.getEmployee().getContact().getJobTitle());
		JSONMember.put("activity", member.getProjectactivity().getActivityName());
		JSONMember.put("idActivity", member.getProjectactivity().getIdActivity());
		JSONMember.put("status", idioma.getString("resource." + member.getStatus()));
		
		JSONMember.put(Contact.BUSINESSPHONE, member.getEmployee().getContact().getBusinessPhone());
		JSONMember.put(Contact.MOBILEPHONE, member.getEmployee().getContact().getMobilePhone());
		JSONMember.put(Contact.EMAIL, member.getEmployee().getContact().getEmail());
		
		Double costRate = member.getEmployee().getCostRate();
		
		JSONMember.put(Employee.COSTRATE, (costRate == null ? 0 : costRate));
		
		if (member.getEmployee().getPerformingorg() != null) {
			JSONMember.put("performing_org", member.getEmployee().getPerformingorg().getName());
			JSONMember.put("idPerforg", member.getEmployee().getPerformingorg().getIdPerfOrg());
		}
		else {
			JSONMember.put("performing_org", StringPool.BLANK);
			JSONMember.put("idPerforg", StringPool.BLANK);
		}
		
		if (member.getEmployee().getResourceprofiles() != null) {
			JSONMember.put("profile_name", member.getEmployee().getResourceprofiles().getProfileName());
		}
		else {
			JSONMember.put("profile_name", StringPool.SPACE);
		}
		
		if (member.getEmployee().getSkillsemployees() != null) {
			StringBuilder skills = new StringBuilder();
			String skill = null;
			for (Skillsemployee listSkill: member.getEmployee().getSkillsemployees()) {
				if (StringPool.BLANK.equals(skills)) {
					skills.append(listSkill.getSkill().getName());
					skill = listSkill.getSkill().getName();
				}
				else { skills.append("<br>" + listSkill.getSkill().getName()); }
			}
			if (skill == null) {
				JSONMember.put("skills", StringPool.SPACE);
				JSONMember.put("skill", StringPool.SPACE);
			}
			else {
				JSONMember.put("skills", skills.toString());
				JSONMember.put("skill", skill);
			}
		}
		else {
			JSONMember.put("skills", StringPool.SPACE);
			JSONMember.put("skill", StringPool.SPACE);
		}
		
		JSONMember.put("manager_fullname", member.getEmployee().getEmployee().getContact().getFullName());
		
		return JSONMember;
	}
	
	
	/**
	 * Get JSON Object from program
	 * @param program
	 * @return
	 * @throws Exception
	 */
	public static JSONObject programToJSON(Program program) throws Exception {
		if (program == null) {
			throw new ProgramNotFoundException();
		}
		
		JSONObject JSONProgram = new JSONObject();
		JSONProgram.put("id",	program.getIdProgram());
		JSONProgram.put("manager",	program.getEmployee().getContact().getFullName());
		JSONProgram.put("code",	program.getProgramCode());
		JSONProgram.put("name",	program.getProgramName());
		JSONProgram.put("title",program.getProgramTitle());
		JSONProgram.put("description",program.getDescription());		
		JSONProgram.put("budgetYear",program.getBudgetYear());
		JSONProgram.put("doc",program.getProgramDoc());
		JSONProgram.put("budget",program.getBudget());
		JSONProgram.put("idEmployee",program.getEmployee().getIdEmployee());
		
		return JSONProgram;
	}
	
	/**
	 * Get JSON Object from Performing Org
	 * @param perforg
	 * @return
	 * @throws Exception
	 */
	public static JSONObject perfOrgToJSON(Performingorg perforg) throws Exception {
		if (perforg == null) {
			throw new PerfOrgNotFoundException();
		}
		
		JSONObject JSONPerfOrg = new JSONObject();
		JSONPerfOrg.put("id",	perforg.getIdPerfOrg());
		JSONPerfOrg.put("manager",	perforg.getEmployee().getContact().getFullName());
		JSONPerfOrg.put("idManager",	perforg.getEmployee().getContact().getIdContact());
		JSONPerfOrg.put("price",	StringPool.BLANK);
		JSONPerfOrg.put("company",	perforg.getCompany().getName());
		JSONPerfOrg.put("idCompany",	perforg.getCompany().getIdCompany());
		JSONPerfOrg.put("onsaas",perforg.getOnSaaS());
		JSONPerfOrg.put("name",perforg.getName());
		
		return JSONPerfOrg;
	}
	
	/**
	 * Get JSON Object from skill
	 * @param skill
	 * @return
	 * @throws Exception
	 */
	public static JSONObject skillToJSON(Skill skill) throws Exception {
		if (skill == null) {
			throw new NoDataFoundException();
		}
		
		JSONObject JSONSkill = new JSONObject();
		JSONSkill.put("id",	skill.getIdSkill());
		JSONSkill.put("name",	skill.getName());
		JSONSkill.put("description",	skill.getDescription());
		
		return JSONSkill;
	}
	
	/**
	 * Get JSON Object from Contact
	 * @param contact
	 * @return
	 * @throws Exception
	 */
	public static JSONObject contactToJSON(Contact contact) throws Exception {
		if (contact == null) {
			throw new ContactNotFoundException();
		}
		
		JSONObject JSONContact = new JSONObject();
		JSONContact.put("id", contact.getIdContact());
		JSONContact.put("company", contact.getCompany().getName());
		JSONContact.put("idCompany", contact.getCompany().getIdCompany());
		JSONContact.put("full_name", contact.getFullName());
		JSONContact.put("job_title", contact.getJobTitle());
		JSONContact.put("file_as", contact.getFileAs());
		JSONContact.put("business_phone", contact.getBusinessPhone());
		JSONContact.put("mobile_phone", contact.getMobilePhone());
		JSONContact.put("business_address", contact.getBusinessAddress());
		JSONContact.put("email", contact.getEmail());
		JSONContact.put("notes", contact.getNotes());
		
		return JSONContact;
	}


	/**
	 * Generates dates in JSON Object for charge select
	 * @param initD
	 * @param endD
	 * @return
	 * @throws Exception
	 */
	public static JSONArray generateDatesJSON(ResourceBundle idioma, Date initD, Date endD) throws Exception {
		
		String nameDate				= null;
		
		Calendar initDate = DateUtil.getCalendar();
		initDate.setTime(initD);
		initDate.set(Calendar.DATE, 1);
		
		Calendar endDate = DateUtil.getCalendar();
		endDate.setTime(DateUtil.getLastMonthDay(endD));
		
		JSONObject monthDateJSON = null;
		JSONArray dates = new JSONArray();
		while (initDate.before(endDate)) {
			nameDate = idioma.getString("month.month_"+(initDate.get(Calendar.MONTH)+1))+StringPool.SPACE+initDate.get(Calendar.YEAR);
			
			monthDateJSON = new JSONObject();
			monthDateJSON.put("nameDate", nameDate);
			monthDateJSON.put("initDate", DateUtil.format(idioma, initDate.getTime()));
			monthDateJSON.put("lastDate", DateUtil.format(idioma, DateUtil.getLastMonthDay(initDate.getTime())));
			
			dates.add(monthDateJSON);
			initDate.add(Calendar.MONTH, +1);
		}
		
		return dates;
	}
	
	
	/**
	 * Get JSON Object from TeamMembersFTEs
	 * @param ftEs
	 * @return
	 * @throws Exception
	 */
	public static JSONArray teamMembersFTEsJSON(List<TeamMembersFTEs> ftEs) throws Exception {
		
		JSONArray membersFTEs 	= new JSONArray();
		
		JSONArray listFTEs 		= null;
		JSONObject nameJSON 	= null;
		JSONObject fte 			= null;
		
		for (TeamMembersFTEs memberFTE: ftEs) {
			
			nameJSON = new JSONObject();
			nameJSON.put("name",memberFTE.getMember().getEmployee().getContact().getFullName());
			
			if (memberFTE.getProject() != null) {
				nameJSON.put("project",memberFTE.getProject().getProjectName());
			}
			
			listFTEs = new JSONArray();
			for (Integer numfte : memberFTE.getFtes()) {
				fte = new JSONObject();
				fte.put("fte", numfte);
				listFTEs.add(fte);
				
			}
			JSONObject auxJSON = new JSONObject();
			auxJSON.put("listfte",listFTEs);
			
			membersFTEs.add(nameJSON);
			membersFTEs.add(listFTEs);
		}
		
		return membersFTEs;
	}

	
	/**
	 * Get JSON Object from BudgetAccounts
	 * @param budgetaccounts
	 * @return
	 * @throws Exception
	 */
	public static JSONObject budgetAccountsToJSON(ResourceBundle idioma, Budgetaccounts budgetaccounts) throws Exception {
		if (budgetaccounts == null) {
			throw new BudgetAccountNotFoundException();
		}
		
		JSONObject JSONBudgetAccounts = new JSONObject();
		JSONBudgetAccounts.put("id", budgetaccounts.getIdBudgetAccount());
		JSONBudgetAccounts.put("description", budgetaccounts.getDescription());
		JSONBudgetAccounts.put("type_cost", budgetaccounts.getTypeCost());
		String typeCostDesc = "";
		if (budgetaccounts.getTypeCost().equals(Constants.COST_TYPE_DIRECT)) {
			typeCostDesc = idioma.getString("cost.type.direct");
		}
		else if (budgetaccounts.getTypeCost().equals(Constants.COST_TYPE_EXPENSE)) {
			typeCostDesc = idioma.getString("cost.type.expense");
		}
		JSONBudgetAccounts.put("type_cost_desc", typeCostDesc);
		
		return JSONBudgetAccounts;
	}
	
	
	/**
	 * Get JSON Object from Contracttype
	 * @param contractType
	 * @return
	 * @throws Exception
	 */
	public static JSONObject contractTypeToJSON(Contracttype contractType) throws Exception {
		if (contractType == null) {
			throw new ContracttypeNotFoundException();
		}
		
		JSONObject JSONContractType = new JSONObject();
		JSONContractType.put("id", contractType.getIdContractType());
		JSONContractType.put("description", contractType.getDescription());
		
		return JSONContractType;
	}
	
	/**
	 * Get JSON Object from Expenseaccounts
	 * @param expenseaccount
	 * @return
	 * @throws Exception
	 */
	public static JSONObject expenseAccountToJSON(Expenseaccounts expenseaccount) throws Exception {
		if (expenseaccount == null) {
			throw new ExpenseaccountNotFoundException();
		}
		
		JSONObject JSONExpendAccount = new JSONObject();
		JSONExpendAccount.put("id", expenseaccount.getIdExpenseAccount());
		JSONExpendAccount.put("description", expenseaccount.getDescription());
		
		return JSONExpendAccount;
	}
	
	
	/**
	 * Get JSON Object from Market
	 * @param category
	 * @return
	 * @throws Exception
	 */
	public static JSONObject categoryToJSON(Category category) throws Exception {
		if (category == null) {
			throw new CategoryNotFoundException();
		}
		
		JSONObject JSONCategory = new JSONObject();
		JSONCategory.put("id", category.getIdCategory());
		JSONCategory.put("name", category.getName());
		JSONCategory.put("description", category.getDescription());
		
		return JSONCategory;
	}
	
	
	/**
	 * Get JSON Object from Geography
	 * @param geography
	 * @return
	 * @throws Exception
	 */
	public static JSONObject geographyToJSON(Geography geography) throws Exception {
		if (geography == null) {
			throw new GeographyNotFoundException();
		}
		
		JSONObject JSONMarket = new JSONObject();
		JSONMarket.put("id", geography.getIdGeography());
		JSONMarket.put("name", geography.getName());
		JSONMarket.put("description", geography.getDescription());
		
		return JSONMarket;
	}
	
	/**
	 * Get JSON Object from Investment
	 * @param project
	 * @param docs
	 * @return
	 * @throws Exception
	 */
	public static JSONObject investmentToJSON(Project project, List<Documentproject> docs) throws Exception {
		if (project == null) {
			throw new NoDataFoundException();
		}
		
		JSONObject JSONInvestment = new JSONObject();
		
		if(Constants.DOCUMENT_STORAGE.equals(Constants.LINK) && docs.get(0) != null) {
			docs.get(0).setProject(null);
			JSONInvestment.put("docs", docs.get(0));
		}
		else if(Constants.DOCUMENT_STORAGE.equals(Constants.FILE_SYSTEM)){
			for(Documentproject doc : docs) {
				doc.setProject(null);
			}
			JSONInvestment.put("docs", docs);	
		}
		
		JSONInvestment.put(Project.INVESTMENTSTATUS, project.getInvestmentStatus());
		JSONInvestment.put(Project.NUMCOMPETITORS, project.getNumCompetitors());
		JSONInvestment.put(Project.FINALPOSITION, project.getFinalPosition());
		JSONInvestment.put(Project.CLIENTCOMMENTS, project.getClientComments());
				
		return JSONInvestment;
	}
	
	/**
	 * Get JSON Object from Operationaccount
	 * @param operationaccount
	 * @return
	 * @throws Exception
	 */
	public static JSONObject operationAccountToJSON(Operationaccount operationaccount) throws Exception {
		if (operationaccount == null) {
			throw new OperationaccountNotFoundException();
		}
		
		JSONObject JSONOperationAccount = new JSONObject();
		JSONOperationAccount.put("id", operationaccount.getIdOpAccount());
		JSONOperationAccount.put("description", operationaccount.getDescription());
		
		return JSONOperationAccount;
	}
	
	/**
	 * Get JSON Object from Operation
	 * @param operation
	 * @return
	 * @throws Exception
	 */
	public static JSONObject operationToJSON(Operation operation) throws Exception {
	
		if (operation == null) {
			throw new OperationNotFoundException();
		}
		
		JSONObject JSONOperation = new JSONObject();
		JSONOperation.put("id", operation.getIdOperation());
		JSONOperation.put("name", operation.getOperationName());
		JSONOperation.put("code", operation.getOperationCode());
		
		if (operation.getOperationaccount() != null) { 
			JSONOperation.put("operation_account", operation.getOperationaccount().getDescription());
			JSONOperation.put("idOpAccount", operation.getOperationaccount().getIdOpAccount());
		}
		else {
			JSONOperation.put("operation_account", StringPool.SPACE);
			JSONOperation.put("idOpAccount", -1);
		}
		
		return JSONOperation;
	}


	/**
	 * Get JSON Object from Project KPI
	 * @param kpi
	 * @return
	 * @throws Exception
	 */
	public static JSONObject kpiToJSON(Projectkpi kpi) throws Exception {
		if (kpi == null) {
			throw new NoDataFoundException();
		}
		
		JSONObject JSONKpi = new JSONObject();
		JSONKpi.put("id", kpi.getIdProjectKpi());
		JSONKpi.put("lower_threshold", kpi.getLowerThreshold() != null ? kpi.getLowerThreshold() : StringPool.BLANK);
		JSONKpi.put("upper_threshold", kpi.getUpperThreshold() != null ? kpi.getUpperThreshold() : StringPool.BLANK);
		JSONKpi.put("value", kpi.getValue() != null ? kpi.getValue() : StringPool.BLANK);
		JSONKpi.put("weight", kpi.getWeight() != null ? kpi.getWeight() : StringPool.BLANK);
		JSONKpi.put("adjusted_value", kpi.getAdjustedValue());
		
		if (kpi.getMetrickpi() != null) {
			JSONKpi.put("metric", kpi.getMetrickpi().getName());
			JSONKpi.put("metric_id", kpi.getMetrickpi().getIdMetricKpi());
			JSONKpi.put("definition", kpi.getMetrickpi().getDefinition());
		}
		
		
		return JSONKpi;
	}
	
	/**
	 * Get JSON Object from Issue
	 * @param idioma
	 * @param issue
	 * @return
	 * @throws Exception
	 */
	public static JSONObject issueToJSON(ResourceBundle idioma, Issuelog issue) throws Exception {
		if (issue == null) {
			throw new IssueNotFoundException();
		}
		
		JSONObject issueJSON = new JSONObject();
		
		String sPriority = "";
		if (Constants.PRIORITY_HIGH.equals(issue.getPriority())) {
			sPriority = idioma.getString("priority.high");
		}
		else if (Constants.PRIORITY_LOW.equals(issue.getPriority())) {
			sPriority = idioma.getString("priority.low");	
		}
		else {
			sPriority = idioma.getString("priority.medium");
		}
		
		issueJSON.put("id", issue.getIdIssue());
		issueJSON.put("status", (issue.getDateClosed()!=null ?  idioma.getString("issue_closed") : idioma.getString("issue_opened")));
		issueJSON.put("priority", issue.getPriority());
		issueJSON.put("priority_desc", sPriority);
		issueJSON.put("date_logged", DateUtil.format(idioma, issue.getDateLogged()));
		issueJSON.put("target_date", DateUtil.format(idioma, issue.getTargetDate()));
		issueJSON.put("assigned_to", issue.getAssignedTo());
		issueJSON.put("description", issue.getDescription());
		issueJSON.put("resolution", issue.getResolution());
		issueJSON.put("date_closed", DateUtil.format(idioma, issue.getDateClosed()));
		
		return issueJSON;
	}
	
	
	/**
	 * Get JSON Object from assumption
	 * @param assumption
	 * @return
	 * @throws Exception
	 */
	public static JSONObject assumptionToJSON(Assumptionregister assumption) throws Exception {
		if (assumption == null) {
			throw new AssumptionNotFoundException();
		}
		
		JSONObject assumptionJSON = new JSONObject();
		
		assumptionJSON.put("id", assumption.getIdAssumption());
		assumptionJSON.put("code", assumption.getAssumptionCode());
		assumptionJSON.put("name", (assumption.getAssumptionName()!=null ? assumption.getAssumptionName() : ""));
		assumptionJSON.put("description", assumption.getDescription());
		assumptionJSON.put("originator", (assumption.getOriginator()!=null ? assumption.getOriginator() : ""));
		assumptionJSON.put("doc", (assumption.getAssumptionDoc()!=null ? assumption.getAssumptionDoc() : ""));
		
		return assumptionJSON;
	}
	
	
	/**
	 * Get JSON Object from assumption log
	 * @param idioma
	 * @param log
	 * @return
	 */
	public static JSONObject assumptionLogToJSON(ResourceBundle idioma, Assumptionreassessmentlog log) {
		JSONObject assumptionLogJSON = new JSONObject();
		
		assumptionLogJSON.put("id", log.getIdLog());
		assumptionLogJSON.put("date", DateUtil.format(idioma, log.getAssumptionDate()));
		assumptionLogJSON.put("change", log.getAssumptionChange());
		
		return assumptionLogJSON;
	}


	/**
	 * Get JSON Object from risk register
	 * @param idioma
	 * @param risk
	 * @return
	 * @throws Exception
	 */
	public static JSONObject riskToJSON(ResourceBundle idioma, Riskregister risk) throws Exception {
		if (risk == null) {
			throw new RiskNotFoundException();
		}
		JSONObject riskJSON = new JSONObject();
		
		riskJSON.put("id", risk.getIdRisk());
		riskJSON.put("code", risk.getRiskCode());
		riskJSON.put("name", risk.getRiskName());
		riskJSON.put("owner", (risk.getOwner()!=null ? risk.getOwner() : ""));
		riskJSON.put("date_raised", DateUtil.format(idioma, risk.getDateRaised()));
		riskJSON.put("description", (risk.getDescription()!=null ? risk.getDescription() : ""));
		riskJSON.put("probability", (risk.getProbability()!=null ? risk.getProbability() : ""));
		riskJSON.put("impact", (risk.getImpact()!=null ? risk.getImpact() : ""));
		riskJSON.put("potential_cost", (risk.getPotentialCost()!=null ? risk.getPotentialCost() : ""));
		riskJSON.put("potential_delay", (risk.getPotentialDelay()!=null ? risk.getPotentialDelay() : ""));
		riskJSON.put("trigger", (risk.getRiskTrigger()!=null ? risk.getRiskTrigger() : ""));
		riskJSON.put("risk_type", (risk.getRiskType()!=null ? risk.getRiskType() : ""));
		riskJSON.put("response", (risk.getRiskcategories()!=null ? risk.getRiskcategories().getIdRiskCategory() : ""));
		riskJSON.put("mitigation_actions", (risk.getMitigationActionsRequired()!=null ? risk.getMitigationActionsRequired() : ""));
		riskJSON.put("mitigation_cost", (risk.getPlannedMitigationCost()!=null ? risk.getPlannedMitigationCost() : ""));
		riskJSON.put("contingency_actions", (risk.getContingencyActionsRequired()!=null ? risk.getContingencyActionsRequired() : ""));
		riskJSON.put("contingency_cost", (risk.getPlannedContingencyCost()!=null ? risk.getPlannedContingencyCost() : ""));
		riskJSON.put("risk_rating", risk.getRiskRating());
		riskJSON.put("materialized", risk.getMaterialized());
		riskJSON.put("date_materialization", DateUtil.format(idioma, risk.getDateMaterialization()));
		riskJSON.put("actual_cost", (risk.getActualMaterializationCost()!=null ? risk.getActualMaterializationCost() : ""));
		riskJSON.put("actual_delay", (risk.getActualMaterializationDelay()!=null ? risk.getActualMaterializationDelay() : ""));
		riskJSON.put("final_comments", (risk.getFinalComments()!=null ? risk.getFinalComments() : ""));
		riskJSON.put("due_date", (risk.getDueDate()!=null ? DateUtil.format(idioma, risk.getDueDate()) : ""));
		riskJSON.put("residual_risk", (risk.getResidualRisk()!=null ? risk.getResidualRisk() : ""));
		riskJSON.put("residual_cost", (risk.getResidualCost()!=null ? risk.getResidualCost() : ""));
		riskJSON.put("response_description", (risk.getResponseDescription()!=null ? risk.getResponseDescription() : ""));

		String status = "";
		if(risk.getStatus()!=null) {
			if(risk.getStatus().equals(Constants.CHAR_CLOSED)) {
				status = Constants.CLOSED;
			}
			else if(risk.getStatus().equals(Constants.CHAR_OPEN)) {
				status = Constants.OPEN;
			}
		}
		
		riskJSON.put("status", status);		
		
		return riskJSON;
	}
	
	/**
	 * Get JSON Object from risk reassessment log
	 * @param idioma
	 * @param log
	 * @return
	 */
	public static JSONObject reassessmentLogToJSON(ResourceBundle idioma,
			Riskreassessmentlog log) {
		JSONObject assumptionLogJSON = new JSONObject();
		
		assumptionLogJSON.put("id", log.getIdLog());
		assumptionLogJSON.put("date", DateUtil.format(idioma, log.getRiskDate()));
		assumptionLogJSON.put("change", log.getRiskChange());
		
		return assumptionLogJSON;
	}


	public static JSONObject toJSON(ResourceBundle idioma,SimpleDateFormat dateFormat, Teammember member) {
		
		Project project		= member.getProjectactivity().getProject();
		
		JSONObject memberJSON = new JSONObject();
		memberJSON.put(Teammember.FTE,		member.getFte());
		memberJSON.put(Teammember.WORKLOAD_IN_DAYS, member.getWorkloadInDays());  //adding workload in days
		memberJSON.put(Teammember.SELLRATE,	member.getSellRate());
		memberJSON.put(Teammember.COMMENTSPM, ValidateUtil.escape(member.getCommentsPm()));
		memberJSON.put(Teammember.COMMENTSRM, ValidateUtil.escape(member.getCommentsRm()));
		memberJSON.put(Teammember.DATEIN,	dateFormat.format(member.getDateIn()));
		memberJSON.put(Teammember.DATEOUT,	dateFormat.format(member.getDateOut()));
		memberJSON.put(Teammember.SKILL,	(member.getSkill() != null?ValidateUtil.escape(member.getSkill().getName()):StringPool.BLANK));
		memberJSON.put(Skill.IDSKILL,		(member.getSkill() != null?member.getSkill().getIdSkill():StringPool.BLANK));
		memberJSON.put("statusTag",			member.getStatus() != null?idioma.getString("resource."+member.getStatus()):StringPool.BLANK);
		memberJSON.put("statusVal",			member.getStatus() != null?member.getStatus():StringPool.BLANK);
		memberJSON.put(Employee.IDEMPLOYEE,		member.getEmployee().getIdEmployee());
		memberJSON.put(Employee.COSTRATE,		ValidateUtil.toCurrency(member.getEmployee().getCostRate()));
		memberJSON.put(Contact.FULLNAME,		ValidateUtil.escape(member.getEmployee().getContact().getFullName()));
		memberJSON.put(Contact.BUSINESSPHONE,	ValidateUtil.escape(member.getEmployee().getContact().getBusinessPhone()));
		memberJSON.put(Contact.MOBILEPHONE,		ValidateUtil.escape(member.getEmployee().getContact().getMobilePhone()));
		memberJSON.put(Contact.EMAIL,			ValidateUtil.escape(member.getEmployee().getContact().getEmail()));
		memberJSON.put(Project.PROJECTNAME,	ValidateUtil.escape(project.getProjectName()));
		memberJSON.put(Project.STATUS,		idioma.getString("project_status."+project.getStatus()));
		memberJSON.put(Teammember.PROJECTACTIVITY,	ValidateUtil.escape(member.getProjectactivity().getActivityName()));
		memberJSON.put(Projectactivity.IDACTIVITY,	member.getProjectactivity().getIdActivity());
		memberJSON.put(Projectactivity.PLANINITDATE,	member.getProjectactivity().getPlanInitDate() != null?dateFormat.format(member.getProjectactivity().getPlanInitDate()):StringPool.BLANK);
		memberJSON.put(Projectactivity.PLANENDDATE,		member.getProjectactivity().getPlanEndDate() != null?dateFormat.format(member.getProjectactivity().getPlanEndDate()):StringPool.BLANK);
		memberJSON.put(Project.PLANNEDINITDATE,		dateFormat.format(project.getPlannedInitDate()));
		memberJSON.put(Project.PLANNEDFINISHDATE,	dateFormat.format(project.getPlannedFinishDate()));
		memberJSON.put(Project.EMPLOYEEBYPROJECTMANAGER, ValidateUtil.escape(project.getEmployeeByProjectManager().getContact().getFullName()));
		memberJSON.put(Project.PERFORMINGORG,	ValidateUtil.escape(project.getPerformingorg().getName()));
		memberJSON.put(Project.PROGRAM, project.getProgram()!= null?ValidateUtil.escape(project.getProgram().getProgramName()):StringPool.BLANK);
		
		StringBuilder skills = new StringBuilder();
		String skill = null;
		
		JSONArray skillArray = new JSONArray();
		
		for (Skillsemployee listSkill: member.getEmployee().getSkillsemployees()) {
			if (skill == null) {
				skills.append(listSkill.getSkill().getName());
				skill = listSkill.getSkill().getName();
			}
			else { skills.append("<br>" + listSkill.getSkill().getName()); }
			
			JSONObject skillJSON = new JSONObject();
			skillJSON.put(Skill.NAME, listSkill.getSkill().getName());
			skillJSON.put(Skill.IDSKILL, listSkill.getSkill().getIdSkill());
			skillArray.add(skillJSON);
		}
		memberJSON.put("skillArray", skillArray);
		
		return memberJSON;
	}

	/**
	 * Create JSON Project object for bubble chart
	 * @param xAxis
	 * @param yAxis
	 * @param area
	 * @param label
	 * @param color
	 * @return
	 */
	public static JSONArray createBubbleProject(double xAxis, double yAxis, double area,
			String label, String color) {
		
		JSONArray projectJSON = new JSONArray();
		projectJSON.add(Math.round(xAxis));
		projectJSON.add(Math.round(yAxis));
		projectJSON.add(Math.round(area));
		JSONObject serieJSON = new JSONObject();
		serieJSON.put("label", label);
		serieJSON.put("color", color);
		projectJSON.add(serieJSON);
		
		return projectJSON;
	}
}
