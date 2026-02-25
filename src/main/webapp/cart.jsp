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
<title>KAIVALAM - Cart</title>
<link rel="icon" type="image/png" href="images/logo.png">

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background:#f8f4ef;
    margin:0;
}

/* NAVBAR */
.navbar {
    background-color:#5c3b2e;
    padding:15px 60px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    color:white;
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

.nav-links a {
    color:white;
    margin-left:25px;
    text-decoration:none;
}

.nav-links a:hover {
    color:#c47f4f;
}

/* CONTAINER */
.container {
    width:80%;
    margin:auto;
    padding:40px;
}

/* CART ITEM */
.cart-item {
    background:white;
    padding:20px;
    margin-bottom:15px;
    box-shadow:0 3px 10px rgba(0,0,0,0.08);
    display:flex;
    justify-content:space-between;
    align-items:center;
    border-radius:8px;
}

/* BUTTONS */
.qty-btn {
    background:#5c3b2e;
    color:white;
    border:none;
    padding:6px 12px;
    cursor:pointer;
    margin:0 3px;
}

.qty-btn:hover {
    background:#c47f4f;
}

.total {
    text-align:right;
    font-size:20px;
    font-weight:bold;
    margin-top:20px;
}

/* ACTION BUTTONS */
.actions {
    display:flex;
    justify-content:space-between;
    margin-top:30px;
}

.checkout {
    background:#c47f4f;
    color:white;
    padding:10px 20px;
    border:none;
    cursor:pointer;
}

.checkout:hover {
    background:#5c3b2e;
}

.back-btn {
    background:#5c3b2e;
    color:white;
    padding:10px 20px;
    border:none;
    cursor:pointer;
}

.back-btn:hover {
    background:#c47f4f;
}

.empty {
    text-align:center;
    margin-top:80px;
    font-size:18px;
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">
    <a href="home">
        <img src="images/logo.png" alt="KAIVALAM Logo">
        <span>KAIVALAM</span>
    </a>
</div>
    <div class="nav-links">
        <a href="home">Home</a>
       
    </div>
</div>

<div class="container">
<h2>Your Cart</h2>

<%
if (cart != null && !cart.isEmpty()) {

    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {

        int productId = entry.getKey();
        int qty = entry.getValue();

        Product product = productDAO.getProductById(productId);

        if(product == null) continue;

        double total = product.getPrice() * qty;
        grandTotal += total;
%>

<div class="cart-item">
    <div>
        <h3><%= product.getName() %></h3>
        <p>₹ <%= product.getPrice() %> × <%= qty %> = ₹ <%= total %></p>
    </div>

    <div>
        <form action="cart" method="post" style="display:inline;">
            <input type="hidden" name="productId" value="<%= productId %>">
            <input type="hidden" name="action" value="increase">
            <button class="qty-btn">+</button>
        </form>

        <form action="cart" method="post" style="display:inline;">
            <input type="hidden" name="productId" value="<%= productId %>">
            <input type="hidden" name="action" value="decrease">
            <button class="qty-btn">−</button>
        </form>
    </div>
</div>

<%
    }
%>

<div class="total">
    Grand Total: ₹ <%= grandTotal %>
</div>

<div class="actions">

    <!-- Continue Shopping -->
    <a href="products">
        <button type="button" class="back-btn">← Continue Shopping</button>
    </a>

    <!-- Checkout -->
    <form action="checkout" method="get">
        <button class="checkout">Proceed to Checkout</button>
    </form>

</div>

<%
} else {
%>
    <div class="empty">
        Your cart is empty.<br><br>
        <a href="products">
            <button class="back-btn">← Start Shopping</button>
        </a>
    </div>
<%
}
%>

</div>

</body>
</html>