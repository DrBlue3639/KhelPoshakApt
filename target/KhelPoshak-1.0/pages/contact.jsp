<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Contact Us - Khel Poshak</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main_css.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
    </head>
    <body>
        <!-- NAVBAR TEMPLATE -->
        <jsp:include page="/templates/navbar.jsp">
            <jsp:param name="active" value="contactus"/>
        </jsp:include>

        <div class="contactContainer">
            <div class="contactHeader">
                <h1>Contact Us</h1>
                <p>Get in touch with us</p>
            </div>
            <div class="contactWrapper">
                <div class="contactInfo">
                    <h2>Our Information</h2>
                    <p><strong>Address:</strong> Pokhara, Nepal</p>
                    <p><strong>Phone:</strong> 9800000000</p>
                    <p><strong>Email:</strong> support@khelposhak.com</p>
                    <p><strong>Hours:</strong> Mon-Sat: 9AM - 6PM</p>
                </div>
                <div class="contactForm">
                    <h2>Send Message</h2>
                    <form action="${pageContext.request.contextPath}/ContactS" method="post">
                        <input type="text" name="name" placeholder="Your Name" required>
                        <input type="email" name="email" placeholder="Your Email" required>
                        <input type="text" name="subject" placeholder="Subject" required>
                        <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
                        <button type="submit">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
        <!--footer from template:  used directive include tag because of static HTML-->
        <%@include file="/templates/footer.html" %>
    </body>
</html>