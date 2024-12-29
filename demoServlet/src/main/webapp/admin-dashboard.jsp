<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        /* Background video styling */
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

        /* Full-screen video */
        .background-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        /* Overall container card */
        .overall-card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
            width: 80%;
            max-width: 1000px;
            border: 2px solid orange;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 30px; /* Add margin-bottom to create space under the card */
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            width: 100%;
        }

        .card {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    background-color: rgba(255, 255, 255, 0.7); /* Make the card slightly transparent */
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
    border: 2px solid orange;
    width: 180px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
    transform: translateY(-10px);
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.25);
}


        .card img {
            width: 80px;
            height: 80px;
            margin-bottom: 10px;
            object-fit: contain;
        }

        .card a {
            display: block;
            padding: 10px;
            background-color: orange;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            transition: background-color 0.3s ease, transform 0.3s ease, box-shadow 0.3s ease;
        }

        .card a:hover {
            background-color: #cc6600;
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }

        p {
            text-align: center;
            margin-top: 15px;
        }

        /* Modal Styles */
        #confirmModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        #confirmModalContent {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }

        #confirmYes, #confirmNo {
            padding: 10px 20px;
            margin: 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        #confirmYes {
            background-color: red;
            color: white;
        }

        #confirmNo {
            background-color: green;
            color: white;
        }

        /* Applying the provided h2 animation styles */
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
            margin-bottom: 30px;
        }

        h2:hover {
            color: #FF4500;
            transform: scale(1.1);
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);
        }
    </style>
    <script>
        function showConfirmModal() {
            document.getElementById("confirmModal").style.display = "block";
        }

        function hideConfirmModal() {
            document.getElementById("confirmModal").style.display = "none";
        }

        function confirmRemoval() {
            window.location.href = "remove-restaurant?action=confirm";
        }
    </script>
</head>
<body>
    <!-- Background video -->
    <video class="background-video" autoplay loop muted>
        <source src="https://ik.imagekit.io/whfmkiwjg/food1.mp4?tr=orig&updatedAt=1735232183552" type="video/mp4">
        Your browser does not support the video tag.
    </video>

    <!-- Overall Card Container -->
    <div class="overall-card">
        <!-- Admin Dashboard Title -->
        <h2>Admin Dashboard</h2>

        <%
            response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
            if(session.getAttribute("resID") == null) {
                response.sendRedirect("adminLogin.jsp");
            }
        %>

        <!-- Display Success Message -->
        <%
            session = request.getSession(false);
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                out.println("<p style='color: green;'>" + successMessage + "</p>");
                session.removeAttribute("successMessage"); // Remove the message after displaying
            }
        %>

        <!-- Container for Cards -->
        <div class="container">
            <!-- Add Food Card -->
            <div class="card">
                <img src="https://ik.imagekit.io/zwq8uei9d/complete-order-icon-in-filled-line-style-for-any-vector-35318884.jpg?updatedAt=1735223856143" alt="Add Food">
                <a href="add-food.jsp">Add Food</a>
            </div>
            <!-- View Orders Card -->
            <div class="card">
                <img src="https://ik.imagekit.io/zwq8uei9d/images.jpg?updatedAt=1735223855778" alt="View Orders">
                <a href="view-orders">View Orders</a>
            </div>
            <!-- Edit Food Items Card -->
            <div class="card">
                <img src="https://ik.imagekit.io/zwq8uei9d/download.jpg" alt="Edit Food Items">
                <a href="edit-food">Edit Food Items</a>
            </div>
            <!-- Remove Restaurant Card -->
            <div class="card">
                <img src="https://ik.imagekit.io/zwq8uei9d/photo-1517248135467-4c7edcad34c4.jpg?updatedAt=1735223856448" alt="Remove Restaurant">
                <a href="#" onclick="showConfirmModal()">Remove Your Restaurant</a>
            </div>
            <!-- Logout Card -->
            <div class="card">
                <img src="https://ik.imagekit.io/zwq8uei9d/pngtree-vector-logout-icon-png-image_1022628.jpg?updatedAt=1735223855897" alt="Logout">
                <a href="logout.jsp">Logout</a>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div id="confirmModal">
        <div id="confirmModalContent">
            <p>Would you like to remove your restaurant completely?</p>
            <button id="confirmYes" onclick="confirmRemoval()">Yes</button>
            <button id="confirmNo" onclick="hideConfirmModal()">Cancel</button>
        </div>
    </div>
</body>
</html>
