<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.foodorderapp.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <style>
        /* General reset and styling */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
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
            background: rgba(0, 0, 0, 0.4); /* Dark overlay */
            z-index: -1;
        }

        /* Container styling */
        .container {
            width: 100%;
            max-width: 500px;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            animation: fadeIn 1s ease-out;
        }

        .container:hover {
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.2);
            transform: translateY(-5px);
        }

        /* Header styling */
        h1 {
            text-align: center;
            color: #FFA500; /* Orange color */
            font-size: 30px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        /* Label styling */
        label {
            font-size: 16px;
            color: #333;
            font-weight: bold;
            margin-bottom: 8px;
            display: inline-block;
        }

        /* Input field styling */
        input[type="text"], input[type="email"], input[type="tel"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 2px solid #FFA500; /* Orange border */
            border-radius: 8px;
            font-size: 16px;
            background-color: #f9f9f9;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus, input[type="email"]:focus, input[type="tel"]:focus {
            border-color: #FF8C00; /* Darker orange on focus */
            background-color: #fff;
            outline: none;
        }

        /* Button styling */
        button {
            width: 100%;
            padding: 12px;
            background-color: #FFA500; /* Orange background */
            color: white;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 15px;
            transition: background-color 0.3s, transform 0.3s;
        }

        button:hover {
            background-color: #FF8C00; /* Darker orange on hover */
            transform: translateY(-2px);
        }

        /* Error message styling */
        p.error {
            color: red;
            margin-top: 15px;
            text-align: center;
        }

        /* Animation for fade-in effect */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <!-- Background Video -->
    <video autoplay muted loop>
        <source src="https://ik.imagekit.io/zwq8uei9d/6757663-hd_1920_1080_25fps.mp4?updatedAt=1735361380506" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <div class="container">
        <h1>Edit Profile</h1>
        <form action="UpdateUserProfile" method="post">
            <input type="hidden" name="userId" value="<%= request.getAttribute("userId") %>" />
            
            <label for="userName">Name:</label>
            <input type="text" id="userName" name="userName" value="<%= request.getAttribute("userName") %>" required />
            
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= request.getAttribute("address") %>" required />
            
            <label for="userEmail">Email:</label>
            <input type="email" id="userEmail" name="userEmail" value="<%= request.getAttribute("userEmail") %>" required />
            
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" value="<%= request.getAttribute("phone") %>" required />
            
            <button type="submit">Update Profile</button>

            <!-- Display error message if any -->
            <p class="error">
                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
            </p>
        </form>
    </div>
</body>
</html>
