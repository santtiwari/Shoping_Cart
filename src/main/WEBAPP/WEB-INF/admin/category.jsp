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
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->
<!-- sweat alert cdn message -->

</head>
<body>

	<%
		// Retrieve messages from session
		String successMsg = (String) session.getAttribute("succMsg");
		System.out.println("successMsg :: " + successMsg);
		String errorMsg = (String) session.getAttribute("errorMsg");
		System.out.println("errorMsg :: " + errorMsg);
		// Remove attributes immediately to prevent repeated alerts
		session.removeAttribute("succMsg");
		session.removeAttribute("errorMsg");
	%>

	<script>
    var successMsg = "<%=successMsg != null ? successMsg : ""%>";
    //alert(successMsg);
    var errorMsg = "<%=errorMsg != null ? errorMsg : ""%>
		";
		//alert(errorMsg);

		if (successMsg.trim() !== "") {
			swal("Good job!", successMsg, "success");
		}

		if (errorMsg.trim() !== "") {
			swal("Error!", errorMsg, "error");
		}
	</script>


	<!-- Your category form here -->

	<%@ include file="../base.jsp"%>
	<section>
		<div class="container-fluid p-5 mt-5">
			<div class="row">
				<div class="col-md-3">
					<div class="card shadow">
						<div class="card-header text-center fs-4 bg-primary">Add
							Category</div>
						<div class="card-body">
							<form action="/admin/saveCategory" method="post"
								enctype="multipart/form-data">

								<div class="mb-3">
									<label>Enter Category</label> <input type="text"
										class="form-control" name="name">
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

								<div class="mb-3">
									<label>Upload Image</label> <input type="file"
										class="form-control" name="file">
								</div>
								<button class="btn btn-outline-primary col-md-12 mt-2">
									<i class="fa fa-save"></i>Save
								</button>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-8">
					<div class="card shadow">
						<div class="card-header text-center fs-4 bg-primary">Category
							Details</div>
						<div class="card-body">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">Sl No</th>
										<th scope="col">Category</th>
										<th scope="col">Status</th>
										<th scope="col">Image</th>
										<th scope="col">Action</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="category" items="${categorys}">
										<tr>
											<th scope="row">${category.id}</th>
											<td>${category.name}</td>
											<td>${category.isActive}</td>
											<td><img alt=""
												src="/img/category_img/${category.imageName}" width="50px"
												height="50px"></td>
											<td><a href="/admin/loadEditCategory/${category.id}"
												class="btn btn-outline-primary btn-sm"><i
													class="fa-solid fa-pen-to-square text-primary fa-1x"></i>Edit</a>
												<a href="/admin/deleteCategory/${category.id}"
												class="btn btn-outline-danger btn-sm"><i
													class="fa-solid fa-trash-arrow-up text-danger fa-1x"></i>Delete</a>
											</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
							<!-- start pagination -->
							<div class="row">
								<div class="col-md-4">Total Products : [${totalElements }]</div>
								<div class="col-md-6">
									<c:if test="${productsSize> 0}">
										<nav aria-label="Page navigation example">
											<ul class="pagination">
												<li class="page-item ${isFirst ? 'disabled' : ''}"><a
													class="page-link"
													href="${pageContext.request.contextPath}/products?pageNo=${pageNo - 1}"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												</a></li>

												<c:forEach var="i" begin="1" end="${totalPages}">
													<li class="page-item ${i == (pageNo + 1) ? 'active' : ''}">
														<a class="page-link"
														href="${pageContext.request.contextPath}/products?pageNo=${i - 1}">${i}</a>
													</li>
												</c:forEach>

												<li class="page-item ${isLast ? 'disabled' : ''}"><a
													class="page-link"
													href="${pageContext.request.contextPath}/products?pageNo=${pageNo + 1}"
													aria-label="Next"> <span aria-hidden="true">&raquo;</span>
												</a></li>
											</ul>
										</nav>
								</div>
								</c:if>
							</div>

						</div>
					</div>
				</div>

			</div>
		</div>
	</section>
	<%@ include file="../footer.jsp"%>
	<!-- <script>
    function confirmSave() {
        Swal.fire({
            title: "Are you sure?",
            text: "Do you really want to save this category?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes, save it!"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("categoryForm").submit();
            }
        });
    }
</script> -->

</body>
</html>