<%-- 
    Document   : login.jsp
    Created on : Apr 10, 2026, 4:21:37 PM
    Author     : akashadhikari
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>log in page</title>
    </head>
    <body>
        <h2>Login</h2>

        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Email"  />
            <input type="password" name="password" placeholder="Password" />
            <button type="submit">Login</button>
        </form>
    </body>
</html>
