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
 * Base Pojo object for domain model class Expensesheetcomment
 * @see es.sm2.openppm.model.base.Expensesheetcomment
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Expensesheetcomment
 */
public class BaseExpensesheetcomment  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "expensesheetcomment";
	
	public static final String IDEXPENSESHEETCOMMENT = "idExpenseSheetComment";
	public static final String EXPENSESHEET = "expensesheet";
	public static final String PREVIOUSSTATUS = "previousStatus";
	public static final String ACTUALSTATUS = "actualStatus";
	public static final String COMMENTDATE = "commentDate";
	public static final String CONTENTCOMMENT = "contentComment";

     private Integer idExpenseSheetComment;
     private Expensesheet expensesheet;
     private String previousStatus;
     private String actualStatus;
     private Date commentDate;
     private String contentComment;

    public BaseExpensesheetcomment() {
    }
    
    public BaseExpensesheetcomment(Integer idExpenseSheetComment) {
    	this.idExpenseSheetComment = idExpenseSheetComment;
    }
   
    public Integer getIdExpenseSheetComment() {
        return this.idExpenseSheetComment;
    }
    
    public void setIdExpenseSheetComment(Integer idExpenseSheetComment) {
        this.idExpenseSheetComment = idExpenseSheetComment;
    }
    public Expensesheet getExpensesheet() {
        return this.expensesheet;
    }
    
    public void setExpensesheet(Expensesheet expensesheet) {
        this.expensesheet = expensesheet;
    }
    public String getPreviousStatus() {
        return this.previousStatus;
    }
    
    public void setPreviousStatus(String previousStatus) {
        this.previousStatus = previousStatus;
    }
    public String getActualStatus() {
        return this.actualStatus;
    }
    
    public void setActualStatus(String actualStatus) {
        this.actualStatus = actualStatus;
    }
    public Date getCommentDate() {
        return this.commentDate;
    }
    
    public void setCommentDate(Date commentDate) {
        this.commentDate = commentDate;
    }
    public String getContentComment() {
        return this.contentComment;
    }
    
    public void setContentComment(String contentComment) {
        this.contentComment = contentComment;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idExpenseSheetComment").append("='").append(getIdExpenseSheetComment()).append("' \n");	
		buffer.append("expensesheet").append("='").append(getExpensesheet()).append("' \n");	
		buffer.append("previousStatus").append("='").append(getPreviousStatus()).append("' \n");	
		buffer.append("actualStatus").append("='").append(getActualStatus()).append("' \n");	
		buffer.append("commentDate").append("='").append(getCommentDate()).append("' \n");	
		buffer.append("contentComment").append("='").append(getContentComment()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Expensesheetcomment) )  { result = false; }
		 else if (other != null) {
		 	Expensesheetcomment castOther = (Expensesheetcomment) other;
			if (castOther.getIdExpenseSheetComment().equals(this.getIdExpenseSheetComment())) { result = true; }
         }
		 return result;
   }


}


