import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.foodorderapp.model.UserOrderedDetails;
import java.sql.*;
import java.util.*;

@WebServlet("/userOrderDetails")
public class UserOrderDetailsServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/application";  // Modify accordingly
    private static final String DB_USER = "root";  // Modify accordingly
    private static final String DB_PASSWORD = "Gopi@2003";  // Modify accordingly

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");  // Assuming userId is stored in session

        if (userId == null) {
            response.sendRedirect("login.jsp");  // Redirect to login page if user is not logged in
            return;
        }

        List<UserOrderedDetails> userOrderedDetailsList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            // Modify the SQL query to join the restaurant table and fetch resName
        	String sql = "SELECT o.order_id, o.order_date, o.order_status, f.food, od.quantity, od.price, r.resName "
        	           + "FROM orders o "
        	           + "JOIN order_details od ON o.order_id = od.order_id "
        	           + "JOIN food f ON od.food_id = f.foodId "
        	           + "JOIN restaurant r ON od.res_id = r.resId "  // Join with restaurant table correctly
        	           + "WHERE o.user_id = ? "
        	           + "ORDER BY o.order_date DESC"; 
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        UserOrderedDetails order = new UserOrderedDetails();
                        order.setOrderId(rs.getInt("order_id"));
                        order.setOrderDate(rs.getTimestamp("order_date"));
                        order.setOrderStatus(rs.getString("order_status"));
                        order.setFood(rs.getString("food"));
                        order.setQuantity(rs.getInt("quantity"));
                        order.setPrice(rs.getDouble("price"));
                        order.setResName(rs.getString("resName"));  // Set the restaurant name
                        userOrderedDetailsList.add(order);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Error fetching order details", e);
        }

        // Set the ordered details list as a request attribute
        request.setAttribute("userOrderedDetailsList", userOrderedDetailsList);
        
        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("userOrderDetails.jsp");
        dispatcher.forward(request, response);
    }
}
