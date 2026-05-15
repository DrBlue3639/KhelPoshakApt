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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    // Add these methods to your existing OrderDao class
    public int getTotalOrdersCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM orders";
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

    public double getTotalRevenue() {
        double revenue = 0;
        try {
            String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE order_status != 'Cancelled'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return revenue;
    }

    public int getPendingOrdersCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM orders WHERE order_status = 'Pending'";
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

    public int getOrdersTodayCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM orders WHERE DATE(order_date) = CURDATE()";
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

    public double getRevenueToday() {
        double revenue = 0;
        try {
            String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE DATE(order_date) = CURDATE() AND order_status != 'Cancelled'";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                revenue = rs.getDouble(1);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return revenue;
    }

    public List<Integer> getWeeklyOrdersCount() {
        List<Integer> weeklyOrders = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            weeklyOrders.add(0);
        }

        try {
            String sql = "SELECT DAYOFWEEK(order_date) as day, COUNT(*) as count "
                    + "FROM orders WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) "
                    + "GROUP BY DAYOFWEEK(order_date)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int day = rs.getInt("day");
                int count = rs.getInt("count");
                // Convert MySQL day (1=Sun,2=Mon...) to index (Mon=0, Sun=6)
                int index;
                if (day == 1) {
                    index = 6; // Sunday
                } else {
                    index = day - 2; // Monday=0, Tuesday=1, etc.
                }
                if (index >= 0 && index < 7) {
                    weeklyOrders.set(index, count);
                }
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return weeklyOrders;
    }

    public List<Double> getWeeklyRevenue() {
        List<Double> weeklyRevenue = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            weeklyRevenue.add(0.0);
        }

        try {
            String sql = "SELECT DAYOFWEEK(order_date) as day, COALESCE(SUM(total_amount), 0) as revenue "
                    + "FROM orders WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) "
                    + "AND order_status != 'Cancelled' GROUP BY DAYOFWEEK(order_date)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int day = rs.getInt("day");
                double revenue = rs.getDouble("revenue");
                int index;
                if (day == 1) {
                    index = 6;
                } else {
                    index = day - 2;
                }
                if (index >= 0 && index < 7) {
                    weeklyRevenue.set(index, revenue);
                }
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return weeklyRevenue;
    }

    public List<Map<String, Object>> getRecentOrders(int limit) {
        List<Map<String, Object>> orders = new ArrayList<>();
        try {
            String sql = "SELECT o.order_number, u.full_name as customerName, o.total_amount, o.order_status as status "
                    + "FROM orders o JOIN users u ON o.user_id = u.user_id "
                    + "ORDER BY o.order_date DESC LIMIT ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> order = new HashMap<>();
                order.put("orderNumber", rs.getString("order_number"));
                order.put("customerName", rs.getString("customerName"));
                order.put("totalAmount", rs.getDouble("total_amount"));
                order.put("status", rs.getString("status"));
                orders.add(order);
            }
            rs.close();
            ps.close();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return orders;
    }

    public int getCompletedOrdersCount() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM orders WHERE order_status = 'Delivered'";
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
