<%-- Document : adminNavbar Created on : May 7, 2026, 8:41:42 PM Author : ACER
--%> <%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib
    uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <link
        rel="stylesheet"
        href="${pageContext.request.contextPath}/css/navbar.css"
        />

    <div class="navContainer">
        <!-- LOGO -->
        <a href="${pageContext.request.contextPath}/pages/Admindashboard.jsp">
            <div class="logo">
                <img
                    src="${pageContext.request.contextPath}/resources/khelPoshakBlacklogo.png"
                    width="35px"
                    />

                <div class="logotext">
                    <b>KhelPoshak Admin</b>
                </div>
            </div>
        </a>

        <!-- NAVIGATION -->
        <nav class="navigation">
            <ul>
                <li>
                    <a
                        href="${pageContext.request.contextPath}/pages/Admindashboard.jsp"
                        class="${param.active == 'dashboard' ? 'active' : ''}"
                        >
                        Dashboard
                    </a>
                </li>

                <li>
                    <a
                        href="${pageContext.request.contextPath}/ProdS?action=list"
                        class="${param.active == 'manageProducts' ? 'active' : ''}"
                        >
                        Manage Products
                    </a>
                </li>

                <li>
                    <a
                        href="${pageContext.request.contextPath}/ProdS?action=add"
                        class="${param.active == 'addProducts' ? 'active' : ''}"
                        >
                        Add Products
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/AdminDashboardS" class="${param.active == 'analytics' ? 'active' : ''}">
                        Analytics
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/LogoutS" class="logoutBtn">
                        Logout
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/ProfileS"
                       class="${param.active == 'profile' ? 'active' : ''}">
                        My Profile
                    </a>
                </li>

            </ul>
        </nav>
    </div>
