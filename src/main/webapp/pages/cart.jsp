<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
</head>
<body>
    
<!--     navigation container 
    <div class="navContainer">
      <a href="index.html">
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
          <li><a href="index.html">Home</a></li>
          <li><a href="#">About</a></li>
          <li><a href="#">Contact</a></li>
          <li id="Login">
            <a href="pages/Login.html" style="color: rgb(21, 88, 246)">Login</a>
          </li>
          <a href="pages/Register.html"><button>Register</button></a>
        </ul>
      </nav>
    </div>-->
        <!-- NAVBAR TEMPLATE -->
    <jsp:include page="/templates/navbar.jsp">
        <jsp:param name="active" value="home"/>
    </jsp:include>
    

    <!-- PAGE HEADER -->
    <div class="pageHeader">
        <h1>Your Shopping Cart</h1>
        <p>Review your items before checkout</p>
    </div>

    <!-- EMPTY CART -->
    <c:if test="${empty cartItems}">
        <div class="emptyCart">
            <p>Your cart is empty</p>
            <a href="${pageContext.request.contextPath}/homeS" class="primaryBtn">
                Continue Shopping
            </a>
        </div>
    </c:if>

    <!-- CART CONTENT -->
    <c:if test="${not empty cartItems}">

        <div class="cartContainer">

            <!-- TABLE -->
            <table class="cartTable">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Size</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr>

                            <td class="productName">${item.name}</td>

                            <td>${item.size}</td>

                            <td>$${item.price}</td>

                            <td>
                                <form action="${pageContext.request.contextPath}/CartS" method="post" class="qtyForm">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="product_id" value="${item.productId}">
                                    <input type="hidden" name="size" value="${item.size}">

                                    <input type="number" name="quantity"
                                           value="${item.quantity}" min="1">

                                    <button type="submit">Update</button>
                                </form>
                            </td>

                            <td class="subtotal">$${item.subtotal}</td>

                            <td>
                                <a href="${pageContext.request.contextPath}/CartS?action=remove&product_id=${item.productId}&size=${item.size}"
                                   class="removeBtn"
                                   onclick="return confirm('Remove this item?')">
                                    Remove
                                </a>
                            </td>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- TOTAL + ACTIONS -->
            <div class="cartSummary">

                <div class="totalBox">
                    <span>Total:</span>
                    <strong>$${total}</strong>
                </div>

                <div class="cartActions">
                    <a href="${pageContext.request.contextPath}/CheckoutS" class="checkoutBtn">
                        Proceed to Checkout
                    </a>

                    <a href="${pageContext.request.contextPath}/homeS" class="secondaryBtn">
                        Continue Shopping
                    </a>
                </div>

            </div>

        </div>

    </c:if>

    <!-- BACK -->
    <div class="backContainer">
        <a href="${pageContext.request.contextPath}/homeS">← Back to Home</a>
    </div>

</body>
</html>