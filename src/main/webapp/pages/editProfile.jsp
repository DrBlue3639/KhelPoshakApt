<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit Profile - Khel Poshak</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    </head>
    <body>
        <c:choose>
            <c:when test="${sessionScope.user.role == 'ADMIN'}">
                <jsp:include page="/templates/adminNavbar.jsp">
                    <jsp:param name="active" value="profile"/>
                </jsp:include>
            </c:when>
            <c:otherwise>
                <jsp:include page="/templates/navbar.jsp">
                    <jsp:param name="active" value="profile"/>
                </jsp:include>
            </c:otherwise>
        </c:choose>

        <div class="profileContainer">
            <div class="profileHeader">
                <h1>Edit Profile</h1>
                <p>Update your account information</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert success">${success}</div>
            </c:if>
            <c:if test="${not empty passwordError}">
                <div class="alert error">${passwordError}</div>
            </c:if>
            <c:if test="${not empty passwordSuccess}">
                <div class="alert success">${passwordSuccess}</div>
            </c:if>

            <div class="editProfileContent">
                <!-- Update Profile Form -->
                <div class="formCard">
                    <h2>Personal Information</h2>
                    <form action="${pageContext.request.contextPath}/ProfileS" method="post">
                        <input type="hidden" name="action" value="updateProfile">
                        
                        <div class="formGroup">
                            <label>Full Name *</label>
                            <input type="text" name="fullName" value="${sessionScope.user.fullName}" required>
                        </div>
                        
                        <div class="formGroup">
                            <label>Email</label>
                            <input type="email" value="${sessionScope.user.email}" disabled>
                            <small>Email cannot be changed</small>
                        </div>
                        
                        <div class="formGroup">
                            <label>Phone Number</label>
                            <input type="tel" name="phone" value="${sessionScope.user.phone}">
                        </div>
                        
                        <div class="formGroup">
                            <label>Address</label>
                            <textarea name="address" rows="3">${sessionScope.user.address}</textarea>
                        </div>
                        
                        <button type="submit" class="btnPrimary">Update Profile</button>
                    </form>
                </div>

                <!-- Change Password Form -->
                <div class="formCard">
                    <h2>Change Password</h2>
                    <form action="${pageContext.request.contextPath}/ProfileS" method="post">
                        <input type="hidden" name="action" value="changePassword">
                        
                        <div class="formGroup">
                            <label>Current Password *</label>
                            <input type="password" name="currentPassword" required>
                        </div>
                        
                        <div class="formGroup">
                            <label>New Password *</label>
                            <input type="password" name="newPassword" required>
                            <small>Must have uppercase, number, special character, min 6 chars</small>
                        </div>
                        
                        <div class="formGroup">
                            <label>Confirm New Password *</label>
                            <input type="password" name="confirmPassword" required>
                        </div>
                        
                        <button type="submit" class="btnSecondary">Change Password</button>
                    </form>
                </div>

                <div class="actionLinks">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/ProfileS">← Back to Admin Profile</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/ProfileS">← Back to Profile</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <%@include file="/templates/footer.html" %>
    </body>
</html>