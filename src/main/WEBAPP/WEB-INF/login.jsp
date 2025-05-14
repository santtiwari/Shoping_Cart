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
</head>
<body>
<%@ include file="base.jsp"%>
<section>
<div class="container mt-5 p-5">
<div class="row">
<div class="col-md-6 p-5">
<img src="/img/ecom.jpg" width="100%" height="400px">
</div>
<div class="col-md-6 mt-3 p-5">
<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
<div class="card-header bg-primary">
<p class="fs-4 text-center">Login</p>

<c:if test="${param.error != null}">
    <div class="alert alert-danger text-center">
    ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
</div>
</c:if>

<c:if test="${param.logout != null}">
    <div class="alert alert-success">Logout Successfully</div>
</c:if>


</div>
<div class="card-body">
<form action="/login" method="post">
<div class="mb-3">
<label class="form-lable">Email</label>
<input class="form-control" name="username" id="username" type="email">
</div>

<div class="mb-3">
<label class="form-lable">Password</label>
<input class="form-control" name="password" id="password" type="password">
</div>
<button type="submit" class="btn bg-primary text-white col-md-12">Login</button>
</form>
</div>

<div class="card-footer text-center">
<a href="/forgot-password" class="text-decoration-none">Forgot password</a><br>
Don't have an account ?
<a href="#" class="text-decoration-none">Create one</a>
</div>

</div>
</div>
</div>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
</html>