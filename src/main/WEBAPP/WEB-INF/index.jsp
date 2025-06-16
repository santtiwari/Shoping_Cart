<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Index Page</title>
</head>
<body>
	<%@ include file="base.jsp"%>
	<!-- Carousel start Bootstrap -->
	<%-- <img alt="" src="<c:url value='/img/notes_img.jpg'/>" width="100%" height="auto"> --%>
	<section>
	<!-- start slider -->
		<div id="carouselExample" class="carousel slide">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="/img/shopcart1.jpeg" class="d-block w-100" alt="..."
					height="350px">
				</div>
				<div class="carousel-item">
					<img src="/img/house.jpg" class="d-block w-100" alt="..."
					height="350px">
				</div>
				<div class="carousel-item">
					<img src="/img/woodland.jpg" class="d-block w-100" alt="..."
					height="350px">
				</div>
			</div>
			 <!-- Previous & Next Buttons -->
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExample" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExample" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
		<!-- End slider -->
		
		<!-- start category Module -->
		<div class="container">
		<div class="row">
		<p class="text-center fs-4">Category</p>
		<c:forEach var="c" items="${category}">
		<div class="col-md-2">
		<div class="card rounded-circle shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="${pageContext.request.contextPath}/img/category_img/${c.imageName}" width="65%" height="140px"><br>
		<a href="/products?category=${c.name}" class="text-decoration-none">${c.name}</a>

		</div>
		</div>
		</div>
		</c:forEach>
		<!-- <div class="col-md-2">
		<div class="card rounded-circle shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/category_img/beauty.jpg" width="65%" height="140px">
		<p>Beauty</p>
		</div>
		</div>
		</div> -->
		
		<!-- <div class="col-md-2">
		<div class="card rounded-circle shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/category_img/electronic.jpg" width="65%" height="140px">
		<p>Electronic</p>
		</div>
		</div>
		</div> -->
		
		<!-- <div class="col-md-2">
		<div class="card rounded-circle shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/category_img/grocery.jpg" width="65%" height="140px">
		<p>Grocery</p>
		</div>
		</div>
		</div> -->
		
		<!-- <div class="col-md-2">
		<div class="card rounded-circle shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/category_img/mobile.jpg" width="65%" height="140px">
		<p>Mobile</p>
		</div>
		</div>
		</div> -->
		
		<!-- <div class="col-md-2">
		<div class="card rounded-circle shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/category_img/pant.jpg" width="65%" height="140px">
		<p>Clothes</p>
		</div>
		</div>
		</div> -->
		</div>
		</div>
		<!-- End category Module -->
		
		<!-- Start latest product Module -->
		<div class="container-fluid bg-light p-3">
		<div class="row">
		<p class="text-center fs-4">Latest Product</p>
		
		<c:forEach var="p" items="${products}">
		<div class="col-md-3">
		<div class="card shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="${pageContext.request.contextPath}/img/product_img/${p.image}" width="65%" height="140px">
		<p class="text-center"><a href="/product/${product.id}" class="text-decoration-none">${p.title}</a></p>
		</div>
		</div>
		</div>
		</c:forEach>
		
		<!-- <div class="col-md-3">
		<div class="card shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/product_img/laptop1.jpg" width="65%" height="140px">
		<p class="text-center">Hp Laptop</p>
		</div>
		</div>
		</div> -->
		
		<!-- <div class="col-md-3">
		<div class="card shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/product_img/laptop2.jpg" width="65%" height="140px">
		<p class="text-center">Hp Laptop</p>
		</div>
		</div>
		</div> -->
		
		<!-- <div class="col-md-3">
		<div class="card shadow-sm p-3 mb-5 bg-body-tertiary rounded">
		<div class="card-body text-center">
		<img src="/img/product_img/laptop3.jpg" width="65%" height="140px">
		<p class="text-center">Hp Laptop</p>
		</div>
		</div>
		</div> -->
		
		</div>
		</div>
		<!-- End latest product Module -->
	</section>
	<!-- Carousel start Bootstrap END -->
	<%@include file="footer.jsp" %>
</body>
</html>