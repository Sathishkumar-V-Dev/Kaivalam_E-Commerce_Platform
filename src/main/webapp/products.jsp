<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.artisanplatform.model.Product" %>
<%@ page import="com.artisanplatform.model.User" %>

<!DOCTYPE html>
<html>
<head>
<title>KAIVALAM - Products</title>
<link rel="icon" type="image/png" href="images/logo.png">

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f8f4ef;
}

/* NAVBAR */
.navbar {
    background-color: #5c3b2e;
    padding: 15px 60px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
}

.logo {
    font-size: 24px;
    font-weight: bold;
    letter-spacing: 2px;
}

.nav-links a {
    color: white;
    margin-left: 25px;
    text-decoration: none;
    font-size: 14px;
}

.nav-links a:hover {
    color: #c47f4f;
}

/* SUCCESS MESSAGE */
.success-message {
    width: 90%;
    max-width: 1200px;
    margin: 15px auto;
    padding: 12px;
    background-color: #d4edda;
    color: #155724;
    border-left: 5px solid #28a745;
    border-radius: 5px;
    font-size: 14px;
    opacity: 1;
    transition: opacity 0.5s ease;
}

/* PAGE TITLE */
.page-title {
    text-align: center;
    padding: 30px 20px 10px 20px;
}

.page-title h1 {
    color: #5c3b2e;
    font-size: 32px;
}

/* PRODUCT GRID */
.container {
    width: 90%;
    max-width: 1200px;
    margin: 40px auto;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
    padding-bottom: 100px;
}

@media (max-width: 992px) {
    .container {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 600px) {
    .container {
        grid-template-columns: 1fr;
    }
}

.card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    transition: 0.3s;
    display: flex;
    flex-direction: column;
    min-height: 600px;
}

.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 30px rgba(0,0,0,0.15);
}

.card img {
    width: 100%;
    height: 350px;
    object-fit: contain;
    background-color: #f8f4ef;
    padding: 10px;
}

.card-content {
    padding: 20px;
    flex: 1;
}

.card-content h3 {
    margin: 0;
    font-size: 20px;
    color: #5c3b2e;
}

.card-content p {
    font-size: 14px;
    color: #666;
    margin-top: 10px;
    min-height: 50px;
}

.price {
    font-size: 20px;
    color: #c47f4f;
    font-weight: bold;
    margin-top: 10px;
}

.stock {
    font-size: 13px;
    margin-top: 5px;
    color: green;
}

.out-stock {
    color: red;
}

.btn {
    display: block;
    width: 100%;
    background-color: #5c3b2e;
    color: white;
    text-align: center;
    padding: 12px;
    border: none;
    cursor: pointer;
    font-size: 14px;
    transition: 0.3s;
}

.btn:hover {
    background-color: #c47f4f;
}

/* FOOTER */
.footer {
    background-color: #5c3b2e;
    color: white;
    padding: 40px 60px 20px 60px;
}

.footer-container {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
}

.footer-section {
    margin-bottom: 20px;
    max-width: 500px;
}

.footer-section h3 {
    margin-bottom: 15px;
}

.footer-section p {
    margin: 6px 0;
    font-size: 14px;
}

.footer-section a {
    color: #f2c6a0;
    text-decoration: none;
}

.footer-section a:hover {
    text-decoration: underline;
}

.footer-bottom {
    text-align: center;
    margin-top: 20px;
    font-size: 13px;
    border-top: 1px solid rgba(255,255,255,0.2);
    padding-top: 10px;
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

<%
User user = (User) session.getAttribute("loggedInUser");
boolean isLoggedIn = (user != null);

Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
int cartCount = 0;
if(cart != null){
    for(int qty : cart.values()){
        cartCount += qty;
    }
}
%>

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

        <% if(isLoggedIn){ %>
            <a href="cart">🛒 Cart (<%= cartCount %>)</a>
            <a href="myOrders">📦 My Orders</a>
        <% } %>

        <a href="#about">About</a>
        <a href="#contact">Contact</a>

        <% if(!isLoggedIn){ %>
            <a href="login.jsp">Login</a>
        <% } else { %>
            <a href="logout">Logout</a>
        <% } %>
    </div>
</div>

<!-- SUCCESS MESSAGE -->
<%
String cartMessage = (String) session.getAttribute("cartMessage");
if(cartMessage != null){
%>
<div class="success-message" id="successMsg">
    <%= cartMessage %>
</div>
<%
    session.removeAttribute("cartMessage");
}
%>

<!-- TITLE -->
<div class="page-title">
    <h1>Explore Our Handcrafted Collection</h1>
</div>

<!-- PRODUCTS -->
<div class="container">

<%
List<Product> products = (List<Product>) request.getAttribute("products");

if (products != null && !products.isEmpty()) {
    for (Product product : products) {
%>

    <div class="card">
        <img src="images/<%= product.getImageUrl() %>" alt="Product Image">

        <div class="card-content">
            <h3><%= product.getName() %></h3>
            <p><%= product.getDescription() %></p>

            <div class="price">₹ <%= product.getPrice() %></div>

            <% if (product.getStockQuantity() > 0) { %>
                <div class="stock">In Stock</div>
            <% } else { %>
                <div class="stock out-stock">Out of Stock</div>
            <% } %>
        </div>

        <form action="cart" method="post">
            <input type="hidden" name="productId" value="<%= product.getProductId() %>">
            <input type="hidden" name="action" value="add">
            <button class="btn">Add to Cart</button>
        </form>
    </div>

<%
    }
} else {
%>
    <h3 style="text-align:center;">No Products Available</h3>
<%
}
%>

</div>

<script>
setTimeout(function(){
    let msg = document.getElementById("successMsg");
    if(msg){
        msg.style.opacity = "0";
        setTimeout(function(){
            msg.style.display = "none";
        }, 500);
    }
}, 3000);
</script>



<!-- FOOTER -->
<div class="footer">
    <div class="footer-container">
        <div class="footer-section" id="about">
            <h3>About KAIVALAM</h3>
            <p>
                KAIVALAM is rooted in tradition and dedicated to preserving
                handcrafted clay artistry. Every piece reflects culture,
                craftsmanship, and sustainability.
            </p>
        </div>

        <div class="footer-section" id="contact">
            <h3>Contact Us</h3>
            <p>📞 Phone: <a href="tel:8754985031">8754985031</a></p>
            <p>💬 WhatsApp:
                <a href="https://wa.me/919159636197" target="_blank">
                    9159636197
                </a>
            </p>
            <p>📧 Email:
                <a href="mailto:sathishbackend.dev@gmail.com">
                    sathishbackend.dev@gmail.com
                </a>
            </p>
        </div>
    </div>

    <div class="footer-bottom">
        © 2026 KAIVALAM | Preserving Tradition Through Craft
    </div>
</div>

</body>
</html>