<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Product</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editproduct.css">
        <style>
            .current-image {
                margin-top: 5px;
                font-size: 12px;
                color: #666;
            }
            .current-image img {
                max-width: 60px;
                max-height: 60px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-top: 5px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/templates/adminNavbar.jsp">
            <jsp:param name="active" value="manageProducts"/>
        </jsp:include>
        
        <div class="formContainer">
            <div class="formCard">
                <h2>Edit Product</h2>

                <form action="ProdS" method="post" enctype="multipart/form-data">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <input type="hidden" name="categoryId" value="${product.categoryId}">

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Name</label>
                            <input type="text" name="name" value="${product.name}">
                        </div>
                        <div class="formGroup">
                            <label>Description</label>
                            <input type="text" name="description" value="${product.description}">
                        </div>
                    </div>

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Price</label>
                            <input type="text" name="price" value="${product.price}">
                        </div>
                        <div class="formGroup">
                            <label>Team</label>
                            <input type="text" name="team" value="${product.team}">
                        </div>
                    </div>

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Sport</label>
                            <input type="text" name="sport" value="${product.sport}">
                        </div>
                        <div class="formGroup">
                            <label>Player</label>
                            <input type="text" name="playerName" value="${product.playerName}">
                        </div>
                    </div>

                    <div class="formGroup">
                        <label>Sizes Available</label>
                        <input type="text" name="sizesAvailable" value="${product.sizesAvailable}">
                    </div>

                    <!-- Show current image -->
                    <div class="formGroup">
                        <label>Current Image</label>
                        <div class="current-image">
                            <c:if test="${not empty product.imageUrl}">
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="Product">
                                <br>${product.imageUrl}
                            </c:if>
                            <c:if test="${empty product.imageUrl}">
                                No image uploaded
                            </c:if>
                        </div>
                    </div>

                    <!-- Upload new image -->
                    <div class="formGroup">
                        <label>Change Image (Optional)</label>
                        <input type="file" name="image" accept="image/*">
                        <small>Leave empty to keep current image</small>
                    </div>

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Stock S</label>
                            <input type="text" name="stockS" value="${product.stockS}">
                        </div>
                        <div class="formGroup">
                            <label>Stock M</label>
                            <input type="text" name="stockM" value="${product.stockM}">
                        </div>
                        <div class="formGroup">
                            <label>Stock L</label>
                            <input type="text" name="stockL" value="${product.stockL}">
                        </div>
                    </div>

                    <div class="formRow">
                        <div class="formGroup">
                            <label>Stock XL</label>
                            <input type="text" name="stockXl" value="${product.stockXl}">
                        </div>
                        <div class="formGroup">
                            <label>Stock XXL</label>
                            <input type="text" name="stockXxl" value="${product.stockXxl}">
                        </div>
                    </div>

                    <button type="submit" class="submitBtn">Update Product</button>
                </form>

                <a href="ProdS?action=list" class="backLink">← Back</a>
            </div>
        </div>
    </body>
</html>