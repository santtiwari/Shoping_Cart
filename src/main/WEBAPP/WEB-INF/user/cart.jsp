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
<div class="container-fluid mt-5 p-5">
<!-- <div class="row">
<div class="col-md-10 offset-md-1"> -->
<div class="card shadow p-3 mb-5 bg-body rounded">
<div class="card-header bg-primary text-center">
<p class="fs-4">Cart Page</p>
</div>
<div class="card-body">
<table class="table">
  <thead>
    <tr>
      <th scope="col">Sl.No</th>
      <th scope="col">Image</th>
      <th scope="col">Product Name</th>
      <th scope="col">Price</th>
      <th scope="col" class="text-center">Quantity</th>
      <th scope="col">Total Price</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="cart" items="${carts}" varStatus="status">
    <tr>
       <th scope="row">${status.count}</th> 
      <td>
      <img src="<c:url value='/img/product_img/${cart.product.image}' />" width="50" height="50" alt="">
      </td>
      <td>${cart.product.title}</td>
      <td>${cart.product.discountPrice}</td>
      <td>
  <a href="<c:url value='/user/cartQuantityUpdate'>
              <c:param name='sy' value='de'/>
              <c:param name='cid' value='${cart.id}'/>
           </c:url>">
    <i class="fa-solid fa-minus"></i>
  </a>
  [ ${cart.quantity} ]
  <a href="<c:url value='/user/cartQuantityUpdate'>
              <c:param name='sy' value='in'/>
              <c:param name='cid' value='${cart.id}'/>
           </c:url>">
    <i class="fa-solid fa-plus"></i>
  </a>
</td>
      <td>${cart.totalPrice}</td>
    </tr>
    </c:forEach>
    <tr>
    <td colspan="4"></td>
    <td class="fw-bold">Total Price</td>
    <td class="fw-bold">&#8377; ${totalOrderPrice }</td>
    </tr>
    
  </tbody>
</table>
<div class="text-center">
<a href="/user/orders" class="btn btn-outline-warning">Proceed Payment</a>
</div>
</div>
</div>
</div>
<!-- </div>
</div> -->
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>