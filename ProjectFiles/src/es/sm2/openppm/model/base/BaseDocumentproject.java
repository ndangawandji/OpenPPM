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



 /**
 * Base Pojo object for domain model class Documentproject
 * @see es.sm2.openppm.model.base.Documentproject
 * @author Hibernate Generator by Javier Hernandez
 * For implement your own methods use class Documentproject
 */
public class BaseDocumentproject  implements java.io.Serializable {


	private static final long serialVersionUID = 1L;
	
	public static final String ENTITY = "documentproject";
	
	public static final String IDDOCUMENTPROJECT = "idDocumentProject";
	public static final String PROJECT = "project";
	public static final String LINK = "link";
	public static final String TYPE = "type";
	public static final String MIME = "mime";
	public static final String EXTENSION = "extension";
	public static final String NAME = "name";
	public static final String CONTENTCOMMENT = "contentComment";

     private Integer idDocumentProject;
     private Project project;
     private String link;
     private String type;
     private String mime;
     private String extension;
     private String name;
     private String contentComment;

    public BaseDocumentproject() {
    }
    
    public BaseDocumentproject(Integer idDocumentProject) {
    	this.idDocumentProject = idDocumentProject;
    }
   
    public Integer getIdDocumentProject() {
        return this.idDocumentProject;
    }
    
    public void setIdDocumentProject(Integer idDocumentProject) {
        this.idDocumentProject = idDocumentProject;
    }
    public Project getProject() {
        return this.project;
    }
    
    public void setProject(Project project) {
        this.project = project;
    }
    public String getLink() {
        return this.link;
    }
    
    public void setLink(String link) {
        this.link = link;
    }
    public String getType() {
        return this.type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    public String getMime() {
        return this.mime;
    }
    
    public void setMime(String mime) {
        this.mime = mime;
    }
    public String getExtension() {
        return this.extension;
    }
    
    public void setExtension(String extension) {
        this.extension = extension;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
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
		buffer.append("idDocumentProject").append("='").append(getIdDocumentProject()).append("' \n");	
		buffer.append("project").append("='").append(getProject()).append("' \n");	
		buffer.append("link").append("='").append(getLink()).append("' \n");	
		buffer.append("type").append("='").append(getType()).append("' \n");	
		buffer.append("mime").append("='").append(getMime()).append("' \n");	
		buffer.append("extension").append("='").append(getExtension()).append("' \n");	
		buffer.append("name").append("='").append(getName()).append("' \n");	
		buffer.append("contentComment").append("='").append(getContentComment()).append("' \n");	
		buffer.append("]");
      
      return buffer.toString();
     }

	@Override
	public boolean equals(Object other) {
		boolean result = false;
         if (this == other) { result = true; }
		 else if (other == null) { result = false; }
		 else if (!(other instanceof Documentproject) )  { result = false; }
		 else if (other != null) {
		 	Documentproject castOther = (Documentproject) other;
			if (castOther.getIdDocumentProject().equals(this.getIdDocumentProject())) { result = true; }
         }
		 return result;
   }


}


