/**
 * Generated 29 juin 2015 11:53:59 by Hibernate Tools 4.0.0
 * Openppm versius Devoteam
 * @author : Xavier De Langautier, Cedric Ndanga Wandji
 */

package es.sm2.openppm.model.base;


import es.sm2.openppm.model.* ;

import java.util.Date;

/**
 * Purchaseorder.
*/
public class BasePurchaseorder  implements java.io.Serializable {
	
	public static final String ENTITY = "Purchaseorder";
	public static final String NAME = "purchaseName";
	
	private static final long serialVersionUID = 1L;
	private Integer idPurchase;
	private String purchaseRef;
    private String purchaseName;
    private Double purchaseCost;
    private Date receptionDate;
    private Customer customer;

    public BasePurchaseorder() {		
    }

    public Integer getIdPurchase() {
        return this.idPurchase;
    }
    
    public void setIdPurchase(Integer idPurchase) {
        this.idPurchase = idPurchase;
    }
    
    public String getPurchaseRef() {
        return this.purchaseRef;
    }
    
    public void setPurchaseRef(String purchaseRef) {
        this.purchaseRef = purchaseRef;
    }
    public String getPurchaseName() {
        return this.purchaseName;
    }
    
    public void setPurchaseName(String purchaseName) {
        this.purchaseName = purchaseName;
    }
    public Double getPurchaseCost() {
        return this.purchaseCost;
    }
    
    public void setPurchaseCost(Double purchaseCost) {
        this.purchaseCost = purchaseCost;
    }
    public Date getReceptionDate() {
        return this.receptionDate;
    }
    
    public void setReceptionDate(Date receptionDate) {
        this.receptionDate = receptionDate;
    }
    public Customer getCustomer() {
        return this.customer;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

   /**
     * toString
     * @return String
     */
   public String toString() {
		 
	   StringBuffer buffer = new StringBuffer();
	
	   buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [");
	   buffer.append("]");
	  
	   return buffer.toString();
   }

   public boolean equals(Object other) {
	   
	   if ( (this == other ) ) return true;
	   if ( (other == null ) ) return false;
	   if ( !(other instanceof Purchaseorder) ) return false;
	   Purchaseorder castOther = ( Purchaseorder ) other; 
	   return false;
   }
   
   public int hashCode() {
	   
	   int result = 17;
	   return result;
   }   



}
