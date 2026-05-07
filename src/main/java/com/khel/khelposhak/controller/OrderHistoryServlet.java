package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.OrderDao;
import com.khel.khelposhak.model.OrderModel;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.SessionUtil;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/OrderHistoryS")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user != null) {
            OrderDao orderDao = new OrderDao();
            List<OrderModel> orders = orderDao.getOrdersByUserId(user.getUserId());
            request.setAttribute("orders", orders);
        }
        request.getRequestDispatcher("/pages/orderHistory.jsp").forward(request, response);
    }
}