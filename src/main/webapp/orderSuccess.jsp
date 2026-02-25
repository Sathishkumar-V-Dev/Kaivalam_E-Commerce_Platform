<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.artisanplatform.model.Order" %>
<%@ page import="com.artisanplatform.model.OrderItem" %>
<%@ page import="com.artisanplatform.model.User" %>
<%@ page import="com.artisanplatform.dao.ProductDAO" %>
<%@ page import="com.artisanplatform.dao.impl.ProductDAOImpl" %>
<%@ page import="com.artisanplatform.model.Product" %>
<%@ page import="java.util.List" %>

<%
Order order = (Order) request.getAttribute("order");
List<OrderItem> items = (List<OrderItem>) request.getAttribute("orderItems");
User loggedInUser = (User) session.getAttribute("loggedInUser");

String userName = (loggedInUser != null) ? loggedInUser.getName() : "Customer";

ProductDAO productDAO = new ProductDAOImpl();
%>

<!DOCTYPE html>
<html>
<head>
<title>Order Success - KAIVALAM</title>
<link rel="icon" type="image/png" href="images/logo.png">

<style>
body {
    margin:0;
    font-family:'Segoe UI', sans-serif;
    background:#f8f4ef;
}

.container {
    width:90%;
    max-width:900px;
    margin:60px auto;
    background:white;
    padding:40px;
    border-radius:10px;
    box-shadow:0 4px 20px rgba(0,0,0,0.1);
}

.success {
    text-align:center;
    color:#28a745;
    font-size:26px;
    margin-bottom:10px;
}

.subtitle {
    text-align:center;
    color:#555;
    margin-bottom:20px;
}

.order-id {
    text-align:center;
    font-size:18px;
    margin-bottom:30px;
    background:#f1f1f1;
    padding:12px;
    border-radius:6px;
}

.section-title {
    font-size:20px;
    color:#5c3b2e;
    margin-top:20px;
    margin-bottom:10px;
}

.item {
    margin-bottom:8px;
    font-size:14px;
}

.total {
    font-weight:bold;
    margin-top:15px;
    font-size:18px;
}

.btn {
    display:inline-block;
    margin-top:30px;
    background:#5c3b2e;
    color:white;
    padding:10px 25px;
    text-decoration:none;
    border-radius:5px;
}

.btn:hover {
    background:#c47f4f;
}

.center {
    text-align:center;
}

/* ORDER SUCCESS ALIGNMENT */

.order-header {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    font-weight: bold;
    padding-bottom: 10px;
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
}

.order-item {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    padding: 8px 0;
    font-size: 14px;
    align-items: center;
}

.item-name {
    font-weight: 500;
}

.item-qty,
.item-price,
.item-total {
    text-align: center;
}
</style>
</head>

<body>

<div class="container">

<div class="success">
🎉 Order Placed Successfully, <%= userName %>!
</div>

<div class="subtitle">
Thank you for shopping with KAIVALAM.  
Your order has been confirmed.
</div>

<div class="order-id">
<strong>Order ID:</strong>
<%= request.getAttribute("formattedOrderId") %>
</div>

<!-- ORDER DETAILS -->
<div class="section-title">Order Details</div>

<div class="order-header">
    <div>Product</div>
    <div>Qty</div>
    <div>Price</div>
    <div>Total</div>
</div>

<%
double totalAmount = 0;

if(items != null){
    for(OrderItem item : items){

        Product product = productDAO.getProductById(item.getProductId());

        double subtotal = item.getPrice() * item.getQuantity();
        totalAmount += subtotal;
%>

<div class="order-item">
    
    <div class="item-name">
        <%= (product != null) ? product.getName() : "Product" %>
    </div>

    <div class="item-qty">
        <%= item.getQuantity() %>
    </div>

    <div class="item-price">
        ₹ <%= item.getPrice() %>
    </div>

    <div class="item-total">
        ₹ <%= subtotal %>
    </div>

</div>

<%
    }
}
%>

<div class="total">
Total Paid: ₹ <%= totalAmount %>
</div>

<!-- SHIPPING ADDRESS -->
<div class="section-title">Shipping Address</div>
<p>
<%= (order != null) ? order.getShippingAddress() : "" %>
</p>

<!-- PAYMENT METHOD -->
<div class="section-title">Payment Method</div>
<p>
<%= (order != null) ? order.getPaymentMethod() : "" %>
</p>

<div class="center">
<a href="home" class="btn">Continue Shopping</a>
</div>

</div>

</body>
</html>