<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.artisanplatform.dao.*" %>
<%@ page import="com.artisanplatform.dao.impl.*" %>
<%@ page import="com.artisanplatform.model.*" %>

<%
Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
ProductDAO productDAO = new ProductDAOImpl();
double grandTotal = 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>KAIVALAM - Checkout</title>
<link rel="icon" type="image/png" href="images/logo.png">

<style>
body {
    margin:0;
    font-family:'Segoe UI', sans-serif;
    background:#f8f4ef;
}

/* NAVBAR */
.navbar {
    background:#5c3b2e;
    color:white;
    padding:15px 60px;
    font-size:22px;
    font-weight:bold;
}

/* MAIN CONTAINER */
.checkout-container {
    width:90%;
    max-width:1200px;
    margin:40px auto;
    display:flex;
    gap:40px;
}

/* LEFT SECTION */
.left-section {
    flex:2;
    background:white;
    padding:30px;
    border-radius:8px;
    box-shadow:0 3px 12px rgba(0,0,0,0.08);
}

/* RIGHT SECTION */
.right-section {
    flex:1;
    background:white;
    padding:30px;
    border-radius:8px;
    box-shadow:0 3px 12px rgba(0,0,0,0.08);
    height:fit-content;
}

/* SECTION TITLES */
.section-title {
    font-size:20px;
    margin-bottom:15px;
    color:#5c3b2e;
}

/* TEXTAREA */
textarea {
    width:100%;
    height:100px;
    padding:10px;
    border-radius:5px;
    border:1px solid #ccc;
    margin-bottom:20px;
}

/* PAYMENT OPTIONS */
.payment-option {
    margin-bottom:10px;
}

/* ORDER ITEMS */
.order-item {
    margin-bottom:10px;
    font-size:14px;
}

.total {
    margin-top:15px;
    font-size:18px;
    font-weight:bold;
}

/* BUTTON */
.place-btn {
    margin-top:20px;
    width:100%;
    background:#c47f4f;
    color:white;
    padding:12px;
    border:none;
    cursor:pointer;
    font-size:16px;
}

.place-btn:hover {
    background:#5c3b2e;
}

/* EMPTY CART */
.empty {
    text-align:center;
    margin-top:100px;
    font-size:18px;
}

/* ORDER SUMMARY CLEAN ALIGNMENT */
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

.order-header {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    font-weight: bold;
    padding-bottom: 10px;
    border-bottom: 1px solid #ddd;
    margin-bottom: 10px;
}

.back-btn {
    display: inline-block;
    padding: 12px 18px;
    background-color: #ccc;
    color: #333;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
    transition: 0.3s;
}

.back-btn:hover {
    background-color: #999;
    color: white;
}

.logo a {
    display: flex;
    align-items: center;
    text-decoration: none;
}

.logo img {
    height: 40px;
    margin-right: 10px;
}

.logo span {
    color: white;
    font-weight: bold;
    font-size: 20px;
}

</style>
</head>

<body>

<div class="navbar">
 <div class="logo">
    <a href="home">
        <img src="images/logo.png" alt="KAIVALAM Logo">
        <span>KAIVALAM</span>
    </a>
</div>
</div>

<%
if(cart != null && !cart.isEmpty()){
%>

<div class="checkout-container">

<!-- LEFT SIDE -->
<div class="left-section">

<form action="placeOrder" method="post">

<div class="section-title">Shipping Address</div>
<textarea name="shippingAddress" required
placeholder="Enter your full shipping address..."></textarea>

<div class="section-title">Mode of Payment</div>

<div class="payment-option">
    <input type="radio" name="paymentMethod" value="COD" checked>
    Cash on Delivery (COD)
</div>

<div class="payment-option">
    <input type="radio" name="paymentMethod" value="UPI">
    UPI
</div>

<div class="payment-option">
    <input type="radio" name="paymentMethod" value="Card">
    Credit / Debit Card
</div>

<div class="payment-option">
    <input type="radio" name="paymentMethod" value="NetBanking">
    Net Banking
</div>

<button class="place-btn">Place Order</button>

</form>

<div style="margin-top:15px; display:flex; gap:10px;">

    

    <a href="cart" class="back-btn">
        ← Back to Cart
    </a>

</div>

</div>

<!-- RIGHT SIDE -->
<div class="right-section">

<div class="section-title">Order Summary</div>
<div class="order-header">
    <div>Product</div>
    <div>Qty</div>
    <div>Price</div>
    <div>Total</div>
</div>

<%
for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {

    Product product = productDAO.getProductById(entry.getKey());
    int qty = entry.getValue();

    if(product == null) continue;

    double total = product.getPrice() * qty;
    grandTotal += total;
%>

<div class="order-item">
    <div class="item-name">
        <%= product.getName() %>
    </div>

    <div class="item-qty">
        <%= qty %>
    </div>

    <div class="item-price">
        ₹ <%= product.getPrice() %>
    </div>

    <div class="item-total">
        ₹ <%= total %>
    </div>
</div>

<%
}
%>

<hr>
<div class="total">
Total: ₹ <%= grandTotal %>
</div>

</div>

</div>

<%
} else {
%>

<div class="empty">
Your cart is empty.<br><br>
<a href="products">
<button class="place-btn" style="width:auto;">Go to Products</button>
</a>
</div>

<%
}
%>

</body>
</html>