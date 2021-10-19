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

import java.awt.Color;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.ResourceBundle;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.annotations.XYTextAnnotation;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.XYBubbleRenderer;
import org.jfree.data.Range;
import org.jfree.data.xy.DefaultXYZDataset;
import org.jfree.data.xy.XYZDataset;

import es.sm2.openppm.charts.ChartArea2D;
import es.sm2.openppm.charts.ChartGantt;
import es.sm2.openppm.charts.ChartMSArea2D;
import es.sm2.openppm.charts.ChartMSArea2DDataset;
import es.sm2.openppm.charts.PlChartInfo;
import es.sm2.openppm.common.Constants;
import es.sm2.openppm.dao.DirectCostsDAO;
import es.sm2.openppm.dao.ExpensesDAO;
import es.sm2.openppm.dao.IwosDAO;
import es.sm2.openppm.dao.MilestoneDAO;
import es.sm2.openppm.dao.ProjectActivityDAO;
import es.sm2.openppm.dao.ProjectDAO;
import es.sm2.openppm.dao.ProjectFollowupDAO;
import es.sm2.openppm.exceptions.DateNotFoundException;
import es.sm2.openppm.exceptions.NoDataFoundException;
import es.sm2.openppm.exceptions.ProjectNetIncomeEmptyException;
import es.sm2.openppm.exceptions.ProjectNotFoundException;
import es.sm2.openppm.exceptions.ProjectTcvEmptyException;
import es.sm2.openppm.model.Milestones;
import es.sm2.openppm.model.Program;
import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Projectfollowup;
import es.sm2.openppm.utils.DateUtil;
import es.sm2.openppm.utils.SessionFactoryUtil;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

public final class ChartLogic extends GenericLogic {

	private ChartLogic() {
		super();
	}
	
	/**
	 * Collects information to generate the Chart
	 * @param project
	 * @param showFollowups
	 * @param until 
	 * @param since 
	 * @return
	 * @throws Exception 
	 */
	public static ChartGantt consChartGantt(ResourceBundle idioma, Project project,boolean showFollowups, boolean showPlanned, Date since, Date until) throws Exception {
		if (project.getIdProject() == -1) {
			throw new ProjectNotFoundException();
		}
		else if (since == null || until == null) {
			throw new DateNotFoundException();
		}
		
		ChartGantt chartGantt		= null;
		String numTasks				= null;
		String dateStr				= "";
		Set<Milestones> milestones	= null;
		
		SimpleDateFormat df = new SimpleDateFormat(DateUtil.getDatePattern(idioma), idioma.getLocale());
		SimpleDateFormat dfYear = new SimpleDateFormat("yyyy");
		
		int numTask		= 0;
		double days;
		double resdays;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectActivityDAO activityDAO = new ProjectActivityDAO(session);
			List<Projectactivity> projectactivities = activityDAO.findByProject(project, since, until);
			
			String titleName = (
					dfYear.format(since).equals(dfYear.format(until)) ? dfYear.format(since) 
					: dfYear.format(since) +StringPool.BLANK_DASH+ dfYear.format(until)
				);
			
			chartGantt = new ChartGantt(idioma, df.format(since), df.format(until),
					titleName, project.getProjectName(), "0");
	        
			Calendar sinceCal = DateUtil.getCalendar();
			sinceCal.setTime(since);
			sinceCal.set(Calendar.DAY_OF_MONTH,1);
			since = sinceCal.getTime();
			
			Calendar untilCal = DateUtil.getCalendar();
			untilCal.setTime(until);
			untilCal.set(Calendar.DAY_OF_MONTH,untilCal.getActualMaximum(Calendar.DAY_OF_MONTH));
			until = untilCal.getTime();
			
			for (Projectactivity task : projectactivities) {
				
				Date planInit	= null;
				Date planEnd	= null;
				
				if (task.getWbsnode().getWbsnode() == null) {
					planInit	= project.getPlannedInitDate();
					planEnd		= project.getPlannedFinishDate();
				}
				else {
					planInit	= task.getPlanInitDate();
					planEnd		= task.getPlanEndDate();
				}
				Date actInit = task.getActualInitDate();
				Date actEnd = (task.getActualEndDate() == null?task.getPlanEndDate():task.getActualEndDate());
				
				milestones = task.getMilestoneses();
				
				if (planInit != null && planEnd != null) {
					
					Date sinceInit = (planInit.before(since)?since:planInit);
					Date untilEnd = (until.before(planEnd)?until:planEnd);
					
					numTask++;
					numTasks = Integer.toString(numTask);
					
					for (Milestones itemMilestones : milestones) {
						// Only if milestone is report type
						
						if ("Y".equals(itemMilestones.getReportType().toString().toUpperCase())
								&& DateUtil.between(since, until, itemMilestones.getPlanned())) {
							
							dateStr = df.format(itemMilestones.getPlanned());
							chartGantt.addMilestone(dateStr, numTasks+"-1", itemMilestones.getLabel());
						}
						
					}
					chartGantt.addTask(task.getActivityName(), numTasks);
					
					chartGantt.addCategories(idioma.getString("cost.planned"), numTasks, df.format(sinceInit), 
							df.format(untilEnd), numTasks+"-1",2);
				}
				if (actInit != null && actEnd != null && showPlanned) {
					
					Date sinceInit = (actInit.before(since)?since:actInit);
					Date untilEnd = (until.before(actEnd)?until:actEnd);
					
					chartGantt.addCategories(idioma.getString("cost.actual"), numTask+StringPool.BLANK, df.format(sinceInit), 
							df.format(untilEnd), numTask+"",0);
					
					for (Milestones itemMilestones : milestones) {
						// Only if milestone is report type
						if ("Y".equals(itemMilestones.getReportType().toString().toUpperCase())
								&& DateUtil.between(since, until, itemMilestones.getAchieved())) {
							
							dateStr = df.format(itemMilestones.getAchieved());
							chartGantt.addMilestone(dateStr, numTasks+"", itemMilestones.getLabel());
						}
						
					}
					
					Double poc = null;
					if (task.getWbsnode().getWbsnode() == null) {
						poc = activityDAO.calcPoc(task);
					}
					else {
						poc = task.getPoc();
					}
					if (poc != null && poc > 0 && showPlanned) {
						
						Calendar initDate = DateUtil.getCalendar();
						initDate.setTime(actInit);
						
						Calendar endDate = DateUtil.getCalendar();
						endDate.setTime(actEnd);
						
						days = endDate.getTimeInMillis() - initDate.getTimeInMillis();
						resdays = days / (1000 * 60 * 60 * 24);
						
						resdays = resdays * (poc / 100);
						
						endDate.setTime(actInit);
						endDate.add(Calendar.DATE, (int)resdays);
						
						if (DateUtil.between(actInit, actEnd, endDate.getTime())) {
							chartGantt.addCategories(idioma.getString("percent_complete"), numTasks, df.format(actInit), 
									df.format(endDate.getTime()), numTasks,1);
						}
					}
					
				}
			}
			
			if (showFollowups) {
				ProjectFollowupDAO followupDAO = new ProjectFollowupDAO(session);
				List<Projectfollowup> followups = followupDAO.findByProject(project, Constants.ASCENDENT);
				
				Date dateSchedule = null;
				for (Projectfollowup followup : followups) {
					if (followup.getGeneralComments() != null || followup.getRisksComments() != null || followup.getCostComments() != null
								|| followup.getScheduleComments() != null || followup.getGeneralFlag() != null
								|| followup.getRiskFlag() != null || followup.getCostFlag() != null || followup.getScheduleFlag() != null
								|| followup.getPerformanceDoc() != null) {
						if (dateSchedule == null) {
							dateSchedule = followup.getFollowupDate();
						}
						else if (dateSchedule.before(followup.getFollowupDate())) {
							dateSchedule = followup.getFollowupDate();
						}
					}
				}
				if (DateUtil.between(since, until, dateSchedule)) {
					numTask++;
					numTasks = Integer.toString(numTask);
					chartGantt.addTask(idioma.getString("schedule_chart.last_status_report")+ " " + df.format(dateSchedule), numTasks);
					chartGantt.addMilestone(df.format(dateSchedule), numTasks+"-1", idioma.getString("control"));
					
					chartGantt.addCategories("", numTasks, df.format(dateSchedule), 
							df.format(dateSchedule), numTasks+"-1",0);
				}
			}
			
			if (numTask > 0)  { 
				chartGantt.setNumTasks(numTasks);
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
		return chartGantt;
	}
	
	
	/**
	 * Collects information to generate the Chart by Program
	 * @param until 
	 * @param since 
	 * @param program
	 * @return
	 * @throws Exception 
	 */
	public static ChartGantt consChartGantt(ResourceBundle idioma,
			List<Project> listProjects, Date since, Date until) throws Exception {
		
		if (listProjects == null || listProjects.isEmpty()) {
			throw new ProjectNotFoundException();
		}
		
		ChartGantt chartGantt	= null;
		int numTask				= 0;
		SimpleDateFormat dfYear = new SimpleDateFormat("yyyy");
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			MilestoneDAO milestoneDAO		= new MilestoneDAO(session);
			ProjectActivityDAO activityDAO	= new ProjectActivityDAO(session);
			
			SimpleDateFormat df = new SimpleDateFormat(DateUtil.getDatePattern(idioma), idioma.getLocale());
			
			//interval of dates for chart
			Calendar initDate	= null;
			Calendar endDate	= null;
			Calendar tempCal	= DateUtil.getCalendar();
			
			if (since == null || until == null) {
				
				for (Project proj :listProjects) {
					
					Projectactivity activity = activityDAO.consRootActivity(proj);
					
					Date start = null;
					Date finish = null;
					
					if (Constants.STATUS_INITIATING == proj.getStatus()) {
						start	= proj.getPlannedInitDate();
						finish	= proj.getPlannedFinishDate();
					}
					else if (Constants.STATUS_PLANNING == proj.getStatus() && activity != null) {
						start	= activity.getPlanInitDate();
						finish	= activity.getPlanEndDate();
					}
					else if (Constants.STATUS_CONTROL == proj.getStatus() && activity != null) {
						start	= (activity.getActualInitDate() == null? activity.getPlanInitDate():activity.getActualInitDate());
						finish	= activity.getPlanEndDate();
					}
					else if (activity != null) {
						start	= activity.getActualInitDate();
						finish	= activity.getActualEndDate();
					}
					
					
					if (start != null && start.before(proj.getPlannedInitDate())) {
						
						tempCal.setTime(start);
					}
					else {
						tempCal.setTime(proj.getPlannedInitDate());
					}
					
					if (initDate == null || initDate.after(tempCal)) {
						if (initDate == null) { initDate = DateUtil.getCalendar(); }
						initDate.setTime(tempCal.getTime());
					}
					
					if (finish != null && finish.after(proj.getPlannedFinishDate())) {
						
						tempCal.setTime(finish);
					}
					else {
						tempCal.setTime(proj.getPlannedFinishDate());
					}
					
					if (endDate == null || endDate.before(tempCal)) {
						if (endDate == null) { endDate = DateUtil.getCalendar(); }
						endDate.setTime(tempCal.getTime());
					}
				}
			}
			
			if (since != null) {
				initDate = DateUtil.getCalendar();
				initDate.setTime(since);
				initDate.set(Calendar.DAY_OF_MONTH,1);
				since = initDate.getTime();
			}
			else {
				since = initDate.getTime();
			}
			if (until != null) {	
				endDate = DateUtil.getCalendar();
				endDate.setTime(until);
				endDate.set(Calendar.DAY_OF_MONTH,endDate.getActualMaximum(Calendar.DAY_OF_MONTH));
				until = endDate.getTime();
			}
			else {
				until = endDate.getTime();
			}
			
			if (endDate != null && initDate != null) {
			
				String titleName = (
						dfYear.format(initDate.getTime()).equals(dfYear.format(endDate.getTime()))
						? dfYear.format(initDate.getTime()) 
						: dfYear.format(initDate.getTime()) +StringPool.BLANK_DASH+ dfYear.format(endDate.getTime())
					);
				
				chartGantt = new ChartGantt(idioma, df.format(initDate.getTime()), df.format(endDate.getTime()),
						titleName, StringPool.BLANK, "0");
				
				for (Project proj : listProjects) {
					
					Projectactivity activity = activityDAO.consRootActivity(proj);
					
					Date start = null;
					Date finish = null;
					
					if (Constants.STATUS_INITIATING == proj.getStatus()) {
						start	= proj.getPlannedInitDate();
						finish	= proj.getPlannedFinishDate();
					}
					else if (Constants.STATUS_PLANNING == proj.getStatus() && activity != null) {
						start	= activity.getPlanInitDate();
						finish	= activity.getPlanEndDate();
					}
					else if (Constants.STATUS_CONTROL == proj.getStatus() && activity != null) {
						start	= activity.getActualInitDate();
						finish	= activity.getPlanEndDate();
					}
					else if (activity != null) {
						start	= activity.getActualInitDate();
						finish	= activity.getActualEndDate();
					}
					
					if ((since.before(proj.getPlannedInitDate()) && until.after(proj.getPlannedInitDate())) 
							|| (since.before(proj.getPlannedFinishDate()) && until.after(proj.getPlannedFinishDate()))
							|| (since.after(proj.getPlannedInitDate()) && until.before(proj.getPlannedFinishDate()))
							|| DateUtil.equals(since, proj.getPlannedInitDate())
							|| DateUtil.equals(until, proj.getPlannedFinishDate())) {
						
						numTask++;
						
						Date startPlan = since.before(proj.getPlannedInitDate())?proj.getPlannedInitDate():since;
						Date finishPlan = until.after(proj.getPlannedFinishDate())?proj.getPlannedFinishDate():until;
						
						chartGantt.addTask(proj.getProjectName(), numTask+StringPool.BLANK);
						chartGantt.addCategories(idioma.getString("cost.planned"), numTask+StringPool.BLANK, df.format(startPlan), 
								df.format(finishPlan), numTask+"-1",2);
						

						List<Milestones> milestones = milestoneDAO.findByProject(proj);
						
						if (start != null && finish != null) {
							
							Date startAct = since.before(start)?start:since;
							Date finishAct = until.after(finish)?finish:until;
							
							chartGantt.addCategories(idioma.getString("cost.actual"), numTask+StringPool.BLANK, df.format(startAct), 
									df.format(finishAct), numTask+"",0);
							
							for (Milestones milestone : milestones) {

								if ("Y".equals(milestone.getReportType().toString().toUpperCase())
										&& DateUtil.between(since, until, milestone.getAchieved())) {
									
									String dateStr = df.format(milestone.getAchieved());
									chartGantt.addMilestone(dateStr, numTask+"",5, milestone.getLabel());
								}
								
							}
						}
						
						for (Milestones milestone : milestones) {
							
							if ("Y".equals(milestone.getReportType().toString().toUpperCase())
									&& DateUtil.between(since, until, milestone.getPlanned())) {
								
								String dateStr = df.format(milestone.getPlanned());
								chartGantt.addMilestone(dateStr, numTask+"-1",5, milestone.getLabel());
							}
						}

						double poc = proj.getPOC(session)/100;
						
						if (poc > 0 && start != null && finish != null) {
							
							Calendar initDateTemp = DateUtil.getCalendar();
							initDateTemp.setTime(start);
							
							Calendar endDateTemp = DateUtil.getCalendar();
							endDateTemp.setTime(finish);
							
							long days = endDateTemp.getTimeInMillis() - initDateTemp.getTimeInMillis();
							double resdays = days / (1000 * 60 * 60 * 24);
							poc = Math.round(poc*Math.pow(10,2))/Math.pow(10,2);
							
							resdays = resdays * poc;
							
							initDateTemp.add(Calendar.DATE, (int)resdays);
							
							Date startAct = since.before(start)?start:since;
							Date finishAct = until.after(initDateTemp.getTime())?initDateTemp.getTime():until;
							
							if (initDateTemp.getTime().after(start)) {
								chartGantt.addCategories(idioma.getString("percent_complete"), String.valueOf(numTask),
										df.format(startAct), df.format(finishAct), String.valueOf(numTask),1);
							}
							
						}
					}
				}
				chartGantt.setNumTasks(numTask+StringPool.BLANK);
			}
			
			tx.commit();
		}
		catch (Exception e) {
			e.printStackTrace();
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return (numTask > 0 ? chartGantt : null);
	}
	
	
	/**
	 * Return info for generate chart PL
	 * @param idProject
	 * @return
	 * @throws Exception 
	 */
	public static PlChartInfo consInfoPlChart(Project project) throws Exception {
		
		PlChartInfo plChartInfo = new PlChartInfo(); 
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			if (project.getTcv() == null) {
				throw new ProjectTcvEmptyException();
			}
			
			IwosDAO iwosDAO = new IwosDAO(session);
			plChartInfo.setSumIwos(iwosDAO.getTotal(project));
			
			ExpensesDAO expensesDAO = new ExpensesDAO(session);
			plChartInfo.setSumExpenses(expensesDAO.getTotal(project));
			
			DirectCostsDAO directCostsDAO = new DirectCostsDAO(session);
			plChartInfo.setSumDirectCost(directCostsDAO.getTotal(project));

			plChartInfo.setTcv(project.getTcv());
			
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
		return plChartInfo;
	}
	
	
	/**
	 * Return actual info for generate chart PL to Control Costs
	 * @param idProject
	 * @return
	 * @throws Exception 
	 */
	public static PlChartInfo consActualInfoPlChart(Project project) throws Exception {
		
		PlChartInfo plChartInfo = new PlChartInfo(); 
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
		
			if (project.getTcv() == null) {
				throw new ProjectTcvEmptyException();
			}
			if (project.getNetIncome() == null || project.getNetIncome() <= 0) {
				throw new ProjectNetIncomeEmptyException();
			}
			
			IwosDAO iwosDAO = new IwosDAO(session);
			plChartInfo.setSumIwos(iwosDAO.getActualTotal(project));
			
			ExpensesDAO expensesDAO = new ExpensesDAO(session);
			plChartInfo.setSumExpenses(expensesDAO.getActualTotal(project));
			
			DirectCostsDAO directCostsDAO = new DirectCostsDAO(session);
			plChartInfo.setSumDirectCost(directCostsDAO.getActualTotal(project));

			plChartInfo.setTcv(project.getTcv());
			
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
		return plChartInfo;
	}
	
	
	/**
	 * Create Chart Income Forecast
	 * @param idioma 
	 * @param program 
	 * @return
	 * @throws Exception 
	 */
	public static ChartMSArea2D consChartIncome(ResourceBundle idioma, Program program) throws Exception {
		
		ChartMSArea2D chart = new ChartMSArea2D(idioma.getString("project_pl.thousands"));
		chart.setDecimalPrecision("2");
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			//Legend Months
			int i=1;
			for (i=1; i <= 12;i++) {
				chart.addCategory(idioma.getString("month.month" + i + "_short"));
			}
			
			//Date range
			Calendar initDate = DateUtil.getCalendar();
			initDate.set(Calendar.MONTH, 0);
			initDate.set(Calendar.DAY_OF_MONTH, 1);
			
			Calendar currentDate = DateUtil.getCalendar();
			currentDate.setTime(DateUtil.getFirstMonthDay(currentDate.getTime()));
			
			Calendar endDate = DateUtil.getCalendar();
			endDate.set(Calendar.MONTH, 11);
			endDate.setTime(DateUtil.getLastMonthDay(endDate.getTime()));
			
			Calendar tempDate = DateUtil.getCalendar();
			tempDate.setTime(initDate.getTime());
			tempDate.set(Calendar.DAY_OF_MONTH, 1);
			
			// Initiate necessary DAOs
			ProjectFollowupDAO followupDAO	= new ProjectFollowupDAO(session);
			
			/* Calculate IF */
			ChartMSArea2DDataset datasetIncomeForecast = new ChartMSArea2DDataset(idioma.getString("chart.forecast"), "FFFFFF", "1");
			
			// Calculate EV until current date (Real values)
			Double ev = null;
			Double previousEv = followupDAO.getProgramEV(program, initDate.getTime());
			
			while (!tempDate.after(currentDate)) {
				ev = (followupDAO.getProgramEV(program, DateUtil.getLastMonthDay(tempDate.getTime())) - previousEv)/1000;
				datasetIncomeForecast.addValue(String.valueOf(ev.intValue()));
				
				tempDate.add(Calendar.MONTH, 1);
			}
			
			// Calculate EV from current date to end year (IncomeForecast / IF)
			Double ifMonth = 0D;
			tempDate.setTime(currentDate.getTime());
			while (!tempDate.after(endDate)) {
				ifMonth += (followupDAO.getProgramBacklog(program, DateUtil.getLastMonthDay(tempDate.getTime()), currentDate.getTime()))/1000;
				Double value = ifMonth+ev;
				datasetIncomeForecast.addValue(String.valueOf(value.intValue()));
				
				tempDate.add(Calendar.MONTH, 1);
			}
			/* End Calculate IF */
			
			/* Calculate Sales Forecast */
			ChartMSArea2DDataset datasetSalesForecast = new ChartMSArea2DDataset(idioma.getString("chart.forecast.backlog"), "8D929E", "1");
			
			List<Project> investments = null;
			
			int[] listData = salesData(investments, currentDate, endDate);
			
			//Enter values for dataSet forecast
			tempDate.setTime(currentDate.getTime());
			i = 0;
			while (tempDate.before(endDate)) {
				datasetSalesForecast.addValue(String.valueOf(listData[i]));
				
				i++;
				tempDate.add(Calendar.MONTH, +1);
			}
			/* End calculate Sales Forecast */
			
			//Add data sets to chart
			chart.addDatasets(datasetIncomeForecast);
			chart.addDatasets(datasetSalesForecast);
			
			/* Calculate To Be Found (TBF) */
			Double ifTarget = (program.getBudget() == null ? ifMonth : program.getBudget().intValue())/1000;
			Double tbf = ifTarget - (ifMonth+ev);
			chart.setTrendValue(String.valueOf(ifMonth+ev));
			chart.setYAxisMaxValue(String.valueOf(ifTarget > ifMonth ? ifTarget : ifMonth));
			chart.setTrendDisplayvalue(idioma.getString("chart.forecast.tbf") + String.valueOf(tbf.intValue()));
			
			tx.commit();
		}
		catch (NoDataFoundException e) {
			chart = null;
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
		return chart;
	}
	
	
	/**
	 * Create Chart Sales Forecast
	 * @param idioma 
	 * @return
	 * @throws Exception 
	 */
	public static ChartArea2D consChartSales(ResourceBundle idioma, Integer[] ids) throws Exception {
		
		ChartArea2D chart = null;
		
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			Calendar initDate = DateUtil.getCalendar();
			initDate.setTime(DateUtil.getFirstMonthDay(initDate.getTime()));
			initDate.add(Calendar.MONTH, +1);
			
			Calendar endDate = DateUtil.getCalendar();
			endDate.add(Calendar.MONTH, +13);
			endDate.setTime(DateUtil.getLastMonthDay(endDate.getTime()));
			
			Calendar tempDate = DateUtil.getCalendar();
			tempDate.setTime(initDate.getTime());
			
			ProjectDAO projectDAO = new ProjectDAO(session);
			List<Project> investments = projectDAO.consInvestmentInProcess(ids);
			
			if (!investments.isEmpty()) {
				
				int[] listData = salesData(investments, initDate, endDate);
				
				chart = new ChartArea2D();
				int i = 0;
				
				while (tempDate.before(endDate)) {
					chart.addElement(idioma.getString("month.month" + (tempDate.get(Calendar.MONTH)+1)+"_short")
							, String.valueOf(listData[i]));
					i++;
					tempDate.add(Calendar.MONTH, + 1);
				}
			}
			tx.commit();
		}
		catch (NoDataFoundException e) {
			chart = null;
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
		return chart;
	}

	
	private static int[] salesData(List<Project> investments, Calendar initDate, Calendar endDate) throws NoDataFoundException {

		boolean noData = true;
		
		Calendar tempDate = DateUtil.getCalendar();
		tempDate.setTime(initDate.getTime());
		
		int[] listData = new int[13];
		int i = 0;
		while (tempDate.before(endDate)) {
			listData[i] = 0;
			
			for (Project investment : investments) {
				
				Date start = investment.getPlannedInitDate();
				Date finish = investment.getPlannedFinishDate();
				
				if (start != null) {
					
					if (!start.after(tempDate.getTime()) &&
							!tempDate.after(finish)) {
						
						double months = DateUtil.monthsBetween(start, finish);
						double tv = (investment.getTcv() == null ? 0 : investment.getTcv().doubleValue());
						double winProbability = (investment.getPriority() == null?0:investment.getPriority());
						double total;
						
						tv = (tv / 1000);
						winProbability = (winProbability / 100);
						total = ((tv * winProbability) / months);
						
						if (total > 0) { 
							noData = false;				
							listData[i] += total;
						}
					}
				}
			}
			
			i++;
			tempDate.add(Calendar.MONTH, + 1);
		}
		
		if (noData) { throw new NoDataFoundException(); }
		
		return listData;
	}
	
	
	public static JFreeChart createBubbleChart(ResourceBundle idioma,List<Project> projList, boolean investiment) throws Exception {
		
		JFreeChart bubblechart = null;
		Transaction tx = null;
		Session session = SessionFactoryUtil.getInstance().getCurrentSession();
		try {
			tx = session.beginTransaction();
			
			ProjectFollowupDAO followupDAO	= new ProjectFollowupDAO(session);
			
			List<Double> x1 = new ArrayList<Double>();
			List<Double> y1 = new ArrayList<Double>();
			List<Double> z1 = new ArrayList<Double>();
			
			List<Double> x2 = new ArrayList<Double>();
			List<Double> y2 = new ArrayList<Double>();
			List<Double> z2 = new ArrayList<Double>();
			
			List<Double> x3 = new ArrayList<Double>();
			List<Double> y3 = new ArrayList<Double>();
			List<Double> z3 = new ArrayList<Double>();
			
			List<Double> x4 = new ArrayList<Double>();
			List<Double> y4 = new ArrayList<Double>();
			List<Double> z4 = new ArrayList<Double>();
			
			List<XYTextAnnotation> anotations = new ArrayList<XYTextAnnotation>(); 
			XYTextAnnotation anotation = null;
			
			double maxValue = 0; 
			Double value = null;
			
			for (Project proj : projList) {
				
				value = (investiment?proj.getTcv():proj.getBac());
				if (value != null && proj.getProbability() != null
						&& maxValue < value) {
					
					maxValue = value;
				}
			}
			maxValue = (maxValue/new Double(1000));
			int xMin = 0;
			int xMax = 100;
			int yMin = 0; 
			int yMax = 100;
			
			for (Project proj : projList) {
				
				if (proj.getProbability() != null) {
					
					double poc = new Double(0);
					
					if (investiment) { poc = proj.getProbability(); }
					else {poc = proj.getPOC(session); }
					
					Double tcv = (proj.getTcv() == null?0:proj.getTcv());
					Double bac = (proj.getBac() == null?0:proj.getBac());
					
					Double valueBubble = new Double((investiment?tcv:bac)/new Double(1000));
					
					double area = valueBubble;
					if (maxValue > 0) { area = (area*Constants.BUBBLE_MAX)/maxValue; }
					else { area = Constants.BUBBLE_DEFAULT; }
					
					if (area <= 1D) { area = Constants.BUBBLE_MIN; }
					
					double strategic = (proj.getPriority() == null ? 0 : proj.getPriority()); 
					double yPosition = strategic;
					
					if (yPosition >= 90) {
						
						int temp = (int) Math.floor(yPosition+(area/2)+0.99);
						temp = (temp > 95?temp+2:temp);
						yMax = (temp > 100 && temp > yMax?temp:yMax);
						
						yPosition -= ((area/2)+2);
					}
					else if (yPosition <= 10) {
						
						int temp = (int) Math.floor(yPosition-(area/2));
						temp = (temp < 5?temp-2:temp);
						yMin = (temp < 0 && temp < yMin?temp:yMin);
						
						yPosition += ((area/2)+2);
					}
					else if (area < 10) {
						yPosition += ((area/2)+2);
					}
					
					
					double xPosition = poc;
					if (xPosition >= 90) {
						
						int temp = (int) Math.floor(xPosition+(area/2)+0.99);
						temp = (temp > 95?temp+2:temp);
						xMax = (temp > 100 && temp > xMax?temp:xMax);
						
						xPosition -= ((area/2)+2);
					}
					else if (xPosition <= 10) {
						
						int temp = (int) Math.floor(xPosition-(area/2));
						temp = (temp < 5?temp-2:temp);
						xMin = (temp < 0 && temp < xMin?temp:xMin);
						
						xPosition += ((area/2)+2);
					}
					
					anotation = new XYTextAnnotation(
							ValidateUtil.isNullCh(proj.getChartLabel(), proj.getAccountingCode()),
							yPosition, xPosition
						);
					anotations.add(anotation);
					
					Projectfollowup followupRisk = followupDAO.findLastByProjectRisk(proj);
					
					Character risk = (followupRisk != null?followupRisk.getRiskFlag():null);

					if (investiment || risk == null) {
						y4.add(strategic);
						x4.add(poc);
						z4.add(area);
					}
					else if (risk.equals(Constants.RISK_LOW) || risk.equals(Constants.RISK_NORMAL)) {
						y1.add(strategic);
						x1.add(poc);
						z1.add(area);
					}
					else if (risk.equals(Constants.RISK_MEDIUM)) {
						y2.add(strategic);
						x2.add(poc);
						z2.add(area);
					}
					else if (risk.equals(Constants.RISK_HIGH)) {
						y3.add(strategic);
						x3.add(poc);
						z3.add(area);
					}
					
				}
			}
			
			DefaultXYZDataset dataset = new DefaultXYZDataset(); 
			
			double[][] defaultData = new double[3][y4.size()];
			for (int i = 0; i < y4.size(); i ++) {
				defaultData[0][i] = y4.get(i);
				defaultData[1][i] = x4.get(i);
				defaultData[2][i] = z4.get(i);
			}
			
			if (!investiment) {
				double[][] s1 = new double[3][y1.size()];
				for (int i = 0; i < y1.size(); i ++) {
					s1[0][i] = y1.get(i);
					s1[1][i] = x1.get(i);
					s1[2][i] = z1.get(i);
				}
				dataset.addSeries(idioma.getString("chart.bubble.low_risk"), s1);
				
				double[][] s2 = new double[3][y2.size()];
				for (int i = 0; i < y2.size(); i ++) {
					s2[0][i] = y2.get(i);
					s2[1][i] = x2.get(i);
					s2[2][i] = z2.get(i);
				}
				dataset.addSeries(idioma.getString("chart.bubble.medium_risk"), s2);
				
				double[][] s3 = new double[3][y3.size()];
				for (int i = 0; i < y3.size(); i ++) {
					s3[0][i] = y3.get(i);
					s3[1][i] = x3.get(i);
					s3[2][i] = z3.get(i);
				}
				dataset.addSeries(idioma.getString("chart.bubble.high_risk"), s3);
				
				dataset.addSeries(idioma.getString("chart.bubble.unknown"), defaultData);
			}
			else {
				dataset.addSeries(idioma.getString("investments"), defaultData);
			}
			
			bubblechart = createBubbleChart(idioma, null, idioma.getString("strategic_value")+StringPool.SPACE+StringPool.PERCENT,
					(investiment?idioma.getString("proposal.win_probability")+StringPool.SPACE+StringPool.PERCENT:idioma.getString("percent_complete")),
					dataset, PlotOrientation.HORIZONTAL, anotations, investiment, xMin, xMax, yMin, yMax);
			
			tx.commit();
		}
		catch (Exception e) {
			e.printStackTrace();
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		}
		finally {
			SessionFactoryUtil.getInstance().close();
		}
		return bubblechart;
	}
	
	
	/**
	 * Create bubble chart
	 * @param title
	 * @param yAxisLabel
	 * @param xAxisLabel
	 * @param dataset
	 * @param orientation
	 * @param anotations
	 * @param maxRange
	 * @return
	 */
	private static JFreeChart createBubbleChart(ResourceBundle idioma, String title, String yAxisLabel, String xAxisLabel, XYZDataset dataset,
               PlotOrientation orientation,List<XYTextAnnotation> anotations, boolean investment,int xMin, int xMax, int yMin, int yMax) {

		NumberFormat formatter = NumberFormat.getNumberInstance();
		formatter.setMaximumFractionDigits(0);
		
		NumberAxis xAxis = new NumberAxis(xAxisLabel);
		xAxis.setRange(new Range(xMin,xMax));
		xAxis.setNumberFormatOverride(formatter);
		
		NumberAxis yAxis = new NumberAxis(yAxisLabel);
		yAxis.setRange(new Range(yMin,yMax));
		yAxis.setNumberFormatOverride(formatter);
		
		XYPlot plot = new XYPlot(dataset, yAxis, xAxis, null);
		plot.setBackgroundPaint(Color.WHITE);
		
		XYBubbleRenderer renderer = new XYBubbleRenderer(XYBubbleRenderer.SCALE_ON_RANGE_AXIS);
		
		if (!investment) {
			renderer.setSeriesPaint(0, new Color(153,204,0));
			renderer.setSeriesPaint(1, new Color(255,204,0));
			renderer.setSeriesPaint(2, new Color(204,0,0));
			renderer.setSeriesPaint(3, new Color(227,227,227));
		}
		else {
			renderer.setSeriesPaint(0, new Color(227,227,227));
		}
		
	    for (XYTextAnnotation anotation : anotations) {
	    	renderer.addAnnotation(anotation);
	    }
	     
	    plot.setRenderer(renderer);
	    plot.setOrientation(orientation);
		
	    JFreeChart chart = new JFreeChart(title, JFreeChart.DEFAULT_TITLE_FONT,plot, true);
	    chart.setBackgroundPaint(Color.WHITE);

	    return chart;
	}
}
