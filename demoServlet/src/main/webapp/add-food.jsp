<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Food</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
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

        /* Container for form */
        .container {
            background-color: rgba(255, 255, 255, 0.8); /* Slight transparency */
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

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="number"] {
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
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
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
    <!-- Background video -->
    <video class="background-video" autoplay loop muted>
        <source src="https://ik.imagekit.io/whfmkiwjg/food5.mp4?tr=orig&updatedAt=1735232574689" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <!-- Container for form -->
    <div class="container">
        <h2>Add Food</h2>

        <!-- Display success or failure message -->
        <%
        response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
        String message = (String) request.getAttribute("message");
        if (message != null) {
        %>
            <p style="color: <%= message.contains("successfully") ? "green" : "red" %>;">
                <%= message %>
            </p>
        <%
        }
        %>

        <!-- Add food form -->
        <form action="add-food" method="get">
            <div class="form-group">
                <label for="name">Food Name:</label>
                <input type="text" class="form-control" id="name" name="fname" required>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" class="form-control" id="price" name="fprice" required>
            </div>
            <button type="submit" class="btn btn-primary">Add Food</button><br><br>
        </form>
        <a href="admin-dashboard.jsp">Back to Dashboard</a>

        <script>
            // Replace the browser history state to avoid duplicate entries
            window.onload = function() {
                history.replaceState(null, "", "add-food.jsp");
            };
        </script>
    </div>
</body>
</html>
