package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.ProductDao;
import com.khel.khelposhak.model.CartModel;
import com.khel.khelposhak.model.ProductModel;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.SessionUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartS"})
public class CartServlet extends HttpServlet {

    private List<CartModel> getCart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<CartModel> cart = (List<CartModel>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        
        
        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String size = request.getParameter("size");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductDao pdao = new ProductDao();
            ProductModel product = pdao.getProductById(productId);
            List<CartModel> cartItems = getCart(request);
            boolean found = false;
            for (CartModel item : cartItems) {
                boolean samProd = item.getProductId() == productId;
                boolean sameSize = item.getSize().equals(size);
                if (samProd && sameSize) {
                    int newQty = item.getQuantity() + quantity;
                    item.setQuantity(newQty);
                    found = true;
                    break;
                }
            }
            if (!found) {
                int stock = 0;
                if (size.equals("S")) {
                    stock = product.getStockS();
                } else if (size.equals("M")) {
                    stock = product.getStockM();
                } else if (size.equals("L")) {
                    stock = product.getStockL();
                } else if (size.equals("XL")) {
                    stock = product.getStockXl();
                } else if (size.equals("XXL")) {
                    stock = product.getStockXxl();
                }
                String name = product.getName();
                double price = product.getPrice();
                CartModel cartm = new CartModel(productId, name, price, size, quantity, stock);
                cartItems.add(cartm);
            }
            response.sendRedirect(request.getContextPath() + "/CartS");

        } else if ("update".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String size = request.getParameter("size");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            List<CartModel> cartItems = getCart(request);

            for (CartModel item : cartItems) {
                if (item.getProductId() == productId && item.getSize().equals(size)) {
                    if (quantity <= 0) {
                        cartItems.remove(item);
                    } else {
                        item.setQuantity(quantity);
                    }
                    break;
                }
            }
            response.sendRedirect(request.getContextPath() + "/CartS");
            
        } else if ("remove".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String size = request.getParameter("size");

            List<CartModel> cartItems = getCart(request);
            for (int i = 0; i < cartItems.size(); i++) {
                CartModel item = cartItems.get(i);
                if (item.getProductId() == productId && item.getSize().equals(size)) {
                    cartItems.remove(i);
                    break;
                }
            }
            response.sendRedirect(request.getContextPath() + "/CartS");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<CartModel> cartItems = getCart(request);

        double total = 0;
        for (CartModel item : cartItems) {
            total += item.getSubtotal();
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
    }
}