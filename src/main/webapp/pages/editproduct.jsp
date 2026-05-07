<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Edit Product</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editproduct.css">
    </head>

    <body>

        <div class="formContainer">

            <div class="formCard">
                <h2>Edit Product</h2>

                <form action="ProdS" method="post">

                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="productId" value="${product.productId}">
                    <input type="hidden" name="categoryId" value="${product.categoryId}">

                    <!-- Row 1 -->
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

                    <!-- Row 2 -->
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

                    <!-- Row 3 -->
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

                    <!-- Stock Rows -->
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