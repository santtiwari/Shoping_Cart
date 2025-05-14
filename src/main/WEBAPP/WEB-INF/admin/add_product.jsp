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
<!-- sweat alert message -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->
<!-- sweat alert cdn message -->
</head>
<body>

<%
    // Retrieve messages from session
    String successMsg = (String) session.getAttribute("succMsg");
    System.out.println("successMsg :: "+successMsg);
    String errorMsg = (String) session.getAttribute("errorMsg");
    System.out.println("errorMsg :: "+errorMsg);
    // Remove attributes immediately to prevent repeated alerts
    session.removeAttribute("succMsg");
    session.removeAttribute("errorMsg");
%>

<script>
    var successMsg = "<%= successMsg != null ? successMsg : "" %>";
    //alert(successMsg);
    var errorMsg = "<%= errorMsg != null ? errorMsg : "" %>";
    //alert(errorMsg);

    if (successMsg.trim() !== "") {
        swal("Good job!", successMsg, "success");
    }

    if (errorMsg.trim() !== "") {
        swal("Error!", errorMsg, "error");
    }
</script>


<%@ include file="../base.jsp"%>
<section>
<div class="container p-5 mt-3">
<div class="row">
<div class="col-md-6 offset-md-2">
<div class="card shadow">
<div class="card-header bg-primary text-center fs-4">Add Product</div>
<div class="card-body">
<form action="/admin/saveProduct" method="post" enctype="multipart/form-data">
<div class="mb-3">
<label>Enter Title</label>
<input type="text" name="title" class="form-control">
</div>

<div class="mb-3">
<label>Enter Description</label>
<textarea rows="3" cols="" name="description" class="form-control"></textarea>
</div>

<div class="mb-3">
<label>Category</label>
<select class="form-control" name="category">
<option>--Select--</option>
<c:forEach var="c" items="${categories}">
<option>${c.name}</option>
</c:forEach>
</select>
</div>

<div class="mb-3">
<label>Enter Price</label>
<input type="number" name="price" class="form-control">
</div>

<div class="mb-3">
<label>Status</label>
<div class="form-check">
<input class="form-check-input" type="radio" name="isActive"
id="flexRadioDefault1" checked value="true"> <label
class="form-check-label" for="flexRadioDefault1">
Active </label>
</div>
<div class="form-check">
<input class="form-check-input" type="radio" name="isActive"
id="flexRadioDefault2" value="false"> <label
class="form-check-label" for="flexRadioDefault2">
Inactive </label>
</div>
</div>

<div class="row">

<div class="mb-3 col">
<label>Enter Stock</label>
<input type="text" name="stock" class="form-control">
</div>

<div class="mb-3 col">
<label>Upload Image</label>
<input type="file" name="file" class="form-control">
</div>

</div>
<button class="btn btn-primary col-md-12">Submit</button>

</form>
</div>
</div>
</div>
</div>
</div>
</section>

<%@ include file="../footer.jsp" %>
</body>
</html>