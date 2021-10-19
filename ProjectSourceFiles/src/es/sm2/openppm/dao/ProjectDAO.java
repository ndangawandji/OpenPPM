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

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.javabean.DatoColumna;
import es.sm2.openppm.javabean.FiltroTabla;
import es.sm2.openppm.model.Activityseller;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Incomes;
import es.sm2.openppm.model.Performingorg;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectassociation;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.model.Timesheet;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.ValidateUtil;

public class ProjectDAO extends AbstractGenericHibernateDAO<Project, Integer> {

	public ProjectDAO(Session session) {
		super(session);
	}

	/**
	 * Cons project for initiating
	 * @param proj
	 * @return
	 */
	public Project consInitiatingProject(Project proj) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.setFetchMode("performingorg", FetchMode.JOIN);
		crit.setFetchMode("customer", FetchMode.JOIN);
		crit.setFetchMode(Project.GEOGRAPHY, FetchMode.JOIN);
		crit.setFetchMode(Project.CATEGORY, FetchMode.JOIN);
		crit.setFetchMode(Project.PROGRAM, FetchMode.JOIN);
		crit.setFetchMode("employeeByProjectManager", FetchMode.JOIN);
		crit.setFetchMode("employeeByProjectManager.contact", FetchMode.JOIN);
		crit.setFetchMode("employeeByInvestmentManager", FetchMode.JOIN);
		crit.setFetchMode("employeeByInvestmentManager.contact", FetchMode.JOIN);
		crit.setFetchMode("employeeByFunctionalManager", FetchMode.JOIN);
		crit.setFetchMode("employeeByFunctionalManager.contact", FetchMode.JOIN);
		crit.setFetchMode("employeeBySponsor", FetchMode.JOIN);
		crit.setFetchMode("employeeBySponsor.contact", FetchMode.JOIN);
		crit.setFetchMode("stakeholders", FetchMode.JOIN);
		crit.setFetchMode("workingcostses", FetchMode.JOIN);
		crit.setFetchMode(Project.FUNDINGSOURCE, FetchMode.JOIN);
		crit.setFetchMode(Project.PROJECTASSOCIATIONSFORDEPENDENT, FetchMode.JOIN);
		crit.setFetchMode(Project.PROJECTASSOCIATIONSFORDEPENDENT+"."+Projectassociation.PROJECTBYLEAD, FetchMode.JOIN);
		crit.setFetchMode(Project.PROJECTASSOCIATIONSFORLEAD, FetchMode.JOIN);
		crit.setFetchMode(Project.PROJECTASSOCIATIONSFORLEAD+"."+Projectassociation.PROJECTBYDEPENDENT, FetchMode.JOIN);
		
		crit.add(Restrictions.eq("idProject", proj.getIdProject()));
		
		
		return (Project) crit.uniqueResult();
	}
	
	/**
	 * Get Investments in process
	 * @param program
	 * @param internalProject
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Project> consInvestmentInProcess(Integer[] ids) {
		List<Project> listado = null;

		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Project.INVESTMENTSTATUS, Constants.INVESTMENT_IN_PROCESS))
			.add(Restrictions.in(Project.IDPROJECT, ids));
		
		listado = crit.list();

		return listado;
	}
	

	/**
	 * Cons Project and extra info
	 * @param proj
	 * @param joins
	 * @return
	 */
	public Project consProject(Project proj, List<String> joins) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		for (String join : joins) {
			
			crit.setFetchMode(join, FetchMode.JOIN);
		}
		crit.add(Restrictions.eq("idProject", proj.getIdProject()));
		
		return (Project) crit.uniqueResult();
	}
	
	
	/**
	 * Find projects where an Employee is team member in range of days
	 * @param employee
	 * @param sinceDate
	 * @param untilDate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Project> findByResourceInProject(Employee employee, Date sinceDate, Date untilDate) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)			
			.createCriteria(Project.PROJECTACTIVITIES)
			.createCriteria(Projectactivity.TEAMMEMBERS)
			.add(Restrictions.eq(Teammember.EMPLOYEE, employee))
			.add(Restrictions.eq(Teammember.STATUS, Constants.RESOURCE_ASSIGNED))
			.add(Restrictions.disjunction()
					.add(Restrictions.between(Teammember.DATEIN, sinceDate, untilDate))
					.add(Restrictions.between(Teammember.DATEOUT, sinceDate, untilDate))
					.add(Restrictions.and(
							Restrictions.le(Teammember.DATEIN, sinceDate),
							Restrictions.ge(Teammember.DATEOUT, untilDate)
						)
					)
				);
		
		return crit.list();
		
	}
	
	
	/**
	 * Check if Accounting code is in use 
	 * @param proj
	 * @param company 
	 * @param code
	 * @return
	 */
	public boolean accountingCodeInUse(Project proj, Company company) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Project.ACCOUNTINGCODE, proj.getAccountingCode()))
			.add(Restrictions.ne(Project.IDPROJECT, proj.getIdProject()))
			.createCriteria(Project.PERFORMINGORG)
				.add(Restrictions.eq(Performingorg.COMPANY, company));
		
		return ((Integer)crit.uniqueResult() > 0);
	}
	
	/**
	 * Find projects by program
	 * @param program
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Project> findByProgram(Program program) {
		
		List<Project> projects = null;
		
		if (program.getIdProgram() != -1) {
			Criteria crit = getSession().createCriteria(getPersistentClass());
			crit.add(Restrictions.eq("program.idProgram", program.getIdProgram()));
			projects = crit.list();
		}
		return projects;
	}

	
	/**
	 * DSOu = hoy – max(income.actualBillDate)
	 * @param project
	 * @return days
	 */
	public Integer calculateDSOUnbilled(Project project) {
		Integer days = 0;
		
		Query query = getSession().createQuery(
				"select current_date()-max(i.actualBillDate) " +
				"from Incomes as i " +
				"join i.project as p " +
				"where p.idProject=:idProject and i.actualPaymentDate is null");
		query.setInteger("idProject", project.getIdProject());
		
		if (query.uniqueResult() != null) {
			days = ((Double) query.uniqueResult()).intValue();
		}
		
		return days;
	}
	
	
	/**
	 * 
	 * @param project
	 * @return
	 */
	public Integer calculateDSOBilled(Project project) {
		Integer days = null;
		
		Query query = getSession().createQuery(
				"select max(i.actualPaymentDate-i.actualBillDate) " +
				"from Incomes as i " +
				"join i.project as p " +
				"where p.idProject=:idProject and i.actualPaymentDate is not null");
		query.setInteger("idProject", project.getIdProject());
		
		if (query.uniqueResult() != null) {
			days = ((Double) query.uniqueResult()).intValue();
		}
		
		return days;
	}
	
	
	/**
	 * Consult list of projects by ids
	 * @param ids
	 * @param property
	 * @param order
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Project> consList(Integer[] ids, String property, String order, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.in(Project.IDPROJECT, ids));
			
		addJoins(crit, joins);
		addOrder(crit, property, order);
		
		return crit.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<Project> findByProgram(Program program, boolean investiment) {

		List<Project> list = new ArrayList<Project>();
		
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		crit.add(Restrictions.eq(Project.PROGRAM, program));
		
		if (investiment) {
			crit.add(Restrictions.ne(Project.INVESTMENTSTATUS, Constants.INVESTMENT_APPROVED));
			
			list.addAll(crit.list());
		}
		else {
			crit.add(Restrictions.eq(Project.INVESTMENTSTATUS, Constants.INVESTMENT_APPROVED));
			
			list.addAll(crit.list());
		}
		return list;
	}
	
	/**
	 * Consult list of projects by seller
	 * 
	 * @param seller
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<String> findBySeller(Seller seller) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		crit.setProjection(Projections.property(Project.PROJECTNAME));
		
		crit.createCriteria(Project.PROJECTACTIVITIES)
			.createCriteria(Projectactivity.ACTIVITYSELLERS)		
			.add(Restrictions.eq(Activityseller.SELLER, seller));
		
		crit.addOrder(Order.asc(Project.PROJECTNAME));		

		return crit.list();
	}

	
	@SuppressWarnings("unchecked")
	public List<Project> findByFiltro(FiltroTabla filtro, List<String> joins) throws ParseException {

		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
		
		if (!filtro.isInfoTable()) {
			crit.setFirstResult(filtro.getDisplayStart())
				.setMaxResults(filtro.getDisplayLength());
		}
		
		List<DatoColumna> orders = new ArrayList<DatoColumna>();

		for (DatoColumna order : filtro.getOrden()) {
			if (order.getTipo() == Date.class &&
					(order.getNombre().equals(Projectactivity.PLANINITDATE)
					|| order.getNombre().equals(Projectactivity.PLANENDDATE))) {
				orders.add(order);
			}
			else {
				crit.addOrder((order.getValor().equals("asc")?Order.asc(order.getNombre()):Order.desc(order.getNombre())));
			}
		}
		
		applyFilters(crit, filtro.getFiltro(), orders);
		
		if (joins != null) {
			for (String join : joins) {
				crit.setFetchMode(join, FetchMode.JOIN);
			}
		}
		
		return crit.list();
	}

	public int findTotal(List<DatoColumna> filtrosExtras) throws ParseException {

		Criteria crit = getSession().createCriteria(getPersistentClass()).setProjection(Projections.rowCount());
		applyFilters(crit, filtrosExtras, null);
		
		return ((Integer)crit.list().get(0)).intValue();
	}

	public int findTotalFiltered(FiltroTabla filtro) throws ParseException {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());

		applyFilters(crit, filtro.getFiltro(), null);
		
		crit.setProjection(Projections.rowCount());
			
		return ((Integer)crit.list().get(0)).intValue();
	}
	
	private void applyFilters(Criteria crit, List<DatoColumna> filtrosExtras, List<DatoColumna> orders) throws ParseException {
		
		boolean applyOrder = true;
		
		for (DatoColumna filtroColumna : filtrosExtras) {
			
			if (filtroColumna.getTipo() == Boolean.class) {
				
				// Filtramos si es un booleano
				Boolean bool = Boolean.parseBoolean(filtroColumna.getValor());
				if (!(Project.INTERNALPROJECT.equals(filtroColumna.getNombre()) && bool)) {
					
					crit.add(Restrictions.eq(filtroColumna.getNombre(),bool));
				}
			}
			else if (filtroColumna.getTipo() == List.class) {
				
				// Since Until
				if (filtroColumna.getSubTipo() != null && filtroColumna.getSubTipo() == Date.class) {
					
					Date sinceDate = (Date) filtroColumna.getObjectList()[0];
					Date untilDate = (Date) filtroColumna.getObjectList()[1];

					String sinceName = (String) filtroColumna.getNombreList()[0];
					String untilName = (String) filtroColumna.getNombreList()[1];
					
					Criteria critActivity = crit.createCriteria(Project.PROJECTACTIVITIES);
					
					if (applyOrder && orders != null && !orders.isEmpty()) {
						for (DatoColumna order : orders) {
							
							critActivity.addOrder((order.getValor().equals("asc")?Order.asc(order.getNombre()):Order.desc(order.getNombre())));
						}
						applyOrder = false;
					}
					critActivity.add(Restrictions.disjunction()
									.add(Restrictions.between(sinceName, sinceDate, untilDate))
									.add(Restrictions.between(untilName, sinceDate, untilDate))
									.add(Restrictions.and(
											Restrictions.le(sinceName, sinceDate),
											Restrictions.ge(untilName, untilDate)
										)
									)
							)
						.createCriteria(Projectactivity.WBSNODE)
							.add(Restrictions.isNull(Wbsnode.WBSNODE));
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
						if (filtroColumna.getCriteria() != null) {
							Criteria crit2 = crit.createCriteria(filtroColumna.getCriteria());
							crit2.add(Restrictions.in(filtroColumna.getNombre(),ids));
						}
						else {
							crit.add(Restrictions.in(filtroColumna.getNombre(),ids));
						}
					}
				}
				else if (filtroColumna.getNombre() == Project.PROJECTNAME) {
					
					crit.add(Restrictions.disjunction()
							.add(Restrictions.ilike(Project.PROJECTNAME,"%"+filtroColumna.getValor()+"%"))
							.add(Restrictions.ilike(Project.CHARTLABEL,"%"+filtroColumna.getValor()+"%"))
							.add(Restrictions.ilike(Project.ACCOUNTINGCODE,"%"+filtroColumna.getValor()+"%"))
						);
				}
				else {
					// Comparando texto
					crit.add(Restrictions.ilike(filtroColumna.getNombre(),"%"+filtroColumna.getValor()+"%"));
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
	
		if (applyOrder && orders != null && !orders.isEmpty()) {
			
			Criteria critActivity = crit.createCriteria(Project.PROJECTACTIVITIES);
			
			for (DatoColumna order : orders) {
				
				critActivity.addOrder((order.getValor().equals("asc")?Order.asc(order.getNombre()):Order.desc(order.getNombre())));
			}
		}
	}

	/**
	 * Check if chart label is in use
	 * @param proj
	 * @param company
	 * @return
	 */
	public boolean chartLabelInUse(Project proj, Company company) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.eq(Project.CHARTLABEL, proj.getChartLabel()))
			.add(Restrictions.ne(Project.IDPROJECT, proj.getIdProject()))
			.createCriteria(Project.PERFORMINGORG)
				.add(Restrictions.eq(Performingorg.COMPANY, company));
		
		return ((Integer)crit.uniqueResult() > 0);
	}

	public double sumProperty(FiltroTabla filter, String sumProperty) throws ParseException {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());

		applyFilters(crit, filter.getFiltro(), null);
		
		crit.setProjection(Projections.sum(sumProperty));
		
		Double total = (Double)crit.uniqueResult();
		return (total == null?0:total);
	}

	@SuppressWarnings("unchecked")
	public List<Project> consListInControl(Integer[] ids, String property, String order) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())			
			.add(Restrictions.eq(Project.STATUS, Constants.STATUS_CONTROL))
			.add(Restrictions.in(Project.IDPROJECT, ids));
	
		addOrder(crit, property, order);
		
		return crit.list();
	}
	
	public boolean hasPermission(Project project, Employee user, Company company, int tab) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.idEq(project.getIdProject()));
		
		int rol = user.getResourceprofiles().getIdProfile();
		
		if (rol == Constants.ROLE_PMO || rol == Constants.ROLE_FM) {
			crit.add(Restrictions.eq(Project.PERFORMINGORG, user.getPerformingorg()));
		}
		else if (rol == Constants.ROLE_PM) {
			crit.add(Restrictions.eq(Project.EMPLOYEEBYPROJECTMANAGER, user));
		}
		else if (rol == Constants.ROLE_SPONSOR) {
			crit.add(Restrictions.eq(Project.EMPLOYEEBYSPONSOR, user));
		}
		else if (rol == Constants.ROLE_PORFM) {
			crit.createCriteria(Project.PERFORMINGORG)
				.add(Restrictions.eq(Performingorg.COMPANY, company));
		}
		else if (rol == Constants.ROLE_IM && tab == Constants.TAB_INITIATION) {
			crit.add(Restrictions.eq(Project.EMPLOYEEBYINVESTMENTMANAGER, user));
		}
		else if (rol == Constants.ROLE_PROGM) {
			crit.createCriteria(Project.PROGRAM).add(Restrictions.eq(Program.EMPLOYEE, user));
		}
		else {
			return false;
		}
		
		return ((Integer)crit.uniqueResult() > 0);
	}

	/**
	 * Find project by income
	 * @param income
	 * @return
	 */
	public Project findByIncome(Incomes income) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.createCriteria(Project.INCOMESES)
			.add(Restrictions.idEq(income.getIdIncome()));
		
		return (Project) crit.uniqueResult();
	}

	/**
	 * Find by Project Followup
	 * @param projectfollowup
	 * @return
	 */
	public Project findByFollowup(Projectfollowup projectfollowup) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			.createCriteria(Project.PROJECTFOLLOWUPS)
			.add(Restrictions.idEq(projectfollowup.getIdProjectFollowup()));
	
		return (Project) crit.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	public List<Project> find(String search, Performingorg performingorg) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Project.PERFORMINGORG, performingorg))
			.add(Restrictions.disjunction()
					.add(Restrictions.ilike(Project.PROJECTNAME,"%"+search+"%"))
					.add(Restrictions.ilike(Project.CHARTLABEL,"%"+search+"%"))
					.add(Restrictions.ilike(Project.ACCOUNTINGCODE,"%"+search+"%"))
				);
			
		return crit.list();
	}
	
	/**
	 * 
	 * @param employee
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Project> findByEmployee(Employee employee, List<String> joins) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
			
		crit.createCriteria(Project.PROJECTACTIVITIES)
			.createCriteria(Projectactivity.TEAMMEMBERS)			
			.add(Restrictions.eq(Teammember.EMPLOYEE, employee));
		
		crit.addOrder(Order.asc(Project.PROJECTNAME));
		crit.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
			
		return crit.list();
	}
	
	/**
	 * 
	 * @param employee
	 * @param initDate
	 * @param endDate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Project> findByEmployee(Employee employee, Date initDate, Date endDate) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass());
					
		crit.createCriteria(Project.PROJECTACTIVITIES)
			.createCriteria(Projectactivity.TIMESHEETS)			
			.add(Restrictions.ge(Timesheet.INITDATE, initDate))
			.add(Restrictions.le(Timesheet.ENDDATE, endDate));		
				
		crit.addOrder(Order.asc(Project.PROJECTNAME));
		crit.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
			
		return crit.list();
	}
	
	/**
	 * 
	 * @param program
	 * @return
	 */
	public Double getBudgetBottomUp(Program program) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.sum(Project.TCV))
			.add(Restrictions.eq(Project.PROGRAM, program));	
	
		Double budget = (Double)crit.uniqueResult();
		return (budget == null ? 0 : budget);
	}

	/**
	 * Find by PO and equals Planning or Execution
	 * @param performingorg
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Project> findByPO(Performingorg performingorg) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Project.PERFORMINGORG, performingorg))
			.add(Restrictions.or(
					Restrictions.eq(Project.STATUS, Constants.STATUS_CONTROL),
					Restrictions.eq(Project.STATUS, Constants.STATUS_PLANNING))
				);
		
		return crit.list();
	}
}
