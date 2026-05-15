<%-- 
    Document   : navbar
    Created on : May 6, 2026, 10:11:05 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/navbar.css"/>

<div class="navContainer">

    <!-- LOGO -->
    <a href="${pageContext.request.contextPath}/homeS">

        <div class="logo">

            <img
                src="${pageContext.request.contextPath}/resources/khelPoshakBlacklogo.png"
                width="35px"
                />

            <div class="logotext">
                <b>KhelPoshak</b>
            </div>

        </div>

    </a>

    <!-- NAVIGATION -->
    <nav class="navigation">

        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/ProfileS"
                   class="${param.active == 'profile' ? 'active' : ''}">
                    My Profile
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/homeS"
                   class="${param.active == 'home' ? 'active' : ''}">
                    Home
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/products"
                   class="${param.active == 'products' ? 'active' : ''}">
                    All Products
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/pages/about.jsp"
                   class="${param.active == 'aboutus' ? 'active' : ''}">
                    About Us
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/pages/contact.jsp"
                   class="${param.active == 'contactus' ? 'active' : ''}">
                    Contact Us
                </a>
            </li>

            <!-- LOGGED IN -->
            <c:if test="${not empty sessionScope.user}">

                <li class="welcomeText">
                    Welcome, ${sessionScope.user.fullName}
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/CartS"
                       class="${param.active == 'cart' ? 'active' : ''}">
                        Cart
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/OrderHistoryS"
                       class="${param.active == 'orders' ? 'active' : ''}">
                        My Orders
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/LogoutS">
                        Logout
                    </a>
                </li>


            </c:if>

            <!-- NOT LOGGED IN -->
            <c:if test="${empty sessionScope.user}">

                <li>
                    <a href="${pageContext.request.contextPath}/pages/login.jsp"
                       class="${param.active == 'login' ? 'active' : ''}">
                        Login
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/pages/register.jsp">
                        <button>
                            Register
                        </button>
                    </a>
                </li>

            </c:if>

        </ul>

    </nav>

</div>
