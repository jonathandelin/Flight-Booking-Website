<%@page import="java.sql.*"%>
<%@page import="bean.EmpLogin_Bean"%>

<%
	String chosen_flight = request.getParameter("flight_num");


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

<h2>All Reservations By Flight</h2>
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
	<form action="emp_reservation_by_flight.jsp" method="post">
			Flight:<br/>
			<input type="text" name="flightnum"><br/>	
			<input type="submit" value="Submit"><br/>	
		</form>
	</table>

<%
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

%>
	<h3>Passengers with Reservations</h3>
		<table border="1">

			<tr>
				<td>Last Name</td>
				<td>First name</td>
			</tr>
			
			<%--SELECT C.lname AS 'Last Name', C.fname AS 'First Name' FROM loginschema.customer C WHERE C.user_name IN( SELECT A.user_name  FROM loginschema.account A WHERE A.user_name IN (SELECT R.login FROM loginschema.reservations R WHERE R.booked_flightnum = ? ));
			--%>
			
<%
			

			String flightnum = request.getParameter("flightnum");
			out.print("Flight Number: ");
			out.print(flightnum);
			
			try{ 

				Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.2", "root", "admin");
				PreparedStatement statement  = connection.prepareStatement("SELECT C.lname AS 'Last Name', C.fname AS 'First Name' FROM loginschema.customer C WHERE C.user_name IN( SELECT A.user_name  FROM loginschema.account A WHERE A.user_name IN (SELECT R.login FROM loginschema.reservations R WHERE R.booked_flightnum = ? ));");
				//SELECT C.fname, C.lname FROM loginschema.customer C, loginschema.account ACC, reservations R, flights F WHERE C.accnum=ACC.account_number AND ACC.account_number = R.login AND R.booked_flightnum= F.flightnum AND F.flightnum=?

				statement.setString(1, flightnum);
				ResultSet resultSet = statement.executeQuery();


				while(resultSet.next()){
%>
			<tr>
				<td><%=resultSet.getString("Last Name") %></td>
				<td><%=resultSet.getString("First Name") %></td>
			</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>