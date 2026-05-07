package com.khel.khelposhak.model;

import java.time.LocalDateTime;


public class ProductModel {
    private int productId;
    private String name;
    private String description;
    private double price;
    private String sport;
    private String team;
    private String playerName;
    private String sizesAvailable;
    private int stockS;
    private int stockM;
    private int stockL;
    private int stockXl;
    private int stockXxl;
    private int categoryId;
    private String imageUrl;
    private LocalDateTime createdAt;
    

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getSport() {
        return sport;
    }

    public void setSport(String sport) {
        this.sport = sport;
    }

    public String getTeam() {
        return team;
    }

    public void setTeam(String team) {
        this.team = team;
    }

    public String getPlayerName() {
        return playerName;
    }

    public void setPlayerName(String playerName) {
        this.playerName = playerName;
    }

    public String getSizesAvailable() {
        return sizesAvailable;
    }

    public void setSizesAvailable(String sizesAvailable) {
        this.sizesAvailable = sizesAvailable;
    }

    public int getStockS() {
        return stockS;
    }

    public void setStockS(int stockS) {
        this.stockS = stockS;
    }

    public int getStockM() {
        return stockM;
    }

    public void setStockM(int stockM) {
        this.stockM = stockM;
    }

    public int getStockL() {
        return stockL;
    }

    public void setStockL(int stockL) {
        this.stockL = stockL;
    }

    public int getStockXl() {
        return stockXl;
    }

    public void setStockXl(int stockXl) {
        this.stockXl = stockXl;
    }

    public int getStockXxl() {
        return stockXxl;
    }

    public void setStockXxl(int stockXxl) {
        this.stockXxl = stockXxl;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
}
