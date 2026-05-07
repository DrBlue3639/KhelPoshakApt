package com.khel.khelposhak.dao;

import com.khel.khelposhak.databaseConnection.DatabaseConnection;
import com.khel.khelposhak.model.UserModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDao {

    private Connection conn;
    private boolean isConnectionError = false;

    public LoginDao() {
        try {
            conn = DatabaseConnection.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println(ex.getMessage());
        }
    }

    public UserModel loginUser(String email, String password) {

        try {
            String sql = "SELECT * FROM users WHERE email=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String dbPass = rs.getString("password");

                if (dbPass.equals(password)) {

                    UserModel user = new UserModel();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getString("phone"));
                    user.setAddress(rs.getString("address"));
                    user.setRole(rs.getString("role"));
                    user.setPassword(dbPass); 

                    return user;
                }
            } 

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return null;
    }
    
        public UserModel getUserByEmail(String email) {
        try {
            String sql = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                UserModel user = new UserModel();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }
}