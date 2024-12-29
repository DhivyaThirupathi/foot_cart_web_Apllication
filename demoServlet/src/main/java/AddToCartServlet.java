

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    HttpSession session = request.getSession(false); // Prevent new session creation if not present
	    if (session == null || session.getAttribute("userId") == null) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        response.getWriter().write("{\"message\":\"User not logged in.\"}");
	        return;
	    }

	    int userId = (int) session.getAttribute("userId");
	    String foodName = request.getParameter("foodName");
	    String foodPriceStr = request.getParameter("foodPrice");
	    String foodIdStr = request.getParameter("foodId");
	    int restaurantId = 0;

	    try {
	        restaurantId = Integer.parseInt(request.getParameter("resId"));
	    } catch (NumberFormatException e) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        response.getWriter().write("{\"message\":\"Invalid restaurant ID.\"}");
	        return;
	    }

	    double foodPrice;
	    int foodId;
	    try {
	        foodPrice = Double.parseDouble(foodPriceStr);
	        foodId = Integer.parseInt(foodIdStr);
	    } catch (NumberFormatException e) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        response.getWriter().write("{\"message\":\"Invalid food price or ID.\"}");
	        return;
	    }

	    int quantity = 1;

	    try (Connection con = DBConnection.getCon()) {
	        String selectQuery = "SELECT quantity FROM cart WHERE user_id = ? AND food_id = ?";
	        try (PreparedStatement selectStmt = con.prepareStatement(selectQuery)) {
	            selectStmt.setInt(1, userId);
	            selectStmt.setInt(2, foodId);
	            ResultSet rs = selectStmt.executeQuery();

	            if (rs.next()) {
	                int newQuantity = rs.getInt("quantity") + quantity;
	                String updateQuery = "UPDATE cart SET quantity = ? WHERE user_id = ? AND food_id = ?";
	                try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
	                    updateStmt.setInt(1, newQuantity);
	                    updateStmt.setInt(2, userId);
	                    updateStmt.setInt(3, foodId);
	                    updateStmt.executeUpdate();
	                }
	            } else {
	                String insertQuery = "INSERT INTO cart (user_id, food_id, quantity) VALUES (?, ?, ?)";
	                try (PreparedStatement insertStmt = con.prepareStatement(insertQuery)) {
	                    insertStmt.setInt(1, userId);
	                    insertStmt.setInt(2, foodId);
	                    insertStmt.setInt(3, quantity);
	                    insertStmt.executeUpdate();
	                }
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        response.getWriter().write("{\"message\":\"Failed to add item to cart.\"}");
	    }
	 // After processing the cart update
	    session.setAttribute("restaurantId", restaurantId);
	    response.sendRedirect("FoodServlet?restaurant_id=" + restaurantId);

	}

}
