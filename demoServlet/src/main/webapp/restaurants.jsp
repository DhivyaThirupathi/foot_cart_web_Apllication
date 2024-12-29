<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>Restaurants</title>
    <link rel="stylesheet" type="text/css" href="restaurants.css">
    <style>
        /* Reset margins and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow: hidden; /* Ensure content doesn't overflow */
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

        /* Header Styling */
        .header {
            background: rgba(255, 99, 71, 0.8); /* Semi-transparent header */
            padding: 20px 30px;
            border-radius: 10px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            max-width: 1200px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .header h1 {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }

        .header a {
            color: white;
            text-decoration: none;
            font-size: 16px;
            margin: 0 10px;
            transition: color 0.3s ease;
        }

        .header a:hover {
            color: #FFD700;
        }

        .logout-button {
            background-color: #FF4500;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 20px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .logout-button:hover {
            background-color: #E63E00;
        }

        /* Restaurant List Section */
        .restaurant-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            width: 100%;
            max-width: 1200px;
        }

        .restaurant-item {
            background-color: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            text-decoration: none; /* Remove underline for link */
        }

        .restaurant-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .restaurant-item div {
            color: #FFA500; /* Set restaurant name color to orange */
            font-size: 18px;
            font-weight: bold;
        }

        .no-restaurants {
            grid-column: span 2;
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            font-size: 18px;
            color: #FF6347;
            font-weight: bold;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
            }

            .header a {
                margin: 5px 0;
            }

            .restaurant-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>
    <!-- Background Video -->
    <video autoplay loop muted playsinline class="bg-video">
        <source src="https://ik.imagekit.io/zwq8uei9d/3298718-uhd_4096_2160_25fps.mp4" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <div class="header">
        <h1>Restaurants</h1>
        <div>
            <a href="UserProfile">User Profile</a>
            <a href="userOrderDetails">Order Details</a>
            <form action="LogoutServlet" method="post" style="display: inline;">
                <button type="submit" class="logout-button">Logout</button>
            </form>
        </div>
    </div>

    <div class="restaurant-list">
        <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setDateHeader("Expires", 0);
        ArrayList<String> restaurantList = (ArrayList<String>) request.getAttribute("restaurantList");
        ArrayList<Integer> restaurantIds = (ArrayList<Integer>) request.getAttribute("restaurantId");

        if (restaurantList != null && !restaurantList.isEmpty()) {
            for (int i = 0; i < restaurantList.size(); i++) {
        %>
            <a href="FoodServlet?restaurant_id=<%= restaurantIds.get(i) %>" class="restaurant-item">
                <div>
                    <%= restaurantList.get(i) %>
                </div>
            </a>
        <%
            }
        } else {
        %>
            <div class="no-restaurants">No restaurants available.</div>
        <%
        }
        %>
    </div>

</body>
</html>
