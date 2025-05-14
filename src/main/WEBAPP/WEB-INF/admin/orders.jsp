<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Orders</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
</head>
<body>
<%@ include file="../base.jsp"%>

<%
    String successMsg = (String) session.getAttribute("succMsg");
    String errorMsg = (String) session.getAttribute("errorMsg");
    session.removeAttribute("succMsg");
    session.removeAttribute("errorMsg");
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

<section>
    <div class="container mt-5 p-2">
        <div class="row">
            <p class="text-center fs-3 mt-2">All Orders</p>
            <hr>
            <a href="/admin/" class="text-decoration-none"><i class="fa-solid fa-arrow-left"></i> Back</a>

            <div class="col-md-4 p-4">
                <form action="/admin/search-order" method="get">
                    <div class="row">
                        <div class="col">
                            <input type="text" class="form-control" name="orderId"  placeholder="Enter order Id">
                        </div>
                        <div class="col">
                            <button class="btn btn-primary">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="col-md-12 ps-2 pe-2">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th scope="col">Order Id</th>
                            <th scope="col">Deliver Details</th>
                            <th scope="col">Date</th>
                            <th scope="col">Product Details</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Price</th>
                            <th scope="col">Status</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${srch and orderDtls != null}">
                                <tr>
                                    <th scope="row">${orderDtls.orderId}</th>
                                    <td>
                                        <c:if test="${not empty orderDtls.orderAddress}">
                                            Name : ${orderDtls.orderAddress.firstName} ${orderDtls.orderAddress.lastName}<br>
                                            Email : ${orderDtls.orderAddress.email}<br>
                                            Mobno : ${orderDtls.orderAddress.mobileNo}<br>
                                            Address : ${orderDtls.orderAddress.address}<br>
                                            City : ${orderDtls.orderAddress.city}<br>
                                            State : ${orderDtls.orderAddress.state}, ${orderDtls.orderAddress.pincode}
                                        </c:if>
                                        <c:if test="${empty orderDtls.orderAddress}">
                                            Address not available
                                        </c:if>
                                    </td>
                                    <td>${orderDtls.orderDate}</td>
                                    <td>${orderDtls.product.title}</td>
                                    <td>${orderDtls.quantity}</td>
                                    <td>
                                        Quantity : ${orderDtls.quantity} <br>
                                        Price : ${orderDtls.price} <br>
                                        Total Price : ${orderDtls.quantity * orderDtls.price}
                                    </td>
                                    <td>${orderDtls.status}</td>
                                    <td>
                                        <form action="/admin/update-order-status" method="post">
                                            <input type="hidden" name="id" value="${orderDtls.id}" />
                                            <div class="row">
                                                <div class="col">
                                                    <select class="form-control" name="st">
                                                        <option>--select--</option>
                                                        <option value="1">In Progress</option>
                                                        <option value="2">Order Received</option>
                                                        <option value="3">Product Packed</option>
                                                        <option value="4">Out for Delivery</option>
                                                        <option value="5">Delivered</option>
                                                        <option value="6">Cancelled</option>
                                                    </select>
                                                </div>
                                                <div class="col">
                                                    <c:choose>
                                                        <c:when test="${orderDtls.status == 'Cancelled' || orderDtls.status == 'Delivered'}">
                                                            <button class="btn btn-primary btn-sm col disabled">Update</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn btn-primary btn-sm col">Update</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </form>
                                    </td>
                                </tr>
                            </c:when>

                            <c:when test="${srch and orderDtls == null}">
                                <tr>
                                    <td colspan="8" class="text-center text-danger">
                                        ${errorMsg}
                                    </td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <th scope="row">${order.orderId}</th>
                                        <td>
                                            <c:if test="${not empty order.orderAddress}">
                                                Name : ${order.orderAddress.firstName} ${order.orderAddress.lastName}<br>
                                                Email : ${order.orderAddress.email}<br>
                                                Mobno : ${order.orderAddress.mobileNo}<br>
                                                Address : ${order.orderAddress.address}<br>
                                                City : ${order.orderAddress.city}<br>
                                                State : ${order.orderAddress.state}, ${order.orderAddress.pincode}
                                            </c:if>
                                            <c:if test="${empty order.orderAddress}">
                                                Address not available
                                            </c:if>
                                        </td>
                                        <td>${order.orderDate}</td>
                                        <td>${order.product.title}</td>
                                        <td>${order.quantity}</td>
                                        <td>
                                            Quantity : ${order.quantity} <br>
                                            Price : ${order.price} <br>
                                            Total Price : ${order.quantity * order.price}
                                        </td>
                                        <td>${order.status}</td>
                                        <td>
                                            <form action="/admin/update-order-status" method="post">
                                                <input type="hidden" name="id" value="${order.id}" />
                                                <div class="row">
                                                    <div class="col">
                                                        <select class="form-control" name="st">
                                                            <option>--select--</option>
                                                            <option value="1">In Progress</option>
                                                            <option value="2">Order Received</option>
                                                            <option value="3">Product Packed</option>
                                                            <option value="4">Out for Delivery</option>
                                                            <option value="5">Delivered</option>
                                                            <option value="6">Cancelled</option>
                                                        </select>
                                                    </div>
                                                    <div class="col">
                                                        <c:choose>
                                                            <c:when test="${order.status == 'Cancelled' || order.status == 'Delivered'}">
                                                                <button class="btn btn-primary btn-sm col disabled">Update</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-primary btn-sm col">Update</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>

<%@ include file="../footer.jsp"%>
</body>
</html>
