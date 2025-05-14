<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <!-- jstl tag library -->
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
     rel="stylesheet"
     integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
     crossorigin="anonymous">
     <!-- font awesome cdn -->
     <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" 
      integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" 
      crossorigin="anonymous" 
     referrerpolicy="no-referrer" />
     <!-- font awesome cdn close -->
</head>
<body>
<!-- Start Navbar -->
<nav class="navbar navbar-expand-lg bg-primary fixed-top navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"><i class="fa-solid fa-cart-shopping"></i>Ecom Store</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/"><i class="fa-solid fa-house"></i>HOME</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/products">Product</a>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Category</a>
          
          <ul class="dropdown-menu">
          <c:forEach var="category" items="${categorys}">
         <li><a class="dropdown-item" href="/products?category=${category.name}">${category.name}</a></li>
        </c:forEach>
          </ul> </li>
          
      </ul>
      
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
       <c:if test="${user == null}">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/signin">
          <i class="fa-solid fa-right-to-bracket"></i>LOGIN</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="/register">REGISTER</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="#">ADMIN</a>
        </li>
        </c:if>
        <c:if test="${user != null}">
        <c:if test="${user.role=='ROLE_USER'}">
        
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/user/cart">
          <i class="fa-solid fa-cart-shopping"></i> Cart [${countCart }]</a>
        </li>
        </c:if>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle active" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fa-solid fa-user"></i>${user.name}</a>
          
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/user/profile">Profile</a></li>
            <li><a class="dropdown-item" href="/user/user-orders">My Orders</a></li>
            <li><a class="dropdown-item" href="/logout">Logout</a></li>
            <li><hr class="dropdown-divider"></li>
          </ul> </li>
         
        <!-- <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/logout">
          <i class="fa-solid fa-right-to-bracket"></i> Logout</a>
        </li> -->
        </c:if>
      </ul>
      
    </div>
  </div>
</nav>
<!-- End Navbar -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
 integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
 crossorigin="anonymous"></script>
</body>
</html>