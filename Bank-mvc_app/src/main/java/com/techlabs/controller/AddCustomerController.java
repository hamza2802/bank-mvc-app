package com.techlabs.controller;

import com.techlabs.entity.Customer;
import com.techlabs.service.DbService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AddCustomerController")
public class AddCustomerController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if the admin is logged in
        HttpSession session = request.getSession();
        Integer loggedInAdminId = (Integer) session.getAttribute("loggedInAdminId");

        if (loggedInAdminId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Collect form data
        int id = Integer.parseInt(request.getParameter("id"));
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Create a new Customer object
        Customer customer = new Customer(id, firstName, lastName, email, password);

        // Initialize DbService for database connection
        DbService dbService = new DbService();
        Connection conn = dbService.connectToDb();

        String query = "INSERT INTO customer (id, firstname, lastname, email, password) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set parameters for the prepared statement
            stmt.setInt(1, customer.getId());
            stmt.setString(2, customer.getFirstname());
            stmt.setString(3, customer.getLastname());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getPassword());

            // Execute the update
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                // Success message
                request.setAttribute("successMessage", "Customer added successfully!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("AddCustomer.jsp");
                dispatcher.forward(request, response);
            } else {
                // Error message if insertion fails
                request.setAttribute("errorMessage", "Error adding customer.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("AddCustomer.jsp");
                dispatcher.forward(request, response);
            }

        } catch (SQLException e) {
            // Database error handling
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("AddCustomer.jsp");
            dispatcher.forward(request, response);
        } finally {
            // Close the database connection
            dbService.closeConnection();
        }
    }
}
