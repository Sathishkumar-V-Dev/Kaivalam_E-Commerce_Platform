package com.artisanplatform.controller;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        Object user = session.getAttribute("loggedInUser");

        if (user == null) {
            session.setAttribute("redirectAfterLogin", "checkout");
            response.sendRedirect("login.jsp");
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }
}
