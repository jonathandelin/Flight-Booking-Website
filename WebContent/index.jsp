<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<body  style="background-color:grey" >


	<div style="text-align:center;"><h1 style="background-color:red">Login Page</h1></div>
	
	<form action="profile/controller/sign_in_controller.jsp" method="post">

		<table>
	
			<tr>
				<td>Enter Username <input type="text" name="user_name">
					<br></td>
			</tr>

			<tr>
				<td>Enter Password <input type="password" name="password">
					<br></td>
			</tr>

			<tr>
				<td>
					<input style="text-align: center;" type="submit" value="Submit"> 
				</td>
			</tr>
			
			
			
		<%
		String message = (String) session.getAttribute("login_message");
		if (message != null) {
			out.println(message);
			session.removeAttribute("login_message");
		}
		%>	
			
	
		</table>
		
	</form>
	
	<section>
		<nav>
			<a href="registration_page.jsp">New? Register Here!</a> <br>
			<a href="employeelogin.jsp">Employee? Sign in here.</a>
		</nav> 
	</section>

</body>
</html>