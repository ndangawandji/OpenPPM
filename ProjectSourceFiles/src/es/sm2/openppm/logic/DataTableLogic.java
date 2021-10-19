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

import es.sm2.openppm.dao.DataTableDAO;
import es.sm2.openppm.javabean.DatoColumna;
import es.sm2.openppm.javabean.FiltroTabla;
import es.sm2.openppm.utils.SessionFactoryUtil;

public class DataTableLogic extends GenericLogic {


	private DataTableLogic() {
		super();
	}
	
	/**
	 * 
	 * @param filtro
	 * @param tipo
	 * @param joins
	 * @return
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public static List findByFiltro(FiltroTabla filtro,Class tipo, ArrayList<String> joins) throws Exception {
		List list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			DataTableDAO dao = new DataTableDAO(session);
			list = dao.findByFiltro(filtro, tipo, joins);
			
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
	 * Buscar con por ejemplo un listado de personas
	 * @param example
	 * @param tipo
	 * @return
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public static List findByExample(Object example, Class tipo) throws Exception {
		List list = null;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			DataTableDAO dao = new DataTableDAO(session);
			list = dao.findByExample(example, tipo);

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
	 * 
	 * @param tipo
	 * @return
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static int findTotal(List<DatoColumna> filtrosExtras,Class tipo) throws Exception {
		int total = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			DataTableDAO dao = new DataTableDAO(session);
			total = dao.findTotal(filtrosExtras, tipo);

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
		return total;
	}

	/**
	 * 
	 * @param filtro
	 * @param tipo
	 * @return
	 * @throws Exception
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public static int findTotalFiltered(FiltroTabla filtro, Class tipo) throws Exception {
		int total = 0;
		Transaction tx = null;
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			DataTableDAO dao = new DataTableDAO(session);
			total = dao.findTotalFiltered(filtro, tipo);

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
		return total;
	}	
	
}
