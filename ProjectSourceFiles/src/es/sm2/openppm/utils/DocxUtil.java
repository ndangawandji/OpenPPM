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

import java.io.FileInputStream;
import java.util.HashMap;
//import java.util.Iterator;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.docx4j.XmlUtils;
import org.docx4j.jaxb.Context;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.wml.Document;
import org.docx4j.wml.Hdr;

/**
 * Utility class for docx documents 
 * 
 * @author daniel.casas
 *
 */
public class DocxUtil {

	
	/**
	 * 
	 * @param wordMLPackage
	 * @param params
	 * @return
	 * @throws JAXBException
	 */
	public static WordprocessingMLPackage replaceHeaderFields (
			WordprocessingMLPackage wordMLPackage, HashMap<String,String> params) 
	throws JAXBException {
		
		try {
			Hdr header = wordMLPackage.getDocumentModel().getSections().get(0).getHeaderFooterPolicy().getDefaultHeader().getJaxbElement();
			
			String hdrStr = XmlUtils.marshaltoString (header, true, true);
	
			header = (Hdr)XmlUtils.unmarshallFromTemplate(hdrStr, params);
			
			wordMLPackage.getDocumentModel().getSections().get(0).getHeaderFooterPolicy().getDefaultHeader().setJaxbElement(header);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
			
		return wordMLPackage;
	}
	

	/**
	 * 
	 * @param wordMLPackage
	 * @param params
	 * @return
	 * @throws JAXBException
	 */
	public static WordprocessingMLPackage replaceDocumentFields (
			WordprocessingMLPackage wordMLPackage, HashMap<String,String> params) 
	throws JAXBException {
	
		try {
			Document document = wordMLPackage.getMainDocumentPart().getJaxbElement();
			
			String docStr = XmlUtils.marshaltoString (document, true, true);
/*
			for (Iterator it=params.keySet().iterator(); it.hasNext(); ) {
				String key = (String)it.next();
				String value = params.get(key);
				System.out.println (key + "@" + value);
			}
*/
			document = (Document)XmlUtils.unmarshallFromTemplate (docStr, params);
			
			wordMLPackage.getMainDocumentPart().setJaxbElement(document);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
			
		return wordMLPackage;
	}
	

	/**
	 * 
	 * @param templateFilename
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	public static WordprocessingMLPackage loadPackageFromFile (String templateFilename) 
	throws Exception {
		
		// Load the Package
		WordprocessingMLPackage wordMLPackage;
		if (templateFilename.endsWith(".xml")) {
                   
			JAXBContext jc = Context.jcXmlPackage;
			Unmarshaller u = jc.createUnmarshaller();
			u.setEventHandler(new org.docx4j.jaxb.JaxbValidationEventHandler());

			org.docx4j.xmlPackage.Package wmlPackageEl = (org.docx4j.xmlPackage.Package)((JAXBElement)u.unmarshal(
					new javax.xml.transform.stream.StreamSource(new FileInputStream(templateFilename)))).getValue();

			org.docx4j.convert.in.FlatOpcXmlImporter xmlPackage = new org.docx4j.convert.in.FlatOpcXmlImporter( wmlPackageEl);

			wordMLPackage = (WordprocessingMLPackage)xmlPackage.get();
		} 
		else {
			wordMLPackage = WordprocessingMLPackage.load(new java.io.File(templateFilename));
		}
		
		return wordMLPackage;
	}
	
	
}
