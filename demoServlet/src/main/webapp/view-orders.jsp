<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Orders</title>
    <style>
        /* General body and container styling */
        body, html {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            height: 100%;
            overflow: auto; /* Allow scrolling */
        }

        /* Background video styling */
        .background-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        /* Overall container with border */
        .container {
            max-width: 1200px;
            margin: 50px auto;
            background-color: rgba(255, 255, 255, 0.9); /* Slight transparency for the container */
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            border: 3px solid orange; /* Orange border added */
            overflow: auto; /* Allow scrolling within the container */
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #FFA500;
            padding: 15px;
            background-color: #fff8e1;
            border-radius: 8px;
            border: 2px solid orange;
        }

        /* Table Section */
        .table-section {
            margin-bottom: 30px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
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

        /* Spacing and layout adjustments */
        table, th, td {
            border: 1px solid #ddd;
            padding: 10px;
        }

        /* Responsive design for smaller screens */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .table th, .table td {
                font-size: 14px;
                padding: 8px;
            }
        }

    </style>
</head>
<body>
    <!-- Background video -->
    <video class="background-video" autoplay loop muted>
        <source src="https://ik.imagekit.io/whfmkiwjg/4003980-hd_1920_1080_24fps.mp4?updatedAt=1735231507157" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <div class="container">
        <h2>View Orders</h2>

        <!-- Pending Orders Table -->
        <div class="table-section">
            <h3>Pending Orders</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Restaurant ID</th>
                        <th>Food Name</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Order Status</th>
                        <th>Order Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pendingOrders}" var="order">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.userId}</td>
                            <td>${order.restaurantId}</td>
                            <td>${order.foodName}</td>
                            <td>${order.quantity}</td>
                            <td>${order.total}</td>
                            <td>${order.orderStatus}</td>
                            <td>${order.orderDate}</td>
                            <td>
                                <form action="update-order-status" method="post">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <input type="hidden" name="restaurantId" value="${order.restaurantId}">
                                    <button type="submit" class="btn-action">Mark as Dispatched</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Dispatched Orders Table -->
        <div class="table-section">
            <h3>Dispatched Orders</h3>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Restaurant ID</th>
                        <th>Food Name</th>
                        <th>Quantity</th>
                        <th>Total</th>
                        <th>Order Status</th>
                        <th>Order Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${dispatchedOrders}" var="order">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.userId}</td>
                            <td>${order.restaurantId}</td>
                            <td>${order.foodName}</td>
                            <td>${order.quantity}</td>
                            <td>${order.total}</td>
                            <td>${order.orderStatus}</td>
                            <td>${order.orderDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <a href="admin-dashboard.jsp" class="btn-back">Back to Dashboard</a>
    </div>
</body>
</html>
