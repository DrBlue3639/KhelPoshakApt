/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.khel.khelposhak.controller;

import com.khel.khelposhak.utils.SessionUtil;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author akashadhikari
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutS"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Invalidate the session/session sakinx
        SessionUtil.invalidateSession(request);

        // login page ma lani
        response.sendRedirect(request.getContextPath() + "/homeS");
    }

}
