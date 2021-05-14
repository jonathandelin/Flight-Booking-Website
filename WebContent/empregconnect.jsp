<%@page import="java.sql.*"%>
<%

String emp_pass = request.getParameter("emp_pass");
String emp_login = request.getParameter("emp_login");





try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
	PreparedStatement ps3 = con.prepareStatement("INSERT INTO loginschema.employee (`emp_pass`, 'emp_login') VALUES (?, ?);");
	
	
	ps3.setString(1, emp_pass);
	ps3.setString(2, emp_login);

	
	int up3 = ps3.executeUpdate();
	
	
	
}catch(Exception e){
	out.print(e);
}


%>

<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/index.jsp";
	</script>