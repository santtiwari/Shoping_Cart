package com.ecom.Service;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.MessagingException;

import com.ecom.Model.OrderRequest;
import com.ecom.Model.productOrder;

public interface OrderService {
	
	public void saveOrder(Integer userid, OrderRequest orderRequest) throws UnsupportedEncodingException, MessagingException;
	
	public List<productOrder> getOrderByUser(Integer userId);
	
	public productOrder updateOrderStatus(Integer id, String status);
	
	public List<productOrder> getAllOrders();
	
	public productOrder getOrdersByOrderId(String order);

}
