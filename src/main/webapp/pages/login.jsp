<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
        <title>Login to KhelPoshak</title>
    </head>
    <body>
        <!--     navigation container 
            <div class="navContainer">
              <a href="../index.html">
                <div class="logo">
                  <img
                    src="../resources/Logo_heart-pulse-solid.png"
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
                  <li><a href="../index.html">Home</a></li>
                  <li><a href="#">About</a></li>
                  <li><a href="#">Contact</a></li>
                  <li id="Login">
                    <a href="Login.jsp" style="color: rgb(21, 88, 246)">Login</a>
                  </li>
                  <a href="register.jsp"><button>Register</button></a>
                </ul>
              </nav>
            </div>-->
        <!-- NAVBAR TEMPLATE -->
        <jsp:include page="/templates/navbar.jsp">
            <jsp:param name="active" value="login"/>
        </jsp:include>

        <!-- main login part starts -->

        <div class="loginContainer">
            <div class="loginCard">
                <div class="loginHeader">
                    <img src="${pageContext.request.contextPath}/resources/khelPoshakBlacklogo.png" alt="KhelPoshakLogo" />
                    <h3><b>Login to Your Account</b></h3>
                    <p>Enter your credentials to continue</p>
                </div>

                <p style="color: red">${error}</p>
                <form
                    action="${pageContext.request.contextPath}/LogServ"
                    method="post"
                    class="loginForm"
                    >
                    <label>Email</label>
                    <input type="email" placeholder="Enter your email" name="email" required
                           value="${cookie.userEmail != null ? cookie.userEmail.value : ''}">

                    <label>Password</label>
                    <input
                        type="password"
                        placeholder="Enter your password"
                        name="password"
                        required
                        />

                    <!-- <label>Select Role</label>
                    <div class="roleSelection">
                      <label>
                        <input type="radio" name="role" value="admin" required />
                        Admin
                      </label>
                      <label>
                        <input type="radio" name="role" value="patient" />
                        Patient
                      </label>
                    </div> -->

                    <button type="submit" class="loginBtn">Login</button>

                    <p class="registerText">
                        Don't have an account? <a href="register.jsp">Register here</a>
                    </p>
                </form>
            </div>
        </div>
    </body>
</html>

