<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>KAIVALAM - Register</title>
    <link rel="icon" type="image/png" href="images/logo.png">
    <style>
        body {
            font-family: Arial;
            background:#f8f4ef;
        }

        .container {
            width:400px;
            margin:80px auto;
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
            margin:8px 0;
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

        .login-link {
            text-align:center;
            margin-top:10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Create Account</h2>

    <form action="register" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="text" name="phone" placeholder="Phone" required>
        <input type="text" name="address" placeholder="Address">

        <button type="submit">Register</button>
    </form>

    <div class="login-link">
        Already have account? <a href="login.jsp">Login</a>
    </div>
</div>

</body>
</html>