<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!-- JSTL and Spring taglibs -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Message Page</title>

    <!-- ✅ Include Bootstrap CSS and JS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1055;
        }
    </style>
</head>
<body>

<%@ include file="base.jsp" %>

<!-- ✅ Toast container -->
<div class="toast-container">

    <!-- ❌ Error Toast -->
    <c:choose>
        <c:when test="${not empty errorMsg}">
            <div class="toast align-items-center text-white bg-danger border-0" id="errorToast">
                <div class="d-flex">
                    <div class="toast-body">${errorMsg}</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        </c:when>
        <c:when test="${not empty succMsg}">
            <div class="toast align-items-center text-white bg-success border-0" id="successToast">
                <div class="d-flex">
                    <div class="toast-body">${succMsg}</div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            </div>
        </c:when>
    </c:choose>

</div>

<!-- ✅ Script to show toast -->
<script>
    window.onload = function () {
        const errorToastEl = document.getElementById('errorToast');
        if (errorToastEl) {
            new bootstrap.Toast(errorToastEl).show();
        }

        const successToastEl = document.getElementById('successToast');
        if (successToastEl) {
            new bootstrap.Toast(successToastEl).show();
        }
    };
</script>

<!-- After message is shown, clear the model attributes -->
<c:if test="${not empty errorMsg}">
    <c:set var="errorMsg" value="" />
</c:if>

<c:if test="${not empty succMsg}">
    <c:set var="succMsg" value="" />
</c:if>

<%@ include file="footer.jsp" %>
</body>
</html>
