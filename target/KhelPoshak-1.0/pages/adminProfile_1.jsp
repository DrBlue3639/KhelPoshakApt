<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Profile - Khel Poshak</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminProfile.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admindashboard.css">
    </head>
    <body>
        <jsp:include page="/templates/adminNavbar.jsp">
            <jsp:param name="active" value="profile"/>
        </jsp:include>

        <div class="profileContainer adminProfile">
            <div class="profileHeader">
                <h1>Admin Profile</h1>
                <p>Manage your administrator account</p>
            </div>

            <c:if test="${not empty success}">
                <div class="alert success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert error">${error}</div>
            </c:if>

            <div class="profileContent">
                <div class="profileCard adminCard">
                    <div class="profileAvatar adminAvatar">
                        <div class="avatarIcon">
                            ${sessionScope.user.fullName.substring(0,1)}
                        </div>
                        <span class="adminBadge">Administrator</span>
                    </div>

                    <div class="profileInfo">
                        <div class="infoRow">
                            <label>Full Name:</label>
                            <span>${sessionScope.user.fullName}</span>
                        </div>
                        <div class="infoRow">
                            <label>Email:</label>
                            <span>${sessionScope.user.email}</span>
                        </div>
                        <div class="infoRow">
                            <label>Phone:</label>
                            <span>${not empty sessionScope.user.phone ? sessionScope.user.phone : 'Not provided'}</span>
                        </div>
                        <div class="infoRow">
                            <label>Role:</label>
                            <span class="roleBadge">${sessionScope.user.role}</span>
                        </div>
                    </div>
                </div>

                <div class="profileActions adminActions">
                    <a href="${pageContext.request.contextPath}/ProfileS?action=edit" class="btnPrimary">Edit Profile</a>
                    <a href="${pageContext.request.contextPath}/AdminDashboardS" class="btnSecondary">Dashboard</a>
                    <a href="${pageContext.request.contextPath}/ProdS?action=list" class="btnSecondary">Manage Products</a>
                </div>

                <div class="statsSection adminStats">
                    <div class="statBox">
                        <h3>Products</h3>
                        <p>Manage product catalog</p>
                        <a href="${pageContext.request.contextPath}/ProdS?action=list" class="statLink">Manage →</a>
                    </div>
                    <div class="statBox">
                        <h3>Orders</h3>
                        <p>View all customer orders</p>
                        <a href="${pageContext.request.contextPath}/pages/manageOrders.jsp" class="statLink">View →</a>
                    </div>
                    <div class="statBox">
                        <h3>Analytics</h3>
                        <p>View sales reports</p>
                        <a href="${pageContext.request.contextPath}/AdminDashboardS" class="statLink">View →</a>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="/templates/footer.html" %>
    </body>
</html>