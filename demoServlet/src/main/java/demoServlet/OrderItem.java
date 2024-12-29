package demoServlet;

public class OrderItem {
    private int foodId;
    private double price;
    private int quantity;

    public OrderItem(int foodId, double price, int quantity) {
        this.foodId = foodId;
        this.price = price;
        this.quantity = quantity;
    }

    public int getFoodId() {
        return foodId;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }
}
