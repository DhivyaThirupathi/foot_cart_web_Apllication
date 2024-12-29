<%@ page import="java.util.*, com.foodorderapp.model.UserOrderedDetails" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <style>
        /* General reset and styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            position: relative;
            overflow: auto;
        }

        /* Background video */
        video {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -2;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Dark overlay */
            z-index: -1;
        }

        /* Container styling */
        .container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 900px;
            padding: 30px;
            overflow: hidden;
            transform: translateY(10px);
            transition: all 0.3s ease-in-out;
            max-height: 100vh; /* Limit the container height */
            overflow-y: auto; 
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
        }

        h2 {
            text-align: center;
            font-size: 2.5rem;
            color: #34495e;
            margin-bottom: 20px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 2px;
            padding-bottom: 10px;
            border-bottom: 2px solid #d35400;
        }

        /* Table styling */
        table {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        th, td {
            padding: 15px;
            text-align: center;
            font-size: 16px;
            color: #333;
            font-weight: 500;
        }

        th {
            background-color: #d35400;
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #ecf0f1;
        }

        /* Button styling */
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            text-align: center;
            transition: background-color 0.3s, transform 0.2s;
        }

        a:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        /* Responsive styling */
        @media (max-width: 768px) {
            table {
                font-size: 12px;
            }
            a {
                font-size: 12px;
                padding: 8px 16px;
            }
        }
    </style>
</head>
<body>
    <!-- Background Video -->
    <video autoplay muted loop>
        <source src="https://ik.imagekit.io/zwq8uei9d/4909363-hd_1920_1080_25fps.mp4?updatedAt=1735361379685" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <!-- Content Container -->
    <div class="container">
        <h2>Your Order Details</h2>

        <%
            List<UserOrderedDetails> orders = (List<UserOrderedDetails>) request.getAttribute("userOrderedDetailsList");
            if (orders != null && !orders.isEmpty()) {
        %>

        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Order Date</th>
                    <th>Order Status</th>
                    <th>Food</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Restaurant Name</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (UserOrderedDetails order : orders) {
                %>
                <tr>
                    <td><%= order.getOrderId() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td><%= order.getOrderStatus() %></td>
                    <td><%= order.getFood() %></td>
                    <td><%= order.getQuantity() %></td>
                    <td><%= order.getPrice() %></td>
                    <td><%= order.getResName() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <a href="RestaurantServlet">Back to Menu</a>

        <%
            } else {
        %>
        <p class="message error-message" style="text-align: center; color: #e74c3c;">No orders found.</p>
        <%
            }
        %>
    </div>
</body>
</html>
