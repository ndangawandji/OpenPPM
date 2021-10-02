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
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.WBSNodeDAO;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.exceptions.WbsnodeCaException;
import es.sm2.openppm.exceptions.WbsnodeResumException;
import es.sm2.openppm.javabean.ParamResourceBundle;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class WBSNodeLogic extends AbstractGenericLogic<Wbsnode, Integer> {

	/**
	 * Get the first Wbsnode of the project
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static Wbsnode findFirstWBSnode(Project project) throws Exception {
				Wbsnode wbsnode = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			wbsnode = wbsNodeDAO.findFirstNode(project);
			
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
		
		return wbsnode;
	}	
	
	
	/**
	 * Return Childs of Wbsnode
	 * @param wbsnode
	 * @return
	 * @throws Exception 
	 */
	public static List<Wbsnode> findChildsWbsnode(Wbsnode wbsnode) throws Exception {
		
		List<Wbsnode> childs = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			childs = wbsNodeDAO.findChilds(wbsnode);
			
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
		
		return childs;
	}	
	
	
	/** 
	 * Return all WBSNodes for a scope project
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<Wbsnode> consWBSNodes(Project project) throws Exception {
		List<Wbsnode> list = null;
		
		if (project.getIdProject() == null) {
			throw new NoDataFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			list = wbsNodeDAO.findByProject(project);
			
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
	 * Save wbsnode
	 * @param wbsNode
	 * @param idProject
	 * @return activity
	 * @throws Exception 
	 */
	public static boolean saveWBSnode (Wbsnode wbsNode, Project project) throws Exception {

		Transaction tx = null;		 
		boolean changeCA = false;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			/* Saving a child node */
			if(wbsNode.getWbsnode() != null && wbsNode.getIsControlAccount()) {
				Wbsnode parent = wbsNodeDAO.findFirstNode(project);
				if(parent.getIsControlAccount()) {
					parent.setIsControlAccount(false);
					wbsNodeDAO.saveWBSnode(parent, project);
					changeCA = true;	
				}
			}	
			/* Saving the first node */
			if(wbsNode.getWbsnode() == null && wbsNode.getIsControlAccount()) {
				List<Wbsnode> nodes = wbsNodeDAO.findChildsByProject(project);
				if(!nodes.isEmpty()) {
					for(Wbsnode node : nodes) {
						if(node.getIsControlAccount()) {
							wbsNode.setIsControlAccount(false);
							changeCA = true;
							break;
						}
					}
				}
			}
			wbsNodeDAO.saveWBSnode(wbsNode, project);
			
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
		return changeCA;
	}
	
	
	/**
	 * Detele wbs node
	 * @param idWbsnode
	 * @throws Exception 
	 */
	public static void deleteWBSNode (Integer idWbsnode) throws Exception {
		Wbsnode wbsNode = null;
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			if (idWbsnode == -1) {
				throw new NoDataFoundException();
			}
			
			wbsNode = wbsNodeDAO.findById(idWbsnode, false);
			
			if (wbsNode == null) {
				throw new NoDataFoundException();
			}
			if (wbsNode.getIsControlAccount() != null && wbsNode.getIsControlAccount()) {
				throw new WbsnodeCaException();
			}
			if (wbsNode.getWbsnode() == null) {
				throw new WbsnodeResumException();
			}
			
			wbsNodeDAO.makeTransient(wbsNode);
			
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
	 * Check WBS Errors
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<ParamResourceBundle> checkErrorsWBS(Project project) throws Exception {
		
		List<ParamResourceBundle> errors	= new ArrayList<ParamResourceBundle>();
		Transaction tx		= null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			Wbsnode firstNode = wbsNodeDAO.findFirstNode(project);
			
			if (firstNode == null) {
				
				errors.add(new ParamResourceBundle("msg.error.not_found_any","wbs_node","project"));
			}
			else {
				findErrosWBS(firstNode, errors,false);
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
		return errors;
	}


	/**
	 * Find Errors for WBS
	 * @param wbsnode
	 * @param errors
	 * @param isca
	 */
	private static void findErrosWBS(Wbsnode wbsnode, List<ParamResourceBundle> errors,boolean isca) {
		if (wbsnode.getWbsnode() != null && wbsnode.getWbsnodes().size() == 0 && !wbsnode.getWbsnode().getIsControlAccount() &&
				!wbsnode.getIsControlAccount() && !isca) {
			
			ParamResourceBundle temp = new ParamResourceBundle("msg.info.not_ca",wbsnode.getCode(),wbsnode.getName());
			errors.add(temp);
		}
		if (wbsnode.getWbsnodes().size() > 0) {
			for (Wbsnode child : wbsnode.getWbsnodes()) {
				if (isca && child.getIsControlAccount()) {
					ParamResourceBundle temp = new ParamResourceBundle("msg.info.already_ca",child.getCode(),child.getName());
					errors.add(temp);
				}
				if (isca) {
					findErrosWBS(child, errors, true);
				}
				else {
					findErrosWBS(child, errors, child.getIsControlAccount());
				}
			}
		}
	}

	/**
	 * 
	 * @param project
	 * @return
	 * @throws Exception
	 */
	public static Double consTotalBudget(Project project) throws Exception {
		
		Double total = null;
		
		Transaction tx		= null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			total = wbsNodeDAO.consTotalBudget(project);
			
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
	 * Find by project
	 * @param project
	 * @return
	 * @throws Exception 
	 */
	public static List<Wbsnode> findByProject(Project project) throws Exception {
		List<Wbsnode> list = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WBSNodeDAO wbsNodeDAO = new WBSNodeDAO(session);
			list = wbsNodeDAO.findByProject(project);
			
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
}
