<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>My Profile - Khel Poshak</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    </head>
    <body>
        <jsp:include page="/templates/navbar.jsp">
            <jsp:param name="active" value="profile"/>
        </jsp:include>

        <div class="profileContainer">
            <div class="profileHeader">
                <h1>My Profile</h1>
                <p>View and manage your account information</p>
            </div>

            <c:if test="${not empty success}">
                <div class="alert success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert error">${error}</div>
            </c:if>

            <div class="profileContent">
                <div class="profileCard">
                    <div class="profileAvatar">
                        <div class="avatarIcon">
                            ${sessionScope.user.fullName.substring(0,1)}
                        </div>
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
                            <label>Address:</label>
                            <span>${not empty sessionScope.user.address ? sessionScope.user.address : 'Not provided'}</span>
                        </div>
                    </div>
                </div>

                <div class="profileActions">
                    <a href="${pageContext.request.contextPath}/ProfileS?action=edit" class="btnPrimary">Edit Profile</a>
                    <a href="${pageContext.request.contextPath}/OrderHistoryS" class="btnSecondary">My Orders</a>
                    <a href="${pageContext.request.contextPath}/CartS" class="btnSecondary">View Cart</a>
                </div>

                <div class="statsSection">
                    <div class="statBox">
                        <h3>Total Orders</h3>
                        <p>View your order history</p>
                        <a href="${pageContext.request.contextPath}/OrderHistoryS" class="statLink">View →</a>
                    </div>
                    <div class="statBox">
                        <h3>Continue Shopping</h3>
                        <p>Browse more products</p>
                        <a href="${pageContext.request.contextPath}/homeS" class="statLink">Shop →</a>
                    </div>
                    <div class="statBox">
                        <h3>Need Help?</h3>
                        <p>Contact support</p>
                        <a href="${pageContext.request.contextPath}/pages/contact.jsp" class="statLink">Contact →</a>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="/templates/footer.html" %>
    </body>
</html>