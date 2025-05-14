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
<div class="container-fluid mt-4 p-3">
<div class="row">

  <p class="text-center fs-3 mt-2">All Products</p>
            <hr>
            <a href="/admin/" class="text-decoration-none"><i class="fa-solid fa-arrow-left"></i> Back</a>

            <div class="col-md-4 p-3">
                <form action="/admin/products" method="get">
                    <div class="row">
                        <div class="col">
                            <input type="text" class="form-control" name="ch">
                        </div>
                        <div class="col">
                            <button class="btn btn-primary">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>

</div>
<!-- <div class="card shadow card-sh">-->
<div class="p-3 card shadow card-sh"> 
<table class="table table-bordered">
  <thead class="table-light">
    <tr>
      <th scope="col">Sl.No</th>
      <th scope="col">Image</th>
      <th scope="col">Title</th>
      <th scope="col">Category</th>
      <th scope="col">Price</th>
      <th scope="col">Discount</th>
      <th scope="col">Discount Price</th>
      <th scope="col">Status</th>
      <th scope="col">Stock</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="product" items="${products}">
    <tr>
      <th scope="row">${product.id}</th>
      <td>
      <img src="<c:url value='/img/product_img/${product.image}' />" width="50" height="50" alt="Product Image">
      </td>
      <td>${product.title}</td>
      <td>${product.category}</td>
      <td>${product.price}</td>
      <td>${product.discount}</td>
      <td>${product.discountPrice}</td>
      <td>${product.isActive}</td>
      <td>${product.stock}</td>
      <td>
      <a href="<c:url value='/admin/editproduct/${product.id}' />" class="btn btn-outline-primary"><i class="fa-solid fa-pen-to-square"></i>Edit</a>
      <a href="<c:url value='/admin/deleteProduct/${product.id}' />" class="btn btn-outline-danger"><i class="fa-solid fa-eraser"></i>Delete</a>
      
      
      </td>
      
    </tr>
    </c:forEach>
  </tbody>
</table>
<!-- </div>-->
</div> 
</div>

</section>
<%@ include file="../footer.jsp"%>
</body>
</html>