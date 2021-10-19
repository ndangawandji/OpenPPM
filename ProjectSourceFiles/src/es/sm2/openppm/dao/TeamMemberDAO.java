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
/*
 *  Updater : Devoteam : Xavier de Langautier User Story 15
 *                              fonction : consTeamMembers  : Ajout d'un ordre de tri sur la récupération des activités
 *                              ajout du constructeur de list de teammember consTeamMembers : recherche à partir d'un id d'activité
 */

/*
 *  Updater Cedric Ndanga Wandji
 *  Devoteam 04/06/2015 user story 27 : adding of consTeamMember(Integer idProjectActivity, Integer idEmployee)
 *  Devoteam 02/07/2015 user story 40 : adding of workloadInDaysByActivity(Projectactivity activity) 
 */
package es.sm2.openppm.dao;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.javabean.DatoColumna;
import es.sm2.openppm.javabean.FiltroTabla;
import es.sm2.openppm.model.Contact;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Timesheet;
import es.sm2.openppm.servlets.ProjectControlServlet;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

public class TeamMemberDAO extends AbstractGenericHibernateDAO<Teammember, Integer> {


	private Criteria critProject;
	private Criteria critActivity;
	private Criteria critContact;
	private static final Logger LOGGER = Logger.getLogger(ProjectControlServlet.class);	
	
	public TeamMemberDAO(Session session) {
		super(session);
	}

	public Teammember searchMember(Teammember member) {
		
		Query query = getSession().createQuery(
				"select t " +
				"from Teammember as t " + 
				"join fetch t.projectactivity as pa " +
				"join fetch t.employee as e " +
				"join fetch e.contact as c " +
				"join fetch e.resourceprofiles as rp " +
				"join fetch e.performingorg as po " +
				"left join fetch e.skillsemployees as skilldb " +
				"left join fetch skilldb.skill as skill " +
				"join fetch e.employee as rm " +
				"join fetch rm.contact as rm_co " +
				"where t.idTeamMember = :idTeamMember ");
				
		query.setInteger("idTeamMember", member.getIdTeamMember());
		return (Teammember) query.uniqueResult();
				
	}
	
	/**
	 * Search Team Member by criteria
	 * @param employee
	 * @param projectactivity
	 * @param datein
	 * @param dateout
	 * @return
	 */
	public Teammember searchByCriteria(Employee employee, Projectactivity projectactivity,Date datein,Date dateout) {
		Teammember teammember = null;
		
		Query query = getSession().createQuery(
				"select teammember " +
				"from Teammember as teammember " + 
				"join fetch teammember.employee as employee " +
				"join fetch employee.resourceprofiles as resourceprofiles " +
				"join teammember.projectactivity as projAc " +
				"where ((teammember.dateIn between :datein and :dateout) " +
					"or (teammember.dateOut between :datein and :dateout) " +
					"or (:datein between teammember.dateIn and teammember.dateOut) " +
					"or (:dateout between teammember.dateIn and teammember.dateOut)) " +
					"and employee.idEmployee = :idEmployee and projAc.idActivity = :idActivity ");
		query.setInteger("idEmployee", employee.getIdEmployee());
		query.setInteger("idActivity", projectactivity.getIdActivity());
		query.setDate("datein", datein);
		query.setDate("dateout", dateout);
		if (!query.list().isEmpty()) { teammember = (Teammember) query.list().get(0); }
		return teammember;
	}
	
	
	/**
	 * Search Team Members by Project...
	 * @param idProject
	 * @param since
	 * @param until
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> consStaffinFtes(Project project,Date since,Date until) {
		
		Query query = getSession().createQuery(
				"select teammember " +
				"from Teammember as teammember " + 
				"join fetch teammember.employee as employee " +
				"left join fetch teammember.skill as skill " +
				"join fetch employee.contact as contact " +
				"join fetch employee.resourceprofiles as resourceprofiles " +
				"join teammember.projectactivity as projAc " +
				"join projAc.project as project " +
				"where ((teammember.dateIn between :datein and :dateout) " +
					"or (teammember.dateOut between :datein and :dateout) " +
					"or (:datein between teammember.dateIn and teammember.dateOut) " +
					"or (:dateout between teammember.dateIn and teammember.dateOut)) " +
					"and project = :idProject " +
					"and teammember.status = :status " + 
				"order by teammember.employee.contact.idContact");
		
		query.setInteger("idProject", project.getIdProject());
		query.setDate("datein", since);
		query.setDate("dateout", until);
		query.setString("status", Constants.RESOURCE_ASSIGNED);
		
		return query.list();
	}
	
	/**
	 * Search Team Members by Project with actuals FTEs
	 * @param project
	 * @param since
	 * @param until
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> consStaffinActualsFtes(Project project,Date since,Date until) {
		
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.add(Restrictions.eq(Teammember.STATUS, Constants.RESOURCE_ASSIGNED))
			.add(Restrictions.disjunction()
				.add(Restrictions.between(Teammember.DATEIN, since, until))
				.add(Restrictions.between(Teammember.DATEOUT, since, until))
				.add(Restrictions.and(
						Restrictions.le(Teammember.DATEIN, since),
						Restrictions.ge(Teammember.DATEOUT, until)
					)
				)
			);
		
		crit.createCriteria(Teammember.PROJECTACTIVITY)
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		Criteria timesheetsCrit = crit.createCriteria(Teammember.EMPLOYEE)
			.createCriteria(Employee.TIMESHEETS)
			.add(Restrictions.eq(Timesheet.STATUS, Constants.TIMESTATUS_APP3))
			.add(Restrictions.disjunction()
				.add(Restrictions.between(Timesheet.INITDATE, since, until))
				.add(Restrictions.between(Timesheet.ENDDATE, since, until))
				.add(Restrictions.and(
						Restrictions.le(Timesheet.INITDATE, since),
						Restrictions.ge(Timesheet.ENDDATE, until)
					)
				)
			);
		
		timesheetsCrit.createCriteria(Timesheet.PROJECTACTIVITY)			
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		crit.setFetchMode(Teammember.SKILL, FetchMode.JOIN);
		crit.setFetchMode(Teammember.EMPLOYEE, FetchMode.JOIN);
		crit.setFetchMode(Teammember.EMPLOYEE+"."+Employee.CALENDARBASE, FetchMode.JOIN);
		
		return crit.list();
	}
	
	/**
	 * Get Employees to a time sheet pending approve
	 * @param idProjectManager
	 * @param initdate
	 * @param enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Employee> membersTracking(Project project,Date initdate, Date enddate) {
		
		List<Employee> employees = new ArrayList<Employee>();
		
		String queryString = "select distinct employee.idEmployee " +
			"from Teammember as teammember " + 
			"join teammember.employee as employee " +
			"join teammember.projectactivity as projAc " +
			"join projAc.project as project " +
			"right join employee.weektimesheets as weekTs " +
			"join weekTs.projecttimesheets as timesheet " +
			"where project.idProject = :idProject " +
				"and (timesheet.appLevel = :minAppLevel " +
					"or timesheet.appLevel = :maxAppLevel ) " +
				"and timesheet.timeSheetDate between :initdate and :enddate ";
		
		Query query = getSession().createQuery(queryString);
		query.setInteger("idProject", project.getIdProject());
		query.setDate("initdate", initdate);
		query.setDate("enddate", enddate);
		
		query.setCharacter("minAppLevel", Constants.APP1);
		query.setCharacter("maxAppLevel", Constants.APP2);
		
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
					"select employee " +
					"from Teammember as teammember " + 
					"join teammember.employee as employee " +
					"join fetch employee.contact as contact " +
					"join fetch employee.resourceprofiles as resourceprofiles " +
					"join fetch employee.employee as rm " +
					"where employee.idEmployee in ("+ids.toString()+")"
					);
			
			employees = query2.list();
		}
		
		return employees;
	}


	/**
	 * List of Team Members by Resource Manager
	 * @param idEmployee
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> consMemberOfResourceManager(Integer idEmployee) {
		List<Teammember> teammembers = null;
		
		Query query = getSession().createQuery(
				"select tm " +
				"from Employee as rm " +
				"join rm.employees as emples " +
				"join emples.teammembers as tm " +
				"join fetch tm.employee as empl " +
				"join fetch empl.contact as cont " +
				"join tm.projectactivity as projAc " +
				"join projAc.project as project " +
				"where rm.idEmployee = :idEmployee " +
				"order by tm.employee.contact.idContact, project.idProject");
		query.setInteger("idEmployee", idEmployee);
		teammembers = query.list();

		return teammembers;
	}
	
	
	/**
	 * List Team Members by program
	 * @param idProgram
	 * @param initdate
	 * @param enddate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> membersByProgram(Integer idProgram,Date initdate, Date enddate) {
		
		String queryString = "select distinct teammember " +
			"from Teammember as teammember " +
			"join fetch teammember.employee as e " +
			"join fetch e.resourceprofiles as resProf " +
			"join teammember.projectactivity as projAc " +
			"join projAc.project as project " +
			"join project.program as program " +
			"where program.idProgram = :idProgram " +
			"and ((teammember.dateIn between :initdate and :enddate) " +
				"or (teammember.dateOut between :initdate and :enddate) " +
				"or (:initdate between teammember.dateIn and teammember.dateOut) " +
				"or (:enddate between teammember.dateIn and teammember.dateOut)) ";
		
		Query query = getSession().createQuery(queryString);
		query.setInteger("idProgram", idProgram);
		query.setDate("initdate", initdate);
		query.setDate("enddate", enddate);
		
		return query.list();
	}
	
	
	/**
	 * List Team Members by Project Activity
	 * @param idProjectActivity
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> membersByProjectActivity (Integer idProjectActivity) {
		
		String queryString = "select distinct teammember " +
			"from Teammember as teammember " +
			"join teammember.projectactivity as projAc " +
			"where projAc.idActivity = :idProjectActivity";
		
		Query query = getSession().createQuery(queryString);
		query.setInteger("idProjectActivity", idProjectActivity);
		
		return query.list();
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * user story 27
	 * Members employee dedicated at projectactivity
	 * @param project
	 * @param Employee
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> consTeamMember(Integer idProjectActivity, Integer idEmployee) {
		
		String queryString = "select distinct teammember from Teammember as teammember " +
							 "join teammember.projectactivity as projAc " +
							 "join teammember.employee as emp "  + 
							 "where projAc.idActivity = :idProjectActivity " + 
							 "and emp.idEmployee = :idEmployee";
		
		Query query = getSession().createQuery(queryString);
		query.setInteger("idProjectActivity", idProjectActivity);
		query.setInteger("idEmployee", idEmployee);
		
		return query.list();	
	}
	
	/**
	 * Members dedicated at project
	 * @param project
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> consTeamMembers(Project project) {
		
		List<Teammember> members = new ArrayList<Teammember>();
		
		Query query = getSession().createQuery(
			"select t.idTeamMember " +
			"from Teammember as t " +
			"join t.projectactivity as projAc " +
			"join projAc.project as project " +
			"where project.idProject = :idProject " +
			"group by t");
		
		query.setInteger("idProject", project.getIdProject());
		
		List<Integer> idMembers = query.list();
		StringBuilder ids = new StringBuilder();
		
		for (Integer id : idMembers) {
			if (ids.toString().equals(StringPool.BLANK)) {
				ids.append(id.toString());
			}
			else {
				ids.append(StringPool.COMMA+id.toString());
			}
		}
		
		if (!ids.toString().equals(StringPool.BLANK)) {
			Query query2 = getSession().createQuery(
					"select distinct t " +
					"from Teammember as t " +
					"join fetch t.employee as e " +
					"join fetch e.performingorg as po " +
					"join fetch e.contact as c " +
					"join fetch e.resourceprofiles as rp " +
					"left join fetch e.skillsemployees as skilldb " +
					"left join fetch skilldb.skill as skill " +
					"join fetch e.employee as rm " +
					"join fetch rm.contact as rmco " +
					"join fetch t.projectactivity as projAc " +
					"where t.idTeamMember in ("+ids.toString()+ ") "+
					"order by projAc.idActivity"  //us 15
					);
			
			members = query2.list();
		}
		
		return members;
	}

	/**
	 * Members dedicated at project activity
	 * @param projectactivity
	 * @return members
	 * Author : Devoteam Xavier de Langautier 2015/06/05
	 *          User story 15  on ne prends que les activités assignées
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> consTeamMembers(Projectactivity projectActivity) {
		
		List<Teammember> members = new ArrayList<Teammember>();
		//LOGGER.debug("consTeamMember"+ projectActivity.getIdActivity());
		Query query = getSession().createQuery(
			"select t.idTeamMember " +
			"from Teammember as t " +
			"join t.projectactivity as projAc " +
			"where projAc.idActivity = :idActivity " +
			"and t.status = '" + Constants.RESOURCE_ASSIGNED + "' "+
			"group by t");
		
		query.setInteger("idActivity", projectActivity.getIdActivity());

		List<Integer> idMembers = query.list();
		StringBuilder ids = new StringBuilder();
		
		for (Integer id : idMembers) {
			if (ids.toString().equals(StringPool.BLANK)) {
				ids.append(id.toString());
			}
			else {
				ids.append(StringPool.COMMA+id.toString());
			}
		}
		LOGGER.debug("teammemberid "+ids.toString());
		if (!ids.toString().equals(StringPool.BLANK)) {
			Query query2 = getSession().createQuery(
					"select distinct t " +
					"from Teammember as t " +
					"join fetch t.employee as e " +
					"join fetch e.performingorg as po " +
					"join fetch e.contact as c " +
					"join fetch e.resourceprofiles as rp " +
					"left join fetch e.skillsemployees as skilldb " +
					"left join fetch skilldb.skill as skill " +
					"join fetch e.employee as rm " +
					"join fetch rm.contact as rmco " +
					"join fetch t.projectactivity as projAc " +
					"where t.idTeamMember in ("+ids.toString()+ ") "+
					"order by projAc.idActivity" 
					);
			
			members = query2.list();
		}
		
		return members;
	}
	
	/**
	 * @author Cedric Ndanga Wandji
	 * user story 40
	 * Sum of workload by activity
	 * @param project activity
	 * @return
	 */
	public Double workloadInDaysByActivity(Projectactivity activity) {
		
		Query query = getSession().createQuery(
				"select sum(t.workloadInDays) " +
				"from Teammember as t " +
				"join t.projectactivity as projAc " +
				"where projAc.idActivity = :idActivity " +
				"and t.status = '" + Constants.RESOURCE_ASSIGNED + "' "
				);
			
		query.setInteger("idActivity", activity.getIdActivity());
		
		if(query.uniqueResult() != null) {
			return (Double) query.uniqueResult();
		}
		return (double) 0;
	}

	
	/**
	 * Get project by TeamMember
	 * @param member
	 * @return
	 */
	public Project consProject(Teammember member) {
		
		Project proj = null;
		
		Query query = getSession().createQuery(
			"select distinct project " +
			"from Teammember as t " +
			"join t.projectactivity as projAc " +
			"join projAc.project as project " +
			"where t.idTeamMember = :idTeamMember ");
		
		query.setInteger("idTeamMember", member.getIdTeamMember());
		
		if (!query.list().isEmpty()) {
			proj = (Project) query.list().get(0);
		}
		return proj;
	}
	
	/**
	 * Check if resource is assigned in range of dates in activity 
	 * @param member
	 * @return
	 */
	public boolean isAssigned(Teammember member) {
		
		Date since = member.getDateIn();
		Date until = member.getDateOut();
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Teammember.PROJECTACTIVITY, member.getProjectactivity()))
			.add(Restrictions.eq(Teammember.EMPLOYEE, member.getEmployee()))
			.add(Restrictions.ne(Teammember.STATUS, Constants.RESOURCE_RELEASED))
			.add(Restrictions.disjunction()
				.add(Restrictions.between(Teammember.DATEIN, since, until))
				.add(Restrictions.between(Teammember.DATEOUT, since, until))
				.add(Restrictions.and(
						Restrictions.le(Teammember.DATEIN, since),
						Restrictions.ge(Teammember.DATEOUT, until)
					)
				)
			);;
		
		return ((Integer)crit.uniqueResult()) > 0;
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Teammember> filter(FiltroTabla filter, ArrayList<String> joins, Employee user) throws ParseException {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		
		if (!filter.isInfoTable()) {
			crit.setFirstResult(filter.getDisplayStart())
				.setMaxResults(filter.getDisplayLength());
		}
		
		applyFilters(crit, filter.getFiltro(), filter.getOrden(), user);
		
		if (joins != null) {
			for (String join : joins) {
				crit.setFetchMode(join, FetchMode.JOIN);
			}
		}
		
		return crit.list();
	}

	private void applyFilters(Criteria crit, List<DatoColumna> filtrosExtras, List<DatoColumna> orders, Employee user) throws ParseException {
		
		Criteria employeeCrit = crit.createCriteria(Teammember.EMPLOYEE);
		
		employeeCrit.add(Restrictions.eq(Employee.EMPLOYEE, user));
		
		critContact = employeeCrit.createCriteria(Employee.CONTACT);
		critActivity = crit.createCriteria(Teammember.PROJECTACTIVITY);
		critProject	 = critActivity.createCriteria(Projectactivity.PROJECT);
		
		for (DatoColumna filtroColumna : filtrosExtras) {
			
			if (filtroColumna.getTipo() == List.class) {
				
				// Since Until
				if (filtroColumna.getSubTipo() != null && filtroColumna.getSubTipo() == Date.class) {
					
					Date sinceDate = (Date) filtroColumna.getObjectList()[0];
					Date untilDate = (Date) filtroColumna.getObjectList()[1];

					String sinceName = (String) filtroColumna.getNombreList()[0];
					String untilName = (String) filtroColumna.getNombreList()[1];
					
					crit.add(Restrictions.disjunction()
							.add(Restrictions.between(sinceName, sinceDate, untilDate))
							.add(Restrictions.between(untilName, sinceDate, untilDate))
							.add(Restrictions.and(
									Restrictions.le(sinceName, sinceDate),
									Restrictions.ge(untilName, untilDate)
								)
							)
						);
				}
				else {
					// Tiene que estar en la lista
					crit.add(Restrictions.in(filtroColumna.getNombre(),filtroColumna.getValorList()));
				}
			}
			else if (filtroColumna.getTipo() == String.class) {
				
				if (filtroColumna.getSubTipo() == List.class) {
					
					if (!ValidateUtil.isNull(filtroColumna.getValor())) {
						String[] value = filtroColumna.getValor().split(",");
						List<Integer> ids = new ArrayList<Integer>();
						
						for (String id : value) { ids.add(Integer.parseInt(id)); }
						
						if (filtroColumna.getNombre().equals(Project.EMPLOYEEBYPROJECTMANAGER)) {
							
							critProject.add(Restrictions.in(filtroColumna.getNombre()+".idEmployee",ids));
						}
						else if (filtroColumna.getCriteria() != null) {
							Criteria crit2 = crit.createCriteria(filtroColumna.getCriteria());
							crit2.add(Restrictions.in(filtroColumna.getNombre(),ids));
						}
						else {
							crit.add(Restrictions.in(filtroColumna.getNombre(),ids));
						}
						
					}
				}
				else {
					
					if (filtroColumna.getNombre().equals(Contact.FULLNAME)) {
						
						critContact.add(Restrictions.like(filtroColumna.getNombre(),"%"+filtroColumna.getValor()+"%"));
					}
					else {
						// Comparando texto
						crit.add(Restrictions.like(filtroColumna.getNombre(),"%"+filtroColumna.getValor()+"%"));
					}
				}
			}
			else if (filtroColumna.getTipo() == Integer.class) {
				// Filtrando Objectos
				
				Integer value = Integer.parseInt(filtroColumna.getValor());
				crit.add(Restrictions.eq(filtroColumna.getNombre(),value));
			}
			else if (filtroColumna.getTipo() != Date.class) {
				// Filtrando Objectos
				if (filtroColumna.getCriteria() != null) {
					
					crit.createCriteria(filtroColumna.getCriteria())
						.add(Restrictions.eq(filtroColumna.getNombre(),filtroColumna.getObject()));
				}
				else {
					
					crit.add(Restrictions.eq(filtroColumna.getNombre(),filtroColumna.getObject()));
				}
			}
		}
	
		if (orders != null && !orders.isEmpty()) {
			
			appplyOrders(crit, orders);
		}
	}
	
	private void appplyOrders(Criteria crit, List<DatoColumna> orders) {
	
		for (DatoColumna order : orders) {
			
			Criteria critTemp = null;
			if (order.getNombre().equals(Contact.FULLNAME)) { critTemp = critContact; }
			else if (order.getNombre().equals(Project.EMPLOYEEBYPROJECTMANAGER)
					|| order.getNombre().equals(Project.PROJECTNAME)) { critTemp = critProject; }
			else if (order.getNombre().equals(Projectactivity.ACTIVITYNAME)) { critTemp = critActivity; }
			else { critTemp = crit; }
			
			critTemp.addOrder((order.getValor().equals("asc")?Order.asc(order.getNombre()):Order.desc(order.getNombre())));
		}
	}
	
	public int findTotal(List<DatoColumna> filtrosExtras, Employee user) throws ParseException {

		Criteria crit = getSession().createCriteria(getPersistentClass()).setProjection(Projections.rowCount());
		applyFilters(crit, filtrosExtras, null, user);
		
		return ((Integer)crit.list().get(0)).intValue();
	}

	public int findTotalFiltered(FiltroTabla filtro, Employee user) throws ParseException {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());

		applyFilters(crit, filtro.getFiltro(), null, user);
		
		crit.setProjection(Projections.rowCount());
			
		return ((Integer)crit.list().get(0)).intValue();
	}

	/**
	 * Check if employee is assigned in these day on the project activity
	 * @param time
	 * @param projectactivity
	 * @param employee
	 * @return
	 */
	public boolean isWorkDay(Date day, Projectactivity projectactivity,
			Employee employee) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Teammember.PROJECTACTIVITY, projectactivity))
			.add(Restrictions.eq(Teammember.EMPLOYEE, employee))
			.add(Restrictions.le(Teammember.DATEIN, day))
			.add(Restrictions.ge(Teammember.DATEOUT, day));
			
		Integer count = (Integer) crit.uniqueResult();
		return (count > 0);
	}
	
	/**
	 * 
	 * @param employee
	 * @param joins
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> findByEmployeeOrderByProject(Employee employee, Date since, Date until, List<String> joins) throws Exception {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		addJoins(crit, joins);
		crit.add(Restrictions.eq(Teammember.EMPLOYEE, employee))
			.add(Restrictions.ne(Teammember.STATUS, Constants.RESOURCE_RELEASED));
		
		if (since != null && until != null) {
			
			crit.add(Restrictions.disjunction()
					.add(Restrictions.between(Teammember.DATEIN, since, until))
					.add(Restrictions.between(Teammember.DATEOUT, since, until))
					.add(Restrictions.and(
							Restrictions.le(Teammember.DATEIN, since),
							Restrictions.ge(Teammember.DATEOUT, until)
						)
					)
				);
		}
		else if (since != null) {
			crit.add(Restrictions.and(
					Restrictions.le(Teammember.DATEIN, since),
					Restrictions.ge(Teammember.DATEOUT, since)
				));
		}
		else if (until != null) {
			crit.add(Restrictions.and(
					Restrictions.le(Teammember.DATEIN, until),
					Restrictions.ge(Teammember.DATEOUT, until)
				));
		}
		
		crit.createCriteria(Teammember.PROJECTACTIVITY)
			.createCriteria(Projectactivity.PROJECT)
			.addOrder(Order.desc(Project.IDPROJECT));
		
		return crit.list();
	}

	/**
	 * Check if any member is assigned or preassigned in these project
	 * @param proj
	 * @return
	 */
	public boolean isAssigned(Project proj) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.or(
					Restrictions.eq(Teammember.STATUS, Constants.RESOURCE_ASSIGNED),
					Restrictions.eq(Teammember.STATUS, Constants.RESOURCE_PRE_ASSIGNED))
				)
			.createCriteria(Teammember.PROJECTACTIVITY)
				.add(Restrictions.eq(Projectactivity.PROJECT, proj));
		
		Integer count = (Integer) crit.uniqueResult();
		return (count > 0);
	}

	/**
	 * Search Team Members by filter
	 * @param idProjects
	 * @param idPMs
	 * @param idSkills
	 * @param statusList
	 * @param fullName
	 * @param since
	 * @param until
	 * @param nameOrder 
	 * @param order
	 * @param idEmployee 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Teammember> consStaffinFtes(Integer[] idProjects,
			Integer[] idPMs, Integer[] idSkills, String[] statusList,
			String fullName, Date since, Date until, String nameOrder, String order, Integer idEmployee) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		Criteria projCrit = crit.createCriteria(Teammember.PROJECTACTIVITY)
			.createCriteria(Projectactivity.PROJECT);
		
		// Filter by Project
		if (idProjects != null) { projCrit.add(Restrictions.in(Project.IDPROJECT, idProjects)); }
		
		// Filter by Project Manager
		if (idPMs != null) {
			projCrit.createCriteria(Project.EMPLOYEEBYPROJECTMANAGER)
				.add(Restrictions.in(Employee.IDEMPLOYEE, idPMs));
		}
		
		// Filter by Status
		if (statusList != null) { crit.add(Restrictions.in(Teammember.STATUS, statusList)); }
		
		// Filter by Skill
		Criteria skillCrit = crit.createCriteria(Teammember.SKILL);
		if (idSkills != null) { skillCrit.add(Restrictions.in(Skill.IDSKILL, idSkills)); }
		
		// Filter by dates (since && until)
		if (since != null && until != null) {
			
			crit.add(Restrictions.disjunction()
					.add(Restrictions.between(Teammember.DATEIN, since, until))
					.add(Restrictions.between(Teammember.DATEOUT, since, until))
					.add(Restrictions.and(
							Restrictions.le(Teammember.DATEIN, since),
							Restrictions.ge(Teammember.DATEOUT, until)
						)
					)
				);
		}
		else if (since != null) {
			crit.add(Restrictions.and(
					Restrictions.le(Teammember.DATEIN, since),
					Restrictions.ge(Teammember.DATEOUT, since)
				));
		}
		else if (until != null) {
			crit.add(Restrictions.and(
					Restrictions.le(Teammember.DATEIN, until),
					Restrictions.ge(Teammember.DATEOUT, until)
				));
		}

		// Filter By Employee
		Criteria employeeCrit = crit.createCriteria(Teammember.EMPLOYEE);
		if (idEmployee != null) { employeeCrit.add(Restrictions.idEq(idEmployee)); }
		
		// Filter by Full Name
		Criteria contactCrit = employeeCrit.createCriteria(Employee.CONTACT)
			.add(Restrictions.ilike(Contact.FULLNAME, "%"+fullName+"%"));
		
		// Apply Order
		Criteria orderCrit = null;
		if (Project.IDPROJECT.equals(nameOrder)) { orderCrit = projCrit; }
		else if (Skill.IDSKILL.equals(nameOrder)) { orderCrit = skillCrit; }
		else { orderCrit = contactCrit; }
		
		if (Constants.DESCENDENT.equals(order)) { orderCrit.addOrder(Order.desc(nameOrder)); }
		else { orderCrit.addOrder(Order.asc(nameOrder)); }
		
		contactCrit.addOrder(Order.asc(Contact.IDCONTACT));
		
		List<String> joins = new ArrayList<String>();
		joins.add(Teammember.PROJECTACTIVITY);
		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT);
		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT+"."+Project.EMPLOYEEBYPROJECTMANAGER);
		joins.add(Teammember.PROJECTACTIVITY+"."+Projectactivity.PROJECT+"."+Project.EMPLOYEEBYPROJECTMANAGER+"."+Employee.CONTACT);
		
		addJoins(crit, joins);
		
		return crit.list();
	}
}
