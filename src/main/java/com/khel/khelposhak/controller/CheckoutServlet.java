package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.OrderDao;
import com.khel.khelposhak.dao.ProductDao;
import com.khel.khelposhak.model.CartModel;
import com.khel.khelposhak.model.OrderItemModel;
import com.khel.khelposhak.model.OrderModel;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.SessionUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutS"})
public class CheckoutServlet extends HttpServlet {

    private List<CartModel> getCart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<CartModel> cart = (List<CartModel>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void clearCart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            request.getSession().setAttribute("redirectAfterLogin", "/CheckoutS");
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        List<CartModel> cartItems = getCart(request);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CartS");
            return;
        }

        double total = 0;
        for (CartModel item : cartItems) {
            total += item.getSubtotal();
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        List<CartModel> cartItems = getCart(request);

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CartS");
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");
        String phone = request.getParameter("phone");
        String paymentMethod = request.getParameter("paymentMethod");

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            request.setAttribute("error", "Please enter shipping address");
            request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
            return;
        }

        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Please enter phone number");
            request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
            return;
        }

        double total = 0;
        for (CartModel item : cartItems) {
            total += item.getSubtotal();
        }

        OrderModel order = new OrderModel();
        order.setUserId(user.getUserId());
        order.setTotalAmount(total);
        order.setOrderStatus("Pending");
        order.setPaymentMethod(paymentMethod);
        order.setShippingAddress(shippingAddress);
        order.setPhone(phone);
        order.setOrderDate(LocalDateTime.now());

        List<OrderItemModel> orderItems = new ArrayList<>();
        for (CartModel item : cartItems) {
            OrderItemModel orderItem = new OrderItemModel(
                    item.getProductId(),
                    item.getSize(),
                    item.getQuantity(),
                    item.getPrice()
            );
            orderItems.add(orderItem);
        }

        order.setItems(orderItems);

        OrderDao orderDao = new OrderDao();
        int orderId = orderDao.saveOrder(order);

        if (orderId > 0) {
            boolean itemsSaved = orderDao.saveOrderItems(orderId, orderItems);
            if (itemsSaved) {
                clearCart(request);
                response.sendRedirect(request.getContextPath() + "/OrderHistoryS");
                return;  
            } else {
                request.setAttribute("error", "Failed to save order items. Please try again.");
                request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);

            }
        } else {
            request.setAttribute("error", "Order failed! Please try again.");
            request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
        }

    }

}
