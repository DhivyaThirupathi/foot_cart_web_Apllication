<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Food Items</title>
<style>
    /* General body styling */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-image: url('https://ik.imagekit.io/whfmkiwjg/pexels-farklimavi-5539072.jpg?updatedAt=1735233087398');
        background-size: cover; /* Ensure the image covers the entire page */
        background-position: center; /* Center the image */
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        color: #fff; /* White text color to contrast with the background */
    }

    /* Overall container styling */
    .container {
        background-color: rgba(255, 255, 255, 0.8); /* Slight transparency for the container */
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        text-align: center;
        width: 80%;
        max-width: 1000px;
        border: 3px solid orange; /* Orange border around the container */
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        color: #000; /* Set text color inside the container to black */
    }

    .container:hover {
        transform: translateY(-10px); /* Hover effect for the whole card */
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); /* Box-shadow effect on hover */
    }

    h2 {
        color: #FFA500; /* Orange color */
        font-size: 24px;
        margin-bottom: 20px;
        padding: 10px;
        background-color: #fff8e1;
        border-radius: 8px;
        border: 2px solid orange;
        transition: color 0.3s ease, transform 0.3s ease;
    }

    h2:hover {
        color: #FF4500; /* Darker orange color */
        transform: scale(1.1); /* Slight scaling effect */
    }

    /* Table Section */
    .table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background-color: #fff;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    th, td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f8f8f8;
        color: #333;
    }

    tr:hover {
        background-color: #f5f5f5;
    }

    button {
        padding: 8px 20px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button:hover {
        background-color: #218838;
    }

    /* Back to Dashboard button */
    .btn-back {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    .btn-back:hover {
        background-color: #0056b3;
    }

</style>
</head>
<body>
    <div class="container">
        <h2>Edit Food Items</h2>
        
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Food Name</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Retrieve the foodList from the request scope
                    List<demoServlet.FoodItem> foodList = (List<demoServlet.FoodItem>) request.getAttribute("foodList");
                    if (foodList != null) {
                        for (demoServlet.FoodItem food : foodList) { 
                %>
                    <tr>
                        <td><%= food.getFoodName() %></td>
                        <td>
                            <form action="update-food-price" method="post">
                                <input type="hidden" name="foodName" value="<%= food.getFoodName() %>">
                                <input type="text" name="price" value="<%= food.getPrice() %>">
                                <button type="submit">Update Price</button>
                            </form>
                        </td>
                        <td>
                            <form action="delete-food" method="post">
                                <input type="hidden" name="foodName" value="<%= food.getFoodName() %>">
                                <button type="submit">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% 
                        }
                    } else { 
                %>
                    <tr>
                        <td colspan="3">No food items found.</td>
                    </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
        <a href="admin-dashboard.jsp" class="btn-back">Back to Dashboard</a>
    </div>
</body>
</html>


