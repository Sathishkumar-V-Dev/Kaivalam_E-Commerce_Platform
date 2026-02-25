package com.artisanplatform.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
        }

        String action = request.getParameter("action");
        String productIdStr = request.getParameter("productId");

        if (productIdStr != null && action != null) {

            int productId = Integer.parseInt(productIdStr);

            if ("add".equals(action)) {

                cart.put(productId, cart.getOrDefault(productId, 0) + 1);

                // SUCCESS MESSAGE
                session.setAttribute("cartMessage",
                        "Item added to cart successfully!");

            } else if ("increase".equals(action)) {

                if (cart.containsKey(productId)) {
                    cart.put(productId, cart.get(productId) + 1);
                }

            } else if ("decrease".equals(action)) {

                if (cart.containsKey(productId)) {
                    int qty = cart.get(productId) - 1;

                    if (qty <= 0) {
                        cart.remove(productId);
                    } else {
                        cart.put(productId, qty);
                    }
                }
            }
        }

        session.setAttribute("cart", cart);

        //  Redirect back to previous page
        String referer = request.getHeader("referer");

        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("products"); // fallback
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("cart.jsp")
               .forward(request, response);
    }
}
