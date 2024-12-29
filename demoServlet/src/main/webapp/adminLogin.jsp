<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        /* Body styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            position: relative; /* Required for absolute positioning of video */
            overflow: hidden;
        }

        /* Background video styling */
        .background-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ensures the video covers the whole screen */
            z-index: -1; /* Places the video behind the content */
        }

        /* Container styling */
        .container {
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            border: 2px solid orange;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.25);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #FFA500;
            padding: 10px;
            border: 2px solid orange;
            background-color: #fff8e1;
            border-radius: 8px;
        }

        h2:hover {
            color: #FFA500;
            transform: scale(1.1);
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

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

        button:hover {
            background-color: #cc6600;
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.10);
        }

        .btn-secondary {
            display: block;
            text-align: center;
            margin-top: 10px;
            padding: 10px;
            background-color: #6c757d;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        p {
            text-align: center;
            margin-top: 15px;
        }

        a {
            color: orange;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <!-- Background Video -->
    <video class="background-video" autoplay loop muted>
        <source src="https://ik.imagekit.io/whfmkiwjg/11654938-uhd_3840_2160_50fps.mp4?updatedAt=1735231542335" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <!-- Login Form Container -->
    <div class="container">
        <h2>Admin Login</h2>
        <!-- Display Success Message -->
        <%
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        String successMessage = (String)request.getAttribute("registermsg");
        if (successMessage != null) {
            out.println("<p style='color: green;'>" + successMessage + "</p>");
            request.removeAttribute("registermsg"); // Remove the message after displaying
        }

        String delmsg = (String)request.getAttribute("message");
        if (delmsg != null) {
            out.println("<p style='color: green;'>" + delmsg + "</p>");
            session.removeAttribute("message"); // Remove the message after displaying
        }
        %>
        <form action="AdminLoginServlet" method="post">
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
        <p>Don't have an account? <a href="adminRegister.jsp">Register here</a></p>

        <!-- Display Error Message -->
        <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
            <p style="color: red;"><%= errorMessage %></p>
        <%
        }
        %>
        <a href="index.html" class="btn btn-secondary">Go Back to Home Page</a>
    </div>

</body>
</html>
