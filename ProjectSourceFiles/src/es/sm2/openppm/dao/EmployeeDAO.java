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
package es.sm2.openppm.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Expensesheet;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Resourceprofiles;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Timesheet;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

public class EmployeeDAO extends AbstractGenericHibernateDAO<Employee, Integer> {

	public EmployeeDAO(Session session) {
		super(session);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<Employee> searchByExample(Employee exampleInstance,
			Class... joins) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		if (exampleInstance.getPerformingorg() != null) {
			crit.add(Restrictions.eq("performingorg.idPerfOrg", exampleInstance.getPerformingorg().getIdPerfOrg()));
		}
		if (exampleInstance.getResourceprofiles() != null) { 
			crit.add(Restrictions.eq("resourceprofiles.idProfile", exampleInstance.getResourceprofiles().getIdProfile()));
		}
		crit.setFetchMode("contact", FetchMode.JOIN);
		for (Class c : joins) {
			if (c.equals(Employee.class)) {
				crit.setFetchMode("employee", FetchMode.JOIN);
				crit.setFetchMode("employee.contact", FetchMode.JOIN);
			} else if (c.equals(Performingorg.class)) {
				crit.setFetchMode("performingorg", FetchMode.JOIN);
			} else if (c.equals(Resourceprofiles.class)) {
				crit.setFetchMode("resourceprofiles", FetchMode.JOIN);
			}
		}
		return crit.list();
	}
	

	/**
	 * Find by id with Contact
	 * @param emp
	 * @return
	 */
	public Employee findByIdWithContact(Employee emp) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.setFetchMode("contact", FetchMode.JOIN);
		crit.setFetchMode("contact.company", FetchMode.JOIN);
		crit.add(Restrictions.eq("idEmployee", emp.getIdEmployee()));
		return (Employee) crit.uniqueResult();
	}
	
	
	/**
	 * Search employees by criteria
	 * @param idProfile
	 * @param idSkills
	 * @param datein
	 * @param dateout
	 * @param company 
	 * @param idResManager 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> searchByFilter(Integer idProfile, String idSkills,
			Performingorg org, Company company, Integer idResManager) {
		
		List<Employee> employees = new ArrayList<Employee>();
		
		StringBuilder queryString = new StringBuilder();
		queryString.append(
				"select distinct employee.idEmployee " +
				"from Employee as employee " +
				"join employee.performingorg as perfOrg " +
				"join perfOrg.company as company " +
				"left join employee.skillsemployees as skilldb " +
				"left join skilldb.skill as skill " +
				"join employee.resourceprofiles as profiles " +
				"where company.idCompany = :idCompany "); 
		
		
		//filter by PO
		if (org.getIdPerfOrg() != -1) {
			queryString.append("and perfOrg.idPerfOrg = :idPerfOrg ");
		}
		
		//filter by profile
		if (idProfile != -1) {
			queryString.append("and profiles.idProfile = :idProfile ");
		}
		
		if (idResManager != null && idResManager != -1) {
			queryString.append("and employee.employee.idEmployee = :idResourceManager ");
		}
		
		if (!ValidateUtil.isNull(idSkills)) { 
			
			queryString.append("and skill.idSkill in ("+idSkills+") ");
		}
		
		queryString.append("group by employee");
		
		Query query = getSession().createQuery(queryString.toString());
		
		query.setInteger("idCompany", company.getIdCompany());
		
		if (org.getIdPerfOrg() != -1) {
			query.setInteger("idPerfOrg", org.getIdPerfOrg());
		}
		
		//Set the attributes of the filters
		if (idProfile != -1) {
			query.setInteger("idProfile", idProfile);
		}
		
		if (idResManager != null && idResManager != -1) {
			query.setInteger("idResourceManager", idResManager);
		}

		List<Integer> idEmployees = query.list();
		StringBuilder ids = new StringBuilder();
		
		for (Integer id : idEmployees) {
			if (ids.toString().equals(StringPool.BLANK)) {
				ids.append(id.toString());
			}
			else {
				ids.append(StringPool.COMMA+id.toString());
			}
		}
		
		if (!ids.toString().equals(StringPool.BLANK)) {
			Query query2 = getSession().createQuery(
					"select distinct employee " +
					"from Employee as employee " +
					"left join fetch employee.teammembers as teammembers " +
					"join fetch employee.contact as c " +
					"join fetch employee.employee as rm " +
					"join fetch employee.performingorg as perfOrg " +
					"left join fetch employee.skillsemployees as skilldb " +
					"left join fetch skilldb.skill as skill " +
					"join fetch rm.contact as rm_c " +
					"join fetch employee.resourceprofiles as profiles " +
					"where employee.idEmployee in ("+ids.toString()+")"
					);
			employees = query2.list();
		}
		
		return employees;
	}


	/**
	 * Return employee with data
	 * @param employee
	 * @return
	 */
	public Employee findByIdEmployee(Employee employee) {
		
		Employee empl = null;
		
		if (employee.getIdEmployee() != null) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.setFetchMode("contact", FetchMode.JOIN);
			crit.setFetchMode("employee", FetchMode.JOIN);
			crit.setFetchMode("employee.contact", FetchMode.JOIN);
			crit.setFetchMode("performingorg", FetchMode.JOIN);
			crit.setFetchMode("resourceprofiles", FetchMode.JOIN);
			crit.add(Restrictions.eq("idEmployee", employee.getIdEmployee()));
			empl = (Employee) crit.uniqueResult();
		}
		
		return empl;
	}

	
	/**
	 * Search Employee By filter
	 * @param name
	 * @param surname
	 * @param idProfile
	 * @param idPerfOrg
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> searchByFilter(String name, String jobTitle,
			Integer idProfile, Integer idPerfOrg, Company company) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		crit.createCriteria(Employee.CONTACT)
			.add(Restrictions.ilike(Contact.FULLNAME, "%"+name+"%"))
			.add(Restrictions.ilike(Contact.JOBTITLE, "%"+jobTitle+"%"))
			.add(Restrictions.eq(Contact.COMPANY, company));
		
		if (idProfile != -1) {
			crit.add(Restrictions.eq(Employee.RESOURCEPROFILES, new Resourceprofiles(idProfile)));
		}
		if (idPerfOrg != -1) {
			crit.add(Restrictions.eq(Employee.PERFORMINGORG, new Performingorg(idPerfOrg)));
		}
		
		crit.setFetchMode(Employee.CONTACT, FetchMode.JOIN);
		crit.setFetchMode(Employee.CONTACT+"."+Contact.COMPANY, FetchMode.JOIN);
		crit.setFetchMode(Employee.PERFORMINGORG, FetchMode.JOIN);
		
		return crit.list();
	}
	
	
	/**
	 * Calculate FTE of Team Members for these employee
	 * @param employee
	 * @param dateOut 
	 * @param dateIn 
	 * @return
	 */
	public double calculateFTE(Employee employee, Date dateIn, Date dateOut) {
		
		double fte = 0;
		if (employee.getIdEmployee() != null) {
			Query query = getSession().createQuery(
					"select sum(t.fte) " +
					"from Teammember as t " +
					"where ((t.dateIn between :datein and :dateout) " +
							"or (t.dateOut between :datein and :dateout) " +
							"or (:datein between t.dateIn and t.dateOut) " +
							"or (:dateout between t.dateIn and t.dateOut)) " +
						"and t.employee.idEmployee = :idEmployee");
			query.setInteger("idEmployee", employee.getIdEmployee());
			query.setDate("datein", dateIn);
			query.setDate("dateout", dateOut);
			if (query.uniqueResult() != null) {
				fte = (Long)query.uniqueResult();
			}
		}
		return fte;
	}

	@SuppressWarnings("unchecked")
	public List<Employee> consEmployeesByUser(Contact contact) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		crit.createCriteria(Employee.RESOURCEPROFILES)
			.addOrder(Order.asc(Resourceprofiles.PROFILENAME));
		
		crit.setFetchMode("resourceprofiles", FetchMode.JOIN)
			.setFetchMode("performingorg", FetchMode.JOIN);
		
		crit.createCriteria("contact")
			.add(Restrictions.idEq(contact.getIdContact()));
		
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public Employee findResourceByPM(Employee pm) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Employee.CONTACT, pm.getContact()))
			.add(Restrictions.eq(Employee.RESOURCEPROFILES, new Resourceprofiles(Constants.ROLE_RESOURCE)))
			.add(Restrictions.eq(Employee.PERFORMINGORG, pm.getPerformingorg()));
		
		List<Employee> list = crit.list();
		
		return (list != null && !list.isEmpty()?list.get(0):null);
	}

	/**
	 * Find employees by PO and Rol
	 * @param performingorg
	 * @param role
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> findByPOAndRol(Performingorg performingorg, int role) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		if (performingorg != null) {
			crit.add(Restrictions.eq(Employee.PERFORMINGORG, performingorg));
		}
		
		crit.add(Restrictions.eq(Employee.RESOURCEPROFILES, new Resourceprofiles(role)))
			.setFetchMode(Employee.CONTACT, FetchMode.JOIN)
			.createCriteria(Employee.CONTACT)
			.addOrder(Order.asc(Contact.FULLNAME));
		
		return crit.list();
	}

	/**
	 * Search employee by rol an company
	 * @param role
	 * @param company
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> searchEmployees(Resourceprofiles profile, Company company,
			List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		if (joins != null) {
			for (String join : joins) {
				crit.setFetchMode(join, FetchMode.JOIN);
			}
		}
		crit.add(Restrictions.eq(Employee.RESOURCEPROFILES, profile))
			.createCriteria(Employee.CONTACT)
			.add(Restrictions.eq(Contact.COMPANY, company))
			.addOrder(Order.asc(Contact.FULLNAME));
		
		return crit.list();
	}


	/**
	 * 
	 * @param idProjectActivity
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> searchEmployeesAssignedToProjectActivity (int idProjectActivity) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.createCriteria(Employee.TEAMMEMBERS)
			.add(Restrictions.eq(Teammember.PROJECTACTIVITY, new Projectactivity(idProjectActivity)))
			.add(Restrictions.eq(Teammember.STATUS, Constants.RESOURCE_ASSIGNED));

		return crit.list();
	}

	/**
	 * Find Approvals TimeSheet
	 * object[0] == idEmployee
	 * object[1] == Name employee
	 * object[2] == idProject
	 * object[3] == Project Name 
	 * @param pm
	 * @param initDate
	 * @param endDate
	 * @param maxStatus 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> findApprovalsTimeByPM(Employee pm, Date initDate, Date endDate, String maxStatus) {
		
		Query query = getSession().createQuery(
				"select distinct e.idEmployee,c.fullName ,p.idProject, p.projectName " +
				"from Employee as e " +
				"join e.timesheets as ts " +
				"join e.contact as c " +
				"left join ts.projectactivity as pa " +
				"left join pa.project as p " +
				"where (p.employeeByProjectManager = :pm or " +
						"(ts.projectactivity is null and e.performingorg = :po " +
							"and e.idEmployee not in " +
								 "(select distinct e2.idEmployee " +
								 "from Employee as e2 " +
								 "join e2.timesheets as ts2 " +
								 "join ts2.projectactivity as pa2 " +
								 "join pa2.project as p2 " +
								 "where p2.employeeByProjectManager = :pm " +
								 	"and ts2.initDate = :initDate " +
								 	"and ts2.endDate = :endDate " +
								 	"and (ts2.status = :app1 or ts2.status = :maxStatus))" +
								 ")" +
								 "and e.idEmployee in " +
								 "(select distinct e3.idEmployee " +
								 "from Employee as e3 " +
								 "join e3.timesheets as ts3 " +
								 "join ts3.projectactivity as pa3 " +
								 "join pa3.project as p3 " +
								 "where p3.employeeByProjectManager = :pm " +
								 	"and ts3.initDate = :initDate " +
								 	"and ts3.endDate = :endDate " +
								 	"and ts3.status = :app0" +
								 ")" +
					") " +
					"and ts.initDate = :initDate " +
					"and ts.endDate = :endDate " +
					"and (ts.status = :app1 or ts.status = :maxStatus)");
		
		query.setInteger("pm", pm.getIdEmployee());
		query.setDate("initDate", initDate);
		query.setDate("endDate", endDate);
		query.setString("app1", Constants.TIMESTATUS_APP1);
		query.setString("app0", Constants.TIMESTATUS_APP0);
		query.setString("maxStatus", maxStatus);
		query.setEntity("po", pm.getPerformingorg());
		return query.list();
	}

	/**
	 * Find Approvals Expense Sheet
	 * object[0] == idEmployee
	 * object[1] == Name employee
	 * object[2] == idProject
	 * object[3] == Project Name 
	 * @param pm
	 * @param initDate
	 * @param endDate
	 * @param maxStatus 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object[]> findApprovalsExpenseByPM(Employee pm, Date initDate, Date endDate, String maxStatus) {
		
		Query query = getSession().createQuery(
				"select distinct e.idEmployee,c.fullName ,p.idProject, p.projectName " +
				"from Employee as e " +
				"join e.expensesheets as ex " +
				"join ex.project as p " +
				"join e.contact as c " +
				"where p.employeeByProjectManager = :pm " +
					"and (ex.expenseDate between :initDate and :endDate) " +
					"and (ex.status = :app1 or ex.status = :maxStatus)");
		
		query.setInteger("pm", pm.getIdEmployee());
		query.setDate("initDate", initDate);
		query.setDate("endDate", endDate);
		query.setString("app1", Constants.EXPENSE_STATUS_APP1);
		query.setString("maxStatus", maxStatus);
		
		return query.list();
	}

	/**
	 * Find Approvals Time Sheets by Functional Manager
	 * @param user
	 * @param initDate
	 * @param endDate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> findApprovals(Employee user, Date initDate,
			Date endDate) {
		
		Resourceprofiles profile = user.getResourceprofiles();
		
		Criteria crit = getSession().createCriteria(getPersistentClass(),"e")
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.setFetchMode(Employee.CONTACT, FetchMode.JOIN)
			.createCriteria(Employee.TIMESHEETS,"ts")
				.add(Restrictions.eq(Timesheet.INITDATE, initDate))
				.add(Restrictions.eq(Timesheet.ENDDATE, endDate))
				.add(Restrictions.or(
						Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP2),
						Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3)
					))
				.createAlias(Timesheet.PROJECTACTIVITY,"pa", Criteria.LEFT_JOIN)
				.createAlias("pa."+Projectactivity.PROJECT,"p", Criteria.LEFT_JOIN);
					
		// Filter by User. Settings by company for last approval. 
		if (profile.getIdProfile() == Constants.ROLE_FM) {
			
			crit.add(Restrictions.or(
					Restrictions.eq("p."+Project.EMPLOYEEBYFUNCTIONALMANAGER, user),
					Restrictions.and(
							Restrictions.isNull("ts."+Timesheet.PROJECTACTIVITY),
							Restrictions.eq("e."+Employee.PERFORMINGORG, user.getPerformingorg())
						)
				));
		}
		else if (profile.getIdProfile() == Constants.ROLE_PMO) {
			
			crit.add(Restrictions.or(
					Restrictions.eq("p."+Project.PERFORMINGORG, user.getPerformingorg()),
					Restrictions.and(
							Restrictions.isNull("ts."+Timesheet.PROJECTACTIVITY),
							Restrictions.eq("e."+Employee.PERFORMINGORG, user.getPerformingorg())
						)
				));
		}
		
		return crit.list();
	}

	/**
	 * Find Approvals Expenses by Functional Manager
	 * @param user
	 * @param firstMonthDay
	 * @param lastMonthDay
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> findApprovalsExpense(Employee user,
			Date firstMonthDay, Date lastMonthDay) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.setFetchMode(Employee.CONTACT, FetchMode.JOIN)
			.createCriteria(Employee.EXPENSESHEETS)
				.add(Restrictions.between(Expensesheet.EXPENSEDATE, firstMonthDay, lastMonthDay))
				.add(Restrictions.or(
						Restrictions.eq(Expensesheet.STATUS, Constants.TIMESTATUS_APP2),
						Restrictions.eq(Expensesheet.STATUS, Constants.TIMESTATUS_APP3)
					));
		
		// Filter by User. Settings by company for last approval.
		
		Resourceprofiles profile = user.getResourceprofiles();
		
		Criteria filterCrit = crit.createCriteria(Expensesheet.PROJECT);
		
		if (profile.getIdProfile() == Constants.ROLE_FM) {
			
			filterCrit.add(Restrictions.eq(Project.EMPLOYEEBYFUNCTIONALMANAGER, user));
		}
		else if (profile.getIdProfile() == Constants.ROLE_PMO) {
			
			filterCrit.add(Restrictions.eq(Project.PERFORMINGORG, user.getPerformingorg()));
		}
		
		return crit.list();
	}

	/**
	 * Find Employees where inputed hours is approval
	 * @param project
	 * @param since
	 * @param until
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> findInputedInProject(Project project, Date since,
			Date until) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);

		Criteria members = crit.createCriteria(Employee.TEAMMEMBERS)
			.add(Restrictions.eq(Teammember.STATUS, Constants.RESOURCE_ASSIGNED));
		
		if (since != null && until != null) {
			
			members.add(Restrictions.disjunction()
				.add(Restrictions.between(Teammember.DATEIN, since, until))
				.add(Restrictions.between(Teammember.DATEOUT, since, until))
				.add(Restrictions.and(
						Restrictions.le(Teammember.DATEIN, since),
						Restrictions.ge(Teammember.DATEOUT, until)
					)
				)
			);
		}
		members.createCriteria(Teammember.PROJECTACTIVITY)
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		Criteria sheets = crit.createCriteria(Employee.TIMESHEETS)
			.add(Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3));
		
		if (since != null && until != null) {
			sheets.add(Restrictions.disjunction()
				.add(Restrictions.between(Timesheet.INITDATE, since, until))
				.add(Restrictions.between(Timesheet.ENDDATE, since, until))
				.add(Restrictions.and(
						Restrictions.le(Timesheet.INITDATE, since),
						Restrictions.ge(Timesheet.ENDDATE, until)
					)
				)
			);
		}
		sheets.createCriteria(Timesheet.PROJECTACTIVITY)
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		crit.setFetchMode(Employee.CONTACT, FetchMode.JOIN);
		crit.setFetchMode(Employee.CALENDARBASE, FetchMode.JOIN);
		
		return crit.list();
	}

	/**
	 * List employees by company
	 * @param company
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> findByCompany(Company company, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		crit.createCriteria(Employee.CONTACT)
			.add(Restrictions.eq(Contact.COMPANY, company));
		
		addJoins(crit, joins);
		
		return crit.list();
	}

	/**
	 * Check if token is in use
	 * @param token
	 * @return
	 */
	public boolean tokenInUse(String token) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Employee.TOKEN, token));
			
		return ((Integer) crit.uniqueResult() > 0);
	}

	/**
	 * Get employee for generate token
	 * @param contact
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> findForToken(Contact contact) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Employee.CONTACT, contact))
			.add(Restrictions.or(
				Restrictions.eq(Employee.RESOURCEPROFILES, new Resourceprofiles(Constants.ROLE_PMO)),
				Restrictions.eq(Employee.RESOURCEPROFILES, new Resourceprofiles(Constants.ROLE_PM))));
		
		List<String> joins = new ArrayList<String>();
		joins.add(Employee.PERFORMINGORG);
		joins.add(Employee.RESOURCEPROFILES);
		
		addJoins(crit, joins);
		
		crit.addOrder(Order.asc(Employee.PERFORMINGORG));
		crit.addOrder(Order.asc(Employee.RESOURCEPROFILES));
		
		return crit.list();
	}

	/**
	 * Find employee by token
	 * @param token
	 * @return
	 */
	public Employee findByToken(String token) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Employee.TOKEN, token));
		
		List<String> joins = new ArrayList<String>();
		joins.add(Employee.PERFORMINGORG);
		joins.add(Employee.RESOURCEPROFILES);
		
		addJoins(crit, joins);
		
		return (Employee) crit.uniqueResult();
	}
}
