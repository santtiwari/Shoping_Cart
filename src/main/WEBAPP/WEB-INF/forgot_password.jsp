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
    //System.out.println("successMsg :: "+successMsg);
    String errorMsg = (String) session.getAttribute("errorMsg");
    //System.out.println("errorMsg :: "+errorMsg);
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
<div class="col-md-6 p-5">
<img src="/img/ecom.jpg" width="100%" height="400px">
</div>
<div class="col-md-6 mt-3 p-5">
<div class="card shadow p-3 mb-5 bg-body-tertiary rounded">
<div class="card-header bg-primary">
<p class="fs-4 text-center">Forgot Password</p>

</div>
<div class="card-body">
<form action="/forgot-password" method="post">
<div class="mb-3">
<label class="form-lable">Email</label>
<input class="form-control" name="email" id="email" type="email" placeholder="Enter your email" required>
</div>
<div class="text-center">
<button type="submit" class="btn bg-primary text-white">Send</button>
</div>

</form>
</div>

</div>
</div>
</div>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
</html>