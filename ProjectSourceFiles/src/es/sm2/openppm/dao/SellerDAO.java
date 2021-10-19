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
/******************************************************************************
 * Update : Devoteam XL 2015-04-17  user story 23  tri des ressources
 *                 fonction :  viewProjects  tri des listes seller
 *
  ******************************************************************************/
package es.sm2.openppm.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import es.sm2.openppm.model.Activityseller;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Seller;



/**
 * DAO object for domain model class Seller
 * @see es.sm2.openppm.dao.Seller
 * @author Hibernate Generator by Javier Hernandez
 */
public class SellerDAO extends AbstractGenericHibernateDAO<Seller, Integer> {


	public SellerDAO(Session session) {
		super(session);
	}
	
	/**
	 * Return all Seller ordered
	 * 
	 * @param order
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Seller> findAllOrdered(Order... order) {		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		for (Order o : order) {
			crit.addOrder(o);
		}		
		return crit.list();
	}
	
	/**
	 * 
	 * @param project
	 * @param order
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Seller> findByProcurement(Project project, Order... order) {		
		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		crit.createCriteria(Seller.ACTIVITYSELLERS)
			.createCriteria(Activityseller.PROJECTACTIVITY)						
			.add(Restrictions.eq(Projectactivity.PROJECT, project));
		
		for (Order o : order) {
			crit.addOrder(o);
		}		
		return crit.list();
	}

	/**
	 * Search by company
	 * @param company
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Seller> searchByCompany(Company company) {

		Criteria crit = getSession().createCriteria(getPersistentClass())
			.add(Restrictions.eq(Seller.COMPANY, company));
		
		return crit.list();
	}

	/**
	 * Search by company
	 * @param company, propertyOrder, TypeOrder
	 * @return
	 * 
	 * Update Devoteam : Xl 22/04/2015  ajout 'un tri
	 */
	@SuppressWarnings("unchecked")
	public List<Seller> searchByCompany(Company company,String propertyOrder, String typeOrder) {

		Criteria crit = getSession().createCriteria(getPersistentClass());
		
		addOrder(crit, propertyOrder, typeOrder);
	    crit.add(Restrictions.eq(Seller.COMPANY, company));
		
		return crit.list();
	}
}

