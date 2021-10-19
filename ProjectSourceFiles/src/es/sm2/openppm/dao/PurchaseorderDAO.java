/**
 * Generated 29 juin 2015
 * Openppm versius Devoteam, user story 17
 * @author : Xavier De Langautier, Cedric Ndanga Wandji
 */
package es.sm2.openppm.dao;


import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Order;

import es.sm2.openppm.model.Customer;
import es.sm2.openppm.model.Purchaseorder;


/**
 * @author Cedric Ndanga
 *
 */

public class PurchaseorderDAO extends AbstractGenericHibernateDAO<Purchaseorder, Integer> {

	public PurchaseorderDAO(Session session) {
		super(session);
		// TODO Auto-generated constructor stub
	}
	
	
	@SuppressWarnings("unchecked")
	public List<Purchaseorder> findAll() {
		
		String queryString = "select po " + 
							 "from Purchaseorder as po " +
							 "join fetch po.customer";
		
		Query query = getSession().createQuery(queryString);
		
		return query.list();
	}
	
	/**
	 * Find All and order by name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Customer> findAllOrder() {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.addOrder(Order.asc(Purchaseorder.NAME));
		
		return crit.list();
	}

}
