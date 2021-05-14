<%@page import="bean.Login_Bean"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	Login_Bean obj_Login_Bean=(Login_Bean)session.getAttribute("user_session");
	if(obj_Login_Bean==null){
		session.setAttribute("login_message", "Login Session Timed Out! Re-Login Please!");
	%>
	<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/index.jsp";
	</script>
	
	
	
	<%	
	}
	%>


<h2>Update Profile Page</h2>

<table border="1">
<tr>
<td>Username: <%=obj_Login_Bean.getUser_name() %></td>
<td><a href="Home.jsp">Home</a></td>
<td><a href="My_Profile.jsp">Profile</a></td>
<td><a href="flight_history.jsp">Check Flight History</a></td>
<td><a href="searchpage.jsp">Search for Flight And Reserve</a></td>
<td><a href="availableflights.jsp">Check Available Flights</a></td>
<td><a href="../controller/sign_out_controller.jsp">Log Out</a></td>
</tr>
</table>

<%


try{

Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement ps = connection.prepareStatement("SELECT C.email, C.city, C.state, C.zipcode, C.phone, C.address, C.ccnum FROM loginschema.customer C WHERE C.user_name=?;");
ps.setString(1, obj_Login_Bean.getUser_name());
ResultSet resultSet = ps.executeQuery();

if(resultSet.next()){
%>

<h2>User Information</h2>
<table border="1">
<tr>
<td>Email</td>
<td><%=resultSet.getString("email") %></td>
</tr>
<tr>
<td>City</td>
<td><%=resultSet.getString("city") %></td>
</tr>
<tr>
<td>State</td>
<td><%=resultSet.getString("state") %></td>
</tr>
<tr>
<td>ZipCode</td>
<td><%=resultSet.getString("zipcode") %></td>
</tr>
<tr>
<td>Phone number</td>
<td><%=resultSet.getString("phone") %></td>
</tr>
<tr>
<td>Address</td>
<td><%=resultSet.getString("address") %></td>
</tr>
<tr>
<td>Credit Card Number</td>
<td><%=resultSet.getString("ccnum") %></td>
</tr>	
			

</table>

<% 	

}
} catch (Exception e) {
	e.printStackTrace();
}
%>






<table border="1">
<form action="profile_update.jsp" method="post">
	
			<br>
			Update Email <input type="text" name="email"> <br>
			Update City <input type="text" name="city"> <br>
			Update State <input type="text" name="state"> <br>
			Update ZipCode <input type="text" name="zip"> <br>
			Update Phone number <input type="text" name="phonenumber"> <br>
			Update Address <input type="text" name="address"> <br>
			Update Credit Card Number <input type="text" name="ccnum"> <br>
			
			<input type="submit" value="Submit"><br>
		</form>
</table>

</body>
</html>