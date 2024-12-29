package com.foodorderapp.model;

public class Restaurant {
    private int id;
    private String name;
    private String email;
    private String password;
    private String address;
    private long phone;

    // No-argument constructor
    public Restaurant() {}

    // Constructor with arguments
    public Restaurant(int id, String name, String email, String password, String address, long phone) {
        this.id= id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.phone = phone;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public long getPhone() {
        return phone;
    }

    public void setPhone(long phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "Restaurant [id=" + id + ", name=" + name + ", email=" + email + ", address=" + address + ", phone=" + phone + "]";
    }
}

