<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="bean.Login_Bean"%>
<%@page import="common_things.LegNode"%>
<%@page import="common_things.Queue"%>


<%!
public PreparedStatement nonStop(int datediff, String date, String d_airport, String a_airport, String leavedate){
	PreparedStatement statement=null;
	try{ 
		
		Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
		statement = connection.prepareStatement("SELECT L.flight_num, L.d_airport_id, L.a_airport_id, L.departure, L.arrival, L.fare FROM loginschema.legs L WHERE L.d_airport_id=? AND L.a_airport_id=? AND (datediff(L.departure, ?)= ? OR datediff(?, L.departure)= ? )AND datediff(L.arrival, ?)<0 AND L.seat>0");
		statement.setString(1, d_airport);
		statement.setString(2, a_airport);
		statement.setString(3, date);
		statement.setInt(4, datediff);
		statement.setString(5, date);
		statement.setInt(6, datediff);
		statement.setString(7, leavedate);

	}catch (Exception e) {
		e.printStackTrace();
	}
	return statement;
}

public ArrayList<LegNode> transfer(int count,String src,String target,String date,String leavedate){
	
	ArrayList<LegNode> result=new ArrayList<LegNode>();
	Queue<LegNode> leg=new Queue<LegNode>();
	Hashtable<String, Character> visited=new Hashtable<String, Character>();
	//build the queue
	visited.put(src, '1');
	
	try{ 
		
		Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
		PreparedStatement statement = connection.prepareStatement("SELECT M.flightnum FROM loginschema.make_stop M WHERE M.airportID=? AND datediff(M.d_time, ?)<2 AND datediff(?, M.d_time) <2;");
		statement.setString(1, src);
		statement.setString(2, date);
		statement.setString(3, date);
		ResultSet resultSet = statement.executeQuery();
		while(resultSet.next()){
			String flightnum=resultSet.getString("flightnum");
			
			try{ 
				
				Connection connectionP = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
				PreparedStatement statementP = connectionP.prepareStatement("SELECT L.a_airport_id, L.departure, L.arrival, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND L.d_airport_id=? AND L.seat>0 AND datediff(L.arrival, ?)<0");
				statementP.setString(1, flightnum);
				statementP.setString(2, src);
				statementP.setString(3, leavedate);
				ResultSet resultSetP = statementP.executeQuery();
				
				if(resultSetP.next()){
					
					String arriveAirID=resultSetP.getString("a_airport_id");
					
					if(!visited.containsKey(arriveAirID)){
					LegNode temp=new LegNode(flightnum, src, arriveAirID, resultSetP.getString("departure"), resultSetP.getString("arrival"),resultSetP.getInt("fare"), null );
					leg.enqueue(temp);
					}
				}

			}catch (Exception e) {
				e.printStackTrace();
			}
		}

	}catch (Exception e) {
		e.printStackTrace();
	}
	//BFS
	
	if (!leg.isEmpty()){
		while(!leg.isEmpty() && count<10){
				 
			LegNode temp=leg.dequeue();
			String arrivalTime=temp.a_time;
			String curAirID=temp.a_airport;
			try{ 
				
				Connection connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
				PreparedStatement statement = connection.prepareStatement("SELECT M.flightnum FROM loginschema.make_stop M WHERE M.airportID=?  AND timediff( M.d_time, ?)< 86400 AND timediff( M.d_time, ?)>=10800");
				statement.setString(1, curAirID);
				statement.setString(2, arrivalTime);
				statement.setString(3, arrivalTime);
				ResultSet resultSet = statement.executeQuery();

				while(resultSet.next()){
					String flightnum=resultSet.getString("flightnum");
					try{ 
						
						Connection connectionP = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
						PreparedStatement statementP = connectionP.prepareStatement("SELECT L.a_airport_id, L.departure, L.arrival, L.fare FROM loginschema.legs L WHERE L.flight_num=? AND L.d_airport_id=? AND L.seat>0 AND datediff(L.arrival, ?)<0");
						statementP.setString(1, flightnum);
						statementP.setString(2, curAirID);
						statementP.setString(3, leavedate);
						ResultSet resultSetP = statementP.executeQuery();
						
						if(resultSetP.next()){
							
							String arriveAirID=resultSetP.getString("a_airport_id");
							if(!visited.containsKey(arriveAirID)){
								
							LegNode ptr=new LegNode(flightnum, curAirID, arriveAirID, resultSetP.getString("departure"), resultSetP.getString("arrival"),resultSetP.getInt("fare"), temp );
							visited.put(arriveAirID, '1');
							if(ptr.a_airport.compareTo(target)==0){
								result.add(ptr);
								count++;
							}
							else{
								leg.enqueue(ptr);
							}
						}}

					}catch (Exception e) {
						e.printStackTrace();
					}
				}

			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	return result;
}

%>




<%

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

<h1>Airlines Page</h1>
<table border="1">
<tr>
<td>Username: <%=obj_Login_Bean.getUser_name() %></td>
<td><a href="Home.jsp">Home</a></td>
<td><a href="My_Profile.jsp">Profile</a></td>
<td><a href="flight_history.jsp">Check Flight History</a></td>
<td><a href="searchpage.jsp">Search for Flight</a></td>
<td><a href="availableflights.jsp">Check Available Flights</a></td>
<td><a href="../controller/sign_out_controller.jsp">Log Out</a></td>
</table>

<%
try {
Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

String departcity = request.getParameter("departcity");
String arrivecity = request.getParameter("arrivecity");
String departime = request.getParameter("departime");
String leavingtime = request.getParameter("leavingtime");


//first table
%>
<h3 >List of Airlines</h3>
<table  border="1" style="display: inline-block;  float: left;">

<tr>

	<td>Flight Number</td>
	<td>Departing From</td>
	<td>Arriving At</td>
	<td>Departure Time</td>
	<td>Arrival Time</td>
	<td>Fare</td>
	
</tr>

<%
if (leavingtime.compareTo(departime)<=0){leavingtime="9999-12-31";}
//non-stop
int count=0;
ArrayList<LegNode> multipleS1=new ArrayList<LegNode>();
ArrayList<LegNode> multipleS2=new ArrayList<LegNode>();
String userName=obj_Login_Bean.getUser_name();

session.setAttribute("userName", userName);


PreparedStatement statement1=nonStop(0, departime, departcity, arrivecity, leavingtime );
ResultSet resultSet1 = statement1.executeQuery();

while(resultSet1.next()){
%>
<tr>
<td><%=resultSet1.getString("flight_num") %></td>
<td><%=resultSet1.getString("d_airport_id") %></td>
<td><%=resultSet1.getString("a_airport_id") %></td>
<td><%=resultSet1.getString("departure") %></td>
<td><%=resultSet1.getString("arrival") %></td>
<td><%=resultSet1.getString("fare") %>
</tr>

<% 
count++;}

//different date
if (count<10){
	statement1=nonStop(1, departime, departcity, arrivecity, leavingtime );
	resultSet1 = statement1.executeQuery();
	while(resultSet1.next()){
		
		%>
		<tr>
		<td><%=resultSet1.getString("flight_num") %></td>
		<td><%=resultSet1.getString("d_airport_id") %></td>
		<td><%=resultSet1.getString("a_airport_id") %></td>
		<td><%=resultSet1.getString("departure") %></td>
		<td><%=resultSet1.getString("arrival") %></td>
		<td><%=resultSet1.getString("fare") %>
		</tr>
		
		<% 
		count++;}
	
}
//transfer
if (count<10){
	multipleS1=transfer(count, departcity, arrivecity, departime, leavingtime);
	
	for(int i=0; i<multipleS1.size(); i++){
		LegNode ptr=multipleS1.get(i);
		int fare=0;
		%>
		<tr><td><%="index: "+i %></td></tr>
		<% 
		while(ptr!=null){
			%>
			<tr>
			<td><%=ptr. flightNum%></td>
			<td><%=ptr.d_airport %></td>
			<td><%=ptr.a_airport %></td>
			<td><%=ptr.d_time %></td>
			<td><%=ptr.a_time %></td>
			<td><%=ptr.fare %>
			</tr>
			<% 
			fare+=ptr.fare;
			ptr=ptr.next;
		}
		%>
		<tr><td><%="Total Fare: "+fare %></td></tr>
		<tr></tr>
		<% 
	}
}

%>
</table>
<%

//going back table	
if (leavingtime.compareTo(departime)>0){
	%>
	
	<table  border="1" style="display: inline-block;">
	
	<tr>
	<td>Flight Number</td>
	<td>Departing From</td>
	<td>Arriving At</td>
	<td>Departure Time</td>
	<td>Arrival Time</td>
	<td>Fare</td>
	</tr>
	<%
	//non-stop
	int count2=0;
	PreparedStatement statement2=nonStop(0, leavingtime, arrivecity,departcity, "9999-12-31" );
	ResultSet resultSet2 = statement2.executeQuery();
	
	while(resultSet2.next()){
	%>
	<tr>
	<td><%=resultSet2.getString("flight_num") %></td>
	<td><%=resultSet2.getString("d_airport_id") %></td>
	<td><%=resultSet2.getString("a_airport_id") %></td>
	<td><%=resultSet2.getString("departure") %></td>
	<td><%=resultSet2.getString("arrival") %></td>
	<td><%=resultSet2.getString("fare") %>
	</tr>

	<% 
	count2++;}

	//different date
	if (count2<10){
		statement2=nonStop(1, leavingtime, arrivecity,departcity, "9999-12-31" );
		resultSet2 = statement2.executeQuery();
		while(resultSet2.next()){
			
			%>
			<tr>
			<td><%=resultSet2.getString("flight_num") %></td>
			<td><%=resultSet2.getString("d_airport_id") %></td>
			<td><%=resultSet2.getString("a_airport_id") %></td>
			<td><%=resultSet2.getString("departure") %></td>
			<td><%=resultSet2.getString("arrival") %></td>
			<td><%=resultSet2.getString("fare") %>
			</tr>
			
			<% 
			count2++;}
		
	}
	//transfer
	
	if (count2<10){
		
		multipleS2=transfer(count2, arrivecity, departcity, leavingtime, "9999-12-31");
		
		for(int i=0; i<multipleS2.size(); i++){
			out.println("there"+ count);
			LegNode ptr=multipleS2.get(i);
			int fare=0;
			%>
			<tr><td><%="index: "+i %></td></tr>
			<% 
			while(ptr!=null){
				%>
				<tr>
				<td><%=ptr. flightNum%></td>
				<td><%=ptr.d_airport %></td>
				<td><%=ptr.a_airport %></td>
				<td><%=ptr.d_time %></td>
				<td><%=ptr.a_time %></td>
				<td><%=ptr.fare %>
				</tr>
				<% 
				fare+=ptr.fare;
				ptr=ptr.next;
			}
			%>
			<tr><td><%="Total Fare: "+fare %></td></tr>
			<tr></tr>
			<% 
		}
	}

	%>
	</table><br>
	<%
	
}


session.setAttribute("multipleS1", multipleS1);
session.setAttribute("multipleS2", multipleS2);
%>

<p>*<p><br>
<p>TO book a trip, if it's a non-stop trip, please enter the flight number and the departure time, if it's a multiple stop trip, please enter the index in front of it. </p>
<p>To book a round trip, please enter both information for the trip going to the destination and the information for the trip going back.</p><br>

<tr style="float:left">Would you like to book this flight?</tr> <br>

<table border="1">
<form action="make_reservation.jsp" method="post">
	
			If It's a Non-Stop Trip, Enter Flight Number You Would Like to Book:<br>
			 <input type="text" name="Fflightnum"> <br>	
			 Enter the Departure Date and Time:<br>
			 <input type="text" name="FDeparture"> <br>
			If It's a Multiple-Stop Trip, Enter The Index In Front Of the Trip:<br>
			 <input type="text" name="Findex"> <br>
			Enter the amount of passengers you are booking:<br>
			 <input type="text" name="Fpassengers"> <br>
			 Enter the Class:<br>
			 <input type="text" name="FClass"> <br>
			
			 
			 
			 (If Round  Trip)If It's a Non-Stop Trip, Enter Flight Number You Would Like to Book:<br>
			 <input type="text" name="Sflightnum"> <br>	
			 Enter the Departure Date and Time:<br>
			 <input type="text" name="SDeparture"> <br>
			If It's a Multiple-Stop Trip, Enter The Index In Front Of the Trip:<br>
			 <input type="text" name="Sindex"> <br>
			Enter the amount of passengers you are booking:<br>
			 <input type="text" name="Spassengers"> <br>
			 Enter the Class:<br>
			 <input type="text" name="SClass"> <br>
			<input type="submit" value="Submit"><br>	
			
		</form>
</table>
