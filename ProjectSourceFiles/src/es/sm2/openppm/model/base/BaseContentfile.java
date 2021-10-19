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


import java.util.HashSet;
import java.util.Set;

 /**
 * Base Pojo object for domain model class Contentfile
 * @see es.sm2.openppm.model.base.Contentfile
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Contentfile
 */
public class BaseContentfile  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "contentfile";
	
	public static final String IDCONTENTFILE = "idContentFile";
	public static final String CONTENT = "content";
	public static final String EXTENSION = "extension";
	public static final String MIME = "mime";
	public static final String DOCUMENTATIONS = "documentations";

     private Integer idContentFile;
     private byte[] content;
     private String extension;
     private String mime;
     private Set<Documentation> documentations = new HashSet<Documentation>(0);

    public BaseContentfile() {
    }
    
    public BaseContentfile(Integer idContentFile) {
    	this.idContentFile = idContentFile;
    }
   
    public Integer getIdContentFile() {
        return this.idContentFile;
    }
    
    public void setIdContentFile(Integer idContentFile) {
        this.idContentFile = idContentFile;
    }
    public byte[] getContent() {
        return this.content;
    }
    
    public void setContent(byte[] content) {
        this.content = content;
    }
    public String getExtension() {
        return this.extension;
    }
    
    public void setExtension(String extension) {
        this.extension = extension;
    }
    public String getMime() {
        return this.mime;
    }
    
    public void setMime(String mime) {
        this.mime = mime;
    }
    public Set<Documentation> getDocumentations() {
        return this.documentations;
    }
    
    public void setDocumentations(Set<Documentation> documentations) {
        this.documentations = documentations;
    }

   /**
     * Object toString
     * @return String
     */
     public String toString() {
	  StringBuffer buffer = new StringBuffer();

		buffer.append(getClass().getName()).append("@").append(Integer.toHexString(hashCode())).append(" [\n");
		buffer.append("idContentFile").append("='").append(getIdContentFile()).append("' \n");	
		buffer.append("content").append("='").append(getContent()).append("' \n");	
		buffer.append("extension").append("='").append(getExtension()).append("' \n");	
		buffer.append("mime").append("='").append(getMime()).append("' \n");	
		buffer.append("documentations").append("='").append(getDocumentations()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Contentfile) )  { result = false; }
		 else if (other != null) {
		 	Contentfile castOther = (Contentfile) other;
			if (castOther.getIdContentFile().equals(this.getIdContentFile())) { result = true; }
         }
		 return result;
   }


}


