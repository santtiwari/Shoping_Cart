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
    var errorMsg = "<%= errorMsg != null ? errorMsg : "" %>";

    if (successMsg.trim() !== "") {
        swal({
            title: "Success!",
            text: successMsg,
            icon: "success",
            button: "OK",
            timer: 3000,
        });
    }

    if (errorMsg.trim() !== "") {
        swal({
            title: "Oops!",
            text: errorMsg,
            icon: "error",
            button: "Try Again",
        });
    }
</script>

	
	<section>
		<div class="container-fluid mt-5 p-5 bg-light">

			<div class="row">
				<div class="col-md-10 offset-md-1">

					<p class="fs-3 text-center">My Profile</p>
					<hr>
					<div class="text-center">
						<img alt="Profile Image"
							src="../img/profile_img/${user.profileimage}" class="border p-2"
							style="width: 110px; height: 110px; border-radius: 50%;">
					</div>

					<div class="col-md-8 offset-md-2 mt-4">

						<table class="table table-borderless">

							<tbody>
								<form action="/admin/update-profile" method="post" enctype="multipart/form-data">
									<tr>
										<th scope="row">Name</th>
										<td>:</td>
										<td><input type="text" name="name" class="form-control"
											value="${user.name}"></td>

									</tr>

									<tr>
										<th scope="row">Mobile Number</th>
										<td>:</td>
										<td><input type="text" name="mobilenumber" class="form-control"
											value="${user.mobilenumber }"></td>

									</tr>

									<tr>
										<th scope="row">Email</th>
										<td>:</td>
										<td><input type="text" name="" class="form-control"
											value="${user.email }" readonly="readonly"></td>

									</tr>

									<tr>
										<th scope="row">Address</th>
										<td>:</td>
										<td><input type="text" name="address" class="form-control"
											value="${user.address }"></td>

									</tr>

									<tr>
										<th scope="row">City</th>
										<td>:</td>
										<td><input type="text" name="city" class="form-control"
											value="${user.city }"></td>

									</tr>

									<tr>
										<th scope="row">State</th>
										<td>:</td>
										<td><input type="text" name="state" class="form-control"
											value="${user.state}"></td>

									</tr>

									<tr>
										<th scope="row">PinCode</th>
										<td>:</td>
										<td><input type="text" name="" class="form-control"
											value="${user.pin}"></td>

									</tr>

									<tr>
										<th scope="row">Image</th>
										<td>:</td>
										<td><input type="file" name="img" class="form-control"
											value="8527806352"></td>

									</tr>

									<tr>
										<th scope="row">Role</th>
										<td>:</td>
										<td><input type="text" name="" class="form-control"
											value="${user.role}" readonly="readonly"></td>

									</tr>

									<tr>
										<th scope="row">Account Status</th>
										<td>:</td>
										<td><input type="text" name="isEnable" class="form-control"
											value="${user.isEnable}" readonly="readonly">
											<input type="hidden" value="${user.id}" name="id"></td>

									</tr>
									<tr>
										<td></td>
										<td class="text-center">
											<button class="btn btn-outline-success btn-sm">
												<i class="fa fa-edit"></i>Update
											</button>

										</td>
									</tr>
								</form>

							</tbody>
						</table>
					</div>

				</div>
				<hr>
				<div class="col-md-10 offset-md-1 mt-1">
					<div class="row">
						<p class="text-center fs-3">Change Password</p>
						<div class="col-md-6 offset-md-3">
							<table class="table table-borderless">

								<tbody>
									<form action="/admin/change-password" method="post">
										<tr>
											<th scope="row">Current Password</th>
											<td>:</td>
											<td><input type="password" name="currentPassword" class="form-control"></td>

										</tr>
										<tr>
											<th scope="row">New Password</th>
											<td>:</td>
											<td><input type="password" name="newPassword" class="form-control"></td>

										</tr>
										<tr>
											<th scope="row">Confirm Password</th>
											<td>:</td>
											<td><input type="password" name="confirmPassword" class="form-control"></td>

										</tr>
										<tr>
											<td></td>
											<td class="text-center">
												<button class="btn btn-outline-success btn-sm">
													<i class="fa fa-edit"></i>Update
												</button>

											</td>
											<td></td>
										</tr>
									</form>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>

	</section>
	<%@include file="../footer.jsp"%>
</body>
</html>