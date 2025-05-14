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

<!-- sweat alert cdn message -->

</head>
<body>
	<%@ include file="../base.jsp"%>
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
	<section>
		<div class="container mt-5 p-5">

			<div class="row">
			<p class="text-center fs-3">My Orders</p>
				<div class="col-md-12">
					
					<table class="table table-bordered">
  <thead>
    <tr>
      <th scope="col">Order Id</th>
      <th scope="col">Date</th>
      <th scope="col">Product Details</th>
      <th scope="col">Quantity</th>
      <th scope="col">Price</th>
      <th scope="col">Status</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="order" items="${orders}">
    <tr>
      <th scope="row">${order.orderId}</th>
      <td>${order.orderDate}</td>
      <td>${order.product.title}</td>
      <td>${order.quantity}</td>
      <td>Quantity : ${order.quantity} <br>Price : ${order.price} <br> Total Price : ${order.quantity*order.price}</td>
      <td>${order.status}</td>
      <td>
  <c:choose>
    <c:when test="${order.status == 'Cancelled'}">
      <a class="btn btn-sm btn-danger disabled">Cancelled</a>
    </c:when>
    <c:otherwise>
      <a href="<c:url value='/user/update-status?id=${order.id}&st=6' />" class="btn btn-sm btn-danger">Cancel</a>
    </c:otherwise>
  </c:choose>
</td>

    </tr>
    </c:forEach>
  </tbody>
</table>
					
					</div>
				</div>

			</div>


	</section>
	<%@include file="../footer.jsp"%>
</body>
</html>