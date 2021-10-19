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

import es.sm2.openppm.dao.SkillDAO;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.model.Skill;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class SkillLogic extends AbstractGenericLogic<Skill, Integer> {

	/**
	 * Save and update Skill
	 * @param skill
	 * @throws Exception 
	 */
	public static Skill saveSkill(Skill skill) throws Exception {
			
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			SkillDAO skillDAO = new SkillDAO(session);
			
			skill = skillDAO.makePersistent(skill);
			
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
		return skill;
	}
	
	
	/**
	 * Delete skill
	 * @param idCompany
	 * @throws Exception 
	 */
	public static void deleteSkill(Integer idSkill) throws Exception {
		if (idSkill == null || idSkill == -1) {
			throw new NoDataFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			SkillDAO skillDAO	= new SkillDAO(session);
			Skill skill			= skillDAO.findById(idSkill, false);
			
			if (skill != null) {
				
				if (!skill.getSkillsemployees().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","skill","maintenance.resource");
				}
				else if (!skill.getTeammembers().isEmpty()) {
					throw new LogicException("msg.error.delete.this_has","skill","team_member");
				}else{
					skillDAO.makeTransient(skill);
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


	public static Skill findById(Skill skill) throws Exception {
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		
		try {
			tx = session.beginTransaction();
		
			SkillDAO skillDAO = new SkillDAO(session);
			
			skill = skillDAO.findById(skill.getIdSkill(), false);

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
		return skill;
	}
}
