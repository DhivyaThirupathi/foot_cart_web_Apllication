

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected long addUser(String newEmail, String newPass, String newName, String newAddress, long newPhone) {
    	Connection con = DBConnection.getCon();
    	long pk = 0;
    	try {
    		PreparedStatement stmt = con.prepareStatement("select * from userCredentials where userEmail=?");
    		stmt.setString(1, newEmail);
    		ResultSet rs = stmt.executeQuery();
    		if(!rs.next()) {
    			stmt = con.prepareStatement("insert into userCredentials values(0,?,?,?,?,?)");
        		stmt.setString(1, newName);
        		stmt.setString(2, newAddress);
        		stmt.setLong(3,newPhone);
        		stmt.setString(4,newEmail);
        		stmt.setString(5,newPass);
        		
        		pk = stmt.executeUpdate();
        		return pk;
    		}
    		else {
    			return pk;
    		}
    	}catch(SQLException e) {
    		e.printStackTrace();
    	}
    	return pk;
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
	    PrintWriter out = response.getWriter();
	    out.print("<h1>This Servlet is for POST requests only</h1>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		String newEmail = request.getParameter("uEmail");
		String newPass = request.getParameter("uPass");
		String newName = request.getParameter("uName");
		String newAddress = request.getParameter("uAddress");
		long newPhone = Long.parseLong(request.getParameter("uPhone"));
		
		if(addUser(newEmail,newPass,newName,newAddress,newPhone)==1) {
			response.sendRedirect("login.jsp");
		}else {
			out.print("<h1>Email Already Exists</h2>");
		}
	}

}
