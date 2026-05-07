package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.RegisterDao;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.PasswordUtil;
import com.khel.khelposhak.utils.ValidationUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/regServ"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cfPassword = request.getParameter("cfpassword");

        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        boolean isValidName = !ValidationUtil.isNullOrEmpty(fullName)
                && ValidationUtil.isAlphanumericStartingWithLetter(fullName)
                && fullName.length() > 5;

        String errorUser = isValidName ? "" : "Name is not Proper";
        boolean isValidMail = ValidationUtil.isValidEmail(email);
        String errorMail = isValidMail ? "" : "Email is not proper";
        boolean isValidPass = ValidationUtil.isValidPassword(password);
        String errorPass = isValidPass ? "" : "Password must have uppercase,number,specail char,minmum 6 char";
        boolean isValidCon = ValidationUtil.doPasswordsMatch(password, cfPassword);
        String errorCon = isValidCon ? "" : "password not matching";
        String error = errorUser + errorMail + errorPass + errorCon;
        request.setAttribute("error", error);

        if (!error.isBlank()) {
            RequestDispatcher rd = request.getRequestDispatcher("/pages/register.jsp");
            rd.forward(request, response);
            return;
        }

        String haspw = PasswordUtil.getHashPassword(password);
        UserModel user = new UserModel();
        user.setPassword(haspw);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        RegisterDao userdao = new RegisterDao();
        int check = userdao.registerUser(user);

        switch (check) {
            case 1:
                // Registration successful
                response.sendRedirect("pages/login.jsp");
                break;
            case 2:
                // user exists already
                request.setAttribute("error", "Email already registered!");
                RequestDispatcher rd = request.getRequestDispatcher("/pages/register.jsp");
                rd.forward(request, response);
                break;
            default:
                System.out.println("Server error: " + check);
                request.setAttribute("error", "Registration failed! Please try again.");
                RequestDispatcher rd2 = request.getRequestDispatcher("/pages/register.jsp");
                rd2.forward(request, response);
                break;
        }
    }
}
