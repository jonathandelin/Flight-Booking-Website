<%@page import="modal.Login_Modal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="obj_Login_Bean" class="bean.Login_Bean" ></jsp:useBean>
<jsp:setProperty property="*" name="obj_Login_Bean"/>

<%
System.out.println(obj_Login_Bean.getUser_name());
System.out.println(obj_Login_Bean.getPassword());

Login_Modal obj_Login_Modal=new Login_Modal();

boolean flag=obj_Login_Modal.check_user_name(obj_Login_Bean);




if(flag){
	
	session.setAttribute("user_session", obj_Login_Bean);
	
	%>
	<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/profile/view/Home.jsp";
	</script>
<%	
}else{
	
	
	session.setAttribute("login_message", "Login Failed! Username or Password is wrong!");
%>
	<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/index.jsp";
	</script>
<%	
	
	
}
%>



</body>
</html>