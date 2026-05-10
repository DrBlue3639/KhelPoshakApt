<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admindashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addProduct.css" />
        <title>Add Prodcuts</title>
    </head>
    <body>
        <!--     admin navigation 
            <div class="navContainer">
              <a href="/index.html">
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
                    <a href="/pages/Admindashboard.html" style="color: rgb(21, 88, 246)"
                      >Dashboard</a
                    >
                  </li>
                  <li><a href="/pages/editProduct.html">Manage Products</a></li>
                  <li><a href="/pages/manageOrders.html">Manage Orders</a></li>
                  <li>
                    <a href="${pageContext.request.contextPath}/LogoutS">Logout</a>
                  </li>
                </ul>
              </nav>
            </div>-->
        <!-- NAVBAR TEMPLATE -->
        <jsp:include page="/templates/adminNavbar.jsp">
            <jsp:param name="active" value="addProducts"/>
        </jsp:include>

        <!-- main part -->
        <div class="formContainer">
            <div class="formCard">
                <h2>Add Product</h2>

                <form
                    action="${pageContext.request.contextPath}/ProdS?action=add"
                    method="post"
                    >
                    <div class="formGroup">
                        <label>Name</label>
                        <input type="text" name="name" />
                    </div>

                    <div class="formGroup">
                        <label>Description</label>
                        <input type="text" name="description" />
                    </div>

                    <div class="formGroup">
                        <label>Price</label>
                        <input type="number" name="price" />
                    </div>

                    <div class="formGroup">
                        <label>Team</label>
                        <input type="text" name="team" />
                    </div>

                    <div class="formGroup">
                        <label>Sport</label>
                        <input type="text" name="sport" />
                    </div>

                    <div class="formGroup">
                        <label>Player Name</label>
                        <input type="text" name="playerName" />
                    </div>

                    <div class="formGroup">
                        <label>Sizes Available</label>
                        <input type="text" name="sizesAvailable" />
                    </div>

                    <div class="formGroup">
                        <label>Image URL</label>
                        <input type="text" name="imageUrl" />
                    </div>

                    <div class="formGroup">
                        <label>Category</label>
                        <select name="categoryId" required>
                            <option value="">Select Category</option>
                            <c:forEach items="${categories}" var="ca">
                                <option value="${ca.categoryId}">${ca.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Stock S</label>
                            <input type="number" name="stockS" />
                        </div>

                        <div class="formGroup">
                            <label>Stock M</label>
                            <input type="number" name="stockM" />
                        </div>

                        <div class="formGroup">
                            <label>Stock L</label>
                            <input type="number" name="stockL" />
                        </div>
                    </div>

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Stock XL</label>
                            <input type="number" name="stockXl" />
                        </div>

                        <div class="formGroup">
                            <label>Stock XXL</label>
                            <input type="number" name="stockXxl" />
                        </div>
                    </div>

                    <button type="submit" class="submitBtn">Add Product</button>
                </form>

                <a href="${pageContext.request.contextPath}/pages/Admindashboard.jsp" class="backLink">← Back</a>
            </div>
        </div>
    </body>
</html>

