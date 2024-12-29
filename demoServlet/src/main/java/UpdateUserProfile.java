import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateUserProfile")
public class UpdateUserProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String userName = request.getParameter("userName");
        String address = request.getParameter("address");
        String userEmail = request.getParameter("userEmail");
        long phone = Long.parseLong(request.getParameter("phone"));
        
        try (Connection con = DBConnection.getCon()) {
            String updateQuery = "UPDATE userCredentials SET userName = ?, address = ?, userEmail = ?, phone = ? WHERE userId = ?";
            PreparedStatement stmt = con.prepareStatement(updateQuery);
            stmt.setString(1, userName);
            stmt.setString(2, address);
            stmt.setString(3, userEmail);
            stmt.setLong(4, phone);
            stmt.setInt(5, userId);
            
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("successMessage", "Failed to update profile.");
            }
            
            request.getRequestDispatcher("UserProfile").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("successMessage", "Error updating profile.");
            request.getRequestDispatcher("UserProfile").forward(request, response);
        }
    }
}
