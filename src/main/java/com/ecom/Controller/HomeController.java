package com.ecom.Controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.Model.Category;
import com.ecom.Model.Product;
import com.ecom.Model.UserDtls;
import com.ecom.Service.CartService;
import com.ecom.Service.CategoryService;
import com.ecom.Service.ProductService;
import com.ecom.Service.UserService;
import com.ecom.util.CommonUtil;




@Controller
public class HomeController {
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommonUtil commonUtil;
	
	@Autowired
	private BCryptPasswordEncoder PasswordEncoder;
	
	@Autowired
	private CartService cartService;
	
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
	public String index(Model m) {
	List<Category> allActiveCategory = categoryService.getAllActiveCategory()
			.stream()
			.sorted(Comparator.comparingInt(Category::getId).reversed())
			.limit(6).collect(Collectors.toList());
	 List<Product> allActiveProducts = productService.getAllActiveProduct("")
		        .stream()
		        .sorted(Comparator.comparingInt(Product::getId).reversed())
		        .limit(8)
		        .collect(Collectors.toList());
	m.addAttribute("category", allActiveCategory);
	m.addAttribute("products", allActiveProducts);
		return "index";
	}
	@GetMapping("/signin")
	public String login() {
		
		return "login";
	}
	@GetMapping("/register")
	public String register() {
		
		return "register";
	}
	@GetMapping("/products")
	public String products(Model m, @RequestParam(value = "category", defaultValue = "") String category,
			@RequestParam(name = "pageNo", defaultValue="0")Integer pageNo, @RequestParam(name ="pageSize", defaultValue="9")Integer pageSize, @RequestParam(defaultValue="") String ch) {
		List<Category> categories = categoryService.getAllActiveCategory();
		m.addAttribute("categories", categories);
		m.addAttribute("paramValue", category);
		
		//List<Product> products = productService.getAllActiveProduct(category);
		//m.addAttribute("products", products);
		Page<Product> page = null;
		if (ch == null || ch.isEmpty()) {
			page = productService.getAllActiveProductPagination(pageNo, pageSize, category);
		}else {
			 page = productService.searchActiveProductPagination(pageNo, pageSize, category, ch);
		}
		List<Product> products = page.getContent();
		m.addAttribute("products", products);
		m.addAttribute("productsSize", products.size());
		m.addAttribute("pageNo", page.getNumber());
		m.addAttribute("pageSize", pageSize);
		m.addAttribute("totalElements", page.getTotalElements());
		m.addAttribute("totalPages", page.getTotalPages());
		m.addAttribute("isFirst", page.isFirst());
		m.addAttribute("isLast", page.isLast());
		return "product";
	}
	@GetMapping("/product/{id}")
	public String product(@PathVariable int id, Model m) {
		Product productById = productService.getProductbyId(id);
		m.addAttribute("product", productById);
		return "view_product";
	}
	
	@PostMapping("/saveUser")
	public String saveUser(@ModelAttribute UserDtls user,@RequestParam("img") MultipartFile file, HttpSession session) throws IOException 
	{
		Boolean existEmail = userService.existsEmail(user.getEmail());
		
		if(existEmail)
		{
			session.setAttribute("errorMsg", "email id already exist !!");
		}else {
			String imageName= file.isEmpty() ? "default.jpg" :file.getOriginalFilename();
			//String imageName = file!=null ? file.getOriginalFilename():"default.jpg";
			user.setProfileimage(imageName);
			UserDtls saveUser = userService.saveUser(user);
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
		}
		
		
		
		return "redirect:/register";
	}
	
//forgot password logic
	
	@GetMapping("/forgot-password")
	public String showForgotPassword()
	{
		return "forgot_password";
	}
	
	//process send mail
	
		@PostMapping("/forgot-password")
		public String processForgotPassword(@RequestParam String email, HttpSession session, HttpServletRequest request) 
		throws UnsupportedEncodingException, MessagingException
		{
			UserDtls userByEmail = userService.getUserByEmail(email);
			if(ObjectUtils.isEmpty(userByEmail))
			{
				session.setAttribute("errorMsg", "Invalid email");
			}else {
				//generate random token
				String resetToken = UUID.randomUUID().toString();
				userService.updateUserResetToken(email,resetToken);
				
				//genrate url:https://localhost:8080/reset-password?token=sgfdgsterw
				 // Generate dynamic URL
				
				String url = CommonUtil.generateUrl(request)+"/reset-password?token=" + resetToken;
				// Send email with the reset URL
				
				Boolean sendMail = commonUtil.sendMail(url, email);
				if(sendMail)
				{
					session.setAttribute("succMsg", " Please check your email..password reset link sent");
				}else {
					session.setAttribute("errorMsg", "Something went wrong on the server | mail not send ");
				}
			}
			return "redirect:/forgot-password";
		}
	
	//Reset password logic after send mail cick on link
	
	@GetMapping("/reset-password")
	public String showResetPassword(@RequestParam String token, HttpSession session, Model m)
	{
		UserDtls userByToken= userService.getUserByToken(token);
		if(userByToken==null)
		{
			m.addAttribute("errorMsg", "Your Link is invalid or expired !!");
			return "message";
		}
		m.addAttribute("token", token);
		return "reset_password";
	}
	@PostMapping("/reset-password")
	public String ResetPassword(@RequestParam String token,
			@RequestParam String password, HttpSession session, Model m)
	{
		UserDtls userByToken= userService.getUserByToken(token);
		if(userByToken==null)
		{
			m.addAttribute("errorMsg", "Your Link is invalid or expired !!");
			return "message";
		}else
		{
			userByToken.setPassword(PasswordEncoder.encode(password));
			userByToken.setresetToken(null);
			userService.updateUser(userByToken);
			session.setAttribute("succMsg", " Password change successfully !!");
			m.addAttribute("succMsg", " Password change successfully !!");
			
		}
		// Now, to ensure the messages are only shown once, clear them after use
	    m.addAttribute("errorMsg", null); // Clear error message
	    m.addAttribute("succMsg", null);  // Clear success message
		return "message";
	}
	
	@GetMapping("/search")
	public String searchProduct(@RequestParam String ch, Model m) {
		List<Product> searchProduct = productService.searchProduct(ch);
		m.addAttribute("products", searchProduct);
		List<Category> categories = categoryService.getAllActiveCategory();
		m.addAttribute("categories", categories);
		return "product";
	}
	

}
