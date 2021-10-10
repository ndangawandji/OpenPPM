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
package es.sm2.openppm.plugins.msproject;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import net.sf.mpxj.Task;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.MilestoneDAO;
import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.dao.ProjectDAO;
import es.sm2.openppm.dao.ProjectFollowupDAO;
import es.sm2.openppm.dao.TeamMemberDAO;
import es.sm2.openppm.dao.WBSNodeDAO;
import es.sm2.openppm.exceptions.MSProjectNoActivityException;
import es.sm2.openppm.javabean.NodeMSP;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.NumberUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.StringUtil;
import es.sm2.openppm.utils.ValidateUtil;

public class MSProjectLogic {
	
	/**
	 * Load tasks from MS Project file
	 * @param taskList
	 * @param projectId
	 * @throws Exception
	 */
	public static void loadTasks(List<Task> taskList, int projectId) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try {
			tx = session.beginTransaction();
		
			ProjectDAO projectDAO			= new ProjectDAO(session);
			ProjectFollowupDAO followupDAO	= new ProjectFollowupDAO(session);
			TeamMemberDAO memberDAO			= new TeamMemberDAO(session);
			
			Project project = projectDAO.findById(projectId, false);
			
			WBSNodeDAO wbsDAO = new WBSNodeDAO(session);
		
			// Find Resume WBS node
			Wbsnode wbsParent = wbsDAO.findFirstNode(project);
			
			// Parent is added in project by default. Not to be added now.
			Task parent = taskList.get(0);
			List<Task> auxList = parent.getChildTasks();
			
			if (auxList.size() == 0) {
				throw new MSProjectNoActivityException();
			}
			else if (auxList.size() == 1) {
				// Resume activity found
				parent = auxList.get(0);
			}
					
			ProjectActivityDAO activityDAO		= new ProjectActivityDAO(session);
			MilestoneDAO milestoneDAO			= new MilestoneDAO(session);
						
			// Update parent WBS name
			wbsParent.setDescription(StringUtil.cut(parent.getNotes(),1500));
			wbsParent.setBudget(null);
			wbsParent.setWbsnodes(null);
			wbsParent.setIsControlAccount(false);
			
			wbsParent = wbsDAO.makePersistent(wbsParent);
			
			// Update activity with dates
			Projectactivity parentActivity = activityDAO.findByWBSnode(project, wbsParent.getIdWbsnode());
			
			Calendar oldPlanInitDate	= DateUtil.getCalendar();
			Calendar oldPlanEndDate		= DateUtil.getCalendar();
			oldPlanInitDate.setTime(parentActivity.getPlanInitDate());
			oldPlanEndDate.setTime(parentActivity.getPlanEndDate());
			
			double totalBudget		= wbsDAO.totalBudget(project);
			
			parentActivity.setPlanInitDate(parent.getBaselineStart());
			parentActivity.setPlanEndDate(parent.getBaselineFinish());
			parentActivity.setWbsdictionary(StringUtil.cut(parent.getNotes(),300));

			parentActivity = activityDAO.makePersistent(parentActivity);
			
			for (Teammember member : parentActivity.getTeammembers()) {
				
				boolean update = false;
				
				if (member.getDateIn().before(parentActivity.getPlanInitDate()) ||
						member.getDateIn().after(parentActivity.getPlanEndDate())) {
					
					update = true;
					member.setDateIn(parentActivity.getPlanInitDate());
				}
				if (member.getDateOut().after(parentActivity.getPlanEndDate())
						|| member.getDateOut().before(parentActivity.getPlanInitDate())) {
					
					update = true;
					member.setDateOut(parentActivity.getPlanEndDate());
				}
				
				if (update) { memberDAO.makePersistent(member); }
			}
			
			wbsDAO.restoreNodes(wbsParent, project, parentActivity);
			wbsParent = wbsDAO.makePersistent(wbsParent);
			
			// Create tree
			List<NodeMSP> nodes = createTree(parent);
			// Insert tree
			insertWBSNodes(nodes, wbsParent, project, parentActivity, wbsDAO, milestoneDAO, activityDAO);
			
			// Update project
			if (!project.getInvestmentStatus().equals(Constants.INVESTMENT_APPROVED)) {
				
				project.setPlannedInitDate(parent.getBaselineStart());
				project.setPlannedFinishDate(parent.getBaselineFinish());
				projectDAO.makePersistent(project);
			}
			
			Calendar newPlanInitDate	= DateUtil.getCalendar();
			Calendar newPlanEndDate		= DateUtil.getCalendar();
			newPlanInitDate.setTime(parentActivity.getPlanInitDate());
			newPlanEndDate.setTime(parentActivity.getPlanEndDate());
			
			if (!DateUtil.equals(oldPlanInitDate,newPlanInitDate) ||
					!DateUtil.equals(oldPlanEndDate,newPlanEndDate) ||
					totalBudget != wbsDAO.totalBudget(project)) {
				
				
				followupDAO.deleteByProject(project);
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
	}
	
	/**
	 * Create Tree
	 * @param parent
	 * @return
	 */
	private static List<NodeMSP> createTree(Task parent) {
		
		List<NodeMSP> childs = new ArrayList<NodeMSP>();
		
		for (Task child : parent.getChildTasks()) {
			
			List<NodeMSP> childForNode = createTree(child);
			
			if ((!ValidateUtil.isNull(child.getWBS())
					|| !childForNode.isEmpty()
					|| child.getLateStart().equals(child.getLateFinish()))
					&& !ValidateUtil.isNull(child.getName())
					&& child.getBaselineStart() != null
					&& child.getBaselineFinish() != null) {
				
				NodeMSP childMSP = new NodeMSP();
				childMSP.setPlannedStart(child.getBaselineStart());
				childMSP.setPlannedFinish(child.getBaselineFinish());
				childMSP.setName(StringUtil.cut(child.getName(),80));
				childMSP.setDescription(StringUtil.cut(child.getNotes(),1500));
				childMSP.setChilds(childForNode);
				
				
				if (!ValidateUtil.isNull(child.getWBS())) {
					double budget = child.getBaselineCost().doubleValue();
					childMSP.setBudget(NumberUtil.truncate2decimals(budget));
					childMSP.setControlAcount(true);
					childMSP.setCode(StringUtil.cut(child.getWBS(),5));
					
					childMSP.setNotes(StringUtil.cut(child.getNotes(),300));
					
					childMSP.setEv(
							(child.getBCWP() != null
								?NumberUtil.truncate2decimals(child.getBCWP().doubleValue())
								:null)
						);
					childMSP.setAc(
							(child.getACWP() != null
								?NumberUtil.truncate2decimals(child.getACWP().doubleValue())
								:null)
						);
				}
				else {
					childMSP.setControlAcount(false);
					childMSP.setCode(StringPool.BLANK);
				}
				
				childs.add(childMSP);
			}
		}
		return childs;
	}
	
	/**
	 * Insert WBS Nodes
	 * @param childs
	 * @param wbsParent
	 * @param project
	 * @param parentActivity
	 * @param wbsDao
	 * @param milestoneDAO
	 * @param activityDAO
	 */
	private static void insertWBSNodes(List<NodeMSP> childs, Wbsnode wbsParent, Project project, 
			Projectactivity parentActivity, WBSNodeDAO wbsDao,
			MilestoneDAO milestoneDAO, ProjectActivityDAO activityDAO) {
		
		int contTasks = 0;
		int contMilestones = 0;
		
		for (NodeMSP child : childs) {

			if (child.getPlannedStart().equals(child.getPlannedFinish())) {
				contMilestones++;
				
				// Insert milestone
				Milestones milestone = new Milestones();
				milestone.setProject(project);
				milestone.setLabel(String.valueOf(contMilestones));
				milestone.setDescription(child.getName());
				milestone.setPlanned(child.getPlannedStart());
				milestone.setReportType('N');
				milestone.setProjectactivity(parentActivity);
				
				milestoneDAO.makePersistent(milestone);
			}
			else {
				// Insert WBS node and activity 
				contTasks++;
				
				Wbsnode wbsNode = new Wbsnode();
				wbsNode.setProject(project);
				wbsNode.setName(child.getName());				
				wbsNode.setDescription(child.getDescription());

				if (child.isControlAcount()) {
					
					wbsNode.setIsControlAccount(true);
					wbsNode.setBudget(child.getBudget());
					wbsNode.setCode(child.getCode());
				}
				else {
					wbsNode.setIsControlAccount(false);
				}
				wbsNode.setWbsnode(wbsParent);
				
				wbsNode = wbsDao.saveWBSnode(wbsNode, project);
				
				if (child.isControlAcount()) {
					
					// Update activity with dates
					Projectactivity activity = activityDAO.findByWBSnode(project, wbsNode.getIdWbsnode());
					activity.setPlanInitDate(child.getPlannedStart());
					activity.setPlanEndDate(child.getPlannedFinish());
					activity.setEv(child.getEv());
					activity.setAc(child.getAc());
					activity.setWbsdictionary(child.getNotes());
					activityDAO.makePersistent(activity);
					
				}
				insertWBSNodes(child.getChilds(), wbsNode, project, parentActivity, wbsDao, milestoneDAO, activityDAO);
			}
		}
	}
	
	/**
	 * Update Project by Tasks
	 * @param taskList
	 * @param idProject
	 * @throws Exception
	 */
	public static void updateTasks(List<Task> taskList, int idProject) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try {
			tx = session.beginTransaction();
		
			ProjectDAO projectDAO		 = new ProjectDAO(session);
			WBSNodeDAO wbsDAO			 = new WBSNodeDAO(session);			
			
			Project project 		= projectDAO.findById(idProject, false);			
			
			// Find Resume WBS node
			Wbsnode wbsParent = wbsDAO.findFirstNode(project);
			
			// Parent is added in project by default. Not to be added now.
			Task parent = taskList.get(0);
			List<Task> auxList = parent.getChildTasks();
			
			if (auxList.size() == 0) {
				throw new MSProjectNoActivityException();
			}
			else if (auxList.size() == 1) {
				// Resume activity found
				parent = auxList.get(0);
			}
		
			ProjectActivityDAO activityDAO		= new ProjectActivityDAO(session);
			WBSNodeDAO wbsNodeDAO				= new WBSNodeDAO(session);
			
			// Update activity with dates
			Projectactivity parentActivity = activityDAO.findByWBSnode(project, wbsParent.getIdWbsnode());
			parentActivity.setPlanInitDate(parent.getBaselineStart());
			parentActivity.setPlanEndDate(parent.getBaselineFinish());
			
			parentActivity.setActualInitDate(parent.getActualStart());
			parentActivity.setActualEndDate(parent.getActualFinish());
			
			activityDAO.makePersistent(parentActivity);
			
			// Update CAs
			updateNodes(parent, wbsNodeDAO, activityDAO, project);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
	}

	/**
	 * Update Nodes
	 * @param parent
	 * @param wbsNodeDAO
	 * @param activityDAO
	 * @param projScope
	 */
	private static void updateNodes(Task parent, WBSNodeDAO wbsNodeDAO, ProjectActivityDAO activityDAO, Project project) {
	
		for (Task child : parent.getChildTasks()) {
			
			
			 updateNodes(child, wbsNodeDAO, activityDAO, project);
			
			 if (!ValidateUtil.isNull(child.getWBS())) {
				 
				Wbsnode node = new Wbsnode();
				node.setCode(StringUtil.cut(child.getWBS(),5));
				node.setProject(project);
				
				List<Wbsnode> nodes = wbsNodeDAO.searchByCode(node);
				
				if (nodes != null && nodes.size() == 1) {
					node = nodes.get(0);
					
					double budget = child.getBaselineCost().doubleValue();
					node.setBudget(NumberUtil.truncate2decimals(budget));
	
					wbsNodeDAO.makePersistent(node);
					
					for (Projectactivity activity : node.getProjectactivities()) {
						
						activity.setPlanInitDate(child.getBaselineStart());
						activity.setPlanEndDate(child.getBaselineFinish());
						
						activity.setActualInitDate(child.getActualStart());
						activity.setActualEndDate(child.getActualFinish());
						
						activity.setAc(
								child.getActualCost() == null?null:child.getActualCost().doubleValue()
							);
						
						activityDAO.makePersistent(activity);
					} // For Activities
				} // Existing Nodes
				
			} // Existing wbs
		} // For tasks
	}

}
