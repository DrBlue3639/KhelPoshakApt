package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.LoginDao;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.PasswordUtil;
import com.khel.khelposhak.utils.SessionUtil;
import com.khel.khelposhak.utils.ValidationUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UserProfileServlet", urlPatterns = {"/ProfileS"})
public class UserProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        if ("edit".equals(action)) {
            request.getRequestDispatcher("/pages/editProfile.jsp").forward(request, response);
        } else {
            // Check if admin or regular user
            if ("ADMIN".equals(user.getRole())) {
                request.getRequestDispatcher("/pages/adminProfile.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserModel sessionUser = (UserModel) SessionUtil.getAttribute(request, "user");
        
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(request, response, sessionUser);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, sessionUser);
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, UserModel sessionUser)
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Validation
        if (fullName == null || fullName.trim().length() < 3) {
            request.setAttribute("error", "Name must be at least 3 characters");
            request.getRequestDispatcher("/pages/editProfile.jsp").forward(request, response);
            return;
        }
        
        // Update user object
        sessionUser.setFullName(fullName.trim());
        sessionUser.setPhone(phone);
        sessionUser.setAddress(address);
        
        // Update in database
        LoginDao loginDao = new LoginDao();
        boolean updated = loginDao.updateUserProfile(sessionUser);
        
        if (updated) {
            SessionUtil.setAttribute(request, "user", sessionUser);
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
        }
        
        // Redirect based on role
        if ("ADMIN".equals(sessionUser.getRole())) {
            request.getRequestDispatcher("/pages/adminProfile.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/pages/profile.jsp").forward(request, response);
        }
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, UserModel sessionUser)
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Verify current password
        if (!PasswordUtil.checkPassword(currentPassword, sessionUser.getPassword())) {
            request.setAttribute("passwordError", "Current password is incorrect");
            request.getRequestDispatcher("/pages/editProfile.jsp").forward(request, response);
            return;
        }
        
        // Validate new password
        if (!ValidationUtil.isValidPassword(newPassword)) {
            request.setAttribute("passwordError", "Password must have uppercase, number, special character, minimum 6 characters");
            request.getRequestDispatcher("/pages/editProfile.jsp").forward(request, response);
            return;
        }
        
        // Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("passwordError", "New passwords do not match");
            request.getRequestDispatcher("/pages/editProfile.jsp").forward(request, response);
            return;
        }
        
        // Hash new password and update
        String hashedPassword = PasswordUtil.getHashPassword(newPassword);
        LoginDao loginDao = new LoginDao();
        boolean updated = loginDao.updateUserPassword(sessionUser.getUserId(), hashedPassword);
        
        if (updated) {
            sessionUser.setPassword(hashedPassword);
            SessionUtil.setAttribute(request, "user", sessionUser);
            request.setAttribute("passwordSuccess", "Password changed successfully!");
        } else {
            request.setAttribute("passwordError", "Failed to change password. Please try again.");
        }
        
        request.getRequestDispatcher("/pages/editProfile.jsp").forward(request, response);
    }
}