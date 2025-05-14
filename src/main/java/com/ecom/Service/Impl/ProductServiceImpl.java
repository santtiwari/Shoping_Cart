package com.ecom.Service.Impl;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.Model.Product;
import com.ecom.Repositry.ProductRepository;
import com.ecom.Service.ProductService;
@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductRepository prepo;
	@Override
	public Product saveProduct(Product product) {
		
		return prepo.save(product);
	}
	@Override
	public List<Product> getallproducts() {
		
		return prepo.findAll();
	}
	@Override
	public boolean deleteProduct(Integer id) {
		Product product = prepo.findById(id).orElse(null);
		
		if(!ObjectUtils.isEmpty(product)) {
			prepo.delete(product);
			return true;
			
		}else {
			
		return false;
		
		}
	}
	@Override
	public Product getProductbyId(Integer id) {
		Product product = prepo.findById(id).orElse(null);
		return product;
	}
	@Override
	public Product updateProduct(Product product,MultipartFile image) {
		Product dbproduct = getProductbyId(product.getId());
		String imageName = image.isEmpty()? dbproduct.getImage():image.getOriginalFilename();
		dbproduct.setTitle(product.getTitle());
		dbproduct.setDescription(product.getDescription());
		dbproduct.setCategory(product.getCategory());
		dbproduct.setPrice(product.getPrice());
		dbproduct.setStock(product.getStock());
		dbproduct.setImage(imageName);
		dbproduct.setIsActive(product.getIsActive());
		dbproduct.setDiscount(product.getDiscount());
		Double discount= product.getPrice()*(product.getDiscount()/100.0);
		Double discountPrice=product.getPrice()-discount;
		dbproduct.setDiscountPrice(discountPrice);
		
		Product updateProduct = prepo.save(dbproduct);
		if(!ObjectUtils.isEmpty(updateProduct)) {
			if(!image.isEmpty()) {
				try{
				File saveFile = new ClassPathResource("static/img").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath()+ File.separator + "product_img" +File.separator 
						+ image.getOriginalFilename());
				System.out.println("path :: "+path);
				Files.copy(image.getInputStream(), path,StandardCopyOption.REPLACE_EXISTING);
				//session.setAttribute("succMsg", "Product Save Successfully !!");
			}catch(Exception e) {
				e.printStackTrace();
			}
			}
			return product;
		}
		
		return null;
	}
	@Override
	public List<Product> getAllActiveProduct(String category) {
		List<Product> products =null;
		if(ObjectUtils.isEmpty(category)) {
		products = prepo.findByIsActiveTrue();
		}else {
			products= prepo.findByCategory(category);
		}
		return products;
	}
	@Override
	public List<Product> searchProduct(String ch) {
		
		return prepo.findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase(ch, ch);
	}
	@Override
	public Page<Product> getAllActiveProductPagination(Integer pageNo, Integer pageSize, String category) {
		Page<Product> pageProduct=null;
		Pageable pageable= PageRequest.of(pageNo, pageSize);
		
		if(ObjectUtils.isEmpty(category)) {
			pageProduct = prepo.findByIsActiveTrue(pageable);
		}else {
			pageProduct= prepo.findByCategory(pageable, category);
		}
		
		return pageProduct;
	}

}
