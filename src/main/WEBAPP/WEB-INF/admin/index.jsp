<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

</head>
<body>
<%@ include file="../base.jsp"%>
<section>
<div class="container-fluid p-5">
<p class="text-center fs-3 mt-4">Admin Dashboard</p>
<div class="row p-5">
<div class="col-md-4">
<a href="/admin/loadAddProduct" class="text-decoration-none" >
<div class="card shadow mb-2 rounded">
<div class="card-body text-center text-primary">
<i class="fa-solid fa-square-plus fa-3x"></i>
<h4>Add Product</h4>
</div>
</div>
</a>
</div>

<div class="col-md-4">
<a href="/admin/category" class="text-decoration-none" >
<div class="card shadow mb-2 rounded">
<div class="card-body text-center text-warning">
<i class="fa-solid fa-list fa-3x"></i>
<h4>Add Category</h4>
</div>
</div>
</a>
</div>

<div class="col-md-4">
<a href="/admin/products" class="text-decoration-none" >
<div class="card shadow mb-2 rounded">
<div class="card-body text-center text-success">
<i class="fa-solid fa-table-list fa-3x"></i>
<h4>View Product</h4>
</div>
</div>
</a>
</div>

<div class="col-md-4">
<a href="/admin/orders" class="text-decoration-none" >
<div class="card shadow mb-2 rounded">
<div class="card-body text-center text-warning">
<i class="fa-solid fa-box-open fa-3x"></i>
<h4>Orders</h4>
</div>
</div>
</a>
</div>

<div class="col-md-4">
<a href="/admin/users" class="text-decoration-none" >
<div class="card shadow mb-2 rounded">
<div class="card-body text-center text-primary">
<i class="fa-solid fa-user-tie fa-3x"></i>
<h4>User</h4>
</div>
</div>
</a>
</div>

<div class="col-md-4">
<a href="#" class="text-decoration-none" >
<div class="card shadow mb-2 rounded">
<div class="card-body text-center text-primary">
<i class="fa-solid fa-user-plus fa-3x"></i>
<h4>Add Admin</h4>
</div>
</div>
</a>
</div>

</div>
</div>
</section>
<%@include file="../footer.jsp"%>
</body>
</html>