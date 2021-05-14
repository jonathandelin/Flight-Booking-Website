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

<h2>Flight History Page</h2>
<table border="1">
<tr>
<td>Username: <%=obj_Login_Bean.getUser_name() %></td>
<td><a href="Home.jsp">Home</a></td>
<td><a href="My_Profile.jsp">Profile</a></td>
<td><a href="flight_history.jsp">Check Flight History</a></td>
<td><a href="searchpage.jsp">Search for Flight And Reserve</a></td>
<td><a href="availableflights.jsp">Check Available Flights</a></td>
<td><a href="../controller/sign_out_controller.jsp">Log Out</a></td>
</table>

<%
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

%>
<h3>Reservation History</h3>
<table border="1">
<tr>
<td>Reservation Number</td>
<td>Number of Passengers</td>
<td>Booking Date</td>
<td>Fares</td>
<td>Details
</tr>
<% 
try{
String username = obj_Login_Bean.getUser_name();
Connection connection2 = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement ps = connection2.prepareStatement("SELECT R.res_num, R.passengers, R.booking_date, R.total_fare FROM loginschema.reservations R WHERE R.login=? AND dateDiff(curdate(), R.date)>=0;");
ps.setString(1, username);
ResultSet resultSet2 = ps.executeQuery();

while(resultSet2.next()){
int res_num=	resultSet2.getInt("res_num");
%>	
<tr>
<td><%=resultSet2.getString("res_num") %></td>
<td><%=resultSet2.getString("passengers") %></td>
<td><%=resultSet2.getString("booking_date") %></td>
<td><%=resultSet2.getString("total_fare") %>

<td>
<% 	
try{

Connection connectionP = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement psP = connectionP.prepareStatement("SELECT R.flight_numR, L.d_airport_id, L.a_airport_id, L.departure, L.arrival, R.class FROM loginschema.reserved_legs R, loginschema.legs L WHERE R.res_numR= ? AND R.departure=L.departure AND R.flight_numR=L.flight_num");
psP.setInt(1, res_num);
ResultSet resultSetP = psP.executeQuery();

%>
<table border=1>
<tr>
<td>Flight Num</td>
<td>Depart From</td>
<td>Arrive At</td>
<td>Departure Time</td>
<td>Arrival Time</td>
<td>Class</td>
<td>International Or Domestic
</tr>
<% 
while(resultSetP.next()){
	String I_D="";
	PreparedStatement psD = connectionP.prepareStatement("SELECT A.country AS 'A', B.country AS 'B' FROM  loginschema.legs L, loginschema.airports A, loginschema.airports B WHERE L.d_airport_id=A.airportID AND L.a_airport_id=B.airportID AND L.flight_num=? AND L.departure=?; ");
	psD.setString(1,resultSetP.getString("flight_numR"));
	psD.setString(2,resultSetP.getString("departure"));
	ResultSet resultSetD=psD.executeQuery();
	if(resultSetD.next()){
		if(resultSetD.getString("A").compareTo(resultSetD.getString("B"))!=0){
			I_D="international";
		}else{
			I_D="domestic";
		}
	}
%>	
<tr>
<td><%=resultSetP.getString("flight_numR") %></td>
<td><%=resultSetP.getString("d_airport_id") %></td>
<td><%=resultSetP.getString("a_airport_id") %></td>
<td><%=resultSetP.getString("departure") %></td>
<td><%=resultSetP.getString("arrival") %></td>
<td><%=resultSetP.getString("class") %></td>
<td><%=I_D %>
</tr>
<% 	
}

} catch (Exception e) {
	e.printStackTrace();
}
%>
</table>

</td>

</tr>
<% 



}

} catch (Exception e) {
	e.printStackTrace();
}
%>
</table>













<h3>Current Reservation</h3>
<table border="1">
<tr>
<td>Reservation Number</td>
<td>Number of Passengers</td>
<td>Booking Date</td>
<td>Fares</td>
<td>Details
</tr>
<% 
try{
String username = obj_Login_Bean.getUser_name();
Connection connection2 = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement ps = connection2.prepareStatement("SELECT R.res_num, R.passengers, R.booking_date, R.total_fare FROM loginschema.reservations R WHERE R.login=? AND dateDiff(curdate(), R.date)<0;");
ps.setString(1, username);
ResultSet resultSet2 = ps.executeQuery();

while(resultSet2.next()){
int res_num=	resultSet2.getInt("res_num");
%>	
<tr>
<td><%=resultSet2.getString("res_num") %></td>
<td><%=resultSet2.getString("passengers") %></td>
<td><%=resultSet2.getString("booking_date") %></td>
<td><%=resultSet2.getString("total_fare") %>

<td>
<% 	
try{

Connection connectionP = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
PreparedStatement psP = connectionP.prepareStatement("SELECT R.flight_numR, L.d_airport_id, L.a_airport_id, L.departure, L.arrival, R.class FROM loginschema.reserved_legs R, loginschema.legs L WHERE R.res_numR= ? AND R.departure=L.departure AND R.flight_numR=L.flight_num");
psP.setInt(1, res_num);
ResultSet resultSetP = psP.executeQuery();

%>
<table border=1>
<tr>
<td>Flight Num</td>
<td>Depart From</td>
<td>Arrive At</td>
<td>Departure Time</td>
<td>Arrival Time</td>
<td>Class</td>
<td>International Or Domestic
</tr>
<% 
while(resultSetP.next()){
	String I_D="";
	PreparedStatement psD = connectionP.prepareStatement("SELECT A.country AS 'A', B.country AS 'B' FROM  loginschema.legs L, loginschema.airports A, loginschema.airports B WHERE L.d_airport_id=A.airportID AND L.a_airport_id=B.airportID AND L.flight_num=? AND L.departure=?; ");
	psD.setString(1,resultSetP.getString("flight_numR"));
	psD.setString(2,resultSetP.getString("departure"));
	ResultSet resultSetD=psD.executeQuery();
	if(resultSetD.next()){
		if(resultSetD.getString("A").compareTo(resultSetD.getString("B"))!=0){
			I_D="international";
		}else{
			I_D="domestic";
		}
	}
%>	
<tr>
<td><%=resultSetP.getString("flight_numR") %></td>
<td><%=resultSetP.getString("d_airport_id") %></td>
<td><%=resultSetP.getString("a_airport_id") %></td>
<td><%=resultSetP.getString("departure") %></td>
<td><%=resultSetP.getString("arrival") %></td>
<td><%=resultSetP.getString("class") %></td>
<td><%=I_D %>
</tr>
<% 	
}

} catch (Exception e) {
	e.printStackTrace();
}
%>
</table>

</td>

</tr>
<% 



}

} catch (Exception e) {
	e.printStackTrace();
}
%>
</table>

<h4>Edit Reservations</h4>
	<table>
	<form action="cust_deletereservation.jsp" method="post">
			Enter the reservation number that needs to be deleted <input type="text" name="res_num"> <br>		
			<input type="submit" value="Submit"><br>	
		</form>
	</table>