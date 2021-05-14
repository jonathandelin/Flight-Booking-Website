package Connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
	
	
	public static void main(String[] args) {
		DBconnection ob_DBConnection=new DBconnection();
		
		System.out.println(ob_DBConnection.getConnection());
	}
	
	
	
	
		//This function returns the connection
		public Connection getConnection() {
			Connection connection=null;
			System.out.println("Connection called");
			try {
				Class.forName("com.mysql.jdbc.Driver");
				connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return connection;
		}
}
