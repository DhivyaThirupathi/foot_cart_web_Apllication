import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class firstServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String query = "select * from userCredentials where userEmail=? and userPassword=?";
		try (Connection con=DBConnection.getCon();
			PreparedStatement stmt = con.prepareStatement(query);){
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			String email = request.getParameter("uEmail");
			String password = request.getParameter("uPass");
		
			stmt.setString(1, email);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			
			if(rs.next()) {
				int userId = rs.getInt("userId");
				System.out.println(userId);
				HttpSession session = request.getSession();
				session.setAttribute("userId", userId);
                response.sendRedirect("RestaurantServlet");
                System.out.println("Redirecting to RestaurantsServlet");
			}else {
				 request.setAttribute("errorMessage", "Invalid email or password");
                 request.getRequestDispatcher("login.jsp").forward(request, response);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
