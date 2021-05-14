<%@page import="java.sql.*"%>
<%
String user_name = request.getParameter("user_name");
String password = request.getParameter("password");

String first_name = request.getParameter("first_name");
String last_name = request.getParameter("last_name");
String email = request.getParameter("email");
String city = request.getParameter("city");
String state = request.getParameter("state");
String zip = request.getParameter("zip");
String phonenumber = request.getParameter("phonenumber");
String address = request.getParameter("address");
String ccnum = request.getParameter("ccnum");

try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
	PreparedStatement ps = con.prepareStatement("INSERT INTO loginschema.account (`user_name`, `password`) VALUES (?, ?);");
	PreparedStatement ps2 = con.prepareStatement("INSERT INTO loginschema.customer (`fname`, `lname`, `email`, `city`, `state`, `zipcode`, `phone`, `address`, `ccnum`, `creation_date`, `user_name`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURDATE(),?);");
	ps.setString(1, user_name);
	ps.setString(2, password);

	ps2.setString(1, first_name);
	ps2.setString(2, last_name);
	ps2.setString(3, email);
	ps2.setString(4, city);
	ps2.setString(5, state);
	ps2.setString(6, zip);
	ps2.setString(7, phonenumber);
	ps2.setString(8, address);
	ps2.setString(9, ccnum);
	ps2.setString(10, user_name);
	
	int up1 = ps.executeUpdate();
	int up2 = ps2.executeUpdate();

	
	
}catch(Exception e){
	out.print(e);
}


%>

<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/index.jsp";
	</script>