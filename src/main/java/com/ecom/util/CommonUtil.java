package com.ecom.util;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.ecom.Model.productOrder;
@Component
public class CommonUtil {
	//first add dependency in pom.xml search on google spring mail dependency
	
	@Autowired
	private JavaMailSender mailSender;
	
	public Boolean sendMail(String url, String reciepentEmail)
	throws UnsupportedEncodingException, MessagingException
	{
		//mail send process
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		helper.setFrom("santprasad.8989@gmail.com", "Shoping Cart");
		helper.setTo(reciepentEmail);
		String content="<p> Hello,</p>"+"<p> You have requested to reset your password.</p>"
		                +"<p> Click the link below to change your password :</p>" + "<p><a href=\""+url
		                +"\">Change my password</a></p>";
		helper.setSubject("Password Reset");
		helper.setText(content, true);
		mailSender.send(message);
		return true;
	}

	public static String generateUrl(HttpServletRequest request) {
		
		//http://localhost:8080/forgot-password
		 String siteUrl= request.getRequestURL().toString();
		 return siteUrl.replace(request.getServletPath(), "");
	}
	String msg=null;
	
	public boolean sendMailForProductOrder(productOrder order, String status) throws UnsupportedEncodingException, MessagingException
	{
		msg="<p>Hello [[name]],</p>"+ "<p>Thank you order <b>[[orderStatus]]</b>.</p>"
				+ "<p><b>Product Details :</b> </p>"
				+ "<p>Name :[[productName]] </p>"
				+ "<p>Category : [[category]]</p>"
				+ "<p>Quantity : [[quantity]]</p>"
				+ "<p>Price : [[price]]</p>"
				+ "<p>Payment Type : [[paymentType]] </p>";
		//mail send process
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message);
				helper.setFrom("santprasad.8989@gmail.com", "Shoping Cart");
				helper.setTo(order.getOrderAddress().getEmail());
			    
				msg = msg.replace("[[name]]", order.getOrderAddress().getFirstName());
				msg = msg.replace("[[orderStatus]]", status);
				msg = msg.replace("[[productName]]", order.getProduct().getTitle());
				msg = msg.replace("[[category]]", order.getProduct().getCategory());
				msg = msg.replace("[[quantity]]", order.getQuantity().toString());
				msg = msg.replace("[[price]]", order.getPrice().toString());
				msg = msg.replace("[[paymentType]]", order.getPaymentType());
				
				helper.setSubject("Product Ordered Status");
				helper.setText(msg, true);
				mailSender.send(message);
				return true;
	}

}
