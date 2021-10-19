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

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.WorkingcostsDAO;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.exceptions.WorkingcostsNotFoundException;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Workingcosts;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Workingcosts
 * @see es.sm2.openppm.logic.Workingcosts
 * @author Hibernate Generator by Javier Hernandez
 */
public final class WorkingcostsLogic extends AbstractGenericLogic<Workingcosts, Integer>{

	
	/**
	 * Create or update Workingcosts
	 * @param workingcosts
	 * @throws Exception 
	 */
	public static Workingcosts saveWorkingcosts(Workingcosts workingcosts) throws Exception {
		if (workingcosts == null) {
			throw new WorkingcostsNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WorkingcostsDAO workingcostsDAO = new WorkingcostsDAO(session);
			workingcosts = workingcostsDAO.makePersistent(workingcosts);
			
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
		return workingcosts;
	}
	
	/**
	 * Delete Workingcosts
	 * @param workingcosts
	 * @throws Exception 
	 */
	public static void deleteWorkingcosts(Workingcosts workingcosts) throws Exception {
		if (workingcosts == null) {
			throw new WorkingcostsNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WorkingcostsDAO workingcostsDAO = new WorkingcostsDAO(session);
			
			workingcosts = workingcostsDAO.findById(workingcosts.getIdWorkingCosts(), false);
			workingcostsDAO.makeTransient(workingcosts);
			
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
	 * @param proj
	 * @return
	 * @throws Exception
	 */
	public static int consInternalCostByProject(Project proj) 
	throws Exception {
		
		int result = 0;
		List<Workingcosts> list = null;
		if (proj == null) {
			throw new ProjectNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WorkingcostsDAO workingDAO = new WorkingcostsDAO(session);
			list = workingDAO.consByProject(proj);
			
			if(!list.isEmpty()) {
				for (Workingcosts w : list) {
					result += w.getEffort();
				}
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
		return result;
	}

	/**
	 * 
	 * @param proj
	 * @param dept
	 * @return
	 * @throws Exception
	 */
	public static int getCostByDeptAndProject(Project proj, String dept) 
	throws Exception {
		if (proj == null) {
			throw new ProjectNotFoundException();
		}
		int result = 0;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			WorkingcostsDAO workingDAO = new WorkingcostsDAO(session);
			result = workingDAO.getCostsByDept(proj, dept);			
			
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
		return result;
	}

}

