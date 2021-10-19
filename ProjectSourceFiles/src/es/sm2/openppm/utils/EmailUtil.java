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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.log4j.Logger;

import es.sm2.openppm.common.Constants;
import es.sm2.openppm.exceptions.DestinationMailNotFoundException;
import es.sm2.openppm.exceptions.FromMailNotFoundException;
import es.sm2.openppm.exceptions.MailException;

/**
 * Prepare and send email.
 * @author juanma.lopez
 *
 */
public class EmailUtil {

	public final static Logger LOGGER = Logger.getLogger(EmailUtil.class);
	
	private String from;
	private String to;
	private String subject;
	private String bodyText;
	private Properties properties;
	private List<File> files;
    
    /**
     * Constructor. Set from and to
     * @param from
     * @param to
     */
    public EmailUtil(String from, String to) {
    	this.from = from;
    	this.to = to;
    	this.subject = StringPool.BLANK;
    	this.bodyText = StringPool.BLANK;
    	
    	this.properties = new Properties();
    	this.properties.put("mail.transport.protocol", "smtp");
    	this.properties.put("mail.smtp.user", from);
    	this.properties.put("mail.smtp.host", Constants.EMAIL_HOST);
        this.properties.put("mail.smtp.auth", "false");
    	this.properties.put("mail.smtp.port", Constants.EMAIL_PORT);
        this.properties.put("mail.smtp.starttls.enable", Constants.EMAIL_TLS);
    }
    
    public void setSubject(String subject) {
		this.subject = subject;
	}
    
    public void setBodyText(String bodyText) {
		this.bodyText = bodyText;
	}
    
    public void addFile(File file) {
    	if (files == null) { files = new ArrayList<File>(); }
    	files.add(file);
    }
    
    public void send() throws MailException, AddressException, MessagingException {
    	
    	if (this.to == null || StringPool.BLANK.equals(this.to)) {
    		throw new DestinationMailNotFoundException();
    	}
    	if (this.from == null || StringPool.BLANK.equals(this.from)) {
    		throw new FromMailNotFoundException();
    	}
    	
    	javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties);

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(this.from));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(this.to));
        message.setSubject(subject);
        message.setSentDate(new Date());
        
        Multipart multipart = new MimeMultipart();
        
        // Set the email message text.
        MimeBodyPart messagePart = new MimeBodyPart();
        messagePart.setText(bodyText);
        multipart.addBodyPart(messagePart);
        
        // Attach files
        if (files != null) {
        	MimeBodyPart filePart = new MimeBodyPart();
        	for (File file : files) {
		        FileDataSource fds = new FileDataSource(file);
		        filePart.setDataHandler(new DataHandler(fds));
		        filePart.setFileName(fds.getName());
        	}
        	multipart.addBodyPart(filePart);
        }
        
        
        message.setContent(multipart);
        
        Transport t = session.getTransport("smtp");
        t.connect(Constants.EMAIL_USER, Constants.EMAIL_PASS);
        t.sendMessage(message,message.getAllRecipients());
        t.close();
        
        LOGGER.info("Email send from "+this.from+" to "+ this.to);
    }
    
    /**
	 * @return the from
	 */
	public String getFrom() {
		return from;
	}

	/**
	 * @param from the from to set
	 */
	public void setFrom(String from) {
		this.from = from;
	}

	/**
	 * @return the to
	 */
	public String getTo() {
		return to;
	}

	/**
	 * @param to the to to set
	 */
	public void setTo(String to) {
		this.to = to;
	}

	/**
	 * @return the properties
	 */
	public Properties getProperties() {
		return properties;
	}

	/**
	 * @param properties the properties to set
	 */
	public void setProperties(Properties properties) {
		this.properties = properties;
	}

	/**
	 * @return the files
	 */
	public List<File> getFiles() {
		return files;
	}

	/**
	 * @param files the files to set
	 */
	public void setFiles(List<File> files) {
		this.files = files;
	}

	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * @return the bodyText
	 */
	public String getBodyText() {
		return bodyText;
	}
	
}
