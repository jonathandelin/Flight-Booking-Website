<%@page import="java.sql.*"%>
<%@page import="bean.EmpLogin_Bean"%>

<%
	String chosen_airline = request.getParameter("airline");


EmpLogin_Bean obj_EmpLogin_Bean = (EmpLogin_Bean) session.getAttribute("user_session");
if (obj_EmpLogin_Bean == null) {
	session.setAttribute("login_message", "Login Session Timed Out! Re-Login Please!");
	%>
	<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/index.jsp";
	</script>
	<%	
	}
	%>

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
</table>

<br/><br/>

<form>
  <input type="button" value="Back" onclick="history.back()">
</form>

<br/>

<%
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
%>

<h3>Monthly Revenue By Destination</h3>

<table border="1">
<form action="emp_revenue_mon_dest.jsp" method="post">
			 Start:<br>
			 <input type="date" name="start"> <br>	
			 End:<br>
			 <input type="date" name="end"> <br>
			<input type="submit" value="Submit"><br>	
		</form>
</table>

<br/> 

<table border="1">

<tr>
	<td>Destination City</td>
	<td>Destination Revenue</td>
</tr>

<%
	String start = request.getParameter("start");
	String end = request.getParameter("end");
	out.print("Monthy Report: ");
	out.print(start);
	out.print(" - ");
	out.print(end);
		
%>

<%-- 
SELECT F.airport_arrive AS 'Destination City', SUM(R.bookingfee + (R.passengers * F.fares) - R.fare_restrictions) AS 'Destination Revenue' 
FROM loginschema.reservations R 
JOIN loginschema.flights F ON R.booked_flightnum = F.flightnum 
WHERE R.date >= ? AND R.date <= ? GROUP BY F.airport_arrive 
ORDER BY (R.bookingfee + (R.passengers * F.fares) - R.fare_restrictions) DESC
--%>

<%--
SELECT L.a_airport_id AS 'Destination City', SUM(L.fare * R.passengers) AS 'Destination Revenue'
FROM loginschema.reservations R
JOIN loginschema.reserved_legs RL ON RL.res_numR = R.res_num
JOIN loginschema.legs L ON RL.flight_numR = L.flight_num AND RL.departure = L.departure
WHERE R.date >= ? AND R.date <= ?
GROUP BY L.a_airport_id;
 --%>

<%
	try{ 
		Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
		PreparedStatement statement = connection.prepareStatement(" SELECT L.a_airport_id AS 'Destination City', SUM(L.fare * R.passengers) AS 'Destination Revenue' FROM loginschema.reservations R JOIN loginschema.reserved_legs RL ON RL.res_numR = R.res_num JOIN loginschema.legs L ON RL.flight_numR = L.flight_num AND RL.departure = L.departure WHERE R.date >= ? AND R.date <= ? GROUP BY L.a_airport_id ORDER BY SUM(R.passengers*L.fare) DESC;");
		statement.setString(1, start);
		statement.setString(2, end);
		ResultSet resultSet = statement.executeQuery();
		
		while(resultSet.next()){
			
%>

<tr>
<td><%=resultSet.getString("Destination City") %></td>
<td><%=resultSet.getString("Destination Revenue") %></td>
</tr>

<% 
	}

	} catch (Exception e) {
	e.printStackTrace();
	}
%>
</table>
