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
package es.sm2.openppm.model;

import java.util.Date;

import es.sm2.openppm.logic.EmployeeLogic;
import es.sm2.openppm.model.base.BaseEmployee;



/**
 * Model class Employee.
 * @author Hibernate Generator by Javier Hernandez
 */
public class Employee extends BaseEmployee {

	private static final long serialVersionUID = 1L;

    public Employee() {
		super();
    }
    public Employee(Integer idEmployee) {
		super(idEmployee);
    }

    public double getFte(Date dateIn, Date dateOut) throws Exception {
		double fte = EmployeeLogic.calculateFTE(this, dateIn, dateOut);
		return fte;
	}
}

