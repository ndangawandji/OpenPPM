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

import java.io.ByteArrayOutputStream;
import java.io.IOException;

public class CsvFile {

	private ByteArrayOutputStream fileStream = new ByteArrayOutputStream();
	private char separator;
	private boolean newline;
	
	/**
	 * Create file CSV
	 * 
	 * @param separator <Not null not supported> is the character to separate the elements
	 */
	public CsvFile(char separator) {
		this.separator = separator;
		this.newline = true;
	}
	
	/**
	 * Return file in array bytes
	 * @return
	 */
	public byte[] getFileBytes() {
		return fileStream.toByteArray();
	}
	
	/**
	 * Add Value
	 * @param value
	 * @throws IOException
	 */
	public void addValue(String value) throws IOException {
		StringBuffer tmp = new StringBuffer();
		if (newline) {
			newline = false;
		}
        else {
        	tmp.append(separator);
        }
		tmp.append(value);
        byte valueBytes[] = tmp.toString().getBytes();
        this.fileStream.write(valueBytes);
	}
	
	/**
	 * New line
	 * @throws IOException
	 */
	public void newLine() throws IOException {
		String line = "\n";
        byte valueBytes[] = line.getBytes();
        this.fileStream.write(valueBytes);
        newline = true;
	}

	public void setSeparator(char separator) {
		this.separator = separator;
	}

	public char getSeparator() {
		return separator;
	}

	public void setFileStream(ByteArrayOutputStream fileStream) {
		this.fileStream = fileStream;
	}

	public ByteArrayOutputStream getFileStream() {
		return fileStream;
	}
}
