package test_unitaire;

import es.sm2.openppm.logic.*;
import es.sm2.openppm.model.*;
import es.sm2.openppm.model.base.*;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ContactLogic contactlogic = new ContactLogic();
		Contact  monContact = new Contact();
		
		try {
			monContact = contactlogic.consultContact(36);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//monContact.getFullName();
		System.out.println(monContact.getFullName());
		
	}

}
