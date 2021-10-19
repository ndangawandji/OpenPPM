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

import es.sm2.openppm.dao.IssuelogDAO;
import es.sm2.openppm.exceptions.IssueDeleteException;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.model.Issuelog;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.utils.SessionFactoryUtil;

public class IssuelogLogic extends AbstractGenericLogic<Issuelog, Integer> {
	
	/**
	 * Save Issue
	 * @param cost
	 * @throws Exception 
	 */
	public static void saveIssue (Issuelog issue) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			IssuelogDAO issueDAO = new IssuelogDAO(session);
			issueDAO.makePersistent(issue);
			
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
	 * Cons issue log for a project
	 * @param project
	 * @return
	 * @throws ProjectNotFoundException 
	 */
	public static List<Issuelog> consIssues(Project project) throws Exception {
		if (project == null) {
			throw new ProjectNotFoundException();
		}
		List<Issuelog> issues = null;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			Issuelog issue = new Issuelog();
			issue.setProject(project);
			
			IssuelogDAO issueDAO = new IssuelogDAO(session);
			issues = issueDAO.searchByExample(issue);
			
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
		
		return issues;
	}


	public static void deleteIssue(Integer idIssue) throws Exception {
			if (idIssue == -1) {
				throw new IssueDeleteException();
			}
			
			Transaction tx = null;
			Session session = SessionFactoryUtil.getInstance().getCurrentSession();
			try {
				tx = session.beginTransaction();
				
				IssuelogDAO issueDAO = new IssuelogDAO(session);
				Issuelog issue = issueDAO.findById(idIssue, false);
				if (issue != null) {
					issueDAO.makeTransient(issue);
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
}
