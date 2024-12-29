<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodorderapp.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
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
        }
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: rgba(0, 0, 0, 0.5);
            overflow-y: auto;
        }
        video {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -2;
        }
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
            max-height: 80vh; /* Set max height for the container */
    		overflow-y: auto; /* Enable scrolling within the container */
        }
        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
        }
        h1 {
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
            text-align: left;
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
        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        button {
            background-color: #d35400;
            color: white;
            font-size: 14px;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        button:hover {
            background-color: #e67e22;
            transform: translateY(-2px);
        }
        .message {
            text-align: center;
            font-size: 16px;
            margin-bottom: 30px;
        }
        .success-message {
            color: #27ae60;
        }
        .error-message {
            color: #e74c3c;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            font-size: 16px;
            text-decoration: none;
            color: #d35400;
            font-weight: 600;
            position: relative;
            transition: color 0.3s ease;
        }
        .back-link::after {
            content: '→';
            margin-left: 10px;
            font-size: 18px;
            transition: transform 0.3s ease;
        }
        .back-link:hover {
            color: #e67e22;
        }
        .back-link:hover::after {
            transform: translateX(5px);
        }
        /* Animation for table */
        @keyframes slideIn {
            0% {
                transform: translateX(-100%);
            }
            100% {
                transform: translateX(0);
            }
        }
        table {
            animation: slideIn 0.6s ease-out;
        }
    </style>
</head>
<body>
    <video autoplay muted loop>
        <source src="https://ik.imagekit.io/zwq8uei9d/5241407-hd_1920_1080_30fps.mp4?updatedAt=1735361477897" type="video/mp4">
        Your browser does not support the video tag.
    </video>
    <div class="container">
        <h1>User Profile</h1>

        <%
            User user = (User) request.getAttribute("userD");
            if (user != null) {
        %>

        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Email</th>
                    <th>Phone</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= user.getName() %></td>
                    <td><%= user.getAddress() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhone() %></td>
                </tr>
            </tbody>
        </table>

        <div class="button-container">
            <form action="EditUserProfile" method="get">
                <button type="submit">Edit Profile</button>
            </form>
        </div>

        <%
            } else {
        %>
        <p class="message error-message">No user details found.</p>
        <%
            }
        %>

        <%
            String successMessage = (String) request.getAttribute("successMessage");
            if (successMessage != null) {
        %>
        <p class="message success-message"><%= successMessage %></p>
        <%
            }
        %>

        <a href="RestaurantServlet" class="back-link">Back to Menu</a>
    </div>
</body>
</html>
