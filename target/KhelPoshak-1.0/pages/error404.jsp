<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>404 - Page Not Found | Khel Poshak</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .errorContainer {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                max-width: 500px;
                margin: 20px;
            }
            
            .errorCode {
                font-size: 120px;
                font-weight: bold;
                color: #4f46e5;
                line-height: 1;
                margin-bottom: 20px;
            }
            
            .errorTitle {
                font-size: 28px;
                color: #1f2937;
                margin-bottom: 15px;
            }
            
            .errorMessage {
                color: #6b7280;
                margin-bottom: 30px;
                line-height: 1.6;
            }
            
            .homeLink {
                display: inline-block;
                padding: 12px 30px;
                background: #4f46e5;
                color: white;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 500;
                transition: background 0.3s;
            }
            
            .homeLink:hover {
                background: #4338ca;
            }
            
            .suggestions {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid #e5e7eb;
            }
            
            .suggestions p {
                color: #6b7280;
                margin-bottom: 10px;
            }
            
            .suggestions a {
                color: #4f46e5;
                text-decoration: none;
                margin: 0 10px;
            }
            
            .suggestions a:hover {
                text-decoration: underline;
            }
            
            @media (max-width: 768px) {
                .errorCode {
                    font-size: 80px;
                }
                .errorTitle {
                    font-size: 22px;
                }
            }
        </style>
    </head>
    <body>
        <div class="errorContainer">
            <div class="errorCode">404</div>
            <div class="errorTitle">Page Not Found</div>
            <div class="errorMessage">
                Oops! The page you are looking for doesn't exist or has been moved.
            </div>
            <a href="${pageContext.request.contextPath}/homeS" class="homeLink">Go to Homepage</a>
            
          
        </div>
    </body>
</html>