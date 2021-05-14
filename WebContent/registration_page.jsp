<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body  style="background-color:grey" >

	
		<div style="text-align:center;"><h1 style="background-color:red">Registration Page</h1></div>
		<form action="regconnect.jsp" method="post">
			Enter Username <input type="text" name="user_name"> <br>
			Enter Password <input type="password" name="password"> <br>
			Enter First Name <input type="text" name="first_name"> <br>
			Enter Last Name <input type="text" name="last_name"> <br>
			Enter Email <input type="text" name="email"> <br>
			Enter City <input type="text" name="city"> <br>
			Enter State <input type="text" name="state"> <br>
			Enter ZipCode <input type="text" name="zip"> <br>
			Enter Phone number <input type="text" name="phonenumber"> <br>
			Enter Address <input type="text" name="address"> <br>
			Enter Credit Card Number <input type="text" name="ccnum"> <br>
			
			
			
			<input type="submit" value="Submit"><br>
			<a href="index.jsp">Login</a><br>
			<a href="employeelogin.jsp">Employee? Sign in here.</a>
		</form>
	

		<%
		String message=(String)session.getAttribute("register_message");
		
		%>
	


	

</body>
</html>