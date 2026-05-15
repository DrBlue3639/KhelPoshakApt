<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/main_css.css"
            />
        <link
            rel="stylesheet"
            href="${pageContext.request.contextPath}/css/register.css"
            />
        <title>Register to KhelPoshak</title>
        <!-- milauna baki -->
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
                     milauna baki 
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
                  <a href="Register.jsp"><button>Register</button></a>
                </ul>
              </nav>
            </div>-->
        <!-- NAVBAR TEMPLATE -->
        <jsp:include page="/templates/navbar.jsp">
            <jsp:param name="active" value="home"/>
        </jsp:include>

        <!-- page starts here  -->
        <div class="registerContainer">
            <div class="registerCard">
                <div class="registerHeader">
                    <img src="${pageContext.request.contextPath}/resources/khelPoshakBlacklogo.png" alt="KhelPoshakLogo" />
                    <h3><b>Create an Account</b></h3>
                    <p>Fill in the details to get started</p>
                </div>

                <p style="color: red">${error}</p>
                <form
                    action="${pageContext.request.contextPath}/regServ"
                    method="post"
                    class="registerForm"
                    >
                    <label>Full Name</label>
                    <input
                        type="text"
                        placeholder="Enter your full name"
                        name="fullname"
                        value="${param.fullName}"
                        required
                        />

                    <label>Email</label>
                    <input
                        type="email"
                        placeholder="Enter your email"
                        name="email"
                        value="${param.email}"
                        required
                        />

                    <label>Password</label>
                    <div class="passwordBox">
                        <input
                            type="password"
                            placeholder="Enter password"
                            name="password"
                            id="password"
                            required
                            />
                        <span class="toggleEye" onclick="togglePassword('password', this)">👁</span>
                    </div>

                    <label>Confirm Password</label>
                    <div class="passwordBox">
                        <input
                            type="password"
                            placeholder="Confirm password"
                            name="cfpassword"
                            id="cfpassword"
                            required
                            />
                        <span class="toggleEye" onclick="togglePassword('cfpassword', this)">👁</span>
                    </div>
                    <label>Phone</label>
                    <input type="tel" name="phone" value="${param.phone}" />

                    <label>Address</label>
                    <textarea name="address">${param.address}</textarea>

                    <button type="submit" class="registerBtn">Register</button>

                    <p class="loginText">
                        Already have an account? <a href="Login.jsp">Login here</a>
                    </p>
                </form>
            </div>
        </div>
        <script>
            function togglePassword(id,icon) {
                const input = document.getElementById(id);

                if (input.type === "password") {
                    input.type = "text";
                    icon.textContent = "🙈";
                } else {
                    input.type = "password";
                    icon.textContent = "👁";
                }
            }
        </script>
    </body>
</html>

