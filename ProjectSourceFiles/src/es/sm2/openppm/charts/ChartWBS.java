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
/*
 *  Updater : Cedric Ndanga Wandji
 *  Devoteam 11/06/2015 user story 40 : updating generateWBS(...) java method
 *  Devoteam 02/07/2015 user story 40 : adding sumOfInitWorkload() and sumOfCurrentWorkload() java methods
 */
package es.sm2.openppm.charts;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Set;

import es.sm2.openppm.exceptions.LogicException;
import es.sm2.openppm.logic.TeamMemberLogic;
import es.sm2.openppm.logic.WBSNodeLogic;
import es.sm2.openppm.logic.TimesheetLogic;
import es.sm2.openppm.model.Projectactivity;
import es.sm2.openppm.model.Wbsnode;
import es.sm2.openppm.utils.StringPool;
import es.sm2.openppm.utils.ValidateUtil;

/**
 * @author javier.hernandez
 *
 */
public class ChartWBS {
	
	private Wbsnode wbsNodeParent;
	private boolean showPoc;
	private double globalPoc;
	
	public ChartWBS(Wbsnode wbsNodeParent, boolean showPoc) {
		this.wbsNodeParent = wbsNodeParent;
		this.showPoc = showPoc;
	}

	public ChartWBS(Wbsnode wbsNodeParent, boolean showPoc, Double globalPoc) {
		this.wbsNodeParent = wbsNodeParent;
		this.showPoc = showPoc;
		this.setGlobalPoc(globalPoc == null?0:globalPoc);
	}

	public Wbsnode getWbsNodeParent() {
		return wbsNodeParent;
	}

	public void setWbsNodeParent(Wbsnode wbsNodeParent) {
		this.wbsNodeParent = wbsNodeParent;
	}
	
	public boolean isShowPoc() {
		return showPoc;
	}

	public void setShowPoc(boolean showPoc) {
		this.showPoc = showPoc;
	}

	/**
	 * Generate html code for view chart
	 * @return
	 * @throws LogicException 
	 */
	public String generateHTML() throws Exception {

		DecimalFormat decimalFormat = new DecimalFormat("###.## %");
		
		globalPoc = globalPoc /100;
		
		StringBuilder textHtml = new StringBuilder();
		if (wbsNodeParent != null && wbsNodeParent.getName() != null) {
			String pocStr = "";
			if (showPoc) {
				pocStr = " <h7 style=\"color:#FF0000\">" + decimalFormat.format(globalPoc) + "</h7>";
			}
			textHtml.append("<div id=\"main\" align=\"center\">" +
					"<table><tr><td style=\"border-top:none !important;\"><span id=\"titlewbs\" class=\"ui-corner-all\" style=\"background-color:#CDDBFF\">" +
					wbsNodeParent.getName() + pocStr+"</span></td></tr></table><table><tr>");
			
			List<Wbsnode> childs = WBSNodeLogic.findChildsWbsnode(wbsNodeParent);
			if (!childs.isEmpty()) {
				textHtml.append(generateWBS(childs,new StringBuilder(),0,showPoc).toString());
			}
			textHtml.append("</tr></table></div>");
		}
		return textHtml.toString();
	}
	/**
	 * Generate nodes of WBS
	 * @param wbsnodes
	 * @param html
	 * @param level
	 * @param bac
	 * @param showPoc
	 * @return
	 * @throws LogicException 
	 * @updater Cedric Ndanga, Devoteam, user story 40
	 */
	private StringBuilder generateWBS(List<Wbsnode> wbsnodes, StringBuilder html, int level, Boolean showPoc) throws Exception {
		int sublevel = level +1;
		double poc = 0;
		DecimalFormat decimalFormat = new DecimalFormat("###.## %");
		
		for (Wbsnode child: wbsnodes) {
			List<Wbsnode> childs = WBSNodeLogic.findChildsWbsnode(child);
			String code = ValidateUtil.isNullCh(child.getCode(), "");
			Set<Projectactivity> activitys = child.getProjectactivities();
			double sumInitWorkload = 0;											// cnw us40
			double sumActualWorkload = 0;										// cnw us40
			
			sumInitWorkload = sumOfInitWorkload(child);			// cnw us40 getting total init workload
			sumActualWorkload = sumOfCurrentWorkload(child);	// cnw us40 getting total current workload
			
			for (Projectactivity activity: activitys) {
				if (showPoc) {
					poc = (activity.getPoc() == null?0:activity.getPoc())/100;
				}
			}
			
			if (level == 0) {
				html.append("<td><ul class=\"treeview-gray gray\"><li><div class=\"closed ui-corner-all ");
				if (child.getIsControlAccount()) {
					if(sumInitWorkload == 0 || (sumInitWorkload - sumActualWorkload) >= 0) {	// cnw us40 si le workload initial n'est renseigné pour aucune activité, l'activité sera considéré comme dans les temps. 
						html.append("cAccountRight\">"+code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
						if (showPoc) {
							html.append("<br><h7 style=\"color:#008000\">" + decimalFormat.format(poc) + "</h7>");
						}
					}
					else {			// si sumInitWorkload != 0 && (sumInitWorkload - sumActualWorkload) < 0, activite hors delais
						html.append("cAccountLate\">"+code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
						if (showPoc) {
							html.append("<br><h7 style=\"color:#ff0000\">" + decimalFormat.format(poc) + "</h7>");
						}
					}
				}
				else {
					if(sumInitWorkload == 0 || (sumInitWorkload - sumActualWorkload) >= 0) {	// cnw us40 si le workload initial n'est renseigné pour aucune activité, l'activité sera considéré comme dans les temps. 
						html.append("wGroupsRight\">"+code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
						if (showPoc) {
							html.append("<br><h7 style=\"color:#008000\">" + decimalFormat.format(calcPoc(childs)) + "</h7>");
						}
					}
					else {		// si sumInitWorkload != 0 && (sumInitWorkload - sumActualWorkload) < 0, activite hors delais
						html.append("wGroupsLate\">"+code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
						if (showPoc) {
							html.append("<br><h7 style=\"color:#ff0000\">" + decimalFormat.format(calcPoc(childs)) + "</h7>");
						}
					}
				}
				html.append(StringPool.END_DIV);
			}
			else {
				if (childs.isEmpty()) {
					if(sumInitWorkload == 0 || (sumInitWorkload - sumActualWorkload) >= 0) {	// cnw us40 si le workload initial n'est renseigné pour aucune activité, l'activité sera considéré comme dans les temps.
						html.append("<li><span style=\"color:#008000\">" + code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP) + "</span>");
						if (showPoc && child.getIsControlAccount()) {
							html.append("&nbsp;<h7 style=\"color:#008000\">" + decimalFormat.format(poc) + "</h7>");
						}
					}
					else {		// si sumInitWorkload != 0 && (sumInitWorkload - sumActualWorkload) < 0, activite hors delais
						html.append("<li><span style=\"color:#ff0000\">" + code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP) + "</span>");
						if (showPoc && child.getIsControlAccount()) {
							html.append("&nbsp;<h7 style=\"color:#ff0000\">" + decimalFormat.format(poc) + "</h7>");
						}
					}
				}
				else {
					html.append("<li >");
					if (child.getIsControlAccount()) {
						if(sumInitWorkload == 0 || (sumInitWorkload - sumActualWorkload) >= 0) {	// cnw us40 si le workload initial n'est renseigné pour aucune activité, l'activité sera considéré comme dans les temps. 
							html.append("<div class=\"ui-corner-all cAccountRight\">" + code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
							if (showPoc) {
								html.append("<br><h7 style=\"color:#008000\">" + decimalFormat.format(poc) + "</h7>");
							}
						}
						else {		// si sumInitWorkload != 0 && (sumInitWorkload - sumActualWorkload) < 0, activite hors delais
							html.append("<div class=\"ui-corner-all cAccountLate\">" + code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
							if (showPoc) {
								html.append("<br><h7 style=\"color:#ff0000\">" + decimalFormat.format(poc) + "</h7>");
							}
						}
					}
					else {
						if(sumInitWorkload == 0 || (sumInitWorkload - sumActualWorkload) >= 0) {	// cnw us40 si le workload initial n'est renseigné pour aucune activité, l'activité sera considéré comme dans les temps. 
							html.append("<div class=\"ui-corner-all wGroupsRight\">"+ code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
							if (showPoc) {
								html.append("<br><h7 style=\"color:#008000\">" + decimalFormat.format(calcPoc(childs)) + "</h7>");
							}
						}
						else {		// si sumInitWorkload != 0 && (sumInitWorkload - sumActualWorkload) < 0, activite hors delais
							html.append("<div class=\"ui-corner-all wGroupsLate\">"+ code + StringPool.NBSP+child.getName().replace(StringPool.SPACE, StringPool.NBSP));
							if (showPoc) {
								html.append("<br><h7 style=\"color:#ff0000\">" + decimalFormat.format(calcPoc(childs)) + "</h7>");
							}
						}
					}
					
					html.append(StringPool.END_DIV);
				}
			}
			if (!childs.isEmpty()) {
				html.append("<ul>");
				html = generateWBS(childs, html, sublevel, showPoc);
				html.append("</ul>");
			}
			html.append("</li>");
			if (level == 0) { html.append("</ul></td>"); }
		}
		return html;
	}

	private double calcPoc(List<Wbsnode> childs) throws Exception {
		
		double poc = 0;
		
		for (Wbsnode child : childs) {
			
			List<Wbsnode> childsForChild = WBSNodeLogic.findChildsWbsnode(child);
			
			if (child.getIsControlAccount()) {
				Set<Projectactivity> activitys = child.getProjectactivities();
				for (Projectactivity activity: activitys) {
					poc += (activity.getPoc() == null?0:activity.getPoc())/100;
				}
			}
			else if (!childsForChild.isEmpty()) {
				poc += calcPoc(childsForChild);
			}
		}
		
		if (!childs.isEmpty()) { poc = poc / childs.size(); }
		
		return poc;
	}
	
	/**
	 * @author Cedric Ndanga
	 * @return sum of init Workload of group activities or only activity
	 * user story 40
	 */
	public double sumOfInitWorkload(Wbsnode child) throws Exception {
		
		List<Wbsnode> childs = WBSNodeLogic.findChildsWbsnode(child);
		Set<Projectactivity> activities = null;
		double sum = 0;
		
		if(child != null) {
			activities = child.getProjectactivities();
			for (Projectactivity activity : activities) {
				sum = sum + (activity.getInitWorkload() != null?activity.getInitWorkload():0);
			}
		}
		
		if(!childs.isEmpty()) {
			
			for (Wbsnode wbsnode : childs) {
				if(wbsnode.getIsControlAccount()) {
					activities = wbsnode.getProjectactivities();
					for (Projectactivity activity : activities) {
						sum = sum + (activity.getInitWorkload() != null?activity.getInitWorkload():0);
					}
				}
				else {
					sum = sum + sumOfInitWorkload(wbsnode);
				}
			}
		}
		
		return sum;
	}
	
	/**
	 * @author Cedric Ndanga
	 * @return sum of current Workload of group activities or only activity
	 * user story 40
	 */
	public double sumOfCurrentWorkload(Wbsnode child) throws Exception {
		
		List<Wbsnode> childs = WBSNodeLogic.findChildsWbsnode(child);
		Set<Projectactivity> activities = null;
		double sum = 0;
		
		if(child != null) {
			activities = child.getProjectactivities();
			for (Projectactivity activity : activities) {
				sum = sum + TeamMemberLogic.workloadInDaysByActivity(activity);
			}
		}
		
		if(!childs.isEmpty()) {
			
			for (Wbsnode wbsnode : childs) {
				if(wbsnode.getIsControlAccount()) {
					activities = wbsnode.getProjectactivities();
					for (Projectactivity activity : activities) {
						sum = sum + TeamMemberLogic.workloadInDaysByActivity(activity);
					}
				}
				else {
					sum = sum + sumOfCurrentWorkload(wbsnode);
				}
			}
		}
		
		return sum;
	}
	
	public void setGlobalPoc(double globalPoc) {
		this.globalPoc = globalPoc;
	}

	public double getGlobalPoc() {
		return globalPoc;
	}

}
