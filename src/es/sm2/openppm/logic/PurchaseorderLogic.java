/**
 * Generated 29 juin 2015
 * Openppm versius Devoteam, user story 17
 * @author : Xavier De Langautier, Cedric Ndanga Wandji
 */

package es.sm2.openppm.logic;

import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

import es.sm2.openppm.dao.PurchaseorderDAO;
import es.sm2.openppm.model.Purchaseorder;
import es.sm2.openppm.utils.SessionFactoryUtil;

/**
 * @author Cedric Ndanga
 * User-story 17
 */
public class PurchaseorderLogic extends AbstractGenericLogic<Purchaseorder, Integer> {

	public final static Logger LOGGER = Logger.getLogger(PurchaseorderLogic.class);
	
	
	public List<Purchaseorder> findAll() {
		
		List<Purchaseorder> purchaseorders = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.beginTransaction();
			
			PurchaseorderDAO purchaseDAO = new PurchaseorderDAO(session);
			purchaseorders = purchaseDAO.findAll();
			
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
		return purchaseorders;
	}
	
	public static void savePO(Purchaseorder po) throws Exception {
		
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		Transaction tx = null;
		
		try {
			tx = session.beginTransaction();
			
			PurchaseorderDAO purchaseDAO = new PurchaseorderDAO(session);
			purchaseDAO.makePersistent(po);
			
			LOGGER.debug("YHWH est Dieu >>>>> YHWH est Dieu");
			
			tx.commit();
			
		} catch (Exception e) {
			if(tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			SessionFactoryUtil.getInstance().close();
		}
		
	}

}
