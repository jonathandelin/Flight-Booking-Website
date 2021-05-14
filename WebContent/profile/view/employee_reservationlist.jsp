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

<h2>Reservation Page</h2>
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
	<form action="employee_reservationlist.jsp" method="post">
			Enter Customer Last Name or Flight Number:<br>
			<input type="text" name="input"> <br>	
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
<h3>List of Reservations for chosen Customer or Flight</h3>
<table border="1">

<tr>
<td>Reservation Number</td>
<td>Customer Login</td>
<td>Number of Passengers</td>
<td>Date</td>
<td>Flight Number</td>


</tr>
<%
try{ 
String input = request.getParameter("input");
Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement statement  = connection.prepareStatement("SELECT R.res_num, R.login, R.passengers, R.date, R.booked_flightnum FROM loginschema.reservations R WHERE R.booked_flightnum = ? OR R.login IN (SELECT A.user_name FROM loginschema.account A WHERE A.user_name IN (SELECT C.user_name FROM loginschema.customer C WHERE C.lname = ? ));");
statement.setString(1, input);
statement.setString(2, input);

ResultSet resultSet = statement.executeQuery();


while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("res_num") %></td>
<td><%=resultSet.getString("login") %></td>
<td><%=resultSet.getString("passengers") %></td>
<td><%=resultSet.getString("date") %></td>
<td><%=resultSet.getString("booked_flightnum") %></td>

</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>

<h3>List of ALL Reservations</h3>
<table border="1">

<tr>
<td>Reservation Number</td>
<td>Customer Login</td>
<td>Number of Passengers</td>
<td>Date</td>
<td>Flight Number</td>


</tr>
<%
try{ 
String input = request.getParameter("input");
Connection connection2 = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement statement2  = connection2.prepareStatement("SELECT R.res_num, R.login, R.passengers, R.date, R.booked_flightnum FROM loginschema.reservations R;");

ResultSet resultSet2 = statement2.executeQuery();


while(resultSet2.next()){
%>
<tr>
<td><%=resultSet2.getString("res_num") %></td>
<td><%=resultSet2.getString("login") %></td>
<td><%=resultSet2.getString("passengers") %></td>
<td><%=resultSet2.getString("date") %></td>
<td><%=resultSet2.getString("booked_flightnum") %></td>

</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
