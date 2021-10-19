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

import es.sm2.openppm.dao.ContractTypeDAO;
import es.sm2.openppm.exceptions.ContracttypeNotFoundException;
import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.model.Contracttype;
import es.sm2.openppm.utils.SessionFactoryUtil;

public final class ContractTypeLogic extends AbstractGenericLogic<Contracttype, Integer>{

	
	/**
	 * Save Contracttype
	 * @param contractType
	 * @throws Exception 
	 */
	public static void saveContractType(Contracttype contractType) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			ContractTypeDAO contractTypeDAO = new ContractTypeDAO(session);
			
			contractTypeDAO.makePersistent(contractType);
			
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
	 * Delete Contracttype
	 * @param idContractType
	 * @throws Exception 
	 */
	public static void deleteContractType(Integer idContractType) throws Exception {
		if (idContractType == null || idContractType == -1) {
			throw new ContracttypeNotFoundException();
		}
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try{
			tx = session.beginTransaction();
			
			ContractTypeDAO contractTypeDAO = new ContractTypeDAO(session);
			Contracttype contractType = contractTypeDAO.findById(idContractType, false);
			
			if (contractType != null) {
				if(!contractType.getProjects().isEmpty()){
					throw new LogicException("msg.error.delete.this_has","contract_type","project");
				}else{
					contractTypeDAO.makeTransient(contractType);
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
