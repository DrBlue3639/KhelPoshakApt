<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Khel Poshak - Home</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_css.css">
    </head>

    <body>

        <!-- NAVBAR TEMPLATE -->
        <jsp:include page="/templates/navbar.jsp">
            <jsp:param name="active" value="home"/>
        </jsp:include>

        <!-- MAIN INTRO SECTION -->
        <div id="introductionContainer">

            <div class="BigLogo">
                <img
                    src="${pageContext.request.contextPath}/resources/khelPoshakWhitelogo.png"
                    alt="logo"
                    width="100px"
                    />
            </div>

            <div class="mainText">
                <h1>Buy Official Sports Jerseys Easily</h1>
                <p>Find your favorite team and player jerseys</p>
            </div>

            <!-- SEARCH + FILTER -->
            <div class="searchSection">

                <!-- SEARCH -->
                <form action="${pageContext.request.contextPath}/homeS" method="get" class="searchForm">
                    <div class="searchbar">
                        <input type="text" name="search"
                               placeholder="Search jersey, teams, players..."
                               value="${param.search}">
                        <button type="submit">Search</button>
                    </div>
                </form>

                <!-- FILTER -->
                <form action="${pageContext.request.contextPath}/homeS" method="get" class="filterForm">

                    <select name="category">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.categoryId}">
                                ${cat.name}
                            </option>
                        </c:forEach>
                    </select>

                    <select name="sort">
                        <option value="">Sort By</option>
                        <option value="price">Highest Price</option>
                    </select>

                    <button type="submit">Filter</button>
                </form>

            </div>

        </div>

        <!-- FEATURED PRODUCTS -->
        <div class="productSection">
            <h2>Featured Jerseys</h2>

            <div class="product-grid">

                <c:forEach var="p" items="${products}">
                    <div class="product-card">
                        <!-- Add image display -->
                        <div class="product-img">
                            <c:if test="${not empty p.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${p.imageUrl}" 
                                     alt="${p.name}">
                            </c:if>
                            <c:if test="${empty p.imageUrl}">
                                <div style="width: 100%; height: 180px; background: #ddd; display: flex; align-items: center; justify-content: center;">
                                    No Image
                                </div>
                            </c:if>
                        </div>

                        <h3>${p.name}</h3>
                        <p class="team">${p.team}</p>
                        <p class="price">$${p.price}</p>

                        <!-- Rest of your form remains same -->
                        <form action="${pageContext.request.contextPath}/CartS" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="product_id" value="${p.productId}">
                            <select name="size" required class="sizeSelection">
                                <option value="">Size</option>
                                <option value="S">S</option>
                                <option value="M">M</option>
                                <option value="L">L</option>
                                <option value="XL">XL</option>
                                <option value="XXL">XXL</option>
                            </select>
                            <input type="hidden" name="quantity" value="1">
                            <button type="submit" class="buyBtn">Add to Cart</button>
                        </form>
                    </div>
                </c:forEach>

            </div>
        </div>

        <!-- What we have for you section -->
        <div class="shopSection">
            <h2>What we have for you!!!</h2>

            <div class="sportGrid">

                <div class="sportCard footballCard">
                        <h3>Football</h3>
                        <p>Browse Football jerseys</p>
                </div>

                <div class="sportCard cricketCard">
                    <h3>Cricket</h3>
                    <p>Browse Cricket jerseys</p>
                </div>

                <div class="sportCard basketballCard">
                    <h3>Basketball</h3>
                    <p>Browse Basketball jerseys</p>
                </div>

            </div>
        </div>

        <!--footer from template:  used directive include tag because of static HTML-->
        <%@include file="/templates/footer.html" %>

    </body>
</html>