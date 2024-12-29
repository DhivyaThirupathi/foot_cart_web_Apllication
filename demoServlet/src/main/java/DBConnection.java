import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.*;

public class DBConnection {
	public static Connection con = null;
	public static Connection getCon() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/application", "root", "Gopi@2003");
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
}
