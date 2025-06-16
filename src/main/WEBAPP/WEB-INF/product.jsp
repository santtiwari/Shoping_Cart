<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!-- jstl tag library -->
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ include file="base.jsp"%>
<section>
<div class="container-fluid bg-primary p-5 mt-5">
<div class="row">
<div class="col-md-8 offset-md-2">
<form action="/products" method="get">
<div class="input-group">
<input type="text" class="form-control" name="ch">
<button class="btn btn-light text-dark ms-3 col-md-2">
<i class="fa-solid fa-magnifying-glass"></i>Search</button>
</div>
</form>
</div>
</div>
</div>

<div class="container-fluid mt-1">
<div class="row">
<div class="col-md-2 p-0">
<div class="card shadow-sm p-0 mb-5 bg-body-tertiary rounded">
<div class="card-body">
<div class="list-group">
<p class="fs-5">Category</p>
<a href="/products" class="list-group-item list-group-item-action ${empty paramValue ? 'active' : ''}"
area-current="true">All</a>

<c:forEach var="categorie" items="${categories}">
    <c:url var="categoryUrl" value="/products">
        <c:param name="category" value="${categorie.name}" />
    </c:url>
    <a href="${categoryUrl}"
       class="list-group-item list-group-item-action ${fn:trim(paramValue) == fn:trim(categorie.name) ? 'active' : ''}">
        ${categorie.name}
    </a>
</c:forEach>

</div>
</div>
</div>
</div>

<div class="col-md-10">
<div class="card shadow-sm p-3 mb-5 bg-body-tertiary rounded">
<div class="card-body">
<p class="fs-3 text-center">Products</p>
<div class="row">
<c:if test="${productsSize > 0}">
								
<c:forEach var="product" items="${products}">
<div class="col-md-3">
<div class="card">
<div class="card-body">
<img src="<c:url value='/img/product_img/${product.image}' />" width="50" height="50" alt="Product Image">
<p class="fs-5 text-center">${product.title}</p>
<div class="row text-center">
<p class="fs-6 fw-bold">
<span>&#8377; ${product.discountPrice }</span><br>
<span class="text-decoration-line-through text-secondary">&#8377; ${product.price}</span>
 <span class="fs-6 text-success">${product.discount}%off</span>
</p>
<a href="/product/${product.id}" class="btn btn-primary col-md-6 offset-md-3">View Details</a>
</div>
</div>
</div>
</div>
</c:forEach>
</c:if>
<c:if test="${productsSize <= 0}">

							<p class="fs-4 text-center mt-4 text-danger">Product not Available</p>
							</c:if>
</div>
</div>
</div>
<!-- start pagination -->
<div class="row">
<div class="col-md-4">Total Products : [${totalElements }]</div>
<div class="col-md-6">
<c:if test="${productsSize> 0}">
<nav aria-label="Page navigation example">
  <ul class="pagination">
    <li class="page-item ${isFirst ? 'disabled' : ''}">
    <a class="page-link" href="${pageContext.request.contextPath}/admin/products?pageNo=${pageNo - 1}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
    </a>
</li>

    <c:forEach var="i" begin="1" end="${totalPages}">
    <li class="page-item ${i == (pageNo + 1) ? 'active' : ''}">
        <a class="page-link" href="${pageContext.request.contextPath}/admin/products?pageNo=${i - 1}">${i}</a>
    </li>
</c:forEach>

    <li class="page-item ${isLast ? 'disabled' : ''}">
      <a class="page-link" href="${pageContext.request.contextPath}/admin/products?pageNo=${pageNo + 1}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul>
</nav>
</div>
</c:if>
</div>
</div>
</div>
</div>
</section>
</body>
</html>