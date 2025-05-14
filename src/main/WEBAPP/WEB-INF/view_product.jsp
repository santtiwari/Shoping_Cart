<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Details</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Toast styling -->
<style>
.toast-container {
	position: fixed;
	top: 40px;
	right: 40px;
	z-index: 1055;
}
</style>
</head>
<body>

	<%@ include file="base.jsp"%>

	<!-- Toast Notification Container -->
	<div class="toast-container">
		<%
			if (session.getAttribute("succMsg") != null) {
		%>
		<div class="toast text-white bg-success border-0 show" role="alert"
			aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body">
					<%=session.getAttribute("succMsg")%>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
		<%
			session.removeAttribute("succMsg");
		%>
		<%
			}
		%>

		<%
			if (session.getAttribute("errorMsg") != null) {
		%>
		<div class="toast text-white bg-danger border-0 show" role="alert"
			aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body">
					<%=session.getAttribute("errorMsg")%>
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
		<%
			session.removeAttribute("errorMsg");
		%>
		<%
			}
		%>
	</div>

	<!-- Product Detail Section -->
	<section>
		<div class="container card-sh"
			style="margin-top: 70px; margin-bottom: 100px">
			<div class="col-md-12 p-5">
				<div class="row">
					<div class="col-md-6 text-end">
						<img alt="" src="/img/product_img/laptop.jpg" width="330px"
							height="400px">
					</div>
					<div class="col-md-6">
						<p class="fs-3">${product.title}</p>
						<p>
							<span class="fw-bold">Description:</span><br>
							${product.description}
						</p>
						<p>
							<span class="fw-bold">Product Details:</span><br> Status:
							<c:if test="${product.stock > 0}">
								<span class="badge bg-success">Available</span>
							</c:if>
							<c:if test="${product.stock <= 0}">
								<span class="badge bg-warning">Out of Stock</span>
							</c:if>
							<br> Category: ${product.category}<br> Policy: 7 Days
							Replacement & Return
						</p>
						<p class="fs-5 fw-bold">
							Price: &nbsp;&nbsp;<i class="fas fa-rupee-sign"></i>
							${product.discountPrice} <span
								class="fs-6 text-decoration-line-through text-secondary">${product.price}</span>
							<span class="fs-6 text-success">${product.discount}% off</span>
						</p>

						<div class="row">
							<div class="col-md-4 text-success text-center p-2">
								<i class="fas fa-money-bill-wave fa-2x"></i>
								<p>Cash on Delivery</p>
							</div>
							<div class="col-md-4 text-danger text-center p-2">
								<i class="fas fa-undo-alt fa-2x"></i>
								<p>Return Available</p>
							</div>
							<div class="col-md-4 text-primary text-center p-2">
								<i class="fas fa-truck-moving fa-2x"></i>
								<p>Free Shipping</p>
							</div>
						</div>

						<c:if test="${product.stock > 0}">
							<%-- If user is not logged in --%>
							<c:if test="${user == null}">
								<a href="/signin" class="btn btn-danger col-md-12">Add To
									Cart</a>
							</c:if>

							<%-- If user is logged in --%>
							<c:if test="${user != null}">
								<a href="/user/addCart?pid=${product.id}&uid=${user.id}"
									class="btn btn-danger col-md-12">Add To Cart</a>
							</c:if>

						</c:if>

						<c:if test="${product.stock <= 0}">
							<a href="login.jsp" class="btn text-white btn-warning col-md-12">Out
								of Stock</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Bootstrap JS Bundle -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Auto-dismiss toasts -->
	<script>
        document.addEventListener("DOMContentLoaded", function () {
            const toasts = document.querySelectorAll('.toast');
            toasts.forEach(toastEl => {
                new bootstrap.Toast(toastEl, { delay: 3000 }).show();
            });
        });
    </script>
</body>
</html>
