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
<%@ include file="../base.jsp"%>

<section>
<div class="container mt-5 p-5">
<form action="/user/save-order" method="post" id="orders" novalidate>
<div class="row">
<div class="col-md-6">

<div class="mb-3 row">
<p class="text-center fs-4">Billing Address</p>
<hr>
<div class="col p-1">
<label>First Name</label>
<input type="text" name="firstName" required="required"
class="form-control mt-1">
</div>

<div class="col p-1">
<label>Last Name</label>
<input type="text" name="lastName" required="required"
class="form-control mt-1">
</div>
</div>

<div class="mb-3 row">
<div class="col p-1">
<label>Email</label>
<input type="email" name="email" required="required"
class="form-control col">
</div>
<div class="col p-1">
<label>Mobile Number</label>
<input type="text" name="mobileNo" required="required"
class="form-control col ms-2">
</div>
</div>

<div class="mb-3 row">
<div class="col p-1">
<label>Address</label>
<input type="text" name="address" required="required"
class="form-control col"></div>

<div class="col p-1">
<label>City</label>
<input type="text" name="city" required="required"
class="form-control col ms-2">
</div>
</div>
<div class="mb-3 row">
<div class="col p-1">
<label>State</label>
<input type="text" name="state" required="required"
class="form-control col"></div>

<div class="col p-1">
<label>Pincode</label>
<input type="number" name="pincode" required="required"
class="form-control col ms-2">
</div>
</div>

<%-- </form> --%>
</div>
<div class="col-md-6">
<p class="text-center fs-4">Payment Type</p>
<hr>
<div class="card">
<div class="card-body">
<table class="table table-borderless">
<tbody>
<tr>
<td>Total Price</td>
<td>:</td>
<td>&#x20B9; ${orderPrice}</td>
</tr>
<tr>
<td>Delivery Fee</td>
<td>:</td>
<td>&#x20B9; 250</td>
</tr>
<tr>
<td>Tax</td>
<td>:</td>
<td>&#x20B9; 100</td>
</tr>
<tr class="border-top">
<td>Total Price</td>
<td>:</td>
<td>&#x20B9; ${totalOrderPrice}</td>
</tr>
</tbody>
</table>
</div>
</div>
<div class="card shadow p-3 mb-5 mt-2 bg-body-tertiary rounded">

<div class="card-body">
 <%-- <form action="/login" method="post"> --%>
<div class="mb-3">
<label class="form-lable">Select Payment Type</label>
<select class="form-control" name="paymentType" required="required"> 
<option value="">--select--</option>
<option value="COD">Cash On Delivery</option>
<option value="ONLINE">Online Payment</option>
</select>
</div>

<button class="btn bg-primary text-white col-md-12">Place Order</button>
 </div>
 </div>
</div>
</div>

</form>
</div>

</section>
<%@include file="../footer.jsp" %>
</body>
</html>