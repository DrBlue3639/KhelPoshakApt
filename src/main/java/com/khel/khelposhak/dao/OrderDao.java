package com.khel.khelposhak.dao;

import com.khel.khelposhak.databaseConnection.DatabaseConnection;
import com.khel.khelposhak.model.OrderItemModel;
import com.khel.khelposhak.model.OrderModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

    private Connection conn;
    private boolean isConnectionError = false;

    public OrderDao() {
        try {
            conn = DatabaseConnection.getDbConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println(ex.getMessage());
        }
    }

    public int saveOrder(OrderModel o) {

        int orderId = 0;

        try {
            String sql = "INSERT INTO orders(order_number, user_id, total_amount, order_status, "
                    + "payment_method, shipping_address, phone, order_date) VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setString(1, "ORD-" + System.currentTimeMillis());
            ps.setInt(2, o.getUserId());
            ps.setDouble(3, o.getTotalAmount());
            ps.setString(4, o.getOrderStatus());
            ps.setString(5, o.getPaymentMethod());
            ps.setString(6, o.getShippingAddress());
            ps.setString(7, o.getPhone());
            ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return orderId;
    }

    public boolean saveOrderItems(int orderId, List<OrderItemModel> items) {

        try {
            String sql = "INSERT INTO order_items(order_id, product_id, size, quantity, price_at_time, subtotal) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            for (OrderItemModel item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setString(3, item.getSize());
                ps.setInt(4, item.getQuantity());
                ps.setDouble(5, item.getPriceAtTime());
                ps.setDouble(6, item.getSubtotal());
                ps.addBatch();
            }

            ps.executeBatch();
            return true;

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }

    public List<OrderModel> getOrdersByUserId(int userId) {

        List<OrderModel> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderModel o = new OrderModel();

                o.setOrderId(rs.getInt("order_id"));
                o.setOrderNumber(rs.getString("order_number"));
                o.setUserId(rs.getInt("user_id"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setShippingAddress(rs.getString("shipping_address"));
                o.setPhone(rs.getString("phone"));

                Timestamp ts = rs.getTimestamp("order_date");
                if (ts != null) {
                    o.setOrderDate(ts.toLocalDateTime());
                }

                o.setItems(getOrderItemsByOrderId(o.getOrderId()));

                list.add(o);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return list;
    }

    public List<OrderItemModel> getOrderItemsByOrderId(int orderId) {

        List<OrderItemModel> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM order_items WHERE order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                OrderItemModel item = new OrderItemModel();

                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setSize(rs.getString("size"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPriceAtTime(rs.getDouble("price_at_time"));
                item.setSubtotal(rs.getDouble("subtotal"));

                list.add(item);
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return list;
    }

    public OrderModel getOrderById(int orderId) {

        OrderModel o = new OrderModel();

        try {
            String sql = "SELECT * FROM orders WHERE order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                o.setOrderId(rs.getInt("order_id"));
                o.setOrderNumber(rs.getString("order_number"));
                o.setUserId(rs.getInt("user_id"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setShippingAddress(rs.getString("shipping_address"));
                o.setPhone(rs.getString("phone"));

                Timestamp ts = rs.getTimestamp("order_date");
                if (ts != null) {
                    o.setOrderDate(ts.toLocalDateTime());
                }

                o.setItems(getOrderItemsByOrderId(orderId));
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return o;
    }

    public boolean updateOrderStatus(int orderId, String status) {

        try {
            String sql = "UPDATE orders SET order_status=? WHERE order_id=?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return false;
        }
    }
}