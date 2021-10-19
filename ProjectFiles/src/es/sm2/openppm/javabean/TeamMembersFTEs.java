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
package es.sm2.openppm.javabean;

import java.util.List;

import es.sm2.openppm.model.Project;
import es.sm2.openppm.model.Teammember;
import es.sm2.openppm.utils.ValidateUtil;

public class TeamMembersFTEs {
	
	private Teammember member;
	private Project project;
	private double hours;
	private String projectNames; 
	
	private int[] ftes;
	
	public TeamMembersFTEs(Teammember member, Project project){
		this.member = member;
		this.project = project;
	}
	
	public TeamMembersFTEs(Teammember member){
		this.member = member;
	}
	
	/**
	 * @return the hours
	 */
	public double getHours() {
		return hours;
	}

	/**
	 * @param hours the hours to set
	 */
	public void setHours(double hours) {
		this.hours = hours;
	}
	
	/**
	 * @return the member
	 */
	public Teammember getMember() {
		return member;
	}

	/**
	 * @param member the member to set
	 */
	public void setMember(Teammember member) {
		this.member = member;
	}

	/**
	 * @return the ftes
	 */
	public int[] getFtes() {
		return ftes;
	}

	/**
	 * @param ftes the ftes to set
	 */
	public void setFtes(int[]ftes) {
		this.ftes = ftes;
	}

	/**
	 * @param project the project to set
	 */
	public void setProject(Project project) {
		this.project = project;
	}

	/**
	 * @return the project
	 */
	public Project getProject() {
		return project;
	}
	
	/**
	 * @return project names
	 */
	public String getProjectNames() {
		return projectNames;
	}

	/**
	 * @param projectNames
	 */
	public void setProjectNames(List<Project> projects) {
		
		String projectNames = "";
		
		for (Project project : projects) {
			
			if (ValidateUtil.isNull(projectNames)) { projectNames += project.getProjectName(); }
			else { projectNames += ", "+project.getProjectName(); }
		}
		this.projectNames = projectNames;
	}
}
