package com.khel.khelposhak.controller;

import com.khel.khelposhak.utils.SessionUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutS"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Clear cookies
        Cookie emailCookie = new Cookie("userEmail", null);
        emailCookie.setMaxAge(0);
        emailCookie.setPath("/");
        response.addCookie(emailCookie);
        
        Cookie nameCookie = new Cookie("userName", null);
        nameCookie.setMaxAge(0);
        nameCookie.setPath("/");
        response.addCookie(nameCookie);
        
        // Invalidate session
        SessionUtil.invalidateSession(request);

        // Redirect to home
        response.sendRedirect(request.getContextPath() + "/homeS");
    }
}