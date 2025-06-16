<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<!-- JSTL Tag Libraries -->
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Product</title>
<!-- SweetAlert Message -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
</head>
<body>

<%
    // Retrieve messages from session safely
    String successMsg = (session != null) ? (String) session.getAttribute("succMsg") : null;
    String errorMsg = (session != null) ? (String) session.getAttribute("errorMsg") : null;
    
    if (session != null) {
        session.removeAttribute("succMsg");
        session.removeAttribute("errorMsg");
    }
%>

<script>
    var successMsg = "<%= successMsg != null ? successMsg : "" %>";
    var errorMsg = "<%= errorMsg != null ? errorMsg : "" %>";

    if (successMsg.trim() !== "") {
        swal("Good job!", successMsg, "success");
    }

    if (errorMsg.trim() !== "") {
        swal("Error!", errorMsg, "error");
    }
</script>

<%@ include file="../base.jsp"%>

<section>
<div class="container p-5 mt-3">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <div class="card shadow">
                <div class="card-header text-center fs-4 bg-primary">Edit Product</div>
                <div class="card-body">
                    <form action="/admin/updateProduct" method="post" enctype="multipart/form-data">

                        <!-- Hidden Input for Product ID -->
                        <input type="hidden" name="id" value="${product.id}">

                        <div class="mb-3">
                            <label>Enter Title</label>
                            <input type="text" name="title" class="form-control" value="${product.title}">
                        </div>

                        <div class="mb-3">
                            <label>Enter Description</label>
                            <textarea rows="3" name="description" class="form-control">${product.description}</textarea>
                        </div>

                        <div class="row">
                        <div class="mb-3 col">
                            <label>Category</label>
                            <select class="form-control" name="category">
                                <option value="${product.category}" selected>${product.category}</option>
                                <c:forEach var="c" items="${categories}">
                                    <option value="${c.name}" ${c.name == product.category ? 'selected' : ''}>${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3 col">
                            <label>Enter Price</label>
                            <input type="number" name="price" class="form-control" value="${product.price}">
                        </div>
                        </div>

                        <div class="row">
                        <div class="mb-3 col">
                            <label>Discount</label>
                            <input type="number" name="discount" class="form-control" value="${product.discount}">
                            
                        </div>
                        <div class="mb-3 col">
                            <label>Discount Price</label>
                            <input type="number" class="form-control" value="${product.discountPrice}" readonly>
                        </div>
                        </div>
                        
                        <div class="mb-3">
                      <label>Status</label>
                    <div class="form-check">
                   <input class="form-check-input" type="radio" name="isActive"
                   id="flexRadioDefault1" checked value="true" ${product.isActive ? 'checked' : ''}> <label
                  class="form-check-label" for="flexRadioDefault1">
                 Active </label>
                </div>
              <div class="form-check">
             <input class="form-check-input" type="radio" name="isActive"
             id="flexRadioDefault2" value="false" ${!product.isActive ? 'checked' : ''}> <label
             class="form-check-label" for="flexRadioDefault2">
             Inactive </label>
            </div>
            </div>
                        

                        <div class="row">
                            <div class="mb-3 col">
                                <label>Enter Stock</label>
                                <input type="text" name="stock" class="form-control" value="${product.stock}">
                            </div>

                            <div class="mb-3 col">
                                <label>Upload Image</label>
                                <input type="file" name="file" class="form-control">
                            </div>
                        </div>

                        <img src="${pageContext.request.contextPath}/img/product_img/${product.image}" width="50" height="50" alt="Product Image">

                        <button class="btn btn-primary col-md-12">Update</button>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</section>

<%@ include file="../footer.jsp" %>
</body>
</html>
