package com.artisanplatform.controller;
import java.io.IOException;
import java.util.List;

import com.artisanplatform.dao.CategoryDAO;
import com.artisanplatform.dao.impl.CategoryDAOImpl;
import com.artisanplatform.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDAO categoryDAO = new CategoryDAOImpl();
        List<Category> categories = categoryDAO.getAllCategories();
        System.out.println("Categories size: "+categories.size());

        request.setAttribute("categories", categories);

        RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
        dispatcher.forward(request, response);
    }
}
