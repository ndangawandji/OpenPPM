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
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.javabean.ProcurementBudget;
import es.sm2.openppm.model.Procurementpayments;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Seller;

/**
 * DAO object for domain model class Procurementpayments
 * @see es.sm2.openppm.dao.Procurementpayments
 * @author Hibernate Generator by Javier Hernandez
 */
public class ProcurementpaymentsDAO extends AbstractGenericHibernateDAO<Procurementpayments, Integer> {


	public ProcurementpaymentsDAO(Session session) {
		super(session);
	}

	/**
	 * Get Procurement Payments from Project
	 * @param proj
	 * @param joins
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Procurementpayments> consProcurementPaymentsByProject(Project proj, List<String> joins) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		for (String join : joins) {			
			crit.setFetchMode(join, FetchMode.JOIN);
		}
		
		crit.addOrder(Order.asc(Procurementpayments.SELLER))
			.add(Restrictions.eq(Procurementpayments.PROJECT, proj));
		
		return crit.list();
	}
	
	/**
	 * 
	 * @param seller
	 * @return
	 */
	public List<String> consPruchaseOrder(Seller seller, Project project) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
						
		crit.addOrder(Order.asc(Procurementpayments.SELLER))
			.add(Restrictions.eq(Procurementpayments.SELLER, seller))
			.add(Restrictions.eq(Procurementpayments.PROJECT, project));
		
		List<String> lista = new ArrayList<String>();
		
		for(int i = 0; i < crit.list().size(); i++) {
			Procurementpayments proc = (Procurementpayments)crit.list().get(i);
			lista.add(proc.getPurchaseOrder());			
		}
		
		return lista;
	}
	
	/**
	 * Get Procurement Budgets from Project
	 * 
	 * @param proj
	 * @param joins
	 * @return
	 */
	public List<ProcurementBudget> consProcurementBudgetsByProject(Project proj, List<String> joins) {
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		for (String join : joins) {			
			crit.setFetchMode(join, FetchMode.JOIN);
		}
		
		crit.addOrder(Order.asc(Procurementpayments.SELLER))
			.setProjection(Projections.projectionList()					
					.add(Projections.sum(Procurementpayments.PLANNEDPAYMENT))
					.add(Projections.sum(Procurementpayments.ACTUALPAYMENT))
					.add(Projections.rowCount())					
					.add(Projections.groupProperty(Procurementpayments.SELLER)))
			.add(Restrictions.eq(Procurementpayments.PROJECT, proj));
		
		List<ProcurementBudget> lista = new ArrayList<ProcurementBudget>();
		List<String> purchase = null;
		
		for(int i = 0; i < crit.list().size(); i++) {
			ProcurementBudget budget = new ProcurementBudget();
			Object[] row = (Object[])crit.list().get(i);
			budget.setPlannedPayment((Double)row[0]);
			budget.setActualPayment((Double)row[1]);
			budget.setnPayments((Integer)row[2]);
			
			Seller seller = (Seller)row[3];
			budget.setSeller(seller.getName());
			
			purchase = consPruchaseOrder(seller, proj);			
			String order = "";
			if(purchase != null) {				
				for (String s : purchase) {
					if(!order.equals("")) {
						order += ", ";
					}
					order += s;
				}
			}
			budget.setPurchaseOrder(order);						
			
			lista.add(budget);
		}
		
		return lista;
	}

}

