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

import es.sm2.openppm.dao.ProjectKpiDAO;
import es.sm2.openppm.exceptions.KpiWeightExcededException;
import es.sm2.openppm.model.Metrickpi;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectkpi;
import es.sm2.openppm.utils.SessionFactoryUtil;

/**
 * This class provides all methods for Project' KPI
 * @author juanma.lopez
 *
 */

public final class ProjectKpiLogic extends AbstractGenericLogic<Projectkpi, Integer> {


	/**
	 * Find Project KPI by ID
	 * @param idKpi
	 * @return
	 * @throws Exception 
	 */
	public static Projectkpi findProjectKpi(Integer idKpi) throws Exception {
		Projectkpi kpi = null;

		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectKpiDAO kpiDAO = new ProjectKpiDAO(session);
			kpi = kpiDAO.findById(idKpi, false);
			
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
		return kpi;
	}


	/**
	 * Save project KPI
	 * @param kpi
	 * @throws Exception 
	 */
	public static Projectkpi saveProjectKpi(Projectkpi kpi) throws Exception {
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectKpiDAO kpiDAO = new ProjectKpiDAO(session);
			
			kpi = kpiDAO.makePersistent(kpi);
			
			double total = kpiDAO.getTotalWeight(kpi.getProject());
			if (total > 100) {
				throw new KpiWeightExcededException();
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
		return kpi;
	}
	
	/**
	 * Delete project KPI
	 * @param kpi
	 * @throws Exception 
	 */
	@Override
	public void delete(Projectkpi kpi) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectKpiDAO kpiDAO = new ProjectKpiDAO(session);
			kpi = kpiDAO.findById(kpi.getIdProjectKpi(), false);
			
			kpiDAO.makeTransient(kpi);
			
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
	 * Check if metric is assigned in other project KPI
	 * @param project
	 * @param idProjectKPI
	 * @param metrickpi
	 * @return
	 * @throws Exception 
	 */
	public static boolean metricExist(Project project, int idProjectKPI, Metrickpi metrickpi) throws Exception {
		
		boolean metricExist = false;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectKpiDAO kpiDAO = new ProjectKpiDAO(session);
			metricExist = kpiDAO.metricExist(project, idProjectKPI, metrickpi);
			
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
		return metricExist;
	}
}
