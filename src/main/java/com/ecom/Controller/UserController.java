package com.ecom.Controller;

import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ecom.Model.Cart;
import com.ecom.Model.Category;
import com.ecom.Model.OrderRequest;
import com.ecom.Model.UserDtls;
import com.ecom.Model.productOrder;
import com.ecom.Service.CartService;
import com.ecom.Service.CategoryService;
import com.ecom.Service.OrderService;
import com.ecom.Service.UserService;
import com.ecom.util.CommonUtil;
import com.ecom.util.OrderStatus;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CommonUtil commonUtil;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@GetMapping("/")
	public String home() {

		return "user/home";

	}

	@ModelAttribute
	public void getUserDetails(Principal p, Model m) {
		if (p != null) {
			String email = p.getName();
			UserDtls userDtls = userService.getUserByEmail(email);
			m.addAttribute("user", userDtls);
			Integer countCart = cartService.getCountCart(userDtls.getId());
			m.addAttribute("countCart", countCart);
		}
		List<Category> allActiveCategory = categoryService.getAllActiveCategory();
		m.addAttribute("categorys", allActiveCategory);

	}

	@GetMapping("/addCart")
	public String addToCart(@RequestParam Integer pid ,@RequestParam Integer uid , HttpSession session) {
		
		Cart saveCart = cartService.saveCart(pid, uid);
		
		if(ObjectUtils.isEmpty(saveCart))
		{
			session.setAttribute("errorMsg", "Product add to cart failed");
		}else {
			session.setAttribute("succMsg", "Product added to cart successfully !!");
		}
		 return "redirect:/product/" + pid;
	}
	
	@GetMapping("/cart")
	public String loadCartPage(Principal p, Model m)
	{
		
		UserDtls user = getLoggedInUserDetails(p);
		List<Cart> carts = cartService.getCartsByUser(user.getId());
		m.addAttribute("carts", carts);
		if(carts.size()>0) {
		Double totalOrderPrice = carts.get(carts.size()-1).getTotalOrderPrice();
		m.addAttribute("totalOrderPrice", totalOrderPrice);
		}
		return "/user/cart";
	}
	@GetMapping("/cartQuantityUpdate")
	public String updateCartQuantity(@RequestParam String sy, @RequestParam Integer cid)
	{
		cartService.updateQuantity(sy, cid);
		return "redirect:/user/cart";
		
	}

	private UserDtls getLoggedInUserDetails(Principal p) 
	{
		String email = p.getName();
		UserDtls userDtls = userService.getUserByEmail(email);
		
		return userDtls;
	}
	
	@GetMapping("/orders")
	public String orderPage(Principal p, Model m)
	{
		UserDtls user = getLoggedInUserDetails(p);
		List<Cart> carts = cartService.getCartsByUser(user.getId());
		m.addAttribute("carts", carts);
		if(carts.size()>0) {
			Double orderPrice = carts.get(carts.size()-1).getTotalOrderPrice();
			Double totalOrderPrice = carts.get(carts.size()-1).getTotalOrderPrice() +250+100;
			m.addAttribute("orderPrice", orderPrice);
			m.addAttribute("totalOrderPrice", totalOrderPrice);
		}
		return "/user/order";
	}
	
	@PostMapping("/save-order")
	public String saveOrder(@ModelAttribute OrderRequest request, Principal p) throws UnsupportedEncodingException, MessagingException
	{
		//System.out.println(request);
		UserDtls user = getLoggedInUserDetails(p);
		orderService.saveOrder(user.getId(), request);
		return "redirect:/user/success";
	}
	@GetMapping("/success")
	public String loadSuccess()
	{
		return "/user/success";
		
	}
	@GetMapping("/user-orders")
	public String myOrder(Model m, Principal p)
	{
		UserDtls loginUser = getLoggedInUserDetails(p);
		List <productOrder>orders = orderService.getOrderByUser(loginUser.getId());
		m.addAttribute("orders", orders);
		return "/user/my_orders";
		
	}
	@GetMapping("/update-status")
	public String updateOrderStatus(@RequestParam Integer id, @RequestParam Integer st, HttpSession session)
	{
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
		
		
		return "redirect:/user/user-orders";
		
	}
	@GetMapping("/profile")
	public String profile()
	{
		
		return"/user/profile";
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
		
		return "redirect:/user/profile";
	}
	@PostMapping("/change-password")
	public String changePassword(@RequestParam String newPassword, @RequestParam String currentPassword,
			Principal p, HttpSession session)
	{
		UserDtls loggedInUserDetails = getLoggedInUserDetails(p);
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
		return "redirect:/user/profile";
	}
}
