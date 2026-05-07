<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkout.css">
</head>

<body>
    
<!--     navigation container 
        <div class="navContainer">
          <a href="home.jsp">
            <div class="logo">
              <img
                src="resources/Logo_heart-pulse-solid.png"
                alt="beatLogo"
                width="35px"
              />
              <div class="logotext">
                <b>KhelPoshak</b>
              </div>
            </div>
          </a>
          <nav class="navigation">
            <ul>
              <li><a href="home.jsp">Home</a></li>
              <a href="${pageContext.request.contextPath}/products">All Products</a>
              <a href="${pageContext.request.contextPath}/OrderHistoryS">My Orders</a>
              <li><a href="#">about</a></li>
              <li><a href="#">Contact</a></li>
              <li id="Login">
                <a href="${pageContext.request.contextPath}/pages/login.jsp" style="color: rgb(21, 88, 246)">Login</a>
              </li>
              <a href="${pageContext.request.contextPath}/pages/register.jsp"><button>Register</button></a>
            </ul>
          </nav>
        </div>

 wrapper to avoid navbar overlap 
<div class="pageContent">-->
        <!-- NAVBAR TEMPLATE -->
    <jsp:include page="/templates/navbar.jsp">
        <jsp:param name="active" value="home"/>
    </jsp:include>

    <!-- PAGE HEADER -->
    <div class="pageHeader">
        <h1>Checkout</h1>
        <p>Confirm your order and delivery details</p>
    </div>

    <!-- ERROR -->
    <c:if test="${not empty error}">
        <div class="errorBox">
            ${error}
        </div>
    </c:if>

    <!-- MAIN CONTAINER -->
    <div class="checkoutContainer">

        <!-- ORDER SUMMARY -->
        <div class="summaryCard">
            <h2>Order Summary</h2>

            <table class="checkoutTable">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Size</th>
                        <th>Qty</th>
                        <th>Price</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>
                            <td>${item.name}</td>
                            <td>${item.size}</td>
                            <td>${item.quantity}</td>
                            <td>$${item.price}</td>
                            <td>$${item.subtotal}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="totalBox">
                <span>Total:</span>
                <strong>$${total}</strong>
            </div>
        </div>

        <!-- SHIPPING FORM -->
        <div class="formCard">
            <h2>Shipping Information</h2>

            <form action="${pageContext.request.contextPath}/CheckoutS" method="post">

                <div class="formGroup">
                    <label>Shipping Address</label>
                    <textarea name="shippingAddress" rows="3" required></textarea>
                </div>

                <div class="formGroup">
                    <label>Phone Number</label>
                    <input type="tel" name="phone" required>
                </div>

                <div class="formGroup">
                    <label>Payment Method</label>
                    <select name="paymentMethod" required>
                        <option value="">Select Payment Method</option>
                        <option value="Cash on Delivery">Cash on Delivery</option>
                        <option value="Credit Card">Credit Card</option>
                        <option value="Esewa">Esewa</option>
                        <option value="Khalti">Khalti</option>
                    </select>
                </div>

                <button type="submit" class="checkoutBtn">
                    Place Order
                </button>

            </form>

            <a href="${pageContext.request.contextPath}/CartS" class="backLink">
                ← Back to Cart
            </a>
        </div>

    </div>

</div>

</body>
</html>