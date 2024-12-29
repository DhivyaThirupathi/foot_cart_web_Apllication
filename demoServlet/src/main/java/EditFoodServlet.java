import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import demoServlet.FoodItem;


@WebServlet("/edit-food")
public class EditFoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        HttpSession session = request.getSession();
        int restaurantId = (int) session.getAttribute("resID"); // Logged-in restaurant ID

        try {
            conn = DBConnection.getCon();
            String sql = "SELECT * FROM food WHERE resId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, restaurantId);
            rs = pstmt.executeQuery();

            ArrayList<FoodItem> foodList = new ArrayList<>();
            while (rs.next()) {
                FoodItem food = new FoodItem();
                food.setFoodName(rs.getString("food"));
                System.out.println(rs.getString("food"));
                food.setPrice(rs.getDouble("price"));
                food.setResId(restaurantId);
                foodList.add(food);
            }
            
            
            
            request.setAttribute("foodList", foodList);
            request.getRequestDispatcher("edit-food.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

