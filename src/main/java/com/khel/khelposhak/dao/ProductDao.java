package com.khel.khelposhak.dao;

import com.khel.khelposhak.databaseConnection.DatabaseConnection;
import com.khel.khelposhak.model.ProductModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDao {

    private Connection conn;
    private boolean isConnectionError = false;

    public ProductDao() {
        try {
            conn = DatabaseConnection.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println(ex.getMessage());
        }

    }

    public boolean addProduct(ProductModel p) {
        try {

            String sql = "INSERT INTO products(name, description, price, sport, team, player_name,"
                    + " sizes_available, stock_s, stock_m, stock_l, stock_xl, stock_xxl, category_id,"
                    + " image_url) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getSport());
            ps.setString(5, p.getTeam());
            ps.setString(6, p.getPlayerName());
            ps.setString(7, p.getSizesAvailable());

            ps.setInt(8, p.getStockS());
            ps.setInt(9, p.getStockM());
            ps.setInt(10, p.getStockL());
            ps.setInt(11, p.getStockXl());
            ps.setInt(12, p.getStockXxl());

            ps.setInt(13, p.getCategoryId());
            ps.setString(14, p.getImageUrl());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());
            return false;
        }
    }

    public boolean updateProduct(ProductModel p) {
        try {
            String sql = "UPDATE products SET name=?, description=?, price=?, sport=?, team=?, player_name=?, "
                    + "sizes_available=?, stock_s=?, stock_m=?, stock_l=?, stock_xl=?, stock_xxl=?, category_id=?, "
                    + "image_url=? WHERE product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getSport());
            ps.setString(5, p.getTeam());
            ps.setString(6, p.getPlayerName());
            ps.setString(7, p.getSizesAvailable());
            ps.setInt(8, p.getStockS());
            ps.setInt(9, p.getStockM());
            ps.setInt(10, p.getStockL());
            ps.setInt(11, p.getStockXl());
            ps.setInt(12, p.getStockXxl());
            ps.setInt(13, p.getCategoryId());
            ps.setString(14, p.getImageUrl());
            ps.setInt(15, p.getProductId());
            return ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());
            return false;
        }
    }

    public boolean deleteProduct(int productid) {
        try {
            String sql = "DELETE FROM products WHERE product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productid);
            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());
            return false;

        }

    }

    public List<ProductModel> getAllProduct() {

        List<ProductModel> plist = new ArrayList<>();

        try {
            String sql = "SELECT * FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductModel pm = new ProductModel();
                pm.setProductId(rs.getInt("product_id"));
                pm.setName(rs.getString("name"));
                pm.setDescription(rs.getString("description"));
                pm.setPrice(rs.getDouble("price"));
                pm.setSport(rs.getString("sport"));
                pm.setTeam(rs.getString("team"));
                pm.setPlayerName(rs.getString("player_name"));
                pm.setSizesAvailable(rs.getString("sizes_available"));
                pm.setStockS(rs.getInt("stock_s"));
                pm.setStockM(rs.getInt("stock_m"));
                pm.setStockL(rs.getInt("stock_l"));
                pm.setStockXl(rs.getInt("stock_xl"));
                pm.setStockXxl(rs.getInt("stock_xxl"));

                pm.setCategoryId(rs.getInt("category_id"));
                pm.setImageUrl(rs.getString("image_url"));

                plist.add(pm);

            }

        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());

        }
        return plist;

    }

    public ProductModel getProductById(int id) {
        ProductModel pm = new ProductModel();

        try {
            String sql = "SELECT * FROM products WHERE product_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                pm.setProductId(rs.getInt("product_id"));
                pm.setName(rs.getString("name"));
                pm.setDescription(rs.getString("description"));
                pm.setPrice(rs.getDouble("price"));
                pm.setSport(rs.getString("sport"));
                pm.setTeam(rs.getString("team"));
                pm.setPlayerName(rs.getString("player_name"));
                pm.setSizesAvailable(rs.getString("sizes_available"));

                pm.setStockS(rs.getInt("stock_s"));
                pm.setStockM(rs.getInt("stock_m"));
                pm.setStockL(rs.getInt("stock_l"));
                pm.setStockXl(rs.getInt("stock_xl"));
                pm.setStockXxl(rs.getInt("stock_xxl"));

                pm.setCategoryId(rs.getInt("category_id"));
                pm.setImageUrl(rs.getString("image_url"));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());

        }
        return pm;
    }

    //-------homepage garna lahysi add gareko-----
    //home page ko lagi product search garnako lagi
    public List<ProductModel> searchProducts(String keyword) {
        List<ProductModel> plist = new ArrayList<>();

        try {
            String sql = "SELECT * FROM products WHERE name LIKE ? OR team LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductModel pm = new ProductModel();
                pm.setProductId(rs.getInt("product_id"));
                pm.setName(rs.getString("name"));
                pm.setDescription(rs.getString("description"));
                pm.setPrice(rs.getDouble("price"));
                pm.setSport(rs.getString("sport"));
                pm.setTeam(rs.getString("team"));
                pm.setPlayerName(rs.getString("player_name"));
                pm.setSizesAvailable(rs.getString("sizes_available"));

                pm.setStockS(rs.getInt("stock_s"));
                pm.setStockM(rs.getInt("stock_m"));
                pm.setStockL(rs.getInt("stock_l"));
                pm.setStockXl(rs.getInt("stock_xl"));
                pm.setStockXxl(rs.getInt("stock_xxl"));

                pm.setCategoryId(rs.getInt("category_id"));
                pm.setImageUrl(rs.getString("image_url"));

                plist.add(pm);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());
        }

        return plist;
    }

    public List<ProductModel> getProductOfMaxPrice() {
        List<ProductModel> plist = new ArrayList<>();

        try {
            String sql = "SELECT * FROM products ORDER BY price DESC";
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductModel pm = new ProductModel();
                pm.setProductId(rs.getInt("product_id"));
                pm.setName(rs.getString("name"));
                pm.setDescription(rs.getString("description"));
                pm.setPrice(rs.getDouble("price"));
                pm.setSport(rs.getString("sport"));
                pm.setTeam(rs.getString("team"));
                pm.setPlayerName(rs.getString("player_name"));
                pm.setSizesAvailable(rs.getString("sizes_available"));

                pm.setStockS(rs.getInt("stock_s"));
                pm.setStockM(rs.getInt("stock_m"));
                pm.setStockL(rs.getInt("stock_l"));
                pm.setStockXl(rs.getInt("stock_xl"));
                pm.setStockXxl(rs.getInt("stock_xxl"));

                pm.setCategoryId(rs.getInt("category_id"));
                pm.setImageUrl(rs.getString("image_url"));

                plist.add(pm);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getLocalizedMessage());
        }

        return plist;
    }

    //category use gary product khojna ko lagi
    public List<ProductModel> getProductsByCategory(int categoryId) {

        List<ProductModel> plist = new ArrayList<>();

        try {
            String sql = "SELECT * FROM products WHERE category_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                ProductModel pm = new ProductModel();

                pm.setProductId(rs.getInt("product_id"));
                pm.setName(rs.getString("name"));
                pm.setDescription(rs.getString("description"));
                pm.setPrice(rs.getDouble("price"));
                pm.setSport(rs.getString("sport"));
                pm.setTeam(rs.getString("team"));
                pm.setPlayerName(rs.getString("player_name"));
                pm.setSizesAvailable(rs.getString("sizes_available"));

                pm.setStockS(rs.getInt("stock_s"));
                pm.setStockM(rs.getInt("stock_m"));
                pm.setStockL(rs.getInt("stock_l"));
                pm.setStockXl(rs.getInt("stock_xl"));
                pm.setStockXxl(rs.getInt("stock_xxl"));

                pm.setCategoryId(rs.getInt("category_id"));
                pm.setImageUrl(rs.getString("image_url"));

                plist.add(pm);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return plist;
    }

    public List<ProductModel> getFeaturedProducts() {
        List<ProductModel> featuredProducts = new ArrayList<>();

        try {
            // Get top 4 featured products (you can modify this query)
            String sql = "SELECT * FROM products ORDER BY product_id DESC LIMIT 4";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductModel pm = new ProductModel();
                pm.setProductId(rs.getInt("product_id"));
                pm.setName(rs.getString("name"));
                pm.setDescription(rs.getString("description"));
                pm.setPrice(rs.getDouble("price"));
                pm.setSport(rs.getString("sport"));
                pm.setTeam(rs.getString("team"));
                pm.setPlayerName(rs.getString("player_name"));  // Important!
                pm.setSizesAvailable(rs.getString("sizes_available"));
                pm.setStockS(rs.getInt("stock_s"));
                pm.setStockM(rs.getInt("stock_m"));
                pm.setStockL(rs.getInt("stock_l"));
                pm.setStockXl(rs.getInt("stock_xl"));
                pm.setStockXxl(rs.getInt("stock_xxl"));
                pm.setCategoryId(rs.getInt("category_id"));
                pm.setImageUrl(rs.getString("image_url"));
                featuredProducts.add(pm);
            }

        } catch (SQLException ex) {
            System.out.println("Error getting featured products: " + ex.getMessage());
        }

        return featuredProducts;
    }

    // Add these methods to your existing ProductDao class
    public int getTotalProductsCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return count;
    }

    public List<Map<String, Object>> getLowStockProducts(int threshold) {
        List<Map<String, Object>> products = new ArrayList<>();
        try {
            String sql = "SELECT product_id, name, team, sport, stock_s, stock_m, stock_l, stock_xl, stock_xxl "
                    + "FROM products WHERE stock_s < ? OR stock_m < ? OR stock_l < ? OR stock_xl < ? OR stock_xxl < ? "
                    + "LIMIT 5";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, threshold);
            ps.setInt(2, threshold);
            ps.setInt(3, threshold);
            ps.setInt(4, threshold);
            ps.setInt(5, threshold);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> product = new HashMap<>();
                product.put("productId", rs.getInt("product_id"));
                product.put("name", rs.getString("name"));
                product.put("team", rs.getString("team"));
                product.put("sport", rs.getString("sport"));
                product.put("stockS", rs.getInt("stock_s"));
                product.put("stockM", rs.getInt("stock_m"));
                product.put("stockL", rs.getInt("stock_l"));
                product.put("stockXl", rs.getInt("stock_xl"));
                product.put("stockXxl", rs.getInt("stock_xxl"));
                products.add(product);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return products;
    }

}
