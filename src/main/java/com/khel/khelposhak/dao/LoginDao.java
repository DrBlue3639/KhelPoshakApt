package com.khel.khelposhak.dao;

import com.khel.khelposhak.databaseConnection.DatabaseConnection;
import com.khel.khelposhak.model.UserModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
    public boolean updateUserProfile(UserModel user) {
    try {
        String sql = "UPDATE users SET full_name=?, phone=?, address=? WHERE user_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, user.getFullName());
        ps.setString(2, user.getPhone());
        ps.setString(3, user.getAddress());
        ps.setInt(4, user.getUserId());
        
        return ps.executeUpdate() > 0;
    } catch (SQLException ex) {
        System.out.println("Error updating profile: " + ex.getMessage());
        return false;
    }
}

public boolean updateUserPassword(int userId, String newHashedPassword) {
    try {
        String sql = "UPDATE users SET password=? WHERE user_id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, newHashedPassword);
        ps.setInt(2, userId);
        
        return ps.executeUpdate() > 0;
    } catch (SQLException ex) {
        System.out.println("Error updating password: " + ex.getMessage());
        return false;
    }
}

public List<UserModel> getAllUsers() {
    List<UserModel> users = new ArrayList<>();
    try {
        String sql = "SELECT * FROM users ORDER BY user_id DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            UserModel user = new UserModel();
            user.setUserId(rs.getInt("user_id"));
            user.setFullName(rs.getString("full_name"));
            user.setEmail(rs.getString("email"));
            user.setPhone(rs.getString("phone"));
            user.setAddress(rs.getString("address"));
            user.setRole(rs.getString("role"));
            users.add(user);
        }
        rs.close();
        ps.close();
    } catch (SQLException ex) {
        System.out.println(ex.getMessage());
    }
    return users;
}




    // Add this method to your existing LoginDao class
    public int getTotalUsersCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM users WHERE role != 'ADMIN' OR role IS NULL";
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
}
