<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.artisanplatform.model.*" %>

<!DOCTYPE html>
<html>
<head>
<title>My Orders</title>
<link rel="icon" type="image/png" href="images/logo.png">
<style>
body { font-family: Arial; background:#f8f4ef; }
.container { width:85%; margin:auto; padding:40px; }
table { width:100%; border-collapse: collapse; background:white; }
th, td { padding:12px; border-bottom:1px solid #ddd; text-align:center; }
th { background:#5c3b2e; color:white; }
.btn {
    background:#c47f4f;
    color:white;
    padding:6px 12px;
    text-decoration:none;
}
</style>
</head>
<body>

<div class="container">
<h2>My Orders</h2>

<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
Map<Integer,String> formattedIds =
    (Map<Integer,String>) request.getAttribute("formattedIds");

if (orders != null && !orders.isEmpty()) {
%>

<table>
<tr>
    <th>Order ID</th>
    <th>Date</th>
    <th>Total</th>
    <th>Status</th>
    <th>View</th>
</tr>

<%
for (Order order : orders) {
%>

<tr>
    <td><%= formattedIds.get(order.getOrderId()) %></td>
    <td><%= order.getOrderDate() %></td>
    <td>₹ <%= order.getTotalAmount() %></td>
    <td><%= order.getStatus() %></td>
    <td>
        <a class="btn"
           href="viewOrder?orderId=<%= order.getOrderId() %>">
           View Details
        </a>
    </td>
</tr>

<%
}
%>

</table>

<%
} else {
%>
<p>No orders found.</p>
<%
}
%>

</div>
<div style="text-align:center; margin:40px;">
    <a href="home" 
       style="background:#5c3b2e; color:white; padding:10px 20px; text-decoration:none; border-radius:5px;">
        Continue Shopping
    </a>
</div>
</body>
</html>