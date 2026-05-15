<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manageproduct.css" />

        <title>Edit Products</title>
    </head>

    <body>

        <!-- NAVBAR 
        <div class="navContainer">
              <a href="${pageContext.request.contextPath}/pages/index.html">
                <div class="logo">
                  <img
                    src="/resources/Logo_heart-pulse-solid.png"
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
                  <li>
                    <a href="${pageContext.request.contextPath}/pages/Admindashboard.jsp" style="color: rgb(21, 88, 246)"
                      >Dashboard</a
                    >
                  </li>
                  <li><a href="${pageContext.request.contextPath}/pages/editProduct.jsp">Manage Products</a></li>
                  <li><a href="${pageContext.request.contextPath}/pages/manageOrders.jsp">Manage Orders</a></li>
                  <li>
                    <a href="${pageContext.request.contextPath}/LogoutS">Logout</a>
                  </li>
                </ul>
              </nav>
            </div>-->
        <!-- NAVBAR TEMPLATE -->
        <jsp:include page="/templates/adminNavbar.jsp">
            <jsp:param name="active" value="manageProducts"/>
        </jsp:include>

        <!-- PAGE HEADER -->
        <div class="pageHeader">
            <div>
                <h1>Manage Products</h1>
                <p>Edit, update or remove jersey listings</p>
            </div>

            <a href="${pageContext.request.contextPath}/ProdS?action=add" class="addBtn">
                + Add Product
            </a>
        </div>

        <!-- TABLE CARD -->
        <div class="tableCard">

            <table class="product-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Team</th>
                        <th>Price</th>
                        <th>Stock</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.productId}</td>
                            <td>${p.name}</td>
                            <td>${p.team}</td>
                            <td>Rs. ${p.price}</td>
                            <td>
                                <span class="stock">S:${p.stockS}</span>
                                <span class="stock">M:${p.stockM}</span>
                                <span class="stock">L:${p.stockL}</span>
                            </td>
                            <td class="actions">
                                <a href="${pageContext.request.contextPath}/ProdS?action=edit&product_id=${p.productId}" class="editBtn">
                                    Edit
                                </a>

                                <a href="${pageContext.request.contextPath}/ProdS?action=delete&product_id=${p.productId}"
                                   onclick="return confirm('Delete this product?')"
                                   class="deleteBtn">
                                    Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </body>
</html>