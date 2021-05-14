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

<h2>Airlines Page</h2>
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

<table border="1">
	<form action="employee_flightsbyairport.jsp" method="post">
			Airport Name:<br>
			<input type="text" name="airportname"> <br>	
			<input type="submit" value="Submit"><br>	
		</form>
	</table>

<%
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

%>
<h3>List of Flights</h3>
<table border="1">

<tr>
<td>Flight Number</td>
<td>Departure Day</td>
<td>Arriving At</td>


</tr>
<%
try{ 
String airportname = request.getParameter("airportname");
Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement statement  = connection.prepareStatement("SELECT F.flightnum AS 'Flight_Number', F.wdays AS 'Departure_Day', B.city AS 'Arriving_At' FROM loginschema.flights F, loginschema.airports B WHERE F.airport_depart IN (SELECT A.airportID FROM loginschema.airports A WHERE A.airportID =?) AND F.airport_arrive=B.airportID;");
statement.setString(1, airportname);

ResultSet resultSet = statement.executeQuery();


while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("Flight_Number") %></td>
<td><%=resultSet.getString("Departure_Day") %></td>
<td><%=resultSet.getString("Arriving_At") %></td>

</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>