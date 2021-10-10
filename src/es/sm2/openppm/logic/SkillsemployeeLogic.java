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

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.SkillsemployeeDAO;
import es.sm2.openppm.exceptions.EmployeeNotFoundException;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Skillsemployee;
import es.sm2.openppm.utils.SessionFactoryUtil;



/**
 * Logic object for domain model class Skillsemployee
 * @see es.sm2.openppm.logic.Skillsemployee
 * @author Hibernate Generator by Javier Hernandez
 */
public final class SkillsemployeeLogic extends AbstractGenericLogic<Skillsemployee, Integer>{

	
	/**
	 * Return employee's skills
	 * @param employee
	 * @return
	 * @throws Exception
	 */
	public static List<Skillsemployee> findByEmployee(Employee employee) throws Exception {
		if (employee == null) {
			throw new EmployeeNotFoundException();
		}
		
		List<Skillsemployee> skills = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try {
			tx = session.beginTransaction();
			
			SkillsemployeeDAO SkillsemployeeDAO = new SkillsemployeeDAO(session);
			skills = SkillsemployeeDAO.findByEmployee(employee);
			
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
		return skills;
	}
}
