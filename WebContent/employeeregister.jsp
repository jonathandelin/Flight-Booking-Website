<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	
		<h3>Employee Registration Page</h3>
		<form action="empregconnect.jsp" method="post">
			Enter New Employee Password <input type="password" name="emp_pass"> <br>
			Enter New Employee Login <input type="text" name="emp_login"> <br>
			<input type="submit" value="Submit">
			
			<a href="registration_page.jsp">Register Here</a>
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