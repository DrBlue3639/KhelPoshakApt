package com.khel.khelposhak.controller;

import com.khel.khelposhak.dao.CategoryDao;
import com.khel.khelposhak.dao.ProductDao;
import com.khel.khelposhak.model.CategoryModel;
import com.khel.khelposhak.model.ProductModel;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "AllProductsServlet", urlPatterns = {"/products"})
public class AllProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDao productDao = new ProductDao();
        CategoryDao categoryDao = new CategoryDao();

        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String sort = request.getParameter("sort");
        
        List<ProductModel> products = null;
        
        // Apply search filter
        if (search != null && !search.trim().isEmpty()) {
            products = productDao.searchProducts(search);
            request.setAttribute("searchKeyword", search);
        } 
        // Apply category filter
        else if (category != null && !category.isEmpty()) {
            int categoryId = Integer.parseInt(category);
            products = productDao.getProductsByCategory(categoryId);
            request.setAttribute("selectedCategory", categoryId);
        } 
        // Get all products
        else {
            products = productDao.getAllProduct();
        }
        
        // Apply sorting
        if (products != null && sort != null && !sort.isEmpty()) {
            if ("price".equals(sort)) {
                Collections.sort(products, Comparator.comparingDouble(ProductModel::getPrice));
                request.setAttribute("sortType", "price");
            } else if ("price_desc".equals(sort)) {
                Collections.sort(products, Comparator.comparingDouble(ProductModel::getPrice).reversed());
                request.setAttribute("sortType", "price_desc");
            }
        }
        
        // Get categories for dropdown
        List<CategoryModel> categories = categoryDao.getAllCategories();
        
        // Set attributes
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        
        // Forward to JSP
        request.getRequestDispatcher("/pages/allProducts.jsp").forward(request, response);
    }
}