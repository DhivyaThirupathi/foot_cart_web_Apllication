<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out</title>
    <style>
        /* General body styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            position: relative;
        }

        /* Background video styling */
        .background-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1; /* Ensure it stays behind the content */
        }

        /* Overall container styling */
        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Slight transparency for the container */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 400px;
            border: 3px solid orange; /* Orange border around the container */
            transition: transform 0.3s ease, box-shadow 0.3s ease;
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

        p {
            font-size: 16px;
            color: #333;
            margin-bottom: 20px;
        }

        /* Button styles */
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: orange; /* Orange color for the button */
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }

        .btn:hover {
            background-color: #cc6600; /* Darker orange for hover */
            transform: translateY(-3px); /* Lift effect */
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2); /* Box-shadow on hover */
        }

        .btn-secondary {
            background-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
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
        <h2>You have been logged out successfully.</h2>
        <p><a href="adminLogin.jsp" class="btn">Login Again</a></p>
        <a href="index.html" class="btn btn-secondary" style="margin-top: 20px;">Go Back to Home Page</a>
    </div>
</body>
</html>
