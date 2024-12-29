<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.foodorderapp.model.OrderDetail" %>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        /* Existing styles remain unchanged */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 1200px;
            margin: 50px auto;
            background-color: white;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            border: 3px solid orange;
        }

        h1 {
            text-align: center;
            font-size: 36px;
            font-weight: normal;
            color: #FFA500;
            margin-top: 20px;
            padding: 12px;
            background-color: #fff8e1;
            border-radius: 8px;
            border: 2px solid orange;
        }

        .confirmation-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .confirmation-container p {
            font-size: 18px;
            color: #2c3e50;
            margin-top: 15px;
            padding: 8px;
            background-color: #ecf0f1;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }

        .confirmation-container table {
            width: 80%;
            margin-top: 20px;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        th, td {
            padding: 10px;
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

        .btn-back {
            margin-top: 20px;
            font-size: 18px;
            text-decoration: none;
            color: #2980b9;
            border: 2px solid #2980b9;
            padding: 8px 16px;
            border-radius: 5px;
            background-color: #fff;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background-color: #2980b9;
            color: white;
        }

        /* Confetti animation */
        .confetti {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1000;
        }

        .confetti-piece {
            position: absolute;
            width: 15px;
            height: 15px;
            background-color: var(--color, red);
            opacity: 0.9;
            animation: pop 2.5s ease-out infinite;
        }

        @keyframes pop {
            0% {
                transform: translateY(0) rotate(0);
                opacity: 1;
            }
            75% {
                opacity: 0.5;
            }
            100% {
                transform: translateY(800px) rotate(720deg);
                opacity: 0;
            }
        }
    </style>
</head>
<body>
<div class="confetti"></div> <!-- Confetti container -->

<div class="container">
    <h1>Order Confirmation</h1>
    <div class="confirmation-container">
        <p>Your Order ID: <strong><%= request.getAttribute("orderId") %></strong></p>
        <p>Restaurant: <strong><%= ((OrderDetail) ((ArrayList<?>) request.getAttribute("orderDetails")).get(0)).getRestaurantName() %></strong></p>
        <table>
            <thead>
                <tr>
                    <th>Food Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<OrderDetail> orderDetails = (ArrayList<OrderDetail>) request.getAttribute("orderDetails");
                    for (OrderDetail detail : orderDetails) {
                %>
                <tr>
                    <td><%= detail.getFoodName() %></td>
                    <td><%= detail.getQuantity() %></td>
                    <td><%= detail.getPrice() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <a href="RestaurantServlet" class="btn-back">Back to Menu</a>
    </div>
</div>

<script>
    // Generate confetti animation
    function generateConfetti() {
        const confettiContainer = document.querySelector('.confetti');
        const numberOfPieces = 100;

        for (let i = 0; i < numberOfPieces; i++) {
            const confettiPiece = document.createElement('div');
            confettiPiece.classList.add('confetti-piece');

            // Random colors for confetti
            const colors = [
                '#FF5733', '#33FF57', '#3357FF', '#FFD700', '#FF33A8',
                '#A833FF', '#33FFF0', '#FF8C33', '#FFC733'
            ];
            const randomColor = colors[Math.floor(Math.random() * colors.length)];
            confettiPiece.style.setProperty('--color', randomColor);

            // Random position and animation delay
            confettiPiece.style.left = Math.random() * 100 + '%';
            confettiPiece.style.animationDelay = Math.random() * 2 + 's';

            confettiContainer.appendChild(confettiPiece);
        }

        // Remove confetti pieces after 1 minute (60,000 milliseconds)
        setTimeout(() => {
            confettiContainer.innerHTML = '';
        }, 5000);
    }

    // Trigger confetti animation on page load
    window.onload = generateConfetti;
</script>

</body>
</html>
