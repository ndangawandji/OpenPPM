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

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.CategoryDAO;
import es.sm2.openppm.exceptions.CategoryNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Category;
import es.sm2.openppm.utils.SessionFactoryUtil;




/**
 * Logic object for domain model class Category
 * @see es.sm2.openppm.logic.Category
 * @author Hibernate Generator by Javier Hernandez
 */
public final class CategoryLogic extends AbstractGenericLogic<Category, Integer>{


	/**
	 * Create or update Category
	 * @param category
	 * @throws Exception 
	 */
	public static Category saveCategory(Category category) throws Exception {
		if (category == null) {
			throw new CategoryNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CategoryDAO categoryDAO = new CategoryDAO(session);
			category = categoryDAO.makePersistent(category);
			
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
		return category;
	}
	
	/**
	 * Delete Category
	 * @param category
	 * @throws Exception 
	 */
	public static void deleteCategory(Category category) throws Exception {
		if (category == null) {
			throw new CategoryNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			CategoryDAO categoryDAO = new CategoryDAO(session);
			category = categoryDAO.findById(category.getIdCategory(), false);
			
			if (category != null) {
				if(!category.getProjects().isEmpty()){
					throw new LogicException("msg.error.delete.this_has","category","project");
				}
				else{
					categoryDAO.makeTransient(category);
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
	
			

}

