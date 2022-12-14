<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Buyer Page 2</title>
</head>
<body>
<%
 if ((session.getAttribute("Account") == null)) { %> // checks if in session
You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
<%} else { %>
<% try {
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();		

	//Create a SQL statement
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();
	Statement stmt4 = con.createStatement();
	Statement stmt5 = con.createStatement();
	
	//get bid type
	String bidType = request.getParameter("bidType");
	
	Integer item = Integer.valueOf(request.getParameter("itemID"));
	
	String username = (String) session.getAttribute("Account");
	
	//Make a SELECT query from the table to find if there is a previous bid
	String str = "SELECT bidID FROM Bid where username='"+username+"'and itemID='"+item+"'";
	//Run the query against the database.
	ResultSet result = stmt.executeQuery(str);
	int id=0;
	while (result.next()){
		id++;
	}
	
	if(bidType.equals("manual")){
		//get manual bid amount
	
		//Make an insert statement for the bids table:
		String insert = "INSERT INTO Bid(bidID, IsNormal, ItemID, username)" + "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		//add values into insert statement;
		ps.setInt(1,id);
		ps.setBoolean(2, true);
		ps.setInt(3, item);
		ps.setString(4, username);
		
		ps.executeUpdate();
	}
	
	else{
		//get maxium amount for autobid
		float maxBid = Float.valueOf(request.getParameter("maxBid"));
		//Make an insert statement for the bids table:
		String insert = "INSERT INTO Bid(bidID, IsNormal, ItemID, username)" + "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		//add values into insert statement;
		ps.setInt(1,id);
		ps.setBoolean(2, false);
		ps.setInt(3, item);
		ps.setString(4, username);
			
		ps.executeUpdate();
		
		String inAuto = "INSERT INTO Auto_Bid(bidID, MaxBid, ItemID, username, count)" + "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement pa = con.prepareStatement(insert);
		//add values into insert statement;
		pa.setInt(1,id);
		pa.setFloat(2, maxBid);
		pa.setInt(3, item);
		pa.setString(4, username);
		pa.setInt(5, 0);
		
		pa.executeUpdate();
	}
		
	//Process the bids
	String getInitial = "SELECT initial FROM Item where itemID='"+item+"'";
	String getIncrement = "SELECT increment FROM Item where itemID='"+item+"'";
	String getBidNumber = "SELECT COUNT(*) FROM Bid";
	
	ResultSet gil = stmt2.executeQuery(getInitial);
	ResultSet git = stmt3.executeQuery(getIncrement);
	ResultSet gbn = stmt4.executeQuery(getBidNumber);
	
	//get values
	int initial = 0;
	int increment = 0;
	int count = 0;
	while(gil.next()){
		initial = gil.getInt(1);
	}
	while(git.next()){
		increment = git.getInt(1);
	}
	while(gbn.next()){
		count = gbn.getInt(1);
	}
	
	//calculate current price
	while(count > 0){
		initial += increment;
		count--;
	}
	
	//check autobids
	String getAuto = "SELECT * FROM Auto_Bid where itemID='"+item+"'";
	ResultSet auto = stmt5.executeQuery(getAuto);
	while(auto.next()){
		int max = auto.getInt("MaxBid");
		if(max > initial){
			int id2 = auto.getInt("bidID");
			int autonum = auto.getInt("count");
			int newid1 = id2+autonum;
			int newcount = autonum+1;
			int item2 = auto.getInt("itemID");
			String user2 = auto.getString("username");
			//add new bid from autobid
			String ains = "INSERT INTO Bid(bidID, IsNormal, ItemID, username)" + "VALUES (?, ?, ?, ?)";
			PreparedStatement ai = con.prepareStatement(ains);
			ai.setInt(1, newid1);
			ai.setBoolean(2, true);
			ai.setInt(3, item2);
			ai.setString(4, user2);
			//update autobid ID
			String aupd = "UPDATE Auto_Bid SET count=? WHERE ItemID=? AND username=?";
			PreparedStatement au = con.prepareStatement(aupd);
			au.setInt(1, newcount);
			au.setInt(2, item2);
			au.setString(3, user2);			
		}
		else{
			//Add notification system
		}
	}
	
	//close the connection.
	db.closeConnection(con);
} catch (Exception e) {
	out.print(e);
}
%>
<%
    }
%>

</body>
</html>