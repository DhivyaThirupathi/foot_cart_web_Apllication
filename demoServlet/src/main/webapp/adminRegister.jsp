<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <style>
        /* General body styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative;
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
            background: rgba(0, 0, 0, 0.5); /* Dark overlay */
            z-index: -1;
        }

        /* Container styling */
        .container {
            background-color: #ffffff;
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            border: 2px solid orange;
        }

        /* Heading styling */
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #FFA500;
            transition: color 0.3s ease;
        }

        /* Hover effect for the heading */
        h2:hover {
            color: #FF4500;
        }

        /* Form group styling */
        .form-group {
            margin-bottom: 15px;
        }

        /* Label styling */
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        /* Input field styling */
        input[type="email"], input[type="password"], input[type="text"], input[type="tel"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        /* Button styling */
        button {
            width: 100%;
            padding: 10px;
            background-color: orange;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }

        /* Button hover effect */
        button:hover {
            background-color: #cc6600;
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }

        /* Paragraph styling */
        p {
            text-align: center;
            margin-top: 15px;
        }

        /* Link styling */
        a {
            color: orange;
            text-decoration: none;
        }

        /* Link hover effect */
        a:hover {
            text-decoration: underline;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #FFA500;
            transition: color 0.3s ease, transform 0.3s ease;
            padding: 10px;
            border: 2px solid orange;
            background-color: #fff8e1;
            border-radius: 8px;
            display: block;
            margin: 0 auto;
            width: fit-content;
        }

        h2:hover {
            color: #FFA500;
            transform: scale(1.1);
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }

        .form-group:first-of-type {
            margin-top: 20px;
        }

    </style>
</head>
<body>
    <!-- Background Video -->
    <video autoplay muted loop>
        <source src="https://ik.imagekit.io/zwq8uei9d/3297823-uhd_4096_2160_25fps.mp4?updatedAt=1734532325692" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <!-- Container for the registration form -->
    <div class="container">
        <h2>Restaurant Register Details</h2>
        <% response.setHeader("Cache-Control", "no-cache,no.store,must-revalidate"); %>
        <form action="register-restaurant" method="post">
            <div class="form-group">
                <label for="Resid">Restaurant ID:</label>
                <input type="text" id="Resid" name="id" required>
            </div>
            <div class="form-group">
                <label for="name">Restaurant Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <button type="submit">Register</button>
        </form>
        <p>Already have an account? <a href="adminLogin.jsp">Login here</a></p>
    </div>
</body>
</html>
