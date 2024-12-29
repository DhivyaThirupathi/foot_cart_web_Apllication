

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/remove-restaurant")
public class RemoveRestaurantServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        int restaurantId = (int) session.getAttribute("resID");

        if ("confirm".equals(action)) {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                conn = DBConnection.getCon();

                // SQL query to delete the restaurant (with ON DELETE CASCADE)
                String deleteRestaurantQuery = "DELETE FROM restaurant WHERE resId = ?";
                pstmt = conn.prepareStatement(deleteRestaurantQuery);
                pstmt.setInt(1, restaurantId);

                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    session.invalidate(); // Invalidate session on successful deletion
                    request.setAttribute("message", "Restaurant Deleted Successfully!.");
                    request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "Failed to delete restaurant.");
                    request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
                }

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("message", "Error deleting restaurant. Please try again.");
                request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // If action is not confirmed or restaurant ID is missing, stay on the dashboard
            response.sendRedirect("admin-dashboard.jsp");
        }
    }
}
