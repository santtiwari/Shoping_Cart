package com.ecom.Service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.Model.Category;
import com.ecom.Model.Product;

public interface ProductService {
	
	public Product saveProduct(Product product);
	
	public List<Product> getallproducts();
	
	public boolean deleteProduct(Integer id);
	
	public Product getProductbyId(Integer id);
	
	public Product updateProduct(Product product, MultipartFile file);
	
	public List<Product> getAllActiveProduct(String category);
	
	public List<Product> searchProduct(String ch);
	
	public Page<Product> getAllActiveProductPagination(Integer pageNo, Integer pageSize, String category);

}
