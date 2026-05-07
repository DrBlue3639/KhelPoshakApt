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
import java.util.List;

@WebServlet(name = "ProductServlet", urlPatterns = {"/ProdS"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            ProductModel product = new ProductModel();
            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setSport(request.getParameter("sport"));
            product.setTeam(request.getParameter("team"));
            product.setPlayerName(request.getParameter("playerName"));
            product.setSizesAvailable(request.getParameter("sizesAvailable"));
            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));

            product.setStockS(Integer.parseInt(request.getParameter("stockS")));
            product.setStockM(Integer.parseInt(request.getParameter("stockM")));
            product.setStockL(Integer.parseInt(request.getParameter("stockL")));
            product.setStockXl(Integer.parseInt(request.getParameter("stockXl")));
            product.setStockXxl(Integer.parseInt(request.getParameter("stockXxl")));
            String cid = request.getParameter("categoryId");
            String catId = request.getParameter("categoryId");

            product.setImageUrl(request.getParameter("imageUrl"));
            ProductDao pdao = new ProductDao();
            pdao.addProduct(product);
            request.getRequestDispatcher("/pages/Admindashboard.jsp").forward(request, response);

        } else if ("update".equals(action)) {
            ProductModel product = new ProductModel();
            product.setProductId(Integer.parseInt(request.getParameter("productId")));

            product.setName(request.getParameter("name"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setSport(request.getParameter("sport"));
            product.setTeam(request.getParameter("team"));
            product.setPlayerName(request.getParameter("playerName"));
            product.setSizesAvailable(request.getParameter("sizesAvailable"));

            product.setStockS(Integer.parseInt(request.getParameter("stockS")));
            product.setStockM(Integer.parseInt(request.getParameter("stockM")));
            product.setStockL(Integer.parseInt(request.getParameter("stockL")));
            product.setStockXl(Integer.parseInt(request.getParameter("stockXl")));
            product.setStockXxl(Integer.parseInt(request.getParameter("stockXxl")));

            product.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
            product.setImageUrl(request.getParameter("imageUrl"));
            ProductDao pdao = new ProductDao();
            pdao.updateProduct(product);
            response.sendRedirect("ProdS?action=list");

        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ProductDao pdao = new ProductDao();

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("product_id"));
            pdao.deleteProduct(id);
            response.sendRedirect("ProdS?action=list");

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("product_id"));
            ProductModel pm = pdao.getProductById(id);
            request.setAttribute("product", pm);
            request.getRequestDispatcher("/pages/editproduct.jsp").forward(request, response);

        } else if ("add".equals(action)) {
            CategoryDao cdao = new CategoryDao();
            List<CategoryModel> categories = cdao.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/pages/addproduct.jsp").forward(request, response);
        } else {
            List<ProductModel> products = pdao.getAllProduct();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
        }

    }

}
