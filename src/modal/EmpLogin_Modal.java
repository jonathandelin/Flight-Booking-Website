package modal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import Connection.DBconnection;
import bean.EmpLogin_Bean;
import bean.Login_Bean;

public class EmpLogin_Modal {
	
	public boolean check_user_name(EmpLogin_Bean obj_EmpLogin_Bean) {
		
		boolean flag=false;
		
		DBconnection obj_DBconnection=new DBconnection();
		Connection connection=obj_DBconnection.getConnection();
		
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			String query="SELECT * FROM loginschema.employee where emp_login=? and emp_pass=?";
			ps=connection.prepareStatement(query);
			ps.setString(1, obj_EmpLogin_Bean.getEmp_login());
			ps.setString(2, obj_EmpLogin_Bean.getEmp_pass());
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
