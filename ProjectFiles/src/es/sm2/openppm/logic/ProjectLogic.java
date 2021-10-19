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
package es.sm2.openppm.logic;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.ChargescostsDAO;
import es.sm2.openppm.dao.CompanyDAO;
import es.sm2.openppm.dao.ContactDAO;
import es.sm2.openppm.dao.ContractTypeDAO;
import es.sm2.openppm.dao.EmployeeDAO;
import es.sm2.openppm.dao.IncomesDAO;
import es.sm2.openppm.dao.LogprojectstatusDAO;
import es.sm2.openppm.dao.MilestoneDAO;
import es.sm2.openppm.dao.ProgramDAO;
import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.dao.ProjectCharterDAO;
import es.sm2.openppm.dao.ProjectCostsDAO;
import es.sm2.openppm.dao.ProjectDAO;
import es.sm2.openppm.dao.ProjectFollowupDAO;
import es.sm2.openppm.dao.ProjectKpiDAO;
import es.sm2.openppm.dao.ProjectassociationDAO;
import es.sm2.openppm.dao.StakeholderDAO;
import es.sm2.openppm.dao.TeamMemberDAO;
import es.sm2.openppm.dao.WBSNodeDAO;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.exceptions.ProjectKpiWeightException;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.exceptions.ProposalNotWonException;
import es.sm2.openppm.javabean.DatoColumna;
import es.sm2.openppm.javabean.FiltroTabla;
import es.sm2.openppm.javabean.ProjectInfoJavaBean;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contracttype;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Incomes;
import es.sm2.openppm.model.Logprojectstatus;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectassociation;
import es.sm2.openppm.model.Projectcharter;
import es.sm2.openppm.model.Projectcosts;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ProjectLogic extends AbstractGenericLogic<Project, Integer> {
	
	
	/**
	 * Check if accounting code is used for other projects
	 * @param project
	 * @param user 
	 * @return
	 * @throws Exception
	 */
	public static boolean accountingCodeInUse(Project project, Employee user) throws Exception {
		boolean used = false;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			CompanyDAO companyDAO = new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			
			used = projDAO.accountingCodeInUse(project, company);
			
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
		
		return used;
	}
	
	
	/**
	 * Find projects where an Employee is team member in range of days
	 * @param emp
	 * @param iniMonth
	 * @param endMonth
	 * @return
	 * @throws Exception 
	 */
	public List<Project> findByResourceInProject(Employee employee, Date dayMonth) throws Exception {
		List<Project> empProjects = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO = new ProjectDAO(session);
			empProjects = projectDAO.findByResourceInProject(employee, DateUtil.getFirstMonthDay(dayMonth), DateUtil.getLastMonthDay(dayMonth));
			
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
		
		return empProjects;
	}
	

	/**
	 * Save project
	 * @param project
	 * @throws Exception 
	 */
	public static void saveProject (Project project) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			projDAO.makePersistent(project);
			
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
	}
	
	
	/**
	 * Return project
	 * @param idProject
	 * @return
	 * @throws Exception 
	 */
	public static Project consProject (Integer idProject) throws Exception {
		if (idProject == -1) {
			throw new NoDataFoundException();
		}
		Project project = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			if (idProject != -1) {
				project = projDAO.findById(idProject, false);
			}
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
		return project;
	}
	
	
	/**
	 * Java Bean of Project Info
	 * @param performingorg 
	 * @param id
	 * @return
	 * @throws Exception 
	 */
	public static ProjectInfoJavaBean findById (int idProject, Performingorg performingorg, Company company) throws Exception {
		ProjectInfoJavaBean info = new ProjectInfoJavaBean();
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
		
			ProjectDAO projDAO = new ProjectDAO(session);
			Project project = projDAO.consInitiatingProject(new Project(idProject));
			info.setProject(project);			
			
			ProjectCharterDAO projCharterDAO = new ProjectCharterDAO(session);
			Projectcharter projectcharter = projCharterDAO.findByProject(project);
			info.setProjectCharter(projectcharter);
			
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			Employee example = new Employee();
			example.setPerformingorg(project.getPerformingorg());
			info.setEmployees(employeeDAO.searchByExample(example));
			
			ContactDAO contactDAO = new ContactDAO(session);
			info.setContacts(contactDAO.findAll());
			
			ProgramDAO programDAO = new ProgramDAO(session);
			info.setPrograms(programDAO.searchByPerfOrg(performingorg, null));
			
			ContractTypeDAO contractTypeDAO = new ContractTypeDAO(session);
			info.setContractTypes(contractTypeDAO.findByRelation(Contracttype.COMPANY, company));
			
			CompanyDAO companyDAO = new CompanyDAO(session);
			info.setCompanies(companyDAO.findAll());
			
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
		return info;
	}
	
	
	/**
	 * Create or Update project and it project Charter
	 * @param proj
	 * @param projCharter
	 * @param idDependentProject 
	 * @param idLeadProject 
	 * @throws Exception 
	 */
	public static List<String> saveInitiatingProject(Project proj, Projectcharter projCharter,
			Integer[] idLeadProject, Integer[] idDependentProject, Date newPlannedInitDate) throws Exception {
		
		if (proj == null) {
			throw new NoDataFoundException();
		}
		
		List<String> newInfo = new ArrayList<String>();
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			Date oldPlannedInitDate = proj.getPlannedInitDate();
			proj.setPlannedInitDate(newPlannedInitDate);
			
			ProjectDAO projDAO				 = new ProjectDAO(session);
			WBSNodeDAO wbsNodeDAO 			 = new WBSNodeDAO(session);
			ProjectCharterDAO projCharterDAO = new ProjectCharterDAO(session);
			ProjectActivityDAO activityDAO	 = new ProjectActivityDAO(session);
			ProjectassociationDAO projectassociationDAO = new ProjectassociationDAO(session);
			
			if (proj.getInitDate() == null) {
				proj.setInitDate(new Date());
			}
			
			// Update Root Node name
			Wbsnode rootNode = wbsNodeDAO.findFirstNode(proj);
			rootNode.setName(proj.getProjectName());
			wbsNodeDAO.makePersistent(rootNode);
			
			proj = projDAO.makePersistent(proj);
			
			if (Constants.INVESTMENT_IN_PROCESS.equals(proj.getInvestmentStatus()) && !DateUtil.equals(oldPlannedInitDate, newPlannedInitDate)) {
				
				ProjectFollowupDAO followupDAO	= new ProjectFollowupDAO(session);
				TeamMemberDAO memberDAO			= new TeamMemberDAO(session);
				MilestoneDAO milestoneDAO		= new MilestoneDAO(session);
				
				Calendar tempCal = DateUtil.getCalendar();
				
				Calendar oldCal = DateUtil.getCalendar();
				oldCal.setTime(oldPlannedInitDate);
				
				Calendar newCal = DateUtil.getCalendar();
				newCal.setTime(newPlannedInitDate);
				
				// New days
				
				Long days = (newCal.getTimeInMillis() - oldCal.getTimeInMillis())/Constants.MILLSECS_PER_DAY;
				
				boolean addInfo = false;
				
				// Update Activity dates
				List<Projectactivity> activities = activityDAO.findByProject(proj, null);
				
				for (Projectactivity activity : activities) {
					
					if (activity.getPlanInitDate() != null && activity.getPlanEndDate() != null) {
						
						tempCal.setTime(activity.getPlanInitDate());
						
						tempCal.add(Calendar.DAY_OF_MONTH, days.intValue());
						activity.setPlanInitDate(tempCal.getTime());
						
						tempCal.setTime(activity.getPlanEndDate());
						
						tempCal.add(Calendar.DAY_OF_MONTH, days.intValue());
						activity.setPlanEndDate(tempCal.getTime());
						
						activityDAO.makePersistent(activity);
						
						addInfo = true;
					}
				}
				
				if (addInfo) { newInfo.add("msg.info.check_activity_dates"); }
				
				// Update Milestone date
				List<Milestones> milestones = milestoneDAO.findByProject(proj);
				
				for (Milestones milestone : milestones) {
					
					if (milestone.getPlanned() != null) {
						
						tempCal.setTime(milestone.getPlanned());
						
						tempCal.add(Calendar.DAY_OF_MONTH, days.intValue());
						milestone.setPlanned(tempCal.getTime());
						
						if (milestone.getNotifyDate() != null) {
							tempCal.setTime(milestone.getNotifyDate());
							
							tempCal.add(Calendar.DAY_OF_MONTH, days.intValue());
							milestone.setNotifyDate(tempCal.getTime());
						}
						
						milestoneDAO.makePersistent(milestone);
						
						addInfo = true;
					}
				}
				
				if (addInfo) { newInfo.add("msg.info.check_milestones_dates"); addInfo = false; }
				
				// Update followup date
				List<Projectfollowup> followups = followupDAO.findByRelation(Projectfollowup.PROJECT, proj);
				
				for (Projectfollowup followup : followups) {
					
					if (followup.getFollowupDate() != null) {
						
						tempCal.setTime(followup.getFollowupDate());
						
						tempCal.add(Calendar.DAY_OF_MONTH, days.intValue());
						followup.setFollowupDate(tempCal.getTime());
						
						followupDAO.makePersistent(followup);
						
						addInfo = true;
					}
				}
				
				if (addInfo) { newInfo.add("msg.info.check_followups_dates"); addInfo = false; }
				
				if (memberDAO.isAssigned(proj)) { newInfo.add("msg.info.check_members_assigned"); }
			}
			
			// Change name of root activity
			Projectactivity rootActivity = activityDAO.consRootActivity(proj);
			rootActivity.setActivityName(proj.getProjectName());
			activityDAO.makePersistent(rootActivity);
			
			// Delete all associations
			for (Projectassociation association : proj.getProjectassociationsForDependent()) {
				projectassociationDAO.makeTransient(association);
			}
			for (Projectassociation association : proj.getProjectassociationsForLead()) {
				projectassociationDAO.makeTransient(association);
			}
			
			// Create Associations
			if (idLeadProject != null) {
				for (int idLead : idLeadProject) {
					
					Projectassociation association = new Projectassociation();
					association.setProjectByDependent(proj);
					association.setProjectByLead(new Project(idLead));
					projectassociationDAO.makePersistent(association);
				}
			}
			if (idDependentProject != null) {
				for (int idDependent : idDependentProject) {
					
					Projectassociation association = new Projectassociation();
					association.setProjectByDependent(new Project(idDependent));
					association.setProjectByLead(proj);
					projectassociationDAO.makePersistent(association);
				}
			}
			if (projCharter != null) {
				projCharter.setProject(proj);
				
				projCharterDAO.makePersistent(projCharter);
			}
			
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
		return newInfo;
	}
	
	
	/**
	 * Create or Update project and it project Charter
	 * @param proj
	 * @param projCharter
	 * @throws Exception 
	 */
	public static Project createProject(Project proj) throws Exception {
		
		if (proj == null) {
			throw new NoDataFoundException();
		}
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO					= new ProjectDAO(session);
			ProjectCharterDAO projCharterDAO	= new ProjectCharterDAO(session);		
			ProjectActivityDAO activityDAO		= new ProjectActivityDAO(session);
			ProjectFollowupDAO followupDAO		= new ProjectFollowupDAO(session);
			ProjectCostsDAO projCostsDAO		= new ProjectCostsDAO(session);
			EmployeeDAO employeeDAO				= new EmployeeDAO(session);
			
			if (proj.getInitDate() == null) {
				proj.setInitDate(new Date());
			}

			proj = projDAO.makePersistent(proj);
			
			// Create Project Charter
			Projectcharter projCharter = new Projectcharter();
			projCharter.setProject(proj);
			
			projCharterDAO.makePersistent(projCharter);
								
			// Create root WbsNode
			Wbsnode node = new Wbsnode();
			node.setName(proj.getProjectName());
			node.setProject(proj);
			node.setIsControlAccount(true);
			WBSNodeDAO wbsnodeDAO = new WBSNodeDAO(session);
			wbsnodeDAO.makePersistent(node);
			
			// Create activity for root WbsNode 
			Projectactivity activity = new Projectactivity();
			activity.setActivityName(proj.getProjectName());
			activity.setPlanInitDate(proj.getPlannedInitDate());
			activity.setPlanEndDate(proj.getPlannedFinishDate());
			activity.setWbsnode(node);
			activity.setProject(proj);
			activityDAO.makePersistent(activity);
			
			// Create default followups for initiating and ending project
			Projectfollowup init = new Projectfollowup();
			init.setProject(proj);
			init.setFollowupDate(proj.getPlannedInitDate());
			init.setPv(new Double(0));
			
			Projectfollowup end = new Projectfollowup();
			end.setProject(proj);
			end.setFollowupDate(proj.getPlannedFinishDate());
			end.setPv(proj.getBac());
			
			followupDAO.makePersistent(init);
			followupDAO.makePersistent(end);
			
			// Create Team members for Project Manager
			Employee resource = null; 
				
			if (proj.getEmployeeByProjectManager() != null) {
				resource = employeeDAO.findResourceByPM(proj.getEmployeeByProjectManager());
			}
			
			if (resource != null) {
				
				Teammember memberPM = new Teammember();
				memberPM.setStatus(Constants.RESOURCE_ASSIGNED);
				memberPM.setDateApproved(DateUtil.getCalendar().getTime());
				memberPM.setDateIn(proj.getPlannedInitDate());
				memberPM.setDateOut(proj.getPlannedFinishDate());
				memberPM.setEmployee(resource);
				memberPM.setFte(Constants.RESOURCE_ASSIGNATION);
				memberPM.setProjectactivity(activity);
				
				TeamMemberDAO memberDAO = new TeamMemberDAO(session);
				memberDAO.makePersistent(memberPM);
			}
			
			// Create default expenses
			Projectcosts projectCosts = new Projectcosts();
			projectCosts.setCostDate(proj.getPlannedInitDate());
			projectCosts.setProject(proj);
			
			projCostsDAO.makePersistent(projectCosts);
			
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
		return proj;
	}
	
	
	/**
	 * Approve planning project
	 * @param project
	 * @param user
	 * @throws Exception 
	 */
	public static void approveProject(Project project, Employee user) throws Exception {
		if (project == null) {
			throw new ProjectNotFoundException();
		}
		
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectDAO projectDAO		= new ProjectDAO(session);
			ProjectKpiDAO kpiDAO		= new ProjectKpiDAO(session);
			ProjectActivityDAO activityDAO	= new ProjectActivityDAO(session);
			LogprojectstatusDAO statusDAO	= new LogprojectstatusDAO(session);
			
			
			project.setStatus(Constants.STATUS_CONTROL);
			
			project.setExecDate(new Date());
			
			if (kpiDAO.getTotalWeight(project) != 100) {
				throw new ProjectKpiWeightException();
			}
			
			if (!Constants.INVESTMENT_APPROVED.equals(project.getInvestmentStatus())) {
				throw new ProposalNotWonException();
			}
			projectDAO.makePersistent(project);
			
			statusDAO.makePersistent(new Logprojectstatus(
					project,user, Constants.STATUS_CONTROL,Constants.INVESTMENT_APPROVED, new Date()));
			
			Projectactivity rootActivity = activityDAO.consRootActivity(project);
			
			rootActivity.setActualInitDate(rootActivity.getPlanInitDate());
			rootActivity.setActualEndDate(rootActivity.getPlanEndDate());
			
			activityDAO.makePersistent(rootActivity);
			
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
	}


	/**
	 * Calculate Work In Progress of a project
	 * WIP = Suma(Activity.EV) - Suma(Income.ActualBillAmmount)
	 * @param project
	 * @return WIP
	 * @throws Exception 
	 */
	public static Double calculateWIP(Project project) throws Exception {
		Double wip = 0D;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
		
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			IncomesDAO incomesDAO = new IncomesDAO(session);
			
			Double ev = activityDAO.consCurrentProjectEV(project.getIdProject());
			Double actualBillAmmount = incomesDAO.consActualBillAmmount(project.getIdProject());
			
			wip = ev - actualBillAmmount;
			
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
		
		return wip;
	}
	
			
	/**
	 * Calculate DSO billed
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static Integer calculateDSOBilled(Project project) throws Exception {
		Integer dsoBilled = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO = new ProjectDAO(session);
			dsoBilled = projectDAO.calculateDSOBilled(project);
			
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
		
		return dsoBilled;
	}


	/**
	 * Calculate DSO unbilled
	 * @param project
	 * @return
	 * @throws Exception
	 */
	public static Integer calculateDSOUnbilled(Project project) throws Exception {
		Integer dsoUnbilled = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO = new ProjectDAO(session);
			dsoUnbilled = projectDAO.calculateDSOUnbilled(project);
			
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
		
		return dsoUnbilled;
	}

	
	/**
	 * Close project, only if conditions to close accomplished
	 * @param project
	 * @param user
	 * @throws Exception 
	 */
	public static void closeProject(Project project, Employee user) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO			= new ProjectDAO(session);
			ProjectActivityDAO  activityDAO = new ProjectActivityDAO(session);
			LogprojectstatusDAO statusDAO	= new LogprojectstatusDAO(session);
			
			project.setStatus(Constants.STATUS_CLOSED);
			project.setInvestmentStatus(Constants.INVESTMENT_CLOSED);
			project.setEndDate(new Date());
			
			List<Projectactivity> activities = activityDAO.findByProject(project, null);
			
			for (Projectactivity act : activities) {
			
				if (act.getActualEndDate() != null) {
					act.setPlanEndDate(act.getActualEndDate());
					activityDAO.makePersistent(act);
				}
			}
			
			projectDAO.makePersistent(project);
			
			statusDAO.makePersistent(new Logprojectstatus(
					project,user, Constants.STATUS_CLOSED,Constants.INVESTMENT_CLOSED, new Date()));
			
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
	}

	
	/**
	 * Delete project in initiating
	 * @param project
	 * @throws Exception 
	 */
	public static void deleteProject(Project project) throws Exception {
		
		if (project == null) {
			throw new ProjectNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			StakeholderDAO stakeholderDAO = new StakeholderDAO(session);
			MilestoneDAO milestoneDAO = new MilestoneDAO(session);
			ProjectCharterDAO charterDAO = new ProjectCharterDAO(session);
			ProjectCostsDAO costsDAO = new ProjectCostsDAO(session);
			
			project = projDAO.findById(project.getIdProject(), false);
			
			//Delete all stackeholder
			stakeholderDAO.deleteByProject(project);
			
			//Delete all milestones
			milestoneDAO.deleteByProject(project);
			
			//Delete project Chartet
			charterDAO.deleteByProject(project);
			
			//Delete all costs
			costsDAO.deleteByProject(project);
			
			//Delete project
			projDAO.makeTransient(project);
			

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
	}

	
	/**
	 * Consult list of projects by ids
	 * @param ids
	 * @param property
	 * @param order
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public static List<Project> consList(Integer[] ids, String property, String order, List<String> joins) throws Exception {
		
		List<Project> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			list = projDAO.consList(ids, property, order, joins);
			
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
		return list;
	}
	
	public static List<Project> findByProgram(Program program,
			boolean investiment) throws Exception {
		
		List<Project> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			list = projDAO.findByProgram(program, investiment);
			
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
		return list;
	}

	/**
	 * Filter projects
	 * @param crearFiltro
	 * @return
	 * @throws Exception
	 */
	public static List<Project> filter(FiltroTabla filtro, List<String> joins) throws Exception {
		List<Project> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			list = projDAO.findByFiltro(filtro, joins);
			
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
		return list;
	}
	
	public static int findTotal(List<DatoColumna> filtrosExtras) throws Exception {
		int total = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectDAO projDAO = new ProjectDAO(session);
			total = projDAO.findTotal(filtrosExtras);

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
		return total;
	}

	public static int findTotalFiltered(FiltroTabla filtro) throws Exception {
		int total = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectDAO projDAO = new ProjectDAO(session);
			total = projDAO.findTotalFiltered(filtro);

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
		return total;
	}

	/**
	 * Cons Project and extra info
	 * @param project
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public static Project consProject(Project project, List<String> joins) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			project = projDAO.consProject(project, joins);
			
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
		return project;
	}	
	

	public static boolean chartLabelInUse(Project proj, Employee user) throws Exception {
		boolean used = false;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			CompanyDAO companyDAO = new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			
			used = projDAO.chartLabelInUse(proj, company);
			
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
		
		return used;
	}

	public static double sumProperty(FiltroTabla filter, String sumProperty) throws Exception {
		double total = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProjectDAO projDAO = new ProjectDAO(session);
			total = projDAO.sumProperty(filter, sumProperty);

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
		return total;
	}

	public static List<Project> consListInControl(Integer[] ids, String property, String order) throws Exception {
		List<Project> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			list = projDAO.consListInControl(ids, property, order);
			
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
		return list;
	}

	public static boolean hasPermission(Project project, Employee user, int tab) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		boolean permission = false;
		try {	
			tx = session.beginTransaction();
			
			ProjectDAO projDAO		= new ProjectDAO(session);
			CompanyDAO companyDAO	= new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			permission		= projDAO.hasPermission(project, user, company, tab);
			
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
		return permission;
	}

	/**
	 * Find project by income
	 * @param income
	 * @return
	 * @throws Exception
	 */
	public static Project findByIncome(Incomes income) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		Project project = null;
		
		try {	
			tx = session.beginTransaction();
			
			ProjectDAO projDAO		= new ProjectDAO(session);
			
			project	= projDAO.findByIncome(income);
			
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
		return project;
	}

	/**
	 * Find by Project Followup
	 * @param projectfollowup
	 * @return
	 * @throws Exception 
	 */
	public static Project findByFollowup(Projectfollowup projectfollowup) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		Project project = null;
		
		try {	
			tx = session.beginTransaction();
			
			ProjectDAO projDAO		= new ProjectDAO(session);
			
			project	= projDAO.findByFollowup(projectfollowup);
			
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
		return project;
	}

	public static List<Project> find(String search, Performingorg performingorg) throws Exception {
		List<Project> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			list = projDAO.find(search, performingorg);
			
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
		return list;
	}

	public static double calcExternalCosts(Project project) throws Exception {
		
		double costs = 0;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ChargescostsDAO chargescostsDAO = new ChargescostsDAO(session);
			
			costs =	chargescostsDAO.getSumCosts(project, Constants.SELLER_CHARGE_COST);
			costs += chargescostsDAO.getSumCosts(project, Constants.INFRASTRUCTURE_CHARGE_COST);
			costs += chargescostsDAO.getSumCosts(project, Constants.LICENSE_CHARGE_COST);
			
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
		
		return costs;
	}

	/**
	 * Change status closed of project to control
	 * @param project
	 * @param user
	 * @throws Exception 
	 */
	public static void changeToControl(Project project, Employee user) throws Exception {

		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO			= new ProjectDAO(session);
			LogprojectstatusDAO statusDAO	= new LogprojectstatusDAO(session);
			
			project = projectDAO.findById(project.getIdProject(), false);
			
			project.setStatus(Constants.STATUS_CONTROL);
			project.setInvestmentStatus(Constants.INVESTMENT_APPROVED);
			
			projectDAO.makePersistent(project);
			
			statusDAO.makePersistent(new Logprojectstatus(
					project,user, Constants.STATUS_CONTROL,Constants.INVESTMENT_APPROVED, new Date()));
			
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
	}
	
	/**
	 * 
	 * @param program
	 * @return
	 * @throws Exception
	 */
	public static double calcBudgetBottomUp(Program program) throws Exception {
		
		double budgets = 0;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			ProjectDAO projectDAO = new ProjectDAO(session);
			budgets = projectDAO.getBudgetBottomUp(program);
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
		return budgets;
	}
	
	/**
	 * 
	 * @param employee
	 * @return
	 * @throws Exception
	 */
	public static List<Project> findByEmployee(Employee employee, List<String> joins) throws Exception {
		List<Project> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projDAO = new ProjectDAO(session);
			list = projDAO.findByEmployee(employee, joins);
			
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
		return list;
	}


	/**
	 * Find by PO and equals Planning or Execution
	 * @param performingorg
	 * @return
	 * @throws Exception 
	 */
	public List<Project> findByPO(Performingorg performingorg) throws Exception {
		
		List<Project> projects = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO = new ProjectDAO(session);
			projects = projectDAO.findByPO(performingorg);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return projects;
	}
	
	/**
	 * Find projects by employee between initDate and endDate
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	public static List<Project> findByEmployee(Employee employee, Date initDate, Date endDate) throws Exception {
		
		List<Project> projects = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO = new ProjectDAO(session);
			projects = projectDAO.findByEmployee(employee, initDate, endDate);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return projects;
	}
}
