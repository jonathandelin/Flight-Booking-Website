<%@page import="bean.EmpLogin_Bean"%>
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
	EmpLogin_Bean obj_EmpLogin_Bean=(EmpLogin_Bean)session.getAttribute("user_session");
	if(obj_EmpLogin_Bean==null){
		session.setAttribute("login_message", "Login Session Timed Out! Re-Login Please!");
	%>
	<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/index.jsp";
	</script>
	
	
	
	<%	
	}
	%>

<h2>Update Customer's Profile</h2>
<table border="1">
<tr>
<td>Administrator: <%=obj_EmpLogin_Bean.getEmp_login() %></td>
				
				<td><a href="employeemanagementpage.jsp">Home</a></td>
				<td><a href="Emp_Profile.jsp">Profile</a></td>
				<td><a href="employee_listflights.jsp">List of Flights</a></td>
				<td><a href="employee_flightsbyairport.jsp">List of Flights by Airport</a></td>	
				<td><a href="employee_reservationlist.jsp">List of Reservations</a></td>
				<td><a href="emp_reservation_by_flight.jsp">View Reservation by Flight</a></td>	
				<td><a href="employee_managecustomer.jsp">Manage a Customer</a></td>		
				<td><a href="emp_revenue_main.jsp">Revenue</a></td>
				
				<td><a href="../controller/sign_out_controller.jsp">Log Out</a></td>
</tr>
</table>

<table border="1">
<form action="emp_profile_update.jsp" method="post">
			<br>
			Enter user name of Customer to be edited: <input type="text" name="username"> <br>
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