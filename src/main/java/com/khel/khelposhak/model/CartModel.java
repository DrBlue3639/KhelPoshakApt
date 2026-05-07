package com.khel.khelposhak.model;

public class CartModel {
    private int productId;
    private String name;
    private double price;
    private String size;
    private int quantity;
    private int stock;

    public CartModel(int productId, String name, double price,
                    String size, int quantity, int stock) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.size = size;
        this.quantity = quantity;
        this.stock = stock;
    }

    public int getProductId() { return productId; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getSize() { return size; }
    public int getQuantity() { return quantity; }
    public int getStock() { return stock; }

    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getSubtotal() {
        return price * quantity;
    }
}
