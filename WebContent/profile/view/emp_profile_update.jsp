<%@page import="java.sql.*"%>

<%
String username = request.getParameter("username");
String email = request.getParameter("email");
String city = request.getParameter("city");
String state = request.getParameter("state");
String zip = request.getParameter("zip");
String phonenumber = request.getParameter("phonenumber");
String address = request.getParameter("address");
String ccnum = request.getParameter("ccnum");


try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1/", "root", "admin");
	PreparedStatement ps2 = con.prepareStatement("UPDATE `loginschema`.`customer` SET `email` =? WHERE (`user_name` =?);");
	PreparedStatement ps3 = con.prepareStatement("UPDATE `loginschema`.`customer` SET `city` =? WHERE (`user_name` =?);");
	PreparedStatement ps4 = con.prepareStatement("UPDATE `loginschema`.`customer` SET `state` =? WHERE (`user_name` =?);");
	PreparedStatement ps5 = con.prepareStatement("UPDATE `loginschema`.`customer` SET `zipcode` =? WHERE (`user_name` =?);");
	PreparedStatement ps6 = con.prepareStatement("UPDATE `loginschema`.`customer` SET `phone` =? WHERE (`user_name` =?);");
	PreparedStatement ps7 = con.prepareStatement("UPDATE `loginschema`.`customer` SET `address` =? WHERE (`user_name` =?);");
	PreparedStatement ps8 = con.prepareStatement("UPDATE `loginschema`.`customer` SET `ccnum` =? WHERE (`user_name` =?);");
	
	ps2.setString(1, email);
	ps2.setString(2, username);
	
	ps3.setString(1, city);
	ps3.setString(2, username);
	
	ps4.setString(1, state);
	ps4.setString(2, username);
	
	ps5.setString(1, zip);
	ps5.setString(2, username);
	
	ps6.setString(1, phonenumber);
	ps6.setString(2, username);
	
	ps7.setString(1, address);
	ps7.setString(2, username);
	
	ps8.setString(1, ccnum);
	ps8.setString(2, username);
	

	if(email.length() > 0){
		int up2 = ps2.executeUpdate();
	} else {
		int a = 0;		
	}
	
	if(city.length() > 0){
		int up3 = ps3.executeUpdate();
	} else {
		int b = 0;
	}
	
	if(state.length() > 0){
		int up4 = ps4.executeUpdate();
	} else {
		int c = 0;
	}
	
	if(zip.length() > 0){
		int up5 = ps5.executeUpdate();
	} else {
		int d = 0;
	}
	
	if(phonenumber.length() > 0){
		int up6 = ps6.executeUpdate();
	} else {
		int e = 0;
	}
	
	if(address.length() > 0){
		int up7 = ps7.executeUpdate();
	} else {
		int f = 0;
	}

	if(ccnum.length() > 0){
		int up8 = ps8.executeUpdate();
	} else {
		int g = 0;
	}
	
}catch(Exception e){
	out.print(e);
}
%>

<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/profile/view/employeemanagementpage.jsp";
	</script>