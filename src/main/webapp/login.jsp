<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>KAIVALAM - Login</title>
    <link rel="icon" type="image/png" href="images/logo.png">
    <style>
        body {
            font-family: Arial;
            background:#f8f4ef;
        }

        .container {
            width:400px;
            margin:100px auto;
            background:white;
            padding:30px;
            box-shadow:0 4px 15px rgba(0,0,0,0.1);
            border-radius:8px;
        }

        h2 {
            text-align:center;
            color:#5c3b2e;
        }

        input {
            width:100%;
            padding:10px;
            margin:10px 0;
            border:1px solid #ccc;
            border-radius:4px;
        }

        button {
            width:100%;
            padding:10px;
            background:#5c3b2e;
            color:white;
            border:none;
            cursor:pointer;
        }

        button:hover {
            background:#c47f4f;
        }

        .register-link {
            text-align:center;
            margin-top:15px;
        }
        
        
        .error-message {
    width: 350px;
    margin: 15px auto;
    padding: 10px;
    background-color: #f8d7da;
    color: #721c24;
    border-left: 5px solid #dc3545;
    border-radius: 5px;
    text-align: center;
    font-size: 14px;
}
        
        
    </style>
</head>
<body>

<div class="container">
    <h2>Login to KAIVALAM</h2>
    
    <%
String error = (String) request.getAttribute("loginError");
if(error != null){
%>

<div class="error-message">
    <%= error %>
</div>

<%
}
%>

    <form action="login" method="post">
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>

    <div class="register-link">
        New user? <a href="register.jsp">Create Account</a>
    </div>
</div>

</body>
</html>