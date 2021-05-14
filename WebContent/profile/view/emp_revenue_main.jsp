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
		EmpLogin_Bean obj_EmpLogin_Bean = (EmpLogin_Bean) session.getAttribute("user_session");
		if (obj_EmpLogin_Bean == null) {
			session.setAttribute("login_message", "Login Session Timed Out! Re-Login Please!");
	%>
	<script type="text/javascript">
		window.location.href = "http://localhost:8080/LoginPractice/index.jsp";
	</script>



	<%
		}
	%>


	<div>
		<h2>Revenue Page</h2>
		<table border="1">
			<tr>
				<td>Administrator: <%=obj_EmpLogin_Bean.getEmp_login() %></td>
				
				<td><a href="employeemanagementpage.jsp">Home</a></td>
				<td><a href="employee_listflights.jsp">List of Flights</a></td>
				<td><a href="employee_flightsbyairport.jsp">List of Flights by Airport</a></td>	
				<td><a href="employee_reservationlist.jsp">List of Reservations</a></td>
				<td><a href="emp_reservation_by_flight.jsp">View Reservation by Flight</a></td>	
				<td><a href="employee_managecustomer.jsp">Manage a Customer</a></td>		
				<td><a href="emp_revenue_main.jsp">Revenue</a></td>
				
				<td><a href="../controller/sign_out_controller.jsp">Log Out</a></td>
			</tr>

		</table>
		<br/>
		
		<h4>See Total Revenues By:</h4>
		
		<table style="border:1px solid black;">
			<tr>
				<td><a href="emp_revenue_flight.jsp">Flight</a></td>
				<td><a href="emp_revenue_dest.jsp">Destination</a></td>
				<td><a href="emp_revenue_customer.jsp">Customer</a></td>
			</tr>
		</table>
		
		<h4>See Monthly Revenues By:</h4>
		
		<table style="border:1px solid black;">
			<tr>
				<td><a href="emp_revenue_mon_flight.jsp">Flight</a></td>
				<td><a href="emp_revenue_mon_dest.jsp">Destination</a></td>
				<td><a href="emp_revenue_mon_customer.jsp">Customer</a></td>
				

			</tr>
		</table>

	</div>

</body>
</html>