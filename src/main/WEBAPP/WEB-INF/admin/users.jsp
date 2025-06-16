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
<c:if test="${ userType==1}">
<p class="fs-4" >Users</p>
</c:if> 
<c:if test="${userType==2}">
<p class="fs-4" >Admin</p>
</c:if>
</div>
<div class="card-body">
<table class="table">
  <thead>
    <tr>
      <th scope="col">Sl.No</th>
      <th scope="col">Profile</th>
      <th scope="col">Name</th>
      <th scope="col">Email</th>
      <th scope="col">Mobile No</th>
      <th scope="col">Address</th>
      <th scope="col">Status</th>
      
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="user" items="${users}">
    <tr>
      <th scope="row">${user.id}</th>
      <td>
      <img src="<c:url value='/img/profile_img/${user.profileimage}' />" width="50" height="50" >
      </td>
      <td>${user.name}</td>
      <td>${user.email}</td>
      <td>${user.mobilenumber}</td>
      <td>${user.address}, ${user.city}, ${user.state}, ${user.pin}</td>
      <td>${user.isEnable}</td>
      <td>
      <a href="/admin/updateSts?status=true&id=${user.id}&type=${userType}"
   class="btn btn-outline-primary">
   <i class="fa-solid fa-pen-to-square"></i>Active
    </a>
      
      <a href="/admin/updateSts?status=false&id=${user.id}&type=${userType}" 
       class="btn btn-outline-danger">
      <i class="fa-solid fa-eraser"></i>Inactive</a>
      
      
      </td>
      
    </tr>
    </c:forEach>
  </tbody>
</table>
</div>
</div>
</div>
<!-- </div>
</div> -->
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>