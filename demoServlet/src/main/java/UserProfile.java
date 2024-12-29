import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.foodorderapp.model.User;

/**
 * Servlet implementation class UserProfile
 */
@WebServlet("/UserProfile")
public class UserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int userId = (int)session.getAttribute("userId");
		try(Connection con = DBConnection.getCon()){
			String query = "select userName,address,phone,userEmail from userCredentials where userId = ?";
			
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			
			User user = new User();
			while(rs.next()) {
				user.setName(rs.getString("userName"));
				user.setAddress(rs.getString("address"));
				user.setEmail(rs.getString("userEmail"));
				user.setPhone(rs.getLong("phone"));
			}
			
			request.setAttribute("userD", user);
			
			request.getRequestDispatcher("userProfile.jsp").forward(request, response);
			System.out.println("Redirecting to userProfile.jsp");
			
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}


}