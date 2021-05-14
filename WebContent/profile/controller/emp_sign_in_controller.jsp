<%@page import="modal.EmpLogin_Modal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="obj_EmpLogin_Bean" class="bean.EmpLogin_Bean" ></jsp:useBean>
<jsp:setProperty property="*" name="obj_EmpLogin_Bean"/>

<%
System.out.println(obj_EmpLogin_Bean.getEmp_login());
System.out.println(obj_EmpLogin_Bean.getEmp_pass());

EmpLogin_Modal obj_EmpLogin_Modal=new EmpLogin_Modal();

boolean flag=obj_EmpLogin_Modal.check_user_name(obj_EmpLogin_Bean);




if(flag){
	
	session.setAttribute("user_session", obj_EmpLogin_Bean);
	
	%>
	<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/profile/view/employeemanagementpage.jsp";
	</script>
<%	
}else{
	
	
	session.setAttribute("login_message", "Login Failed! Username or Password is wrong!");
%>
	<script type="text/javascript">
		window.location.href="http://localhost:8080/LoginPractice/employeelogin.jsp";
	</script>
<%	
	
	
}
%>



</body>
</html>