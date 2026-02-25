<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.artisanplatform.model.Category" %>
<%@ page import="com.artisanplatform.model.User" %>
<%@ page import="java.util.Map" %>

<%
List<Category> categories = (List<Category>) request.getAttribute("categories");

/* 🔥 NEW: Login Check */
User user = (User) session.getAttribute("loggedInUser");
boolean isLoggedIn = (user != null);

/* 🔥 NEW: Cart Count */
int cartCount = 0;
Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
if(cart != null){
    for(int qty : cart.values()){
        cartCount += qty;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>KAIVALAM</title>
<link rel="icon" type="image/png" href="images/logo.png">


<style>
/* ---- YOUR ORIGINAL CSS (UNCHANGED) ---- */
body {
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
    background-color: #f8f4ef;
}

.navbar {
    background-color: #5c3b2e;
    padding: 15px 60px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: white;
    position: sticky;
    top: 0;
    z-index: 1000;
}

.logo {
    font-size: 24px;
    font-weight: bold;
    letter-spacing: 2px;
}

.nav-links {
    display: flex;
    align-items: center;
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

/* VIDEO BANNER */
.video-banner {
    position: relative;
    height: 90vh;
    overflow: hidden;
}

.video-banner video {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.banner-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    text-align: center;
    background: rgba(0,0,0,0.4);
    padding: 25px 50px;
    border-radius: 8px;
}

.banner-text h1 {
    font-size: 42px;
    margin: 0;
}

.banner-text p {
    font-size: 26px;
    margin-top: 20px;
}

/* CATEGORY GRID */
.container {
    width: 85%;
    margin: 60px auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 30px;
}

/* ---- Remaining CSS unchanged ---- */
.card {
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.card img {
    width: 100%;
    height: 220px;
    object-fit: cover;
}

.card-content {
    padding: 20px;
    text-align: center;
}

.card-content h3 {
    margin: 0;
    font-size: 22px;
    color: #5c3b2e;
}

.card-content p {
    font-size: 14px;
    color: #666;
    margin-top: 10px;
}

/* COMING SOON CARD */
.coming-soon {
    position: relative;
    overflow: hidden;
}

/* Light blur + dark overlay */
.coming-soon img {
    width: 100%;
    height: 220px;
    object-fit: cover;
    filter: blur(1.5px);
    transform: scale(1.05);
    transition: 0.3s ease;
}

/* Dark overlay */
.coming-soon::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 220px;
    background: rgba(0, 0, 0, 0.25);
}

/* Coming Soon Tag */
.coming-soon .tag {
    position: absolute;
    top: 15px;
    right: 15px;
    background: #c47f4f;
    color: white;
    padding: 6px 14px;
    font-size: 12px;
    font-weight: bold;
    border-radius: 20px;
    z-index: 10;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2);
}

/* Disable hover lift */
.coming-soon:hover {
    transform: none;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    cursor: not-allowed;
}

/* FOOTER unchanged */
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
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
   <div class="logo">
    <a href="home" style="display:flex; align-items:center; text-decoration:none;">
        <img src="images/logo.png" alt="KAIVALAM Logo" style="height:40px; margin-right:10px;">
        <span style="color:white; font-weight:bold; font-size:20px;">KAIVALAM</span>
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

<!-- VIDEO HERO SECTION -->
<div class="video-banner">
    <video autoplay muted loop playsinline>
        <source src="images/video.mp4" type="video/mp4">
    </video>

    <div class="banner-text">

        <% if(isLoggedIn){ %>
            <p style="font-size:20px;">Welcome, <%= user.getName() %> 👋</p>
        <% } %>

        <h1>கைவளம் (KAIVALAM)</h1>
        <p>Prosperity Through Skilled Hands</p>
       
    </div>
</div>

<!-- CATEGORY GRID (UNCHANGED) -->
<div class="container">

<%
if (categories != null && !categories.isEmpty()) {
    for (Category category : categories) {
%>

<a href="products?categoryId=<%= category.getCategoryId() %>" style="text-decoration:none;">
    <div class="card">
        <img src="images/<%= category.getImageUrl() %>" alt="Category Image">
        <div class="card-content">
            <h3><%= category.getCategoryName() %></h3>
            <p><%= category.getDescription() %></p>
        </div>
    </div>
</a>

<%
    }
%>

<div class="card coming-soon">
 <span class="tag">Coming Soon</span>
    <img src="images/wood.jpg" alt="Wooden Arts">
    <div class="card-content">
        <h3>Wooden Arts</h3>
        <p>Beautiful handcrafted wooden creations.</p>
       
    </div>
</div>

<div class="card coming-soon">
 <span class="tag">Coming Soon</span>
    <img src="images/paintings.webp" alt="Drawings & Paintings">
    <div class="card-content">
        <h3>Drawings & Paintings</h3>
        <p>Traditional and modern artistic expressions.</p>
       
    </div>
</div>

<%
} else {
%>
    <h3 style="text-align:center;">No Categories Available</h3>
<%
}
%>

</div>

<!-- FOOTER (UNCHANGED) -->
<div class="footer">

    <div class="footer-container">

        <div class="footer-section" id="about">
            <h3>About KAIVALAM</h3>
            <p>
                KAIVALAM is rooted in tradition and dedicated to preserving
                the beauty of handcrafted clay artistry. From eco-friendly
                Ganesha idols to traditional diyas and pots, every piece
                reflects culture, craftsmanship, and sustainability.
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

            <br>

            <p><strong>Founder:</strong> Thilagavathi</p>
            <p><strong>Co-Founders:</strong></p>
            <p>Praveenkumar Vediyappan</p>
            <p>Sathishkumar Vediyappan</p>
        </div>

    </div>

    <div class="footer-bottom">
        © 2026 KAIVALAM | Preserving Tradition Through Craft
    </div>
</div>

</body>
</html>