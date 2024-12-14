package com.techlabs.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techlabs.entity.Customer;
import com.techlabs.service.CustomerService;
import com.techlabs.service.DbService;

@WebServlet("/UpdateProfileController")
public class UpdateProfileController extends HttpServlet {

    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService(new DbService());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("loggedInCustomerId");
        Customer customer = (Customer) session.getAttribute("customer");

        if (customerId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        if (customer != null) {
            request.setAttribute("firstName", customer.getFirstname());
            request.setAttribute("lastName", customer.getLastname());
            request.setAttribute("email", customer.getEmail());
            RequestDispatcher dispatcher = request.getRequestDispatcher("UpdateProfile.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Customer not found in session.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer customerId = (Integer) session.getAttribute("loggedInCustomerId");
        Customer customer = (Customer) session.getAttribute("customer");

        if (customerId == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String newPassword = request.getParameter("newPassword");

        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() || 
            newPassword == null || newPassword.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Please fill in all fields.");
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            return;
        }

        boolean updated = false;

        try {
            if (firstName != null && !firstName.trim().isEmpty()) {
                customerService.updateFirstName(customerId, firstName);
                updated = true;
            }
            if (lastName != null && !lastName.trim().isEmpty()) {
                customerService.updateLastName(customerId, lastName);
                updated = true;
            }
            if (newPassword != null && !newPassword.trim().isEmpty()) {
                customerService.updatePassword(customerId, newPassword);
                updated = true;
            }

            if (updated) {
                customer.setFirstname(firstName);
                customer.setLastname(lastName);
                customer.setPassword(newPassword);
                session.setAttribute("customer", customer);
                request.setAttribute("successMessage", "Profile updated successfully.");
                request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating your profile. Please try again.");
            request.getRequestDispatcher("UpdateProfile.jsp").forward(request, response);
        }
    }
}
