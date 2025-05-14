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

	<%@ include file="base.jsp"%>
	<section>
		<div class="container mt-5 p-5">
			<div class="row">
				<div class="col-md-5 p-1">
					<img src="/img/ecom.jpg" width="100%" height="400px">
				</div>
				<div class="col-md-7 p-2">
					<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
						<div class="card-header bg-primary">
							<p class="fs-4 text-center">Register</p>
						</div>
						<div class="card-body">
							<form action="/saveUser"  method="post" enctype="multipart/form-data">
							<div class="row">
								<div class="col">
									<label class="form-lable">FullName</label> <input
										class="form-control" name="name" id="name" type="text">
								</div>

								<div class="col">
									<label class="form-lable">Mobile Number</label> <input
										class="form-control" name="mobilenumber" id="mobilenumber"
										type="number">
										</div>
								</div>
								
								<div class="mb-3">
									<label class="form-lable">Email</label> <input
										class="form-control" name="email" id="email" type="email">
								</div>
							
							<div class="row">
								<div class="col">
									<label class="form-lable">Address</label> <input
										class="form-control" name="address" id="address" type="text">
								</div>

								<div class="col">
									<label class="form-lable">City</label> <input
										class="form-control" name="city" id="city"
										type="text">
										</div>
								</div>
								
								<div class="row">
								<div class="col">
									<label class="form-lable">State</label> <input
										class="form-control" name="state" id="state" type="text">
								</div>

								<div class="col">
									<label class="form-lable">Pincode</label> <input
										class="form-control" name="pin" id="number"
										type="text">
										</div>
								</div>
								
								<div class="row">
								<div class="col">
									<label class="form-lable">Password</label> <input
										class="form-control" name="password" id="password" type="password">
								</div>

								<div class="col">
									<label class="form-lable">Confirm Password</label> <input
										class="form-control" name="cpassword" id="cpassword"
										type="password">
										</div>
								</div>
								
								
								<div class="mb-3">
									<label class="form-lable">Profile Image</label> <input
										class="form-control" name="img" id="img" type="file">
								</div>
								
								
								<button type="submit"
									class="btn bg-primary text-white col-md-12">Register</button>
							</form>
						</div>

						<div class="card-footer text-center">
							
							have an account ? <a href="/login" class="text-decoration-none">Login</a>
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>
	<%@include file="footer.jsp"%>
</body>
</html>