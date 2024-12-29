


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

@WebServlet("/update-food-price")
public class UpdateFoodPriceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String foodName = request.getParameter("foodName");
        String price = request.getParameter("price");

        Connection conn = null;
        PreparedStatement pstmt = null;
        String message="";

        try {
            conn = DBConnection.getCon();
            String sql = "UPDATE food SET price = ? WHERE food = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, Double.parseDouble(price));
            pstmt.setString(2, foodName);

            
            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                message = "Price updated successfully!";
            } else {
                message = "Price update failed!";
            }
            
            response.sendRedirect("edit-food");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

