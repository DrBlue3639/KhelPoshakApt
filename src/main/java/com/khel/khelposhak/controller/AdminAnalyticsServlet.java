package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.LoginDao;
import com.khel.khelposhak.dao.OrderDao;
import com.khel.khelposhak.dao.ProductDao;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.SessionUtil;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/AdminDashboardS"})
public class AdminAnalyticsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is admin
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Create DAO instances
        ProductDao productDao = new ProductDao();
        OrderDao orderDao = new OrderDao();
        LoginDao loginDao = new LoginDao();

        // Get dashboard data
        int totalProducts = productDao.getTotalProductsCount();
        int totalOrders = orderDao.getTotalOrdersCount();
        int totalUsers = loginDao.getTotalUsersCount();
        double totalRevenue = orderDao.getTotalRevenue();
        int pendingOrders = orderDao.getPendingOrdersCount();
        int completedOrders = orderDao.getCompletedOrdersCount();
        int ordersToday = orderDao.getOrdersTodayCount();
        double revenueToday = orderDao.getRevenueToday();

        List<Integer> weeklyOrders = orderDao.getWeeklyOrdersCount();
        List<Double> weeklyRevenue = orderDao.getWeeklyRevenue();
        List<Map<String, Object>> recentOrders = orderDao.getRecentOrders(5);
        List<Map<String, Object>> lowStockProducts = productDao.getLowStockProducts(5);

        // Set attributes for JSP
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("pendingOrders", pendingOrders);
        request.setAttribute("completedOrders", completedOrders);
        request.setAttribute("ordersToday", ordersToday);
        request.setAttribute("revenueToday", revenueToday);
        request.setAttribute("weeklyOrders", weeklyOrders);
        request.setAttribute("weeklyRevenue", weeklyRevenue);
        request.setAttribute("recentOrders", recentOrders);
        request.setAttribute("lowStockProducts", lowStockProducts);

        // Forward to JSP
        request.getRequestDispatcher("/pages/analyticsDashboard.jsp").forward(request, response);
    }
}
