package com.khel.khelposhak.dao;

import com.khel.khelposhak.databaseConnection.DatabaseConnection;
import com.khel.khelposhak.model.CategoryModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CategoryDao {
    private Connection conn;
    private boolean isConnectionError = false;

    public CategoryDao() {
        try {
            conn = DatabaseConnection.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println(ex.getMessage());
        }

    }
    public List<CategoryModel> getAllCategories() {

    List<CategoryModel> categories = new ArrayList<>();
    try {
        String sql = "SELECT * FROM categories";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            CategoryModel cm = new CategoryModel();
            cm.setCategoryId(rs.getInt("category_id"));
           
            cm.setName(rs.getString("name"));
            cm.setDescription(rs.getString("description"));
            categories.add(cm);
        }
    } catch (SQLException ex) {
        System.out.println(ex.getMessage());
    }
    
    return categories;
}
    public CategoryModel getCategoryById(int id) {
    CategoryModel cm = new CategoryModel();

    try {
        String sql = "SELECT * FROM categories WHERE category_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            cm.setCategoryId(rs.getInt("category_id"));
            cm.setName(rs.getString("name"));
            cm.setDescription(rs.getString("description"));
        }

    } catch (SQLException ex) {
        System.out.println(ex.getLocalizedMessage());
    }

    return cm;
}
    
    

    
}
