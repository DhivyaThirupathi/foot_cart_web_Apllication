package demoServlet;

public class FoodItem {
    private int foodId;
    private String foodName;
    private double price;
    private int resId;
    public FoodItem() {
    	
    }

    // Constructor
    public FoodItem(int foodId, String foodName, int quantity, double price,int resId) {
        this.foodId = foodId;
        this.foodName = foodName;
        this.price = price;
        this.resId = resId;
    }

    // Getters and Setters
    public int getFoodId() {
        return foodId;
    }

    public void setFoodId(int foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "FoodItem{" +
                "foodId=" + foodId +
                ", foodName='" + foodName + '\'' +
                ", price=" + price +
                '}';
    }

	public int getResId() {
		return resId;
	}

	public void setResId(int resId) {
		this.resId = resId;
	}
}
