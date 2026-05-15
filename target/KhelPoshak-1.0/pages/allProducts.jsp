<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>All Products - Khel Poshak</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/allProducts.css">
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
            <jsp:param name="active" value="products"/>
        </jsp:include>

        <!-- HEADER -->
        <div class="pageHeader">
            <div>
                <h1>All Products</h1>
                <p>Browse and shop your favorite jerseys</p>
            </div>
        </div>

        <!-- SEARCH + FILTER BAR -->
        <div class="filterContainer">

            <!-- Search -->
            <form action="${pageContext.request.contextPath}/products" method="get" class="searchForm">
                <input type="text" name="search" placeholder="Search products..." value="${param.search}">
                <button type="submit">Search</button>
            </form>

            <!-- Filters -->
            <form action="${pageContext.request.contextPath}/products" method="get" class="filterForm">

                <select name="category">
                    <option value="">All Categories</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.categoryId}" ${selectedCategory == cat.categoryId ? 'selected' : ''}>
                            ${cat.name}
                        </option>
                    </c:forEach>
                </select>

                <select name="sort">
                    <option value="">Sort By</option>
                    <option value="price" ${sortType == 'price' ? 'selected' : ''}>Lowest Price</option>
                    <option value="price_desc" ${sortType == 'price_desc' ? 'selected' : ''}>Highest Price</option>
                </select>

                <button type="submit">Filter</button>

                <!-- Preserve search -->
                <c:if test="${not empty param.search}">
                    <input type="hidden" name="search" value="${param.search}">
                </c:if>
            </form>
        </div>

        <!-- PRODUCT GRID -->
        <div class="productSection">
            <div class="product-grid">

                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <div class="product-img">
                            <c:if test="${not empty p.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${p.imageUrl}" 
                                     alt="${p.name}">
                            </c:if>
                            <c:if test="${empty p.imageUrl}">
                                <div style="width: 100%; height: 200px; background: #f0f0f0; display: flex; align-items: center; justify-content: center; border-radius: 8px; ">
                                    No Image
                                </div>
                            </c:if>
                        </div>
                        <h3>${p.name}</h3>
                        <p class="team">${p.team} | ${p.sport}</p>
                        <p class="price">$${p.price}</p>
                        <!-- Rest of your form -->
                        <form action="${pageContext.request.contextPath}/CartS" method="post" class="cartForm">

                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="product_id" value="${p.productId}">

                            <div class="formRow">
                                <select name="size" required>
                                    <option value="">Size</option>
                                    <option value="S">S</option>
                                    <option value="M">M</option>
                                    <option value="L">L</option>
                                    <option value="XL">XL</option>
                                    <option value="XXL">XXL</option>
                                </select>

                                <input type="number" name="quantity" value="1" min="1" max="10" required>
                            </div>

                            <button type="submit" class="cartBtn">Add to Cart</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- EMPTY STATE -->
        <c:if test="${empty products}">
            <p class="emptyMsg">No products found.</p>
        </c:if>

        <!-- BACK -->
        <div class="backContainer">
            <a href="${pageContext.request.contextPath}/homeS">← Back to Home</a>
        </div>

        <!--footer from template:  used directive include tag because of static HTML-->
        <%@include file="/templates/footer.html" %>

    </body>
</html>