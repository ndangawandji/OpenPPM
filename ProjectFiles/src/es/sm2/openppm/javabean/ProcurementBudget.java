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

public class ProcurementBudget {

	private String seller;
	private int nPayments;
	private String purchaseOrder;
	private Double plannedPayment;
	private Double actualPayment;
	
	public String getSeller() {
		return seller;
	}
	
	public void setSeller(String seller) {
		this.seller = seller;
	}
	
	public int getnPayments() {
		return nPayments;
	}
	
	public void setnPayments(int nPayments) {
		this.nPayments = nPayments;
	}
	
	public String getPurchaseOrder() {
		return purchaseOrder;
	}
	
	public void setPurchaseOrder(String purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}
	
	public Double getPlannedPayment() {
		return plannedPayment;
	}
	
	public void setPlannedPayment(Double plannedPayment) {
		this.plannedPayment = plannedPayment;
	}
	
	public Double getActualPayment() {
		return actualPayment;
	}
	
	public void setActualPayment(Double actualPayment) {
		this.actualPayment = actualPayment;
	}	
}
