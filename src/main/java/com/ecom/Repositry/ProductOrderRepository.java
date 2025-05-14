package com.ecom.Repositry;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ecom.Model.productOrder;

public interface ProductOrderRepository extends JpaRepository<productOrder, Integer> {

	List<productOrder> findByUserId(Integer userId);

	productOrder findByOrderId(String order);

}
