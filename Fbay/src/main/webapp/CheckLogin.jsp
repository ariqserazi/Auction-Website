<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Checking Login</title>

</head>
<body>
	<%@ page import ="java.sql.*" %>
<%

    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    String username = request.getParameter("username");   
    String password = request.getParameter("password");
	
    ResultSet str;
 
    str = stmt.executeQuery("select * from Account where username='" + username + "'");
    
    if (str.next()){
    	 ResultSet str1;
    	    str1 = stmt.executeQuery("select * from Account where username='" + username + "' and password='" + password + "'");
    	    if (str1.next()) {
    	    	session.setAttribute("Account", username); // the username will be stored in the session
    	        response.sendRedirect("redirect.jsp");
    	    } else {
    	        out.println("Invalid password <a href='Login.jsp'>try again</a>");
    	    }
    }
    else{
    	out.println("Username doesn't exist");
    }
%>
</body>
</html>