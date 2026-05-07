package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.LoginDao;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.PasswordUtil;
import com.khel.khelposhak.utils.SessionUtil;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet(name = "Login", urlPatterns = {"/LogServ"})
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        LoginDao logDao = new LoginDao();
        UserModel userModel = logDao.getUserByEmail(email);

        if (userModel == null) {
            request.setAttribute("error", "invalid email or password");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }

        String storedPassword = userModel.getPassword();

        boolean matched = PasswordUtil.checkPassword(password, storedPassword);
        //when bycrpt pw is correct 
        if (matched) {
            SessionUtil.setAttribute(request, "user", userModel);

            HttpSession session = request.getSession();
            String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");

            if (redirectAfterLogin != null && !redirectAfterLogin.isEmpty()) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(request.getContextPath() + redirectAfterLogin);
                return;
            }

            if ("ADMIN".equals(userModel.getRole())) {
                response.sendRedirect(request.getContextPath() + "/pages/Admindashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/homeS");
            }
        }
    }
}
