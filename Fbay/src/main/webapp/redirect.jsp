<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
<% if ((session.getAttribute("Account") == null)) { %> // checks if in session
You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
<%} else { %>
Welcome <%=session.getAttribute("Account") %>  
<br> Do you want to Logout </br>
<a href="logout.jsp">Log out</a>
<br> Do you want to become a buyer </br>
 <a href="buyer_Page.jsp" ><button>Become Buyer</button></a>

<br> Do you want to become a seller </br>
 <a href="seller_Page.jsp" ><button>Become Seller </button></a>
<%
    }
%>


</body>
</html>