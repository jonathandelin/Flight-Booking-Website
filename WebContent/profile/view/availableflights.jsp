<%@page import="java.sql.*"%>
<%@page import="bean.Login_Bean"%>

<%
	String chosen_airline = request.getParameter("airline");


	Login_Bean obj_Login_Bean=(Login_Bean)session.getAttribute("user_session");
	if(obj_Login_Bean==null){
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
<td>Username: <%=obj_Login_Bean.getUser_name() %></td>
<td><a href="Home.jsp">Home</a></td>
<td><a href="My_Profile.jsp">Profile</a></td>
<td><a href="flight_history.jsp">Check Flight History</a></td>
<td><a href="searchpage.jsp">Search for Flight And Reserve</a></td>
<td><a href="availableflights.jsp">Check Available Flights</a></td>
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

<h3>List of Active Flights</h3>
<table border="1">

<tr>
<td>Flight Number</td>
<td>Depart From</td>
<td>Arrive At</td>
<td>Departure Time</td>
<td>Arrival Time</td>
<td>Remaining Seats</td>
<td>Cost</td>


</tr>
<%
try{ 
Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
Statement statement = connection.createStatement();
String displayall ="SELECT * FROM loginschema.legs L WHERE L.seat>0 AND L.departure > NOW();";
ResultSet resultSet = statement.executeQuery(displayall);


while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("flight_num") %></td>
<td><%=resultSet.getString("d_airport_id") %></td>
<td><%=resultSet.getString("a_airport_id") %></td>
<td><%=resultSet.getString("departure") %></td>
<td><%=resultSet.getString("arrival") %></td>
<td><%=resultSet.getString("seat") %></td>
<td><%=resultSet.getString("fare") %>
</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>


</table>

<h3>Most Popular Flights by Most Booked</h3>
<table border="1">
<tr>
<td>Flight Number</td>
<td>Times Booked</td>
</tr>
<% 
try{
Connection connection2 = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
Statement statement2 = connection2.createStatement();
String displaymostpopular = "SELECT F.flightnum, sum(F.numseats-L.seat) AS Popular FROM loginschema.flights F, loginschema.legs L WHERE F.flightnum=L.flight_num Group BY F.flightnum ORDER BY sum(F.numseats-L.seat) DESC;";
ResultSet resultSet2 = statement2.executeQuery(displaymostpopular);

while(resultSet2.next()){
%>	
<tr>
<td><%=resultSet2.getString("flightnum") %></td>
<td><%=resultSet2.getString("Popular") %></td>
	
<% 	
}

} catch (Exception e) {
	e.printStackTrace();
}
%>
</table>

<h3>List of All Flights</h3>
<table border="1">

<tr>
<td>Flight Number</td>
<td>Depart From</td>
<td>Arrive At</td>
<td>Departure Time</td>
<td>Arrival Time</td>
<td>Remaining Seats</td>
<td>Cost</td>


</tr>
<%
try{ 
Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
Statement statement = connection.createStatement();
String displayall ="SELECT * FROM loginschema.legs L WHERE L.seat>0;";
ResultSet resultSet = statement.executeQuery(displayall);


while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("flight_num") %></td>
<td><%=resultSet.getString("d_airport_id") %></td>
<td><%=resultSet.getString("a_airport_id") %></td>
<td><%=resultSet.getString("departure") %></td>
<td><%=resultSet.getString("arrival") %></td>
<td><%=resultSet.getString("seat") %></td>
<td><%=resultSet.getString("fare") %>
</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>

