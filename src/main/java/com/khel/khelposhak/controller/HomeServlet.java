package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.CategoryDao;
import com.khel.khelposhak.dao.ProductDao;
import com.khel.khelposhak.model.CategoryModel;
import com.khel.khelposhak.model.ProductModel;
import com.khel.khelposhak.model.UserModel;
import com.khel.khelposhak.utils.SessionUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/homeS"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDao productDao = new ProductDao();
        CategoryDao categoryDao = new CategoryDao();

        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String sort = request.getParameter("sort");

        List<ProductModel> products = productDao.getAllProduct();

        if (search != null && !search.trim().isEmpty()) {
            products = productDao.searchProducts(search);
            request.setAttribute("searchKeyword", search);
        }

        if (category != null && !category.isEmpty()) {
            int categoryId = Integer.parseInt(category);
            products = productDao.getProductsByCategory(categoryId);
            request.setAttribute("selectedCategory", categoryId);
        }

        if ("price".equals(sort)) {
            products = productDao.getProductOfMaxPrice();
            request.setAttribute("sortType", "Highest Price");
        }

        List<CategoryModel> categories = categoryDao.getAllCategories();

        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);

        request.setAttribute("isLoggedIn", user != null);
        if (user != null) {
            request.setAttribute("userFullName", user.getFullName());
        }
        List<ProductModel> featuredProducts = productDao.getFeaturedProducts();
        request.setAttribute("featuredProducts", featuredProducts);

        request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
    }

}
