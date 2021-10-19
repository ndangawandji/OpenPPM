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
package es.sm2.openppm.model.base;
import es.sm2.openppm.model.*;


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

 /**
 * Base Pojo object for domain model class Project
 * @see es.sm2.openppm.model.base.Project
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Project
 */
public class BaseProject  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "project";
	
	public static final String IDPROJECT = "idProject";
	public static final String FUNDINGSOURCE = "fundingsource";
	public static final String GEOGRAPHY = "geography";
	public static final String EMPLOYEEBYINVESTMENTMANAGER = "employeeByInvestmentManager";
	public static final String PERFORMINGORG = "performingorg";
	public static final String PROGRAM = "program";
	public static final String PROJECTCALENDAR = "projectcalendar";
	public static final String CUSTOMER = "customer";
	public static final String CATEGORY = "category";
	public static final String EMPLOYEEBYFUNCTIONALMANAGER = "employeeByFunctionalManager";
	public static final String EMPLOYEEBYSPONSOR = "employeeBySponsor";
	public static final String EMPLOYEEBYPROJECTMANAGER = "employeeByProjectManager";
	public static final String CONTRACTTYPE = "contracttype";
	public static final String PROJECTNAME = "projectName";
	public static final String STATUS = "status";
	public static final String RISK = "risk";
	public static final String PRIORITY = "priority";
	public static final String BAC = "bac";
	public static final String NETINCOME = "netIncome";
	public static final String TCV = "tcv";
	public static final String INITDATE = "initDate";
	public static final String ENDDATE = "endDate";
	public static final String DURATION = "duration";
	public static final String EFFORT = "effort";
	public static final String PLANNEDFINISHDATE = "plannedFinishDate";
	public static final String PLANDATE = "planDate";
	public static final String EXECDATE = "execDate";
	public static final String PLANNEDINITDATE = "plannedInitDate";
	public static final String CLOSECOMMENTS = "closeComments";
	public static final String CLOSESTAKEHOLDERCOMMENTS = "closeStakeholderComments";
	public static final String CLOSEURLLESSONS = "closeUrlLessons";
	public static final String CLOSELESSONS = "closeLessons";
	public static final String INTERNALPROJECT = "internalProject";
	public static final String PROJECTDOC = "projectDoc";
	public static final String BUDGETYEAR = "budgetYear";
	public static final String CHARTLABEL = "chartLabel";
	public static final String PROBABILITY = "probability";
	public static final String ISGEOSELLING = "isGeoSelling";
	public static final String INVESTMENTSTATUS = "investmentStatus";
	public static final String SENDED = "sended";
	public static final String NUMCOMPETITORS = "numCompetitors";
	public static final String FINALPOSITION = "finalPosition";
	public static final String CLIENTCOMMENTS = "clientComments";
	public static final String CANCELEDCOMMENTS = "canceledComments";
	public static final String COMMENTS = "comments";
	public static final String LINKDOC = "linkDoc";
	public static final String ACCOUNTINGCODE = "accountingCode";
	public static final String STATUSDATE = "statusDate";
	public static final String LOWERTHRESHOLD = "lowerThreshold";
	public static final String UPPERTHRESHOLD = "upperThreshold";
	public static final String LINKCOMMENT = "linkComment";
	public static final String SCOPESTATEMENT = "scopeStatement";
	public static final String HDDESCRIPTION = "hdDescription";
	public static final String LOGPROJECTSTATUSES = "logprojectstatuses";
	public static final String PROCUREMENTPAYMENTSES = "procurementpaymentses";
	public static final String PROJECTCHARTERS = "projectcharters";
	public static final String DOCUMENTPROJECTS = "documentprojects";
	public static final String INCOMESES = "incomeses";
	public static final String PROJECTCOSTSES = "projectcostses";
	public static final String ISSUELOGS = "issuelogs";
	public static final String CHANGECONTROLS = "changecontrols";
	public static final String ASSUMPTIONREGISTERS = "assumptionregisters";
	public static final String PROJECTACTIVITIES = "projectactivities";
	public static final String STAKEHOLDERS = "stakeholders";
	public static final String EXPENSESHEETS = "expensesheets";
	public static final String PROJECTFOLLOWUPS = "projectfollowups";
	public static final String WBSNODES = "wbsnodes";
	public static final String PROJECTKPIS = "projectkpis";
	public static final String WORKINGCOSTSES = "workingcostses";
	public static final String RISKREGISTERS = "riskregisters";
	public static final String PROJECTCLOSURES = "projectclosures";
	public static final String CHARGESCOSTSES = "chargescostses";
	public static final String MILESTONESES = "milestoneses";
	public static final String PROJECTASSOCIATIONSFORDEPENDENT = "projectassociationsForDependent";
	public static final String PROJECTASSOCIATIONSFORLEAD = "projectassociationsForLead";

     private Integer idProject;
     private Fundingsource fundingsource;
     private Geography geography;
     private Employee employeeByInvestmentManager;
     private Performingorg performingorg;
     private Program program;
     private Projectcalendar projectcalendar;
     private Customer customer;
     private Category category;
     private Employee employeeByFunctionalManager;
     private Employee employeeBySponsor;
     private Employee employeeByProjectManager;
     private Contracttype contracttype;
     private String projectName;
     private Character status;
     private Character risk;
     private Integer priority;
     private Double bac;
     private Double netIncome;
     private Double tcv;
     private Date initDate;
     private Date endDate;
     private Integer duration;
     private Integer effort;
     private Date plannedFinishDate;
     private Date planDate;
     private Date execDate;
     private Date plannedInitDate;
     private String closeComments;
     private String closeStakeholderComments;
     private String closeUrlLessons;
     private String closeLessons;
     private Boolean internalProject;
     private String projectDoc;
     private Integer budgetYear;
     private String chartLabel;
     private Integer probability;
     private Boolean isGeoSelling;
     private Character investmentStatus;
     private Boolean sended;
     private Integer numCompetitors;
     private Integer finalPosition;
     private String clientComments;
     private String canceledComments;
     private String comments;
     private String linkDoc;
     private String accountingCode;
     private Date statusDate;
     private Integer lowerThreshold;
     private Integer upperThreshold;
     private String linkComment;
     private String scopeStatement;
     private String hdDescription;
     private Set<Logprojectstatus> logprojectstatuses = new HashSet<Logprojectstatus>(0);
     private Set<Procurementpayments> procurementpaymentses = new HashSet<Procurementpayments>(0);
     private Set<Projectcharter> projectcharters = new HashSet<Projectcharter>(0);
     private Set<Documentproject> documentprojects = new HashSet<Documentproject>(0);
     private Set<Incomes> incomeses = new HashSet<Incomes>(0);
     private Set<Projectcosts> projectcostses = new HashSet<Projectcosts>(0);
     private Set<Issuelog> issuelogs = new HashSet<Issuelog>(0);
     private Set<Changecontrol> changecontrols = new HashSet<Changecontrol>(0);
     private Set<Assumptionregister> assumptionregisters = new HashSet<Assumptionregister>(0);
     private Set<Projectactivity> projectactivities = new HashSet<Projectactivity>(0);
     private Set<Stakeholder> stakeholders = new HashSet<Stakeholder>(0);
     private Set<Expensesheet> expensesheets = new HashSet<Expensesheet>(0);
     private Set<Projectfollowup> projectfollowups = new HashSet<Projectfollowup>(0);
     private Set<Wbsnode> wbsnodes = new HashSet<Wbsnode>(0);
     private Set<Projectkpi> projectkpis = new HashSet<Projectkpi>(0);
     private Set<Workingcosts> workingcostses = new HashSet<Workingcosts>(0);
     private Set<Riskregister> riskregisters = new HashSet<Riskregister>(0);
     private Set<Projectclosure> projectclosures = new HashSet<Projectclosure>(0);
     private Set<Chargescosts> chargescostses = new HashSet<Chargescosts>(0);
     private Set<Milestones> milestoneses = new HashSet<Milestones>(0);
     private Set<Projectassociation> projectassociationsForDependent = new HashSet<Projectassociation>(0);
     private Set<Projectassociation> projectassociationsForLead = new HashSet<Projectassociation>(0);

    public BaseProject() {
    }
    
    public BaseProject(Integer idProject) {
    	this.idProject = idProject;
    }
   
    public Integer getIdProject() {
        return this.idProject;
    }
    
    public void setIdProject(Integer idProject) {
        this.idProject = idProject;
    }
    public Fundingsource getFundingsource() {
        return this.fundingsource;
    }
    
    public void setFundingsource(Fundingsource fundingsource) {
        this.fundingsource = fundingsource;
    }
    public Geography getGeography() {
        return this.geography;
    }
    
    public void setGeography(Geography geography) {
        this.geography = geography;
    }
    public Employee getEmployeeByInvestmentManager() {
        return this.employeeByInvestmentManager;
    }
    
    public void setEmployeeByInvestmentManager(Employee employeeByInvestmentManager) {
        this.employeeByInvestmentManager = employeeByInvestmentManager;
    }
    public Performingorg getPerformingorg() {
        return this.performingorg;
    }
    
    public void setPerformingorg(Performingorg performingorg) {
        this.performingorg = performingorg;
    }
    public Program getProgram() {
        return this.program;
    }
    
    public void setProgram(Program program) {
        this.program = program;
    }
    public Projectcalendar getProjectcalendar() {
        return this.projectcalendar;
    }
    
    public void setProjectcalendar(Projectcalendar projectcalendar) {
        this.projectcalendar = projectcalendar;
    }
    public Customer getCustomer() {
        return this.customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
    public Category getCategory() {
        return this.category;
    }
    
    public void setCategory(Category category) {
        this.category = category;
    }
    public Employee getEmployeeByFunctionalManager() {
        return this.employeeByFunctionalManager;
    }
    
    public void setEmployeeByFunctionalManager(Employee employeeByFunctionalManager) {
        this.employeeByFunctionalManager = employeeByFunctionalManager;
    }
    public Employee getEmployeeBySponsor() {
        return this.employeeBySponsor;
    }
    
    public void setEmployeeBySponsor(Employee employeeBySponsor) {
        this.employeeBySponsor = employeeBySponsor;
    }
    public Employee getEmployeeByProjectManager() {
        return this.employeeByProjectManager;
    }
    
    public void setEmployeeByProjectManager(Employee employeeByProjectManager) {
        this.employeeByProjectManager = employeeByProjectManager;
    }
    public Contracttype getContracttype() {
        return this.contracttype;
    }
    
    public void setContracttype(Contracttype contracttype) {
        this.contracttype = contracttype;
    }
    public String getProjectName() {
        return this.projectName;
    }
    
    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }
    public Character getStatus() {
        return this.status;
    }
    
    public void setStatus(Character status) {
        this.status = status;
    }
    public Character getRisk() {
        return this.risk;
    }
    
    public void setRisk(Character risk) {
        this.risk = risk;
    }
    public Integer getPriority() {
        return this.priority;
    }
    
    public void setPriority(Integer priority) {
        this.priority = priority;
    }
    public Double getBac() {
        return this.bac;
    }
    
    public void setBac(Double bac) {
        this.bac = bac;
    }
    public Double getNetIncome() {
        return this.netIncome;
    }
    
    public void setNetIncome(Double netIncome) {
        this.netIncome = netIncome;
    }
    public Double getTcv() {
        return this.tcv;
    }
    
    public void setTcv(Double tcv) {
        this.tcv = tcv;
    }
    public Date getInitDate() {
        return this.initDate;
    }
    
    public void setInitDate(Date initDate) {
        this.initDate = initDate;
    }
    public Date getEndDate() {
        return this.endDate;
    }
    
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public Integer getDuration() {
        return this.duration;
    }
    
    public void setDuration(Integer duration) {
        this.duration = duration;
    }
    public Integer getEffort() {
        return this.effort;
    }
    
    public void setEffort(Integer effort) {
        this.effort = effort;
    }
    public Date getPlannedFinishDate() {
        return this.plannedFinishDate;
    }
    
    public void setPlannedFinishDate(Date plannedFinishDate) {
        this.plannedFinishDate = plannedFinishDate;
    }
    public Date getPlanDate() {
        return this.planDate;
    }
    
    public void setPlanDate(Date planDate) {
        this.planDate = planDate;
    }
    public Date getExecDate() {
        return this.execDate;
    }
    
    public void setExecDate(Date execDate) {
        this.execDate = execDate;
    }
    public Date getPlannedInitDate() {
        return this.plannedInitDate;
    }
    
    public void setPlannedInitDate(Date plannedInitDate) {
        this.plannedInitDate = plannedInitDate;
    }
    public String getCloseComments() {
        return this.closeComments;
    }
    
    public void setCloseComments(String closeComments) {
        this.closeComments = closeComments;
    }
    public String getCloseStakeholderComments() {
        return this.closeStakeholderComments;
    }
    
    public void setCloseStakeholderComments(String closeStakeholderComments) {
        this.closeStakeholderComments = closeStakeholderComments;
    }
    public String getCloseUrlLessons() {
        return this.closeUrlLessons;
    }
    
    public void setCloseUrlLessons(String closeUrlLessons) {
        this.closeUrlLessons = closeUrlLessons;
    }
    public String getCloseLessons() {
        return this.closeLessons;
    }
    
    public void setCloseLessons(String closeLessons) {
        this.closeLessons = closeLessons;
    }
    public Boolean getInternalProject() {
        return this.internalProject;
    }
    
    public void setInternalProject(Boolean internalProject) {
        this.internalProject = internalProject;
    }
    public String getProjectDoc() {
        return this.projectDoc;
    }
    
    public void setProjectDoc(String projectDoc) {
        this.projectDoc = projectDoc;
    }
    public Integer getBudgetYear() {
        return this.budgetYear;
    }
    
    public void setBudgetYear(Integer budgetYear) {
        this.budgetYear = budgetYear;
    }
    public String getChartLabel() {
        return this.chartLabel;
    }
    
    public void setChartLabel(String chartLabel) {
        this.chartLabel = chartLabel;
    }
    public Integer getProbability() {
        return this.probability;
    }
    
    public void setProbability(Integer probability) {
        this.probability = probability;
    }
    public Boolean getIsGeoSelling() {
        return this.isGeoSelling;
    }
    
    public void setIsGeoSelling(Boolean isGeoSelling) {
        this.isGeoSelling = isGeoSelling;
    }
    public Character getInvestmentStatus() {
        return this.investmentStatus;
    }
    
    public void setInvestmentStatus(Character investmentStatus) {
        this.investmentStatus = investmentStatus;
    }
    public Boolean getSended() {
        return this.sended;
    }
    
    public void setSended(Boolean sended) {
        this.sended = sended;
    }
    public Integer getNumCompetitors() {
        return this.numCompetitors;
    }
    
    public void setNumCompetitors(Integer numCompetitors) {
        this.numCompetitors = numCompetitors;
    }
    public Integer getFinalPosition() {
        return this.finalPosition;
    }
    
    public void setFinalPosition(Integer finalPosition) {
        this.finalPosition = finalPosition;
    }
    public String getClientComments() {
        return this.clientComments;
    }
    
    public void setClientComments(String clientComments) {
        this.clientComments = clientComments;
    }
    public String getCanceledComments() {
        return this.canceledComments;
    }
    
    public void setCanceledComments(String canceledComments) {
        this.canceledComments = canceledComments;
    }
    public String getComments() {
        return this.comments;
    }
    
    public void setComments(String comments) {
        this.comments = comments;
    }
    public String getLinkDoc() {
        return this.linkDoc;
    }
    
    public void setLinkDoc(String linkDoc) {
        this.linkDoc = linkDoc;
    }
    public String getAccountingCode() {
        return this.accountingCode;
    }
    
    public void setAccountingCode(String accountingCode) {
        this.accountingCode = accountingCode;
    }
    public Date getStatusDate() {
        return this.statusDate;
    }
    
    public void setStatusDate(Date statusDate) {
        this.statusDate = statusDate;
    }
    public Integer getLowerThreshold() {
        return this.lowerThreshold;
    }
    
    public void setLowerThreshold(Integer lowerThreshold) {
        this.lowerThreshold = lowerThreshold;
    }
    public Integer getUpperThreshold() {
        return this.upperThreshold;
    }
    
    public void setUpperThreshold(Integer upperThreshold) {
        this.upperThreshold = upperThreshold;
    }
    public String getLinkComment() {
        return this.linkComment;
    }
    
    public void setLinkComment(String linkComment) {
        this.linkComment = linkComment;
    }
    public String getScopeStatement() {
        return this.scopeStatement;
    }
    
    public void setScopeStatement(String scopeStatement) {
        this.scopeStatement = scopeStatement;
    }
    public String getHdDescription() {
        return this.hdDescription;
    }
    
    public void setHdDescription(String hdDescription) {
        this.hdDescription = hdDescription;
    }
    public Set<Logprojectstatus> getLogprojectstatuses() {
        return this.logprojectstatuses;
    }
    
    public void setLogprojectstatuses(Set<Logprojectstatus> logprojectstatuses) {
        this.logprojectstatuses = logprojectstatuses;
    }
    public Set<Procurementpayments> getProcurementpaymentses() {
        return this.procurementpaymentses;
    }
    
    public void setProcurementpaymentses(Set<Procurementpayments> procurementpaymentses) {
        this.procurementpaymentses = procurementpaymentses;
    }
    public Set<Projectcharter> getProjectcharters() {
        return this.projectcharters;
    }
    
    public void setProjectcharters(Set<Projectcharter> projectcharters) {
        this.projectcharters = projectcharters;
    }
    public Set<Documentproject> getDocumentprojects() {
        return this.documentprojects;
    }
    
    public void setDocumentprojects(Set<Documentproject> documentprojects) {
        this.documentprojects = documentprojects;
    }
    public Set<Incomes> getIncomeses() {
        return this.incomeses;
    }
    
    public void setIncomeses(Set<Incomes> incomeses) {
        this.incomeses = incomeses;
    }
    public Set<Projectcosts> getProjectcostses() {
        return this.projectcostses;
    }
    
    public void setProjectcostses(Set<Projectcosts> projectcostses) {
        this.projectcostses = projectcostses;
    }
    public Set<Issuelog> getIssuelogs() {
        return this.issuelogs;
    }
    
    public void setIssuelogs(Set<Issuelog> issuelogs) {
        this.issuelogs = issuelogs;
    }
    public Set<Changecontrol> getChangecontrols() {
        return this.changecontrols;
    }
    
    public void setChangecontrols(Set<Changecontrol> changecontrols) {
        this.changecontrols = changecontrols;
    }
    public Set<Assumptionregister> getAssumptionregisters() {
        return this.assumptionregisters;
    }
    
    public void setAssumptionregisters(Set<Assumptionregister> assumptionregisters) {
        this.assumptionregisters = assumptionregisters;
    }
    public Set<Projectactivity> getProjectactivities() {
        return this.projectactivities;
    }
    
    public void setProjectactivities(Set<Projectactivity> projectactivities) {
        this.projectactivities = projectactivities;
    }
    public Set<Stakeholder> getStakeholders() {
        return this.stakeholders;
    }
    
    public void setStakeholders(Set<Stakeholder> stakeholders) {
        this.stakeholders = stakeholders;
    }
    public Set<Expensesheet> getExpensesheets() {
        return this.expensesheets;
    }
    
    public void setExpensesheets(Set<Expensesheet> expensesheets) {
        this.expensesheets = expensesheets;
    }
    public Set<Projectfollowup> getProjectfollowups() {
        return this.projectfollowups;
    }
    
    public void setProjectfollowups(Set<Projectfollowup> projectfollowups) {
        this.projectfollowups = projectfollowups;
    }
    public Set<Wbsnode> getWbsnodes() {
        return this.wbsnodes;
    }
    
    public void setWbsnodes(Set<Wbsnode> wbsnodes) {
        this.wbsnodes = wbsnodes;
    }
    public Set<Projectkpi> getProjectkpis() {
        return this.projectkpis;
    }
    
    public void setProjectkpis(Set<Projectkpi> projectkpis) {
        this.projectkpis = projectkpis;
    }
    public Set<Workingcosts> getWorkingcostses() {
        return this.workingcostses;
    }
    
    public void setWorkingcostses(Set<Workingcosts> workingcostses) {
        this.workingcostses = workingcostses;
    }
    public Set<Riskregister> getRiskregisters() {
        return this.riskregisters;
    }
    
    public void setRiskregisters(Set<Riskregister> riskregisters) {
        this.riskregisters = riskregisters;
    }
    public Set<Projectclosure> getProjectclosures() {
        return this.projectclosures;
    }
    
    public void setProjectclosures(Set<Projectclosure> projectclosures) {
        this.projectclosures = projectclosures;
    }
    public Set<Chargescosts> getChargescostses() {
        return this.chargescostses;
    }
    
    public void setChargescostses(Set<Chargescosts> chargescostses) {
        this.chargescostses = chargescostses;
    }
    public Set<Milestones> getMilestoneses() {
        return this.milestoneses;
    }
    
    public void setMilestoneses(Set<Milestones> milestoneses) {
        this.milestoneses = milestoneses;
    }
    public Set<Projectassociation> getProjectassociationsForDependent() {
        return this.projectassociationsForDependent;
    }
    
    public void setProjectassociationsForDependent(Set<Projectassociation> projectassociationsForDependent) {
        this.projectassociationsForDependent = projectassociationsForDependent;
    }
    public Set<Projectassociation> getProjectassociationsForLead() {
        return this.projectassociationsForLead;
    }
    
    public void setProjectassociationsForLead(Set<Projectassociation> projectassociationsForLead) {
        this.projectassociationsForLead = projectassociationsForLead;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idProject").append("='").append(getIdProject()).append("' \n");	
		buffer.append("fundingsource").append("='").append(getFundingsource()).append("' \n");	
		buffer.append("geography").append("='").append(getGeography()).append("' \n");	
		buffer.append("employeeByInvestmentManager").append("='").append(getEmployeeByInvestmentManager()).append("' \n");	
		buffer.append("performingorg").append("='").append(getPerformingorg()).append("' \n");	
		buffer.append("program").append("='").append(getProgram()).append("' \n");	
		buffer.append("projectcalendar").append("='").append(getProjectcalendar()).append("' \n");	
		buffer.append("customer").append("='").append(getCustomer()).append("' \n");	
		buffer.append("category").append("='").append(getCategory()).append("' \n");	
		buffer.append("employeeByFunctionalManager").append("='").append(getEmployeeByFunctionalManager()).append("' \n");	
		buffer.append("employeeBySponsor").append("='").append(getEmployeeBySponsor()).append("' \n");	
		buffer.append("employeeByProjectManager").append("='").append(getEmployeeByProjectManager()).append("' \n");	
		buffer.append("contracttype").append("='").append(getContracttype()).append("' \n");	
		buffer.append("projectName").append("='").append(getProjectName()).append("' \n");	
		buffer.append("status").append("='").append(getStatus()).append("' \n");	
		buffer.append("risk").append("='").append(getRisk()).append("' \n");	
		buffer.append("priority").append("='").append(getPriority()).append("' \n");	
		buffer.append("bac").append("='").append(getBac()).append("' \n");	
		buffer.append("netIncome").append("='").append(getNetIncome()).append("' \n");	
		buffer.append("tcv").append("='").append(getTcv()).append("' \n");	
		buffer.append("initDate").append("='").append(getInitDate()).append("' \n");	
		buffer.append("endDate").append("='").append(getEndDate()).append("' \n");	
		buffer.append("duration").append("='").append(getDuration()).append("' \n");	
		buffer.append("effort").append("='").append(getEffort()).append("' \n");	
		buffer.append("plannedFinishDate").append("='").append(getPlannedFinishDate()).append("' \n");	
		buffer.append("planDate").append("='").append(getPlanDate()).append("' \n");	
		buffer.append("execDate").append("='").append(getExecDate()).append("' \n");	
		buffer.append("plannedInitDate").append("='").append(getPlannedInitDate()).append("' \n");	
		buffer.append("closeComments").append("='").append(getCloseComments()).append("' \n");	
		buffer.append("closeStakeholderComments").append("='").append(getCloseStakeholderComments()).append("' \n");	
		buffer.append("closeUrlLessons").append("='").append(getCloseUrlLessons()).append("' \n");	
		buffer.append("closeLessons").append("='").append(getCloseLessons()).append("' \n");	
		buffer.append("internalProject").append("='").append(getInternalProject()).append("' \n");	
		buffer.append("projectDoc").append("='").append(getProjectDoc()).append("' \n");	
		buffer.append("budgetYear").append("='").append(getBudgetYear()).append("' \n");	
		buffer.append("chartLabel").append("='").append(getChartLabel()).append("' \n");	
		buffer.append("probability").append("='").append(getProbability()).append("' \n");	
		buffer.append("isGeoSelling").append("='").append(getIsGeoSelling()).append("' \n");	
		buffer.append("investmentStatus").append("='").append(getInvestmentStatus()).append("' \n");	
		buffer.append("sended").append("='").append(getSended()).append("' \n");	
		buffer.append("numCompetitors").append("='").append(getNumCompetitors()).append("' \n");	
		buffer.append("finalPosition").append("='").append(getFinalPosition()).append("' \n");	
		buffer.append("clientComments").append("='").append(getClientComments()).append("' \n");	
		buffer.append("canceledComments").append("='").append(getCanceledComments()).append("' \n");	
		buffer.append("comments").append("='").append(getComments()).append("' \n");	
		buffer.append("linkDoc").append("='").append(getLinkDoc()).append("' \n");	
		buffer.append("accountingCode").append("='").append(getAccountingCode()).append("' \n");	
		buffer.append("statusDate").append("='").append(getStatusDate()).append("' \n");	
		buffer.append("lowerThreshold").append("='").append(getLowerThreshold()).append("' \n");	
		buffer.append("upperThreshold").append("='").append(getUpperThreshold()).append("' \n");	
		buffer.append("linkComment").append("='").append(getLinkComment()).append("' \n");	
		buffer.append("scopeStatement").append("='").append(getScopeStatement()).append("' \n");	
		buffer.append("hdDescription").append("='").append(getHdDescription()).append("' \n");	
		buffer.append("logprojectstatuses").append("='").append(getLogprojectstatuses()).append("' \n");	
		buffer.append("procurementpaymentses").append("='").append(getProcurementpaymentses()).append("' \n");	
		buffer.append("projectcharters").append("='").append(getProjectcharters()).append("' \n");	
		buffer.append("documentprojects").append("='").append(getDocumentprojects()).append("' \n");	
		buffer.append("incomeses").append("='").append(getIncomeses()).append("' \n");	
		buffer.append("projectcostses").append("='").append(getProjectcostses()).append("' \n");	
		buffer.append("issuelogs").append("='").append(getIssuelogs()).append("' \n");	
		buffer.append("changecontrols").append("='").append(getChangecontrols()).append("' \n");	
		buffer.append("assumptionregisters").append("='").append(getAssumptionregisters()).append("' \n");	
		buffer.append("projectactivities").append("='").append(getProjectactivities()).append("' \n");	
		buffer.append("stakeholders").append("='").append(getStakeholders()).append("' \n");	
		buffer.append("expensesheets").append("='").append(getExpensesheets()).append("' \n");	
		buffer.append("projectfollowups").append("='").append(getProjectfollowups()).append("' \n");	
		buffer.append("wbsnodes").append("='").append(getWbsnodes()).append("' \n");	
		buffer.append("projectkpis").append("='").append(getProjectkpis()).append("' \n");	
		buffer.append("workingcostses").append("='").append(getWorkingcostses()).append("' \n");	
		buffer.append("riskregisters").append("='").append(getRiskregisters()).append("' \n");	
		buffer.append("projectclosures").append("='").append(getProjectclosures()).append("' \n");	
		buffer.append("chargescostses").append("='").append(getChargescostses()).append("' \n");	
		buffer.append("milestoneses").append("='").append(getMilestoneses()).append("' \n");	
		buffer.append("projectassociationsForDependent").append("='").append(getProjectassociationsForDependent()).append("' \n");	
		buffer.append("projectassociationsForLead").append("='").append(getProjectassociationsForLead()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Project) )  { result = false; }
		 else if (other != null) {
		 	Project castOther = (Project) other;
			if (castOther.getIdProject().equals(this.getIdProject())) { result = true; }
         }
		 return result;
   }


}


