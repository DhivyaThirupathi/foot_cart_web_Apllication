import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getCon()) {
            String query = "SELECT * FROM restaurant WHERE resEmail = ? AND password = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, email);
                pstmt.setString(2, password);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        int id = rs.getInt("resId");
                        HttpSession session = request.getSession();
                        session.setAttribute("resID", id);
                        session.setAttribute("successMessage", "Login successful!");
                        response.sendRedirect("admin-dashboard.jsp");
                    } else {
                        request.setAttribute("errorMessage", "Invalid email or password");
                        request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            request.setAttribute("errorMessage", "Internal Server Error");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
