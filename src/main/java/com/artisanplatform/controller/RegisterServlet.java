package com.artisanplatform.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.artisanplatform.dao.UserDAO;
import com.artisanplatform.dao.impl.UserDAOImpl;
import com.artisanplatform.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        User user = new User(name, email, password, phone, address, "CUSTOMER");

        UserDAO userDAO = new UserDAOImpl();
        boolean success = userDAO.insertUser(user);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            response.getWriter().println("Registration Failed. Email may already exist.");
        }
    }
}
