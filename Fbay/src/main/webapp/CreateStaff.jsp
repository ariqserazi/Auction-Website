<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%

	
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	String userid = request.getParameter("username");   
	String pass = request.getParameter("password");
    ResultSet rs;
    rs = stmt.executeQuery("select * from Staff where adminuser='" + userid + "'");
    if (rs.next()) {
    	out.println("Username exists, please try another <a href='NewAdminAcc.jsp'>try again</a>");
    } else {
    	int x = stmt.executeUpdate("insert into admin (adminuser, adminpass) values('" +userid+ "', '" +pass+ "')");
    	session.setAttribute("user", userid); // the username will be stored in the session
        response.sendRedirect("AdminSuccess.jsp");
    	
    }
%>