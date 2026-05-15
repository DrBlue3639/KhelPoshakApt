<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admindashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addProduct.css" />
        <title>Add Products</title>
    </head>
    <body>
        <jsp:include page="/templates/adminNavbar.jsp">
            <jsp:param name="active" value="addProducts"/>
        </jsp:include>

        <div class="formContainer">
            <div class="formCard">
                <h2>Add Product</h2>

                <!-- IMPORTANT: Add enctype="multipart/form-data" -->
                <form action="${pageContext.request.contextPath}/ProdS?action=add" 
                      method="post" 
                      enctype="multipart/form-data">

                    <div class="formGroup">
                        <label>Name</label>
                        <input type="text" name="name" required />
                    </div>

                    <div class="formGroup">
                        <label>Description</label>
                        <input type="text" name="description" required />
                    </div>

                    <div class="formGroup">
                        <label>Price</label>
                        <input type="number" step="0.01" name="price" required />
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
                        <input type="text" name="sizesAvailable" placeholder="S,M,L,XL,XXL" />
                    </div>

                    <!-- NEW: Image Upload -->
                    <div class="formGroup">
                        <label>Product Image</label>
                        <input type="file" name="image" accept="image/*" />
                        <small>Upload JPG, PNG, or GIF (Max 5MB)</small>
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
                            <input type="number" name="stockS" value="0" />
                        </div>
                        <div class="formGroup">
                            <label>Stock M</label>
                            <input type="number" name="stockM" value="0" />
                        </div>
                        <div class="formGroup">
                            <label>Stock L</label>
                            <input type="number" name="stockL" value="0" />
                        </div>
                    </div>

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Stock XL</label>
                            <input type="number" name="stockXl" value="0" />
                        </div>
                        <div class="formGroup">
                            <label>Stock XXL</label>
                            <input type="number" name="stockXxl" value="0" />
                        </div>
                    </div>

                    <button type="submit" class="submitBtn">Add Product</button>
                </form>

                <a href="${pageContext.request.contextPath}/pages/Admindashboard.jsp" class="backLink">← Back</a>
            </div>
        </div>
    </body>
</html>