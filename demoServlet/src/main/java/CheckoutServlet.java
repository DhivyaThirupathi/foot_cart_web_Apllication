import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.foodorderapp.model.OrderDetail;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CheckoutServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        int restaurantId = Integer.parseInt(request.getParameter("resId"));
        Connection conn = null;

        try {
            conn = DBConnection.getCon();
            conn.setAutoCommit(false);

            // Fetch cart details and calculate total amount
            String cartQuery = "SELECT f.foodId, c.quantity, f.price * c.quantity AS total_price " +
                               "FROM cart c " +
                               "INNER JOIN food f ON c.food_id = f.foodId " +
                               "WHERE c.user_id = ?";
            PreparedStatement cartStmt = conn.prepareStatement(cartQuery);
            cartStmt.setInt(1, userId);
            ResultSet rs = cartStmt.executeQuery();

            double totalAmount = 0;
            ArrayList<OrderDetail> cartItems = new ArrayList<>();
            while (rs.next()) {
                totalAmount += rs.getDouble("total_price");

                // Save cart details for later processing
                OrderDetail detail = new OrderDetail();
                detail.setFoodId(rs.getInt("foodId"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setPrice(rs.getDouble("total_price"));
                cartItems.add(detail);
            }

            // Insert into orders table
            String orderQuery = "INSERT INTO orders (user_id, res_id, total_amount) VALUES (?, ?, ?)";
            PreparedStatement orderStmt = conn.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            orderStmt.setInt(1, userId);
            orderStmt.setInt(2, restaurantId);
            orderStmt.setDouble(3, totalAmount);
            int rowsInserted = orderStmt.executeUpdate();

            int orderId = 0;
            if (rowsInserted > 0) {
                ResultSet generatedKeys = orderStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
                }
            }

            // Insert into order_details table
            String orderDetailsQuery = "INSERT INTO order_details(order_id, res_id, food_id, quantity, price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement orderDetailsStmt = conn.prepareStatement(orderDetailsQuery);
            for (OrderDetail item : cartItems) {
                orderDetailsStmt.setInt(1, orderId);
                orderDetailsStmt.setInt(2, restaurantId);
                orderDetailsStmt.setInt(3, item.getFoodId());
                orderDetailsStmt.setInt(4, item.getQuantity());
                orderDetailsStmt.setDouble(5, item.getPrice());
                orderDetailsStmt.addBatch();
            }
            orderDetailsStmt.executeBatch();

            // Clear the cart
            String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
            PreparedStatement clearCartStmt = conn.prepareStatement(clearCartQuery);
            clearCartStmt.setInt(1, userId);
            clearCartStmt.executeUpdate();

            // Retrieve order details and restaurant name
            String orderDetailsFetchQuery = "SELECT od.food_id, od.quantity, od.price, f.food AS food_name, r.resName AS restaurant_name " +
                                            "FROM order_details od " +
                                            "JOIN food f ON od.food_id = f.foodId " +
                                            "JOIN restaurant r ON od.res_id = r.resId " +
                                            "WHERE od.order_id = ?";
            PreparedStatement orderDetailsFetchStmt = conn.prepareStatement(orderDetailsFetchQuery);
            orderDetailsFetchStmt.setInt(1, orderId);
            ResultSet orderDetailsRs = orderDetailsFetchStmt.executeQuery();

            ArrayList<OrderDetail> orderDetailsList = new ArrayList<>();
            while (orderDetailsRs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setFoodId(orderDetailsRs.getInt("food_id"));
                detail.setQuantity(orderDetailsRs.getInt("quantity"));
                detail.setPrice(orderDetailsRs.getDouble("price"));
                detail.setFoodName(orderDetailsRs.getString("food_name"));
                detail.setRestaurantName(orderDetailsRs.getString("restaurant_name"));
                orderDetailsList.add(detail);
            }

            request.setAttribute("orderDetails", orderDetailsList);
            request.setAttribute("orderId", orderId);
            RequestDispatcher dispatcher = request.getRequestDispatcher("orderConfirmation.jsp");
            dispatcher.forward(request, response);

            conn.commit();
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
