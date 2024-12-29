package com.foodorderapp.model;

import java.sql.Timestamp;

public class Order {
    private int orderId;
    private int userId;
    private int restaurantId;
    private String foodName;
    private int quantity;
    private String orderStatus;
    private double total;
    private Timestamp orderDate;

    // No-argument constructor
    public Order() {}

    // Constructor with all fields
    public Order(int orderId, int userId, int restaurantId, String foodName, int quantity, String orderStatus, double total, Timestamp orderDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.restaurantId = restaurantId;
        this.foodName = foodName;
        this.quantity = quantity;
        this.orderStatus = orderStatus;
        this.total = total;
        this.orderDate = orderDate;
    }

    // Getters and Setters for each field
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", userId=" + userId + ", restaurantId=" + restaurantId + ", foodName="
                + foodName + ", quantity=" + quantity + ", orderStatus=" + orderStatus + ", total=" + total
                + ", orderDate=" + orderDate + "]";
    }
}
