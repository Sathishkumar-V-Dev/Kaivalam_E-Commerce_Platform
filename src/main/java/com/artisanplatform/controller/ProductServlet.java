package com.artisanplatform.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.artisanplatform.dao.ProductDAO;
import com.artisanplatform.dao.impl.ProductDAOImpl;
import com.artisanplatform.model.Product;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String categoryIdParam = request.getParameter("categoryId");

        if (categoryIdParam != null) {

            int categoryId = Integer.parseInt(categoryIdParam);

            ProductDAO productDAO = new ProductDAOImpl();
            List<Product> products = productDAO.getProductsByCategory(categoryId);

            request.setAttribute("products", products);

            RequestDispatcher rd = request.getRequestDispatcher("products.jsp");
            rd.forward(request, response);
        } else {
            response.sendRedirect("home");
        }
    }
}
