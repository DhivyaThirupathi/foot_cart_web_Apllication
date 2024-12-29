<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="demoServlet.FoodItem" %>
<html>
<head>
    <title>Foods</title>
    <style>
        /* Global styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f9f9f9;
            color: #333;
            padding: 20px;
            min-height: 100vh; /* Ensures the page takes the full height of the viewport */
            overflow-y: auto; /* Enables vertical scrolling for the entire page */
            position: relative;
            overflow-x: hidden; /* Prevents horizontal overflow */
        }

        /* Scrollbar styling for the whole page */
        body::-webkit-scrollbar {
            width: 10px;
        }

        body::-webkit-scrollbar-thumb {
            background-color: orange;
            border-radius: 5px;
        }

        body::-webkit-scrollbar-track {
            background-color: #f1f1f1;
        }

        /* Background Video Styling */
        .bg-video {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1; /* Place the video behind content */
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            justify-content: space-between;
        }

        /* Food Menu and Cart Container */
        .food-menu, .cart {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
            border: 2px solid orange;
            border-radius: 12px;
            padding: 20px;
            width: 48%;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .food-menu:hover, .cart:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }

        h1, h2 {
            text-align: center;
            color: orange;
            margin-bottom: 20px;
            font-size: 24px;
            border-bottom: 2px solid orange;
            padding-bottom: 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            background-color: #fff8e1;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #ffa500;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        li:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        span {
            display: block;
            margin-bottom: 8px;
            font-size: 16px;
        }

        /* Button styles */
        button, input[type="submit"] {
            background-color: orange;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 16px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        button:hover, input[type="submit"]:hover {
            background-color: darkorange;
            transform: scale(1.05);
        }

        /* Cart section styles */
        .cart {
            position: sticky;
            top: 20px;
        }

        .cart-total {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            text-align: right;
        }

        form {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }

        /* Ensure the entire page content scrolls when necessary */
        .container {
            max-height: 100vh; /* Ensure the container takes the full height */
            overflow-y: auto; /* Allow the container to scroll */
        }
    </style>
</head>
<body>
    <!-- Background Video -->
    <video autoplay loop muted playsinline class="bg-video">
        <source src="https://ik.imagekit.io/zwq8uei9d/8030281-hd_1920_1080_30fps.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <div class="container">
        <!-- Food Menu Section -->
        <div class="food-menu">
            <h1>Menu for <%= request.getAttribute("resName") != null ? request.getAttribute("resName") : "Unknown Restaurant" %></h1>
            <ul>
                <%
                    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
                    ArrayList<FoodItem> foodList = (ArrayList<FoodItem>) request.getAttribute("foodList");
                    if (foodList != null && !foodList.isEmpty()) {
                        for (FoodItem food : foodList) {
                            String foodName = food.getFoodName();
                            double foodPrice = food.getPrice();
                            int foodId = food.getFoodId();
                %>
                <li>
                    <form action="AddToCartServlet" method="post">
                        <span><strong>Food Name:</strong> <%= foodName %></span>
                        <span><strong>Price:</strong> Rs.<%= foodPrice %></span>
                        <input type="hidden" name="foodId" value="<%= foodId %>">
                        <input type="hidden" name="foodName" value="<%= foodName %>">
                        <input type="hidden" name="foodPrice" value="<%= foodPrice %>">
                        <input type="hidden" name="resId" value="<%= request.getAttribute("resId") %>">
                        <input type="submit" value="Add to Cart">
                    </form>
                </li>
                <%
                        }
                    } else {
                %>
                <li>No food items available</li>
                <%
                    }
                %>
            </ul>
        </div>

        <!-- Cart Section -->
        <div class="cart">
            <h2>Your Cart</h2>
            <ul>
                <%
                    int id = (int) session.getAttribute("userId");
                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/application", "root", "Gopi@2003")) {
                        String query = "SELECT f.foodId, f.food, c.quantity, f.price * c.quantity AS total_price FROM cart c " +
                                       "INNER JOIN food f ON c.food_id = f.foodId WHERE c.user_id = ?";
                        PreparedStatement stmt = conn.prepareStatement(query);
                        stmt.setInt(1, id);
                        ResultSet rs = stmt.executeQuery();
                        double total = 0;

                        while (rs.next()) {
                            int foodId = rs.getInt("foodId");
                            String foodName = rs.getString("food");
                            int quantity = rs.getInt("quantity");
                            double totalPrice = rs.getDouble("total_price");
                            total += totalPrice;
                %>
                <li>
                    <span><strong>Item:</strong> <%= foodName %></span>
                    <span><strong>Quantity:</strong> <%= quantity %></span>
                    <span><strong>Total Price:</strong> Rs.<%= totalPrice %></span>
                    <form action="RemoveFromCartServlet" method="post">
                        <input type="hidden" name="foodId" value="<%= foodId %>">
                        <input type="hidden" name="resId" value="<%= request.getAttribute("resId") %>">
                        <button type="submit">Remove</button>
                    </form>
                </li>
                <%
                        }
                %>
                <p class="cart-total">Cart Total: Rs.<%= total %></p>
                <%
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </ul>
            <form action="CheckoutServlet" method="POST">
                <input type="hidden" name="resId" value="<%= request.getAttribute("resId") %>">
                <button type="submit">Checkout</button>
            </form>
        </div>
    </div>
</body>
</html>
