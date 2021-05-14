<%@page import="java.sql.*"%>
<%--PreparedStatement getSeatNumber = con.prepareStatement("SELECT R.passengers FROM loginschema.reservations R WHERE res_num=?;");--%>

	<%--ResultSet resultSet = getSeatNumber.executeQuery();
	String passengers = resultSet.getString("passengers");--%>
<%
String res_num = request.getParameter("res_num");


try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
	PreparedStatement Flight_Depart=con.prepareStatement("SELECT R.flight_numR, R.departure FROM loginschema.reserved_legs R WHERE R.res_numR=?;");
	PreparedStatement passengers=con.prepareStatement("SELECT R.passengers FROM loginschema.reservations R WHERE R.res_num=?;");
	
	Flight_Depart.setString(1, res_num);
	passengers.setString(1, res_num);
	
	int pas=0;
	
	ResultSet resultSetFD = Flight_Depart.executeQuery();

	ResultSet resultSetP = passengers.executeQuery();
	
	if(resultSetP.next()){
		pas=resultSetP.getInt("passengers");
	}
	while(resultSetFD.next()){
		String Flight=resultSetFD.getString("flight_numR");
		String departure=resultSetFD.getString("departure");
		
	PreparedStatement addbackseats = con.prepareStatement("UPDATE `loginschema`.`legs` SET `seat` = `seat`+? WHERE (`flight_num` = ?) and (`departure` = ?);");

	addbackseats.setInt(1, pas);
	addbackseats.setString(2, Flight);
	addbackseats.setString(3, departure);
	addbackseats.executeUpdate();
	}

	
	PreparedStatement deletereservation = con.prepareStatement("DELETE FROM `loginschema`.`reservations` WHERE (`res_num` = ?);");
	deletereservation.setString(1, res_num);
	int up2 = deletereservation.executeUpdate();
	
	
	
	
}catch(Exception e){
	out.print(e);
}
%>

<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/profile/view/flight_history.jsp";
	</script>