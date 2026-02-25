<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.artisanplatform.model.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Order Details</title>
<link rel="icon" type="image/png" href="images/logo.png">
<style>
body { font-family: Arial; background:#f8f4ef; }
.container { width:80%; margin:auto; padding:40px; }
.box { background:white; padding:20px; margin-bottom:20px; }
</style>
</head>
<body>

<div class="container">

<%
Order order = (Order) request.getAttribute("order");
List<OrderItem> items =
    (List<OrderItem>) request.getAttribute("items");
String formattedOrderId =
    (String) request.getAttribute("formattedOrderId");
%>

<div class="box">
<h2>Order ID: <%= formattedOrderId %></h2>
<p>Date: <%= order.getOrderDate() %></p>
<p>Status: <%= order.getStatus() %></p>
<p>Total: ₹ <%= order.getTotalAmount() %></p>
<p>Shipping Address: <%= order.getShippingAddress() %></p>
<p>Payment Method: <%= order.getPaymentMethod() %></p>
</div>

<div class="box">
<h3>Items</h3>

<%
for (OrderItem item : items) {
%>

<p>
Product ID: <%= item.getProductId() %>  
(₹ <%= item.getPrice() %> × <%= item.getQuantity() %>)  
= ₹ <%= item.getTotalPrice() %>
</p>

<%
}
%>

</div>



</div>
<div style="text-align:center; margin:40px;">

    <a href="myOrders" 
       style="background:#5c3b2e; color:white; padding:10px 20px; 
       text-decoration:none; border-radius:5px; margin-right:15px;">
        ← Back to My Orders
    </a>

    <a href="home" 
       style="background:#c47f4f; color:white; padding:10px 20px; 
       text-decoration:none; border-radius:5px;">
        Continue Shopping
    </a>

</div>
</body>
</html>