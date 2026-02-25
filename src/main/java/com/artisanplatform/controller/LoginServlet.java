package com.artisanplatform.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.artisanplatform.dao.UserDAO;
import com.artisanplatform.dao.impl.UserDAOImpl;
import com.artisanplatform.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAOImpl();
        User user = userDAO.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);

            // Check if coming from checkout
            String redirect = (String) session.getAttribute("redirectAfterLogin");

            if (redirect != null && redirect.equals("checkout")) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect("checkout");
            } else {
                response.sendRedirect("home");
            }

        } else {
        	 request.setAttribute("loginError", "Invalid Email or Password");

        	    request.getRequestDispatcher("login.jsp")
        	           .forward(request, response);
        }
    }
}
