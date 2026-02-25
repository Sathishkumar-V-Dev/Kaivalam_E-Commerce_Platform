package com.artisanplatform.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.artisanplatform.dao.*;
import com.artisanplatform.dao.impl.*;
import com.artisanplatform.model.*;

@WebServlet("/viewOrder")
public class ViewOrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        OrderDAO orderDAO = new OrderDAOImpl();
        OrderItemDAO orderItemDAO = new OrderItemDAOImpl();

        Order order = orderDAO.getOrderById(orderId);
        List<OrderItem> items =
                orderItemDAO.getItemsByOrderId(orderId);

        // Generate formatted ID using order_date
        LocalDate orderDate =
            order.getOrderDate().toLocalDateTime().toLocalDate();

        String formattedOrderId =
                "KV-" +
                orderDate.toString().replace("-", "") +
                "-" +
                String.format("%04d", order.getOrderId());

        request.setAttribute("order", order);
        request.setAttribute("items", items);
        request.setAttribute("formattedOrderId", formattedOrderId);

        request.getRequestDispatcher("viewOrder.jsp")
               .forward(request, response);
    }
}
