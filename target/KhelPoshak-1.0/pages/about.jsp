<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>About Us - Khel Poshak</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_css.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/about.css">
    </head>

    <body>

        <!-- NAVBAR TEMPLATE -->
        <jsp:include page="/templates/navbar.jsp">
            <jsp:param name="active" value="aboutus"/>
        </jsp:include>

        <div class="aboutContainer">

            <!-- Header -->
            <div class="aboutHeader">
                <h1>About Us</h1>
                <p>Learn more about Khel Poshak</p>
            </div>

            <!-- About Cards -->
            <div class="aboutContent">

                <div class="aboutCard">
                    <div class="cardIcon"></div>
                    <h2>Our Story</h2>
                    <p>
                        Khel Poshak is your one-stop destination for authentic
                        sports jerseys. We bring premium-quality football,
                        cricket, and basketball jerseys for passionate fans.
                    </p>
                </div>

                <div class="aboutCard">
                    <div class="cardIcon"></div>
                    <h2>Our Mission</h2>
                    <p>
                        To provide sports lovers with stylish, affordable,
                        and high-quality jerseys with fast delivery all over Nepal.
                    </p>
                </div>

                <div class="aboutCard">
                    <div class="cardIcon"></div>
                    <h2>Why Shop With Us</h2>
                    <p>
                        Authentic Quality<br>
                        All Sizes Available<br>
                        Secure Payments<br>
                        Quick Delivery<br>
                        Friendly Support
                    </p>
                </div>

                <div class="aboutCard">
                    <div class="cardIcon"></div>
                    <h2>Fast Delivery</h2>
                    <p>
                        We deliver your favorite jerseys quickly and safely
                        to your doorstep anywhere in Nepal.
                    </p>
                </div>

                <div class="aboutCard">
                    <div class="cardIcon"></div>
                    <h2>Premium Quality</h2>
                    <p>
                        Every jersey is selected carefully to ensure
                        maximum comfort, durability, and style.
                    </p>
                </div>

                <div class="aboutCard">
                    <div class="cardIcon"></div>
                    <h2>Customer First</h2>
                    <p>
                        Customer satisfaction is our top priority.
                        We are always ready to support you.
                    </p>
                </div>

            </div>

            <!-- Stats Section -->
            <div class="statsSection">

                <div class="statCard">
                    <h2>5000+</h2>
                    <p>Happy Customers</p>
                </div>

                <div class="statCard">
                    <h2>100+</h2>
                    <p>Jersey Collections</p>
                </div>

                <div class="statCard">
                    <h2>50+</h2>
                    <p>Top Teams</p>
                </div>

                <div class="statCard">
                    <h2>24/7</h2>
                    <p>Support</p>
                </div>

            </div>

            <!-- Team Section -->
            <div class="teamSection">

                <h2>Meet Our Team</h2>

                <div class="teamCards">

                    <div class="teamCard">
                        <div class="teamIcon"></div>
                        <h3>Founder</h3>
                        <p>Leading Khel Poshak with passion for sports.</p>
                    </div>

                    <div class="teamCard">
                        <div class="teamIcon"></div>
                        <h3>Design Team</h3>
                        <p>Creating stylish and modern jersey collections.</p>
                    </div>

                    <div class="teamCard">
                        <div class="teamIcon"></div>
                        <h3>Delivery Team</h3>
                        <p>Ensuring safe and fast delivery across Nepal.</p>
                    </div>

                </div>

            </div>

            <!-- CTA -->
            <div class="aboutCTA">
                <h2>Wear Your Passion</h2>
                <p>Support your favorite team with premium jerseys.</p>

                <a href="${pageContext.request.contextPath}/products" class="shopBtn">
                    Shop Now
                </a>
            </div>

        </div>
        <!--footer from template:  used directive include tag because of static HTML-->
        <%@include file="/templates/footer.html" %>
    </body>
</html>