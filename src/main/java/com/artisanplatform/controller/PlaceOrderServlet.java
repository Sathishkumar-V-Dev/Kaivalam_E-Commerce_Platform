package com.artisanplatform.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.artisanplatform.dao.*;
import com.artisanplatform.dao.impl.*;
import com.artisanplatform.model.*;
import com.artisanplatform.util.DBConnection;

@WebServlet("/placeOrder")
public class PlaceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("loggedInUser");
        Map<Integer, Integer> cart =
                (Map<Integer, Integer>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");
        String paymentMethod = request.getParameter("paymentMethod");

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            ProductDAO productDAO = new ProductDAOImpl();
            OrderDAO orderDAO = new OrderDAOImpl();
            OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

            double totalAmount = 0;

            // Calculate total
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Product product = productDAO.getProductById(entry.getKey());
                totalAmount += product.getPrice() * entry.getValue();
            }

            // Insert Order
            Order order = new Order(
                    user.getUserId(),
                    totalAmount,
                    "PLACED",
                    shippingAddress,
                    paymentMethod
            );

            int orderId = orderDAO.insertOrder(order);

            if (orderId <= 0) {
                throw new SQLException("Order insertion failed.");
            }
            
            order.setOrderId(orderId);
            String formattedOrderId =
                    "KV-" +
                    java.time.LocalDate.now().toString().replace("-", "") +
                    "-" +
                    String.format("%04d", orderId);

            request.setAttribute("formattedOrderId", formattedOrderId);
            List<OrderItem> orderItemList = new ArrayList<>();

            // Insert Order Items
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {

                int productId = entry.getKey();
                int quantity = entry.getValue();

                Product product = productDAO.getProductById(productId);

                if (product.getStockQuantity() < quantity) {
                    throw new SQLException("Insufficient stock.");
                }

                OrderItem item = new OrderItem(
                        orderId,
                        productId,
                        quantity,
                        product.getPrice(),
                        product.getPrice() * quantity
                );

                orderItemDAO.insertOrderItem(item);

                orderItemList.add(item);

                int newStock = product.getStockQuantity() - quantity;
                productDAO.updateStock(productId, newStock);
            }

            conn.commit();

            session.removeAttribute("cart");

            // 🔥 PASS DATA TO JSP
            request.setAttribute("order", order);
            request.setAttribute("orderItems", orderItemList);

            request.getRequestDispatcher("orderSuccess.jsp")
                   .forward(request, response);

        } catch (Exception e) {

            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

            e.printStackTrace();
            response.getWriter().println("Order Failed!");

        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}


