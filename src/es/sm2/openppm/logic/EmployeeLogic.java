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

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.CompanyDAO;
import es.sm2.openppm.dao.EmployeeDAO;
import es.sm2.openppm.dao.SkillsemployeeDAO;
import es.sm2.openppm.exceptions.EmployeeNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.model.Skillsemployee;
import es.sm2.openppm.utils.SecurityUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class EmployeeLogic extends AbstractGenericLogic<Employee, Integer> {

	/**
	 * Save employee
	 * @param employee
	 * @throws Exception 
	 */
	public static Employee saveEmployee (Employee employee, List<Skill> skills) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Employee emple = null;
		
		try {
			tx = session.beginTransaction();
			
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			SkillsemployeeDAO skillsDAO = new SkillsemployeeDAO(session);
			
			emple = employeeDAO.makePersistent(employee);
			
			List<Skillsemployee> skillsDB = null;
			Skillsemployee skill = new Skillsemployee();
			skill.setEmployee(emple);
			skillsDB = skillsDAO.findByEmployee(emple);
			
			if(skillsDB != null) {
				for (Skillsemployee s : skillsDB) {
					skillsDAO.makeTransient(s);
				}
			}
			
			if(skills != null) {
				Skillsemployee skillData;			
				
				for(Skill s : skills) {
					skillData = new Skillsemployee();					
					skillData.setEmployee(emple);
					skillData.setSkill(s);
					skillsDAO.makePersistent(skillData);					
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
		return emple;
	}		
	
	
	/**
	 * Returns employees list with data
	 * @return
	 * @throws Exception 
	 */
	public static List<Employee> findAllEmployeesWithData() throws Exception {
		List<Employee> employees = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			Employee exampleInstance = new Employee();
			employees = employeeDAO.searchByExample(exampleInstance, Employee.class, Performingorg.class, Resourceprofiles.class);
			
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
		return employees;
	}
	
	
	/**
	 * Return employee by id
	 * @param idEmployee
	 * @return
	 * @throws Exception 
	 */
	public static Employee consEmployee(Integer idEmployee) throws Exception {
		Employee employee = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {	
			tx = session.beginTransaction();
			
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			if (idEmployee != -1) {
				employee = employeeDAO.findByIdEmployee(new Employee(idEmployee));
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
		return employee;
	}
	
	
	/**
	 * Delete employee by id
	 * @param idEmployee
	 * @throws Exception 
	 */
	public static void deleteEmployee(Integer idEmployee) throws Exception {
		if (idEmployee == null || idEmployee == -1) {
			throw new EmployeeNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			EmployeeDAO employeeDAO	= new EmployeeDAO(session);
			Employee employee		= employeeDAO.findById(idEmployee, false);
			
			if (employee != null) {
				
				if (!employee.getPerformingorgs().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","maintenance.employee","perf_organization");
				}
				else if (!employee.getPrograms().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","maintenance.employee","program");
				}
				else if (!employee.getTeammembers().isEmpty()) {
					throw new LogicException("msg.error.delete.seller","maintenance.employee","activity");
				}
				else if (!employee.getProjectsForFunctionalManager().isEmpty()) {
					throw new LogicException("msg.error.this_is_a_in_a","maintenance.employee","business_manager","project");
				}
				else if (!employee.getProjectsForInvestmentManager().isEmpty()) {
					throw new LogicException("msg.error.this_is_a_in_a","maintenance.employee","investment_manager","project");
				}
				else if (!employee.getProjectsForProjectManager().isEmpty()) {
					throw new LogicException("msg.error.this_is_a_in_a","maintenance.employee","project_manager","project");
				}
				else if (!employee.getProjectsForSponsor().isEmpty()) {
					throw new LogicException("msg.error.this_is_a_in_a","maintenance.employee","sponsor","project");
				}
				else if (!employee.getEmployees().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","resource_manager","maintenance.employee");
				}
				else {
					employeeDAO.makeTransient(employee);
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
	}
	
	
	/**
	 * Search employee by filter
	 * @param idProfile
	 * @param idSkills
	 * @param datein
	 * @param dateout
	 * @param company 
	 * @param idResManager 
	 * @return
	 * @throws Exception 
	 */
	public static List<Employee> searchEmployees(Integer idProfile, String idSkills, Performingorg org, Company company, Integer idResManager) throws Exception {
		
		List<Employee> employees = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			employees = employeeDAO.searchByFilter(idProfile, idSkills, org, company, idResManager);
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
		return employees;
	}
	
	
	/**
	 * Find employee by id with Contact
	 * @param idEmployee
	 * @return
	 * @throws Exception 
	 */
	public static Employee consEmployeeWithContact(Employee emp) throws Exception {
		Employee employee = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			if (emp.getIdEmployee() != -1) {
				employee = employeeDAO.findByIdWithContact(emp);
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
		return employee;
	}


	/**
	 * Search Employees by filter
	 * @param name
	 * @param jobTitle
	 * @param idProfile
	 * @return
	 * @throws Exception 
	 */
	public static List<Employee> searchEmployees(String name, String jobTitle,
			Integer idProfile, Integer idPerfOrg, Employee user) throws Exception {
		
		List<Employee> employees = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO	= new EmployeeDAO(session);
			CompanyDAO companyDAO	= new CompanyDAO(session);
			
			Company company = companyDAO.searchByEmployee(user);
			employees = employeeDAO.searchByFilter(name, jobTitle, idProfile, idPerfOrg, company);

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
		return employees;
	}


	/**
	 * Calculate FTE of Team Members for these employee
	 * @param employee
	 * @param dateOut 
	 * @param dateIn 
	 * @return
	 * @throws Exception 
	 */
	public static double calculateFTE(Employee employee, Date dateIn, Date dateOut) throws Exception {
		
		double fte = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			fte = employeeDAO.calculateFTE(employee, dateIn, dateOut);

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
		return fte;
	}

	public static List<Employee> consEmployeesByUser(Contact contact) throws Exception {
		List<Employee> employees = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			employees = employeeDAO.consEmployeesByUser(contact);

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
		return employees;
	}

	/**
	 * Find employees by PO and Rol
	 * @param performingorg
	 * @param role
	 * @return
	 * @throws Exception 
	 */
	public static List<Employee> findByPOAndRol(Performingorg performingorg, int role) throws Exception {
		List<Employee> employees = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			employees = employeeDAO.findByPOAndRol(performingorg, role);

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
		return employees;
	}

	/**
	 * Search employee by rol an company
	 * @param role
	 * @param company
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public static List<Employee> searchEmployees(Resourceprofiles profile, Company company,
			List<String> joins) throws Exception {
		
		List<Employee> employees = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			employees = employeeDAO.searchEmployees(profile, company, joins);

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
		return employees;
	}
	

	/**
	 * 
	 * @param idProjectActivity
	 * @return
	 * @throws Exception
	 */
	public static List<Employee> searchEmployeesAssignedToProjectActivity (int idProjectActivity) 
	throws Exception {
	
		List<Employee> employees = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			employees = employeeDAO.searchEmployeesAssignedToProjectActivity(idProjectActivity);

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
		return employees;
	}


	/**
	 * Find Approvals Time Sheet
	 * object[0] == idEmployee
	 * object[1] == Name employee
	 * object[2] == idProject
	 * object[3] == Project Name 
	 * @param maxStatus 
	 * @param consUser
	 * @throws Exception 
	 */
	public List<Object[]> findApprovalsTimeByPM(Employee pm, Date initDate, Date endDate, String maxStatus) throws Exception {
		
		List<Object[]>  list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
			
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			list = employeeDAO.findApprovalsTimeByPM(pm, initDate, endDate, maxStatus);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}
	
	/**
	 * Find Approvals Expense Sheet
	 * object[0] == idEmployee
	 * object[1] == Name employee
	 * object[2] == idProject
	 * object[3] == Project Name 
	 * @param maxStatus 
	 * @param consUser
	 * @throws Exception 
	 */
	public List<Object[]> findApprovalsExpenseByPM(Employee pm, Date initDate, Date endDate, String maxStatus) throws Exception {
		
		List<Object[]>  list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
			
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			list = employeeDAO.findApprovalsExpenseByPM(pm, initDate, endDate, maxStatus);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}
	
	/**
	 * Find Approvals Time Sheets by Functional Manager
	 * @param consUser
	 * @throws Exception 
	 */
	public List<Employee> findApprovals(Employee user, Date initDate, Date endDate) throws Exception {
		
		List<Employee>  list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			list = employeeDAO.findApprovals(user, initDate, endDate);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}

	/**
	 * Find Approvals Expenses by Functional Manager
	 * @param user
	 * @param firstMonthDay
	 * @param lastMonthDay
	 * @return
	 * @throws Exception
	 */
	public List<Employee> findApprovalsExpense(Employee user,
			Date firstMonthDay, Date lastMonthDay) throws Exception {
		
		List<Employee>  list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			list = employeeDAO.findApprovalsExpense(user, firstMonthDay, lastMonthDay);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}

	/**
	 * Find Employees where inputed hours is approval
	 * @param project
	 * @param since
	 * @param until
	 * @return
	 * @throws Exception 
	 */
	public List<Employee> findInputedInProject(Project project, Date since,
			Date until) throws Exception {
		
		List<Employee>  list = null;
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			list = employeeDAO.findInputedInProject(project, since, until);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}

	/**
	 * List employees by company
	 * @param company
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	public List<Employee> findByCompany(Company company, List<String> joins) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		List<Employee> list = null;
		
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			list = employeeDAO.findByCompany(company, joins);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		return list;
	}


	/**
	 * Add token for employee
	 * @param employee
	 * @return
	 * @throws Exception 
	 */
	public String addToken(Employee employee) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		String token = null;
		
		try {
			tx = session.beginTransaction();
			
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			employee = employeeDAO.findById(employee.getIdEmployee());
			
			token = SecurityUtil.getRandomString(30);
			
			while (employeeDAO.tokenInUse(token)) {
				token = SecurityUtil.getRandomString(30);
			}

			employee.setToken(token);
			
			employeeDAO.makePersistent(employee);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return token;
	}

	/**
	 * Get employee for generate token
	 * @param contact
	 * @return
	 * @throws Exception
	 */
	public List<Employee> findForToken(Contact contact) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		List<Employee> list = null;
		
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			list = employeeDAO.findForToken(contact);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return list;
	}

	/**
	 * Find employee by token
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public Employee findByToken(String token) throws Exception {
		
		Transaction tx	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		Employee employee = null;
		
		try {
			tx = session.beginTransaction();
		
			EmployeeDAO employeeDAO = new EmployeeDAO(session);
			employee = employeeDAO.findByToken(token);
			
			tx.commit();
		}
		catch (Exception e) { if (tx != null) { tx.rollback(); } throw e; }
		finally { SessionFactoryUtil.getInstance().close(); }
		
		return employee;
	}
}
