package modal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Connection.DBconnection;
import bean.Login_Bean;

public class Login_Modal {
	
	public boolean check_user_name(Login_Bean obj_Login_Bean) {
		
		boolean flag=false;
		
		DBconnection obj_DBconnection=new DBconnection();
		Connection connection=obj_DBconnection.getConnection();
		
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			String query="SELECT * FROM loginschema.account where user_name=? and password=?";
			ps=connection.prepareStatement(query);
			ps.setString(1, obj_Login_Bean.getUser_name());
			ps.setString(2, obj_Login_Bean.getPassword());
			System.out.println(ps);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				flag=true;
			}
			
			
		} catch (Exception e) {
			
		} finally {
			try {
				if(connection!=null) {
					connection.close();
					}
			} catch (Exception e2) {
				
			}
		}
		
		return flag;
		
	}

}
