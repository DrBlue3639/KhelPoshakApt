package com.khel.khelposhak.dao;

import java.sql.*;
import com.khel.khelposhak.databaseConnection.DatabaseConnection;
import com.khel.khelposhak.model.UserModel;

public class RegisterDao {

    private Connection conn;
    private boolean isConnectionError = false;

    public RegisterDao() {
        try {
            conn = DatabaseConnection.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println(ex.getMessage());
        }
    }

       public int registerUser(UserModel user) {

        try {
          
            String checkSql = "SELECT email FROM users WHERE LOWER(email)=LOWER(?)";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, user.getEmail());

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                return 2; // email exist garx pahelai 
            }

         
            String sql = "INSERT INTO users (full_name, email, password, phone, address) VALUES (?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());

            int result = ps.executeUpdate();

            return result; // thikx vane 1 din x value insert gardha else 0 fail
            

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return 3; // conn error
        }
    }
}