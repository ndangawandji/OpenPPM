package es.sm2.openppm.dao;

import java.util.Date;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.apache.log4j.Logger;

import es.sm2.openppm.logic.TimesheetLogic;
import es.sm2.openppm.model.Employee;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Timesheet;

public class TimesheetDAODVT extends AbstractGenericHibernateDAO<Timesheet, Integer> {
	private static final Logger LOGGER = Logger.getLogger(TimesheetDAODVT.class);
	
	public TimesheetDAODVT(Session session) {
		super(session);
		// TODO Auto-generated constructor stub
		//created by dvt
	}
	
	/**
	 * Get Hours resource
	 * @param idEmployee
	 * @param id
	 * @param initDate
	 * @param endDate
	 * @param minStatus
	 * @param maxStatus
	 * @return Renvoie la somme des  heures correspondant à une periode pour une plage de statut donnée.
	 */
	public double getHoursResource(Integer idEmployee,Integer idActivity,Date initDate, Date endDate, String minStatus, String maxStatus ) {
		
	
		ProjectionList proList = Projections.projectionList();
		proList.add(Projections.sum(Timesheet.HOURSDAY1));
		proList.add(Projections.sum(Timesheet.HOURSDAY2));
		proList.add(Projections.sum(Timesheet.HOURSDAY3));
		proList.add(Projections.sum(Timesheet.HOURSDAY4));
		proList.add(Projections.sum(Timesheet.HOURSDAY5));
		proList.add(Projections.sum(Timesheet.HOURSDAY6));
		proList.add(Projections.sum(Timesheet.HOURSDAY7));
		
		Criteria crit = getSession().createCriteria(getPersistentClass())
			.setProjection(proList)
			.add(Restrictions.or(
				Restrictions.eq(Timesheet.STATUS, minStatus),
				Restrictions.eq(Timesheet.STATUS, maxStatus)
				))
			.add(Restrictions.le(Timesheet.INITDATE, endDate))
			.add(Restrictions.ge(Timesheet.ENDDATE,initDate ))  // permet de couvrir la période demandée
			.add(Restrictions.eq(Timesheet.PROJECTACTIVITY, new Projectactivity(idActivity)))
			.add(Restrictions.eq(Timesheet.EMPLOYEE, new Employee(idEmployee)));
		
		Object[] hoursList = (Object[]) crit.uniqueResult();
		
		// debuger a supprimer
//		for (int i = 0; i < hoursList.length; i++) {
//			Object object = hoursList[i];
//			 if (hoursList[i] != null) {  LOGGER.debug("hours day "+i + " " +object);};		
//		}

		 
		double hours = 0;
		
		if (hoursList != null) {
			hours += (hoursList[0] == null?0:(Double)hoursList[0]);
			hours += (hoursList[1] == null?0:(Double)hoursList[1]);
			hours += (hoursList[2] == null?0:(Double)hoursList[2]);
			hours += (hoursList[3] == null?0:(Double)hoursList[3]);	
			hours += (hoursList[4] == null?0:(Double)hoursList[4]);
			hours += (hoursList[5] == null?0:(Double)hoursList[5]);
			hours += (hoursList[6] == null?0:(Double)hoursList[6]);
		}

		return hours;
	}
	
	/**
	 * @author Cedric Ndanga
	 * Devoteam user story 40
	 * @return total hours of activity
	 * @param activity
	 */
	public double getHoursActivity(Projectactivity activity) {
		
		ProjectionList proList = Projections.projectionList();
		proList.add(Projections.sum(Timesheet.HOURSDAY1));
		proList.add(Projections.sum(Timesheet.HOURSDAY2));
		proList.add(Projections.sum(Timesheet.HOURSDAY3));
		proList.add(Projections.sum(Timesheet.HOURSDAY4));
		proList.add(Projections.sum(Timesheet.HOURSDAY5));
		proList.add(Projections.sum(Timesheet.HOURSDAY6));
		proList.add(Projections.sum(Timesheet.HOURSDAY7));
		
		Criteria crit = getSession().createCriteria(getPersistentClass()).setProjection(proList);
		
		crit.createCriteria(Timesheet.PROJECTACTIVITY).add(Restrictions.idEq(activity.getIdActivity()));
		
		Object[] hoursList = (Object[]) crit.uniqueResult();
		
		double hours = 0;
		
		if (hoursList != null) {
			hours += (hoursList[0] == null?0:(Double)hoursList[0]);
			hours += (hoursList[1] == null?0:(Double)hoursList[1]);
			hours += (hoursList[2] == null?0:(Double)hoursList[2]);
			hours += (hoursList[3] == null?0:(Double)hoursList[3]);
			hours += (hoursList[4] == null?0:(Double)hoursList[4]);
			hours += (hoursList[5] == null?0:(Double)hoursList[5]);
			hours += (hoursList[6] == null?0:(Double)hoursList[6]);
		}
		
		return hours;
	}

}
