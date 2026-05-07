<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Khel Poshak - Orders</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
</head>

<body>

<div class="pageContent">

    <!-- HEADER -->
    <div class="pageHeader">
        <h1>My Orders</h1>
        <p>View your past purchases and invoices</p>
    </div>

    <!-- EMPTY STATE -->
    <c:if test="${empty orders}">
        <div class="emptyState">
            <p>You haven't placed any orders yet.</p>
        </div>
    </c:if>

    <!-- ORDERS -->
    <c:if test="${not empty orders}">
        <div class="ordersContainer">

            <c:forEach var="order" items="${orders}">
                
                <div class="billCard">

                    <!-- TOP -->
                    <div class="billHeader">
                        <div>
                            <h2>Khel Poshak</h2>
                            <p class="invoiceText">Invoice</p>
                        </div>

                        <div class="status">
                            ${order.orderStatus}
                        </div>
                    </div>

                    <!-- INFO -->
                    <div class="billInfo">

                        <div>
                            <p><strong>Invoice No:</strong> ${order.orderNumber}</p>
                            <p><strong>Date:</strong> ${order.orderDate.toString().replace('T', ' ')}</p>
                        </div>

                        <div>
                            <p><strong>Payment:</strong> ${order.paymentMethod}</p>
                            <p><strong>Phone:</strong> ${order.phone}</p>
                        </div>

                    </div>

                    <div class="shippingBox">
                        <strong>Shipping Address:</strong>
                        <p>${order.shippingAddress}</p>
                    </div>

                    <!-- TABLE -->
                    <table class="billTable">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Details</th>
                                <th>Amount</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="item" items="${order.items}">
                                <tr>
                                    <td>Product #${item.productId}</td>
                                    <td>
                                        Size: ${item.size} <br>
                                        Qty: ${item.quantity} × $${item.priceAtTime}
                                    </td>
                                    <td>$${item.subtotal}</td>
                                </tr>
                            </c:forEach>

                            <tr class="totalRow">
                                <td colspan="2">Total</td>
                                <td>$${order.totalAmount}</td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- FOOTER -->
                    <div class="billFooter">
                        Thank you for shopping with Khel Poshak!
                    </div>

                </div>

            </c:forEach>

        </div>
    </c:if>

    <!-- ACTION LINKS -->
    <div class="actionLinks">
        <a href="${pageContext.request.contextPath}/homeS">Continue Shopping</a>
        <a href="${pageContext.request.contextPath}/CartS">View Cart</a>
    </div>

</div>

</body>
</html>