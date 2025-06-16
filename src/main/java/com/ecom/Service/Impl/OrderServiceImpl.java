package com.ecom.Service.Impl;

import java.io.UnsupportedEncodingException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.ecom.Model.Cart;
import com.ecom.Model.OrderAddress;
import com.ecom.Model.OrderRequest;
import com.ecom.Model.productOrder;
import com.ecom.Repositry.CartRepositry;
import com.ecom.Repositry.ProductOrderRepository;
import com.ecom.Service.OrderService;
import com.ecom.util.CommonUtil;
import com.ecom.util.OrderStatus;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private ProductOrderRepository orderRepository;
	
	@Autowired
	private CartRepositry cartRepository;
	
	@Autowired
	private CommonUtil commonUtil;

	@Override
	public void saveOrder(Integer userid, OrderRequest orderRequest) throws UnsupportedEncodingException, MessagingException {
		
		List<Cart> carts = cartRepository.findByUserId(userid);
		for(Cart cart:carts) {
				productOrder order = new productOrder();
				order.setOrderId(UUID.randomUUID().toString());
				order.setOrderDate(LocalDate.now());
				
				order.setProduct(cart.getProduct());
				order.setPrice(cart.getProduct().getDiscountPrice());
				
				order.setQuantity(cart.getQuantity());
				order.setUser(cart.getUser());
				order.setStatus(OrderStatus.IN_PROGRESS.getName());
				order.setPaymentType(orderRequest.getPaymentType());
				
				OrderAddress address = new OrderAddress();
				address.setFirstName(orderRequest.getFirstName());
				address.setLastName(orderRequest.getLastName());
				address.setEmail(orderRequest.getEmail());
				address.setMobileNo(orderRequest.getMobileNo());
				address.setAddress(orderRequest.getAddress());
				address.setCity(orderRequest.getCity());
				address.setState(orderRequest.getState());
				address.setPincode(orderRequest.getPincode());
				order.setOrderAddress(address);
				productOrder saveOrder = orderRepository.save(order);
				commonUtil.sendMailForProductOrder(saveOrder, "success");
				
		}
		
	}

	@Override
	public List<productOrder> getOrderByUser(Integer userId) {
		List<productOrder> orders = orderRepository.findByUserId(userId);
		return orders;
	}

	@Override
	public productOrder updateOrderStatus(Integer id, String status) {
		Optional<productOrder> findById = orderRepository.findById(id);
		if(findById.isPresent()) {
			productOrder productorder = findById.get();
			productorder.setStatus(status);
			productOrder updateOrder = orderRepository.save(productorder);
			return updateOrder;
		}
		return null;
	}

	@Override
	public List<productOrder> getAllOrders() {
		
		return orderRepository.findAll();
	}
	

	@Override
	public Page<productOrder> getAllOrdersPagination(Integer pageNo, Integer pageSize) {
		Pageable pageable = PageRequest.of(pageNo, pageSize);
		return orderRepository.findAll(pageable);
	}

	@Override
	public productOrder getOrdersByOrderId(String orderId) {
		
		return orderRepository.findByOrderId(orderId);
	}

}
