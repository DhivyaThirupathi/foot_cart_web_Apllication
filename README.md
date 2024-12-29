<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery - Login & Register</title>
    <style>
        /* Reset margins and padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body styling */
        body {
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden; /* Prevent scrolling */
            background: url('https://ik.imagekit.io/whfmkiwjg/pexels-ella-olsson-572949-1640773.jpg?updatedAt=1735233071929') no-repeat center center/cover;
        }

        /* Styling for the container */
        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white */
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            border: 2px solid orange;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin: 0 auto; /* Center-align the container */
            z-index: 1; /* Keep the form visible */
        }

        .container:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.25);
        }

        /* Styling for h2 */
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

        /* Styling for input fields */
        input[type="email"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 2px solid orange;
            border-radius: 5px;
            font-size: 16px;
        }

        /* Styling for the submit button */
        button {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border: 2px solid orange;
            background-color: orange;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        button:hover {
            background-color: darkorange;
            border-color: darkorange;
        }

        /* Styling for the link */
        a {
            color: orange;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Styling for error message */
        p {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <form id="login-form" class="form active" method="post" action="LoginServlet">
            <h2>Login</h2>
            <input type="email" id="uEmail" name="uEmail" placeholder="Email" required>
            <input type="password" id="uPass" name="uPass" placeholder="Password" required>
            <button type="submit">Login</button>
            <p>I don't have an account <a href="register.html">Register here</a></p>
        </form>

        <!-- Display Error Message -->
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <p style="color: red;"><%= errorMessage %></p>
        <%
            }
            session.removeAttribute("errorMessage");
        %>
    </div>
</body>
</html>
