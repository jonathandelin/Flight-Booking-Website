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

<%
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
%>


<h3>Revenue By Customer</h3>
<table border="1">

<tr>
	<td>Last Name</td>
	<td>First Name</td>
	<td>Customer Revenue</td>
</tr>

<%--REVENUE BY CUSTOMER
SELECT C.lname AS 'Last Name', C.fname AS 'First Name', SUM(R.bookingfee + (R.passengers * F.fares) - R.fare_restrictions) AS 'Total Revenue' 
FROM loginschema.reservations R 
JOIN loginschema.flights F ON R.booked_flightnum = F.flightnum 
JOIN loginschema.customer C ON R.login = C.user_name 
GROUP BY R.login 
ORDER BY (R.bookingfee + (R.passengers * F.fares) - R.fare_restrictions) DESC

 --%>
 
 <%--
SELECT C.lname AS 'Last Name', C.fname AS 'First Name', SUM(R.total_fare + R.bookingfee) AS 'Customer Revenue' 
FROM loginschema.reservations R 
JOIN loginschema.customer C ON R.login = C.user_name 
GROUP BY R.login 
ORDER BY SUM(R.total_fare + R.bookingfee) DESC;
  --%>

<%
	try{ 
		Connection connection2 = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
		Statement statement2 = connection2.createStatement();
		String total_revenue_by_customer2 = ("SELECT C.lname AS 'Last Name', C.fname AS 'First Name', SUM(R.total_fare + R.bookingfee) AS 'Customer Revenue' FROM loginschema.reservations R JOIN loginschema.customer C ON R.login = C.user_name GROUP BY R.login ORDER BY SUM(R.total_fare + R.bookingfee) DESC;");
		ResultSet resultSet = statement2.executeQuery(total_revenue_by_customer2);
		
		while(resultSet.next()){
			
%>

<tr>
<td><%=resultSet.getString("Last Name") %></td>
<td><%=resultSet.getString("First Name") %></td>
<td><%=resultSet.getString("Customer Revenue") %></td>
</tr>

<% 
	}

	} catch (Exception e) {
	e.printStackTrace();
	}
%>
</table>

<form>
  <input type="button" value="Back" onclick="history.back()">
</form>

