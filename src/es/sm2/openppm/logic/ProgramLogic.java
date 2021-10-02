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

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.CompanyDAO;
import es.sm2.openppm.dao.ProgramDAO;
import es.sm2.openppm.dao.ProjectDAO;
import es.sm2.openppm.dao.ProjectFollowupDAO;
import es.sm2.openppm.dao.ProjectKpiDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.ProgramNotFoundException;
import es.sm2.openppm.javabean.ProjectScore;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ProgramLogic extends AbstractGenericLogic<Program, Integer> {

	/**
	 * Find Program by Id
	 * @param idProgram
	 * @return
	 * @throws Exception 
	 */
	public static Program consProgram(Integer idProgram) throws Exception {
		Program program = null;
		
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			ProgramDAO programDAO = new ProgramDAO(session);
			if (idProgram != -1) {
				program = programDAO.findById(idProgram, false);
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
		
		return program;
	}
	
	
	/**
	 * Returns list Programs
	 * @return
	 * @throws Exception 
	 */
	public static List<Program> findAllWithManager() throws Exception {
		List<Program> programs = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			ProgramDAO programDAO = new ProgramDAO(session);
			programs = programDAO.searchByExample(new Program(), Contact.class);
			
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
		
		return programs;
	}
	
	/**
	 * Save and Update program
	 * @param program
	 * @throws Exception 
	 */
	public static Program saveProgram(Program program) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProgramDAO programDAO = new ProgramDAO(session);
			program = programDAO.makePersistent(program);
			
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
		return program;
	}
	
	/**
	 * Delete Program
	 * @param idCompany
	 * @throws Exception 
	 */
	public static void deleteProgram(Integer idProgram) throws Exception {
		if (idProgram == null || idProgram == -1) {
			throw new ProgramNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			ProgramDAO programDAO	= new ProgramDAO(session);
			Program program			= programDAO.findById(idProgram, false);
			
			if (program != null) {
				
				if (!program.getProjects().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","program","project");
				}
				
				programDAO.makeTransient(program);
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
	
	
	public static List<Program> consByProgramManager(Employee employee) throws Exception {
		
		List<Program> programs = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			ProgramDAO programDAO = new ProgramDAO(session);
			Program example = new Program();
			example.setEmployee(employee);
			
			programs = programDAO.searchByExample(example, Contact.class);
			
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
		
		return programs;
	}
	
	public static List<Program> consByPO(Employee user) throws Exception {
		
		List<Program> programs = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			ProgramDAO programDAO = new ProgramDAO(session);
			programs = programDAO.findByPO(user);
			
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
		
		return programs;
	}

	public static List<ProjectScore> consProjectScores(List<Project> projects) throws Exception {
		
		List<ProjectScore> projectScores = new ArrayList<ProjectScore>();
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			ProjectKpiDAO kpiDAO = new ProjectKpiDAO(session);
			
			for (Project proj : projects) {
				Double score = kpiDAO.calcScore(proj);
				
				ProjectScore pScore = new ProjectScore();
				pScore.setProject(proj);
				pScore.setScore(score);
				
				projectScores.add(pScore);
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
		
		return projectScores;
	}

	/**
	 * Search by PerfOrg
	 * @param performingorg
	 * @return
	 * @throws Exception
	 */
	public static List<Program> searchByPerfOrg(Performingorg performingorg) throws Exception {
		
		List<Program> programs = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			ProgramDAO programDAO = new ProgramDAO(session);
			programs = programDAO.searchByPerfOrg(performingorg, null);
			
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
		return programs;
	}

	/**
	 * Search by company of user
	 * @param user
	 * @param joins
	 * @return
	 * @throws Exception 
	 */
	public static List<Program> consByCompany(Employee user, List<String> joins) throws Exception {
		
		List<Program> programs = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			ProgramDAO programDAO = new ProgramDAO(session);
			CompanyDAO companyDAO = new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			
			programs = programDAO.consByCompany(company, joins);
			
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
		return programs;
	}
	
	/**
	 * 
	 * @param program
	 * @return
	 * @throws Exception
	 */
	public static double calcActualCost(Program program) throws Exception {
		
		double cost = 0;		
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			ProjectDAO projectDAO = new ProjectDAO(session);
			List<Project> projects = projectDAO.findByProgram(program);
			ProjectFollowupDAO followDAO = new ProjectFollowupDAO(session);
			for (Project p : projects) {
				List<Projectfollowup> followups = followDAO.findByProject(p, Constants.DESCENDENT);
				for (Projectfollowup f : followups) {
					if(f.getAc() != null) {
						cost += f.getAc();
						break;
					}
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
		return cost;
	}
}
