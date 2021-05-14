<%@page import="bean.Login_Bean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

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



<h2>FLIGHT SEARCH PAGE</h2>
<h2>Make Reservation</h2>

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


<table border="1">
<form action="availableflights2.jsp" method="post">
			Depart From:<br>
			 <input type="text" name="departcity"> <br>	
			Arrive At:<br>
			 <input type="text" name="arrivecity"> <br>
			When to Depart:<br>
			 <input type="text" name="departime"> <br>
			When to Come Back (if Round Trip):<br>
			 <input type="text" name="leavingtime"> <br>		
			<input type="submit" value="Submit"><br>	
		</form>
</table>





</body>
</html>