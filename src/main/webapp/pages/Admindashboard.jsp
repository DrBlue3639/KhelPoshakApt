<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admindashboard.css" />
        <title>Admin Dashboard Page</title>
    </head>
    <body>
        <!--     admin navigation 
            <div class="navContainer">
              <a href="${pageContext.request.contextPath}/pages/home.jsp">
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
            <jsp:param name="active" value="dashboard"/>
        </jsp:include>

        <!-- main Admin Panel Body  -->
        <div class="admintop">
            <h1>Admin Dashboard</h1>
            <p>Welcome ${sessionScope.user.fullName}</p>
            <br />
            <hr />
        </div>
        <div class="mainMenu">
            <div class="editProducts">
                <a href="${pageContext.request.contextPath}/ProdS?action=list"
                   >Manage Products</a
                >
            </div>
            <div class="addProducts">
                <a href="${pageContext.request.contextPath}/ProdS?action=add"
                   >Add Product</a
                >
                <!-- <a href="${pageContext.request.contextPath}/ProdS?action=add"
                  >Add Product</a
                > -->
            </div>
            <!--            <div class="manageOrder">
                             <a href="orders.jsp">Manage Orders</a> 
                            <a href="${pageContext.request.contextPath}/pages/manageOrders.jsp">Manage Orders</a>
                        </div>
                        <div class="manageUsers">
                             <a href="users.jsp">Manage Users</a> 
                            <a href="${pageContext.request.contextPath}/pages/manageUsers.jsp">Manage Users</a>
                        </div>-->
        </div>
    </body>
</html>
