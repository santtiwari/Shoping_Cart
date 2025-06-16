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


<!-- Your category form here -->

	<%@ include file="../base.jsp"%>
	<section>
		<div class="container-fluid p-5 mt-5">
			<div class="row">
				<div class="col-md-3 offset-md-5">
					<div class="card shadow">
						<div class="card-header text-center fs-4 bg-primary">Edit
							Category</div>
						<div class="card-body">
						
							<form action="/admin/updateCategory" method="post" enctype="multipart/form-data">
							
							<!-- Hidden Input for Category ID (if required) -->
                            <input type="hidden" name="id" value="${category.id}">

								<div class="mb-3">
									<label>Enter Category</label> <input type="text"
										class="form-control" name="name" value="${category.name}">
								</div>

								<div class="mb-3">
									<label>Status</label>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="isActive"
											id="flexRadioDefault1"  value="true" ${category.isActive ? 'checked' : ''}> <label
											class="form-check-label" for="flexRadioDefault1">
											Active </label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="isActive"
											id="flexRadioDefault2" value="false" ${!category.isActive ? 'checked' : ''}> <label
											class="form-check-label" for="flexRadioDefault2">
											Inactive </label>
									</div>
								</div>

								<div class="mb-3">
									<label>Upload Image</label> <input type="file"
										class="form-control" name="file">
								</div>
								<c:if test="${not empty category.imageName}">
                                <img src="/img/category_img/${category.imageName}" width="100px" height="100px" alt="Category Image">
                            </c:if>
								<button class="btn btn-outline-primary col-md-12 mt-2" ><i class="fa-regular fa-pen-to-square"></i></i>Update</button>
							</form>
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