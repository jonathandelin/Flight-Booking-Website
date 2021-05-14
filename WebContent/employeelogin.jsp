<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body  style="background-color:grey" >

		
		<div style="text-align:center;"><h1 style="background-color:red">Employee Login Page</h1></div>
		
		<form action="profile/controller/emp_sign_in_controller.jsp" method="post">
		
			Enter Admin Login:  <input type="text" name="emp_login"> <br>
			Enter Admin Password:  <input type="password" name="emp_pass"> <br>
			
			<input type="submit" value="Submit"><br>
			<a href="index.jsp">Login as Customer</a><br>
			
	
		</form>
	
		<%
		String message=(String)session.getAttribute("login_message");
		
		if(message!=null){
			out.println(message);
			session.removeAttribute("login_message");
		}
		
		
		%>


	

</body>
</html>