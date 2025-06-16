package com.ecom.Repositry;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ecom.Model.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
	
	public Boolean existsByName(String name);

	public List<Category> findByIsActiveTrue();

}
