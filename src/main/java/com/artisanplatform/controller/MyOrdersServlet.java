package com.artisanplatform.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.artisanplatform.dao.*;
import com.artisanplatform.dao.impl.*;
import com.artisanplatform.model.*;

@WebServlet("/myOrders")
public class MyOrdersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAOImpl();
        List<Order> orders = orderDAO.getOrdersByUser(user.getUserId());

        // Generate formatted IDs
        Map<Integer, String> formattedIds = new HashMap<>();

        for (Order order : orders) {

            LocalDate orderDate =
                order.getOrderDate().toLocalDateTime().toLocalDate();

            String formattedOrderId =
                    "KV-" +
                    orderDate.toString().replace("-", "") +
                    "-" +
                    String.format("%04d", order.getOrderId());

            formattedIds.put(order.getOrderId(), formattedOrderId);
        }

        request.setAttribute("orders", orders);
        request.setAttribute("formattedIds", formattedIds);

        request.getRequestDispatcher("myOrders.jsp")
               .forward(request, response);
    }
}
