package com.ecom.Controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.Model.Category;
import com.ecom.Model.Product;
import com.ecom.Model.UserDtls;
import com.ecom.Model.productOrder;
import com.ecom.Service.CartService;
import com.ecom.Service.CategoryService;
import com.ecom.Service.OrderService;
import com.ecom.Service.ProductService;
import com.ecom.Service.UserService;
import com.ecom.util.CommonUtil;
import com.ecom.util.OrderStatus;
import com.sun.xml.bind.api.impl.NameConverter.Standard;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CommonUtil commonUtil;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@ModelAttribute
	public void getUserDetails(Principal p, Model m)
	{
		if(p !=null) {
			String email = p.getName();
			UserDtls userDtls = userService.getUserByEmail(email);
			m.addAttribute("user", userDtls);
			Integer countCart = cartService.getCountCart(userDtls.getId());
			m.addAttribute("countCart", countCart);
		}
		List<Category> allActiveCategory = categoryService.getAllActiveCategory();
		m.addAttribute("categorys", allActiveCategory);
	
	}
	
	@GetMapping("/")
	public String index() {
		
		return "/admin/index";
	}
	@GetMapping("/loadAddProduct")
	public String loadAddProduct(Model m) {
		List<Category> categories = categoryService.getAllCategory();
		m.addAttribute("categories", categories);
		return "/admin/add_product";
	}
	@GetMapping("/category")
	public String category(Model m, @RequestParam(name="pageNo",defaultValue = "0")Integer pageNo, @RequestParam(name="pageSize",defaultValue = "5")Integer pageSize) {
		//m.addAttribute("categorys",categoryService.getAllCategory());
		Page<Category> page = categoryService.getAllCategoryPagination(pageNo, pageSize);
		List<Category> categorys = page.getContent();
		m.addAttribute("categorys", categorys);
		
		m.addAttribute("pageNo", page.getNumber());
		m.addAttribute("pageSize", pageSize);
		m.addAttribute("totalElements", page.getTotalElements());
		m.addAttribute("totalPages", page.getTotalPages());
		m.addAttribute("isFirst", page.isFirst());
		m.addAttribute("isLast", page.isLast());
		return "/admin/category";
	}
	@PostMapping("/saveCategory")
	public String saveCategory(@ModelAttribute Category category,@RequestParam("file")MultipartFile file,
			HttpSession session) throws IOException {
		
		String imageName = file!=null ? file.getOriginalFilename():"default.jpg";
		category.setImageName(imageName);
		Boolean existCategory = categoryService.existCategory(category.getName());
		System.out.println("Message category :: "+existCategory);
		if(existCategory) {
			session.setAttribute("errorMsg", "Category Name is already exist !!");
			
		}else {
			Category saveCategory = categoryService.saveCategory(category);
			System.out.println("MessageSave :: "+saveCategory);
			
			if(ObjectUtils.isEmpty(saveCategory)) {
				session.setAttribute("errorMsg", "Not saved ! internal server issue !!s");
			}else{
				File saveFile = new ClassPathResource("static/img").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath()+ File.separator + "category_img" +File.separator 
						+ file.getOriginalFilename());
				System.out.println("path :: "+path);
				Files.copy(file.getInputStream(), path,StandardCopyOption.REPLACE_EXISTING);
				
				session.setAttribute("succMsg", "Category saved successfully !!");
			}
		}
		return "redirect:/admin/category";
	}
	
	@GetMapping("/deleteCategory/{id}")
	public String deleteCategory(@PathVariable int id, HttpSession session) {
		Boolean deleteCategory = categoryService.deleteCategory(id);
		if(deleteCategory) {
			session.setAttribute("succMsg", "Category deleted successfully !!");
		}else {
			session.setAttribute("errorMsg", "Something went wrong on the server !!");
		}
		return "redirect:/admin/category";
	}
	
	@GetMapping("/loadEditCategory/{id}")
	public String loadEditCategory(@PathVariable int id,Model m) {
		m.addAttribute("category",categoryService.getCategoryById(id));
		return "/admin/edit_category";
	}
	@PostMapping("/updateCategory")
	public String updateCategory(@ModelAttribute Category category, @RequestParam("file")
	MultipartFile file, HttpSession session) throws IOException {
		Category oldCategory = categoryService.getCategoryById(category.getId());
		String imageName = file.isEmpty() ? oldCategory.getImageName():file.getOriginalFilename();
		if(!ObjectUtils.isEmpty(oldCategory)) {
			oldCategory.setName(category.getName());
			oldCategory.setIsActive(category.getIsActive());
			oldCategory.setImageName(imageName);
		}
		Category updateCategory = categoryService.saveCategory(oldCategory);
		if(!ObjectUtils.isEmpty(updateCategory)) {
			if(!file.isEmpty()) {
				File saveFile = new ClassPathResource("static/img").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath()+ File.separator + "category_img" +File.separator 
						+ file.getOriginalFilename());
				System.out.println("path :: "+path);
				Files.copy(file.getInputStream(), path,StandardCopyOption.REPLACE_EXISTING);
				
			}
			session.setAttribute("succMsg", "Category updated Successfully !!");
		}else {
			session.setAttribute("errorMsg", "Something went wrong on the server !!");
		}
		
		return "redirect:/admin/loadEditCategory/"+category.getId();
		
	}
	@PostMapping("/saveProduct")
	public String saveProduct(@ModelAttribute Product product,@RequestParam("file") MultipartFile image, HttpSession session) throws IOException {
		
		String imageName = image.isEmpty()? "default.jpg":image.getOriginalFilename();
		
		product.setImage(imageName);
		product.setDiscount(0);
		product.setDiscountPrice(product.getPrice() != null ? product.getPrice() : 0.0);

		
		Product saveProduct = productService.saveProduct(product);
		if(!ObjectUtils.isEmpty(saveProduct))
		{
			File saveFile = new ClassPathResource("static/img").getFile();
			Path path = Paths.get(saveFile.getAbsolutePath()+ File.separator + "product_img" +File.separator 
					+ image.getOriginalFilename());
			System.out.println("path :: "+path);
			Files.copy(image.getInputStream(), path,StandardCopyOption.REPLACE_EXISTING);
			session.setAttribute("succMsg", "Product Save Successfully !!");
		}else {
			session.setAttribute("errorMsg", "Something went wrong on the server !!");
		}
		return "redirect:/admin/loadAddProduct";
	}
	@GetMapping("/products")
	public String loadViewProduct(Model m, @RequestParam(defaultValue = "") String ch, @RequestParam(name="pageNo",defaultValue = "0")Integer pageNo, @RequestParam(name="pageSize",defaultValue = "5")Integer pageSize) {
		//List<Product> products=null;
		//if(ch !=null && ch.length()>0) {
			//products = productService.searchProduct(ch);
			
		//}else {
			//products= productService.getallproducts();
		//}
		 
		//m.addAttribute("products", products);
		
		Page<Product> page=null;
		if(ch !=null && ch.length()>0) {
			page = productService.searchProductPagination(pageNo, pageSize, ch);
			
		}else {
			page = productService.getallproductspagination(pageNo, pageSize);
		}
		 
		m.addAttribute("products", page.getContent());
		 
		 m.addAttribute("pageNo", page.getNumber()); 
		 m.addAttribute("pageSize", pageSize); 
		 m.addAttribute("totalElements", page.getTotalElements());
		 m.addAttribute("totalPages", page.getTotalPages());
		 m.addAttribute("isFirst", page.isFirst()); 
		 m.addAttribute("isLast", page.isLast());
		 
		
		return "/admin/products";
	}
	@GetMapping("/deleteProduct/{id}")
	public String deleteProduct(@PathVariable int id, HttpSession session) {
		boolean deleteProduct = productService.deleteProduct(id);
		if(deleteProduct) {
			session.setAttribute("succMsg", "Product delete successfully !!");
		}else {
			session.setAttribute("errorMsg", "Something went wrong on the server !!");
		}
		return "redirect:/admin/products";
	}
	@GetMapping("/editproduct/{id}")
	public String editproduct(@PathVariable int id, Model m) {
		m.addAttribute("product", productService.getProductbyId(id));
		m.addAttribute("categories", categoryService.getAllCategory());
		return "/admin/edit_product";
	}
	@PostMapping("/updateProduct")
	public String updateProduct(@ModelAttribute Product product,@RequestParam("file") MultipartFile image,Model m,HttpSession session) {
		if(product.getDiscount()<0 || product.getDiscount()>100) {
			session.setAttribute("errorMsg", "Envalid Discount !!");
		}else {
		
		Product updateProduct = productService.updateProduct(product, image);
		if(!ObjectUtils.isEmpty(updateProduct)) {
			session.setAttribute("succMsg", "Product update successfully !!");
		}else {
			session.setAttribute("errorMsg", "Something went wrong on the server !!");
		}
	}
		return "redirect:/admin/editproduct/"+product.getId();
	}
	@GetMapping("/users")
	public String getAllUsers(Model m, @RequestParam Integer type)
	{
		List<UserDtls> users=null;
		if(type==1) {
			 users = userService.getUsers("ROLE_USER");
		}else {
			users = userService.getUsers("ROLE_ADMIN");
		}
		m.addAttribute("userType", type);
		m.addAttribute("users", users);
		return "/admin/users";
	}
	@GetMapping("/updateSts")
	public String updateUserAccountStatus(@RequestParam Boolean status, @RequestParam Integer id, @RequestParam Integer type, HttpSession session)
	{
		Boolean f= userService.updateUserAccountStatus(id,status);
		if(f)
		{
			session.setAttribute("succMsg", "Account status updated !!");
		}else
		{
			session.setAttribute("errorMsg", "something went wrong on the server !!");
		}
		return "redirect:/admin/users?type="+type;
	}
	@GetMapping("/orders")
	public String getAllOrdeers(Model m, @RequestParam(name="pageNo",defaultValue = "0")Integer pageNo, @RequestParam(name="pageSize",defaultValue = "5")Integer pageSize)
	{
		//List<productOrder> allOrders = orderService.getAllOrders();
		//m.addAttribute("orders", allOrders);
		//m.addAttribute("srch", false);
		
		Page<productOrder> page = orderService.getAllOrdersPagination(pageNo, pageSize);
		m.addAttribute("orders", page.getContent());
		m.addAttribute("srch", false);
		 
		 m.addAttribute("pageNo", page.getNumber()); 
		 m.addAttribute("pageSize", pageSize); 
		 m.addAttribute("totalElements", page.getTotalElements());
		 m.addAttribute("totalPages", page.getTotalPages());
		 m.addAttribute("isFirst", page.isFirst()); 
		 m.addAttribute("isLast", page.isLast());
		
		return "/admin/orders";
	}
	@PostMapping("/update-order-status")
	public String updateOrderStatus(@RequestParam Integer id, @RequestParam Integer st, HttpSession session)
	{
		System.out.println("Received id: " + id);
		System.out.println("Received st: " + st);

		OrderStatus[] values = OrderStatus.values();
		String status = null;
		for(OrderStatus orderst: values) {
			if(orderst.getId().equals(st)) {
				status=	orderst.getName();
			}
		}
		if(status !=null) {
		productOrder updateOrder = orderService.updateOrderStatus(id, status);
		
		try {
			commonUtil.sendMailForProductOrder(updateOrder, status);
		} catch (UnsupportedEncodingException e) {
			
			e.printStackTrace();
		} catch (MessagingException e) {
			
			e.printStackTrace();
		}
		
		if(!ObjectUtils.isEmpty(updateOrder)) {
			session.setAttribute("succMsg", "Status updated successfully !!");
		}else {
			session.setAttribute("errorMsg", "Status not updated !!");
		}
		}else {
			session.setAttribute("errorMsg", "Invalid status selected !!");
		}
		
		return "redirect:/admin/orders";
		
	}
	@GetMapping("/search-order")
	public String searchProduct(@RequestParam String orderId, Model m, HttpSession session,
			@RequestParam(name="pageNo",defaultValue = "0")Integer pageNo, @RequestParam(name="pageSize",defaultValue = "5")Integer pageSize) {
		if(orderId !=null && orderId.length()>0) {
		
		productOrder order = orderService.getOrdersByOrderId(orderId.trim());
		if(ObjectUtils.isEmpty(order)) {
			session.setAttribute("errorMsg", "your id is empty or null!!");
		    m.addAttribute("orderDtls", null);
		}else {
			m.addAttribute("orderDtls", order);
		}
		m.addAttribute("srch", true);
		}else {
			//List<productOrder> allOrders = orderService.getAllOrders();
			//m.addAttribute("orders", allOrders);
			//m.addAttribute("srch", false);
			
			Page<productOrder> page = orderService.getAllOrdersPagination(pageNo, pageSize);
			m.addAttribute("orders", page);
			m.addAttribute("srch", false);
			
			m.addAttribute("pageNo", page.getNumber()); 
			 m.addAttribute("pageSize", pageSize); 
			 m.addAttribute("totalElements", page.getTotalElements());
			 m.addAttribute("totalPages", page.getTotalPages());
			 m.addAttribute("isFirst", page.isFirst()); 
			 m.addAttribute("isLast", page.isLast());
		}
		return "/admin/orders";
	}
	@GetMapping("/add-admin")
	public String loadAdminAdd() {
		
		return "/admin/add_admin";
	}
	@PostMapping("/save-admin")
	public String saveAdmin(@ModelAttribute UserDtls user,@RequestParam("img") MultipartFile file, HttpSession session) throws IOException 
	{
		String imageName= file.isEmpty() ? "default.jpg" :file.getOriginalFilename();
		//String imageName = file!=null ? file.getOriginalFilename():"default.jpg";
		user.setProfileimage(imageName);
		UserDtls saveUser = userService.saveAdmin(user);
		if(!ObjectUtils.isEmpty(saveUser))
		{
			if(!file.isEmpty()) 
			{
				File saveFile = new ClassPathResource("static/img").getFile();
				Path path = Paths.get(saveFile.getAbsolutePath()+ File.separator + "profile_img" +File.separator 
						+ file.getOriginalFilename());
				System.out.println("path :: "+path);
				Files.copy(file.getInputStream(), path,StandardCopyOption.REPLACE_EXISTING);
			}
			session.setAttribute("succMsg", "UserDetail's saved successfully !!");
		}else {
			session.setAttribute("errorMsg", "Something went wrong on the server !!");
		}
		
		return "redirect:/admin/add-admin";
	}
	@GetMapping("/profile")
	public String profile() {
		
		return "/admin/profile";
	}
	
	@PostMapping("/update-profile")
	public String updateProfile(@ModelAttribute UserDtls user, @RequestParam MultipartFile img, HttpSession session)
	{
		UserDtls updateuserProfile = userService.updateUserProfile(user, img);
		if(ObjectUtils.isEmpty(updateuserProfile)) {
			session.setAttribute("errorMsg", "profile is not updated !!");
		}else {
			session.setAttribute("succMsg", "profile is updated successfully !!");
		}
		
		return "redirect:/admin/profile";
	}
	
	@PostMapping("/change-password")
	public String changePassword(@RequestParam String newPassword, @RequestParam String currentPassword,
			Principal p, HttpSession session)
	{
		UserDtls loggedInUserDetails = commonUtil.getLoggedInUserDetails(p);
		boolean matches = passwordEncoder.matches(currentPassword, loggedInUserDetails.getPassword());
		if(matches)
		{
			String encodePassword= passwordEncoder.encode(newPassword);
			loggedInUserDetails.setPassword(encodePassword);
			UserDtls updateuser = userService.updateUser(loggedInUserDetails);
			if(ObjectUtils.isEmpty(updateuser)) 
			{
				session.setAttribute("errorMsg", "Something wrong on Server ");
			}else {
				session.setAttribute("succMsg", "Password is updated successfully !!");
			}
		}else {
			session.setAttribute("errorMsg", "Current Password is incorrect");
		}
		return "redirect:/admin/profile";
	}

}
