<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register User</title>
    </head>
    <body>
        <h2>Create Account</h2>

        <form action="${pageContext.request.contextPath}/RegisterServlet" method="post">  
            <label>Full Name:</label><br>
            <input type="text" name="fullName" ><br><br>

            <label>Email:</label><br>
            <input type="email" name="email" ><br><br>

            <label>Password:</label><br>
            <input type="password" name="password" ><br><br>

            <label>Phone:</label><br>
            <input type="tel" name="phone" ><br><br>

            <label>Address:</label><br>
            <textarea name="address"></textarea><br><br>

            <button type="submit">Register</button>
        </form>
        <p>Have account?? <a href="login.jsp">Login</a></p>
    </body>
</html>
