/*******************************************************************************

 *  Authors : DEVOTEAM  xavier de langautier 2015/06/14
 ******************************************************************************/
package es.sm2.openppm.dao;

import org.hibernate.Criteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.Session;
import es.sm2.openppm.model.Projectactivity;

public class ProjectActivityDAODVT extends AbstractGenericHibernateDAO<Projectactivity, Integer> {

	public ProjectActivityDAODVT(Session session) {
		super(session);
	}


	/**
	 * Determiner si il ya une assignation pour cette activité
	 * @param activity
	 * @return boolean
	 * @throws Exception 
	 * 
	 * Create : Devoteam XAvier de langautier 2015/06/14 user story 15
	 */
	public boolean checkIfActivityInputed(Projectactivity activity) {
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(Projections.rowCount())
			.add(Restrictions.idEq(activity.getIdActivity()))
			.createCriteria(Projectactivity.TIMESHEETS);

		
		return ((Integer)crit.uniqueResult() > 0);
	}

}
