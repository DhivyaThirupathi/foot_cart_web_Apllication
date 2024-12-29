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

@WebServlet("/EditUserProfile")
public class EditUserProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int userId = (int)session.getAttribute("userId");
        
        try (Connection con = DBConnection.getCon()) {
            String query = "SELECT userName, address, phone, userEmail FROM userCredentials WHERE userId = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                request.setAttribute("userId", userId);
                request.setAttribute("userName", rs.getString("userName"));
                request.setAttribute("address", rs.getString("address"));
                request.setAttribute("phone", rs.getLong("phone"));
                request.setAttribute("userEmail", rs.getString("userEmail"));
                
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
