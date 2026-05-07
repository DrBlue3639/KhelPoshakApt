package com.khel.khelposhak.model;

public class OrderItemModel {

    private int orderItemId;
    private int orderId;
    private int productId;
    private String size;
    private int quantity;
    private double priceAtTime;
    private double subtotal;
    
    public OrderItemModel() {
    }

    public OrderItemModel(int productId, String size, int quantity, double priceAtTime) {
        this.productId = productId;
        this.size = size;
        this.quantity = quantity;
        this.priceAtTime = priceAtTime;
        this.subtotal = priceAtTime * quantity;
    }

    public int getOrderItemId() {
        return orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public int getProductId() {
        return productId;
    }

    public String getSize() {
        return size;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPriceAtTime() {
        return priceAtTime;
    }

    public double getSubtotal() {
        return subtotal;
    }

    // Setters
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setPriceAtTime(double priceAtTime) {
        this.priceAtTime = priceAtTime;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
}
