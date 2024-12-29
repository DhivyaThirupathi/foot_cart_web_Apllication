

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demoServlet.FoodItem;

/**
 * Servlet implementation class FoodServlet
 */
@WebServlet("/FoodServlet")
public class FoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FoodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Disable caching to ensure the back button behaves correctly
        

        int restaurantId = Integer.parseInt(request.getParameter("restaurant_id"));
        System.out.println("Food Servlet res id: " + restaurantId);

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        System.out.println("Food Servlet user id: " + userId);

        ArrayList<FoodItem> foodList = new ArrayList<>();

        try (Connection con = DBConnection.getCon()) {
            String checkQuery = "SELECT DISTINCT f.resId FROM cart c INNER JOIN food f ON c.food_id = f.foodId WHERE c.user_id = ?";
            PreparedStatement ps = con.prepareStatement(checkQuery);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int existingResId = rs.getInt("resId");
                if (existingResId != restaurantId) {
                    String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
                    PreparedStatement clearCartStmt = con.prepareStatement(clearCartQuery);
                    clearCartStmt.setInt(1, userId);
                    clearCartStmt.executeUpdate();
                }
            }

            String query = "SELECT * FROM food WHERE resId = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, restaurantId);
            rs = ps.executeQuery();

            while (rs.next()) {
                FoodItem food = new FoodItem();
                food.setFoodId(rs.getInt("foodId"));
                food.setFoodName(rs.getString("food"));
                food.setPrice(rs.getInt("price"));
                foodList.add(food);
            }

            request.setAttribute("foodList", foodList);
            request.setAttribute("resName", getResName(con, restaurantId));
            request.setAttribute("resId", restaurantId);

            RequestDispatcher dispatcher = request.getRequestDispatcher("foods.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

	private String getResName(Connection con,int resId) throws SQLException{
		String query = "select resName from restaurant where resId = ?";
		PreparedStatement ps = con.prepareStatement(query);
		ps.setInt(1, resId);
		ResultSet rs = ps.executeQuery();
		return rs.next() ? rs.getString("resName") : "Unknown Restaurant";
}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
