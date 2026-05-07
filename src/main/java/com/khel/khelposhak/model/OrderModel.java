package com.khel.khelposhak.model;

import java.time.LocalDateTime;
import java.util.List;

public class OrderModel {

    private int orderId;
    private String orderNumber;
    private int userId;
    private double totalAmount;
    private String orderStatus;
    private String paymentMethod;
    private String shippingAddress;
    private String phone;
    private LocalDateTime orderDate;
    private List<OrderItemModel> items;

    public OrderModel() {
    }

    public int getOrderId() {
        return orderId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public int getUserId() {
        return userId;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public String getPhone() {
        return phone;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public List<OrderItemModel> getItems() {
        return items;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public void setItems(List<OrderItemModel> items) {
        this.items = items;
    }
}
