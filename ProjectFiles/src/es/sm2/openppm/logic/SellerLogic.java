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
package es.sm2.openppm.logic;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;

import es.sm2.openppm.dao.ProjectDAO;
import es.sm2.openppm.dao.SellerDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.SellerNotFoundException;
import es.sm2.openppm.model.Company;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Seller;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Seller
 * @see es.sm2.openppm.logic.Seller
 * @author Hibernate Generator by Javier Hernandez
 */
public final class SellerLogic extends AbstractGenericLogic<Seller, Integer>{

	
	/**
	 * Return all Seller ordered
	 * 
	 * @param order
	 * @return
	 * @throws Exception
	 */
	public static List<Seller> findAllOrdered(Order... order) throws Exception {
		List<Seller> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			SellerDAO sellerDAO = new SellerDAO(session);
			list = sellerDAO.findAllOrdered(order);

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
		return list;
	}
	
	/**
	 * Return sellers with a Statement of Work
	 * 
	 * @param project
	 * @param order
	 * @return
	 * @throws Exception
	 */
	public static List<Seller> findByProcurement(Project project, Order... order) throws Exception {
		List<Seller> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			SellerDAO sellerDAO = new SellerDAO(session);
			list = sellerDAO.findByProcurement(project, order);

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
		return list;
	}
	
	/**
	 * Create or update Seller
	 * @param seller
	 * @throws Exception 
	 */
	public static Seller saveSeller(Seller seller) throws Exception {
		if (seller == null) {
			throw new SellerNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			SellerDAO sellerDAO = new SellerDAO(session);
			seller = sellerDAO.makePersistent(seller);
			
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
		return seller;
	}
	
	/**
	 * Delete Seller
	 * @param seller
	 * @throws Exception 
	 */
	public static void deleteSeller(Seller sel) throws Exception {
		if (sel == null) {
			throw new SellerNotFoundException();
		}
		List<String> list 	= null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ProjectDAO projectDAO = new ProjectDAO(session);
			SellerDAO sellerDAO = new SellerDAO(session);			
			Seller seller = sellerDAO.findById(sel.getIdSeller(), false);
			list = projectDAO.findBySeller(seller);			
			
			if (list.size() > 0) {
				
				String projects = "<br /><ul><li>";
				for (String s : list) {
					if(!projects.equals("<br /><ul><li>")) {
						projects += "</li><li>";
					}
					projects += s;
				}
				
				projects += "</li></ul>";
				
				throw new LogicException("msg.error.delete.seller", seller.getName(), projects);
			}			
			else {
				sellerDAO.makeTransient(seller);
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
	 * Search by company
	 * @param company
	 * @return
	 * @throws Exception 
	 */
	public static List<Seller> searchByCompany(Company company) throws Exception {
		
		List<Seller> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			SellerDAO sellerDAO = new SellerDAO(session);
			list = sellerDAO.searchByCompany(company);

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
		return list;
	}
	/**
	 * Search by company
	 * @param company, propertyOrder, typeOrder
	 * @return
	 * @throws Exception 
	 * 
	 * Update Devoteam  XL 22/04/2015	ajout trie sur seller name
	 */
	public static List<Seller> searchByCompany(Company company,String propertyOrder, String typeOrder) throws Exception {
		
		List<Seller> list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			SellerDAO sellerDAO = new SellerDAO(session);
			list = sellerDAO.searchByCompany(company, propertyOrder,  typeOrder);

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
		return list;
	}

}

