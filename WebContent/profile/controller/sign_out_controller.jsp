<%

session.removeAttribute("user_session");


session.setAttribute("login_message", "You have signed out!");

%>

<script type="text/javascript"> 
window.location.href="http://localhost:8080/LoginPractice/index.jsp";


</script>