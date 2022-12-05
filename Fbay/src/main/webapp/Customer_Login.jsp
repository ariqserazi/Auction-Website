<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>
      Staff Login Page
    </title>
    <style>
      body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: black;
      }
      * {
        box-sizing: border-box;
      }
      .container {
        padding: 16px;
        background-color: white;
      }
      input[type="text"],
      input[type="email"],
      input[type="password"] {
        width: 100%;
        height: 5px;
        padding: 15px;
        margin: 5px 0 22px 0;
        display: inline-block;
        border: none;
        outline: none;
        background: whitesmoke;
      }
      input[type="text"]:focus,
      input[type="email"]:focus,
      input[type="password"]:focus {
        background-color: #ddd;
        outline: none;
      }
      .registerbtn {
        background-color: lightblue;
        color: black;
        padding: 16px 20px;
        margin: 8px;
        cursor: pointer;
        width: 100%;
        opacity: 0.9;
      }
      .registerbtn:hover {
        opacity: 1;
      }
      a {
        color: blue ;
      }
      .login{
          background: whitesmoke;
          text-align: center;
      }
  </style>
  </head>
  <body>
    <div class="container">
      <form method = "post" action = "CheckCustLogin.jsp">
        <h1> Customer Login Page</h1>
        <hr />
        <label>Name</label>
        <input type="text" name="username" />
        <br />
        <br />
        <label>Password</label>
        <input type="password" name="password" />
        <br />
		
        <button class="registerbtn">Login</button>
   
        <div class="login">
        <p>Don't have an account? <a href="CreateNewCust.jsp">Sign Up for a Customer Account</a>   </p>
      </form>
    </div>
</div>
  </body>
</html>