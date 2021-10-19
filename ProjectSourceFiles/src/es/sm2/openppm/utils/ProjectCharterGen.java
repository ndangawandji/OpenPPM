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
package es.sm2.openppm.utils;

import java.io.File;
import java.util.HashMap;

import org.docx4j.openpackaging.packages.WordprocessingMLPackage;


public class ProjectCharterGen {

	/**
	 * 
	 * @param templateFilename
	 * @param outputFilename
	 * @param paramsHeader
	 * @param paramsDoc
	 * @throws Exception
	 */
	public File generateFromTemplate (String templateFilename,
									  String outputFilename, 
									  HashMap<String,String> headerParams, 
									  HashMap<String,String> docParams )
	throws Exception {
		
		WordprocessingMLPackage wordMLPackage = DocxUtil.loadPackageFromFile(templateFilename);

		// HEADER
		//
		if (headerParams.size() > 0) {
			DocxUtil.replaceHeaderFields(wordMLPackage, headerParams);
		}

		// DOCUMENT
		//
		DocxUtil.replaceDocumentFields(wordMLPackage, docParams);

		// SAVE THE NEW DOCUMENT
        //
		File outputFile = new File(outputFilename);
		
		wordMLPackage.save (outputFile);
		
		return outputFile;
	}
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
           
		String inputfilepath = "src/es/sm2/openppm/templates/project_charter_reverso_template_talaia.docx";

		String outputfilepath = "project_charter_reverso_IBEROSTAR.docx";
		
		ProjectCharterGen gen = new ProjectCharterGen();
		
		HashMap<String,String> headerParams = new HashMap<String,String>();
		headerParams.put("POName", "Innovación y Sistemas");
		
		HashMap<String,String> docParams = new HashMap<String,String>();
		docParams.put("ProjectName",		"Implantación de Talaia en IBEROSTAR");
		docParams.put("BudgetYear",			"N/A");
		docParams.put("ProjectNumber",		"IS-SF-099");
		docParams.put("ProjectManagerName",	"Luis Devis");
		docParams.put("ProgramName",		"Innovación y Sistemas");
		docParams.put("SponsorName",		"Innovación y Sistemas");
		docParams.put("Customer",			"Innovación y Sistemas");
		
		docParams.put("ProjectDescription",	"Implantación de Talaia en el departamento de Innovación y Sistemas.");
		
		
		gen.generateFromTemplate(inputfilepath, outputfilepath, headerParams, docParams);
		
/*
		// CONVERT TO PDF
		//
		System.out.println("Converting to pdf");
		
		wordMLPackage.setFontMapper(new IdentityPlusMapper());         

		org.docx4j.convert.out.pdf.PdfConversion c = 
			new org.docx4j.convert.out.pdf.viaXSLFO.Conversion(wordMLPackage);
	      
		OutputStream os = new java.io.FileOutputStream(inputfilepath + ".pdf");                 
		c.output(os);
		System.out.println("Saved " + inputfilepath + ".pdf");
*/
		System.out.println("..done");
	}
}
