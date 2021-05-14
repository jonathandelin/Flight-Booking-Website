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
</tr>
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
<td>Airline ID</td>
<td>Seat Number</td>
<td>Working Days</td>
<td>Fares</td>
<td>Flight Departs From</td>
<td>Flight Arrives At</td>


</tr>
<%
try{ 
Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.2/", "root", "admin");
Statement statement = connection.createStatement();
String displayall ="SELECT * FROM loginschema.flights;";
ResultSet resultSet = statement.executeQuery(displayall);


while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("flightnum") %></td>
<td><%=resultSet.getString("airline") %></td>
<td><%=resultSet.getString("numseats") %></td>
<td><%=resultSet.getString("wdays") %></td>
<td>$<%=resultSet.getString("fares") %>
<td><%=resultSet.getString("airport_depart") %>
<td><%=resultSet.getString("airport_arrive") %>
</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>

<h3>Most Active Flights</h3>
<table border="1">
<tr>
<td>Flight Number</td>
<td>Number of Stops</td>
</tr>
<% 
try{
Connection connection2 = DriverManager.getConnection("jdbc:mysql://127.0.0.2/", "root", "admin");
Statement statement2 = connection2.createStatement();
String displaymostpopular = "SELECT L.flight_num, COUNT(L.flight_num) AS Number_of_Stops FROM loginschema.legs L GROUP BY L.flight_num ORDER BY COUNT(*) DESC;";
ResultSet resultSet2 = statement2.executeQuery(displaymostpopular);

while(resultSet2.next()){
%>	
<tr>
<td><%=resultSet2.getString("flight_num") %></td>
<td><%=resultSet2.getString("Number_of_Stops") %></td>
	
<% 	
}

} catch (Exception e) {
	e.printStackTrace();
}
%>
</table>
