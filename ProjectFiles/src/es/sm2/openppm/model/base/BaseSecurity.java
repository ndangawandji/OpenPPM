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

 /**
 * Base Pojo object for domain model class Security
 * @see es.sm2.openppm.model.base.Security
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Security
 */
public class BaseSecurity  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "security";
	
	public static final String IDSEC = "idSec";
	public static final String CONTACT = "contact";
	public static final String LOGIN = "login";
	public static final String PASSWORD = "password";
	public static final String AUTORIZATIONLEVEL = "autorizationLevel";
	public static final String DATECREATION = "dateCreation";
	public static final String DATELAPSED = "dateLapsed";
	public static final String ATTEMPTS = "attempts";
	public static final String DATELASTATTEMPT = "dateLastAttempt";

     private Integer idSec;
     private Contact contact;
     private String login;
     private String password;
     private Character autorizationLevel;
     private Date dateCreation;
     private Date dateLapsed;
     private Integer attempts;
     private Date dateLastAttempt;

    public BaseSecurity() {
    }
    
    public BaseSecurity(Integer idSec) {
    	this.idSec = idSec;
    }
   
    public Integer getIdSec() {
        return this.idSec;
    }
    
    public void setIdSec(Integer idSec) {
        this.idSec = idSec;
    }
    public Contact getContact() {
        return this.contact;
    }
    
    public void setContact(Contact contact) {
        this.contact = contact;
    }
    public String getLogin() {
        return this.login;
    }
    
    public void setLogin(String login) {
        this.login = login;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    public Character getAutorizationLevel() {
        return this.autorizationLevel;
    }
    
    public void setAutorizationLevel(Character autorizationLevel) {
        this.autorizationLevel = autorizationLevel;
    }
    public Date getDateCreation() {
        return this.dateCreation;
    }
    
    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }
    public Date getDateLapsed() {
        return this.dateLapsed;
    }
    
    public void setDateLapsed(Date dateLapsed) {
        this.dateLapsed = dateLapsed;
    }
    public Integer getAttempts() {
        return this.attempts;
    }
    
    public void setAttempts(Integer attempts) {
        this.attempts = attempts;
    }
    public Date getDateLastAttempt() {
        return this.dateLastAttempt;
    }
    
    public void setDateLastAttempt(Date dateLastAttempt) {
        this.dateLastAttempt = dateLastAttempt;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idSec").append("='").append(getIdSec()).append("' \n");	
		buffer.append("contact").append("='").append(getContact()).append("' \n");	
		buffer.append("login").append("='").append(getLogin()).append("' \n");	
		buffer.append("password").append("='").append(getPassword()).append("' \n");	
		buffer.append("autorizationLevel").append("='").append(getAutorizationLevel()).append("' \n");	
		buffer.append("dateCreation").append("='").append(getDateCreation()).append("' \n");	
		buffer.append("dateLapsed").append("='").append(getDateLapsed()).append("' \n");	
		buffer.append("attempts").append("='").append(getAttempts()).append("' \n");	
		buffer.append("dateLastAttempt").append("='").append(getDateLastAttempt()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Security) )  { result = false; }
		 else if (other != null) {
		 	Security castOther = (Security) other;
			if (castOther.getIdSec().equals(this.getIdSec())) { result = true; }
         }
		 return result;
   }


}


