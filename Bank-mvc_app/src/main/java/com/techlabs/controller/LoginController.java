package com.techlabs.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techlabs.entity.Admin;
import com.techlabs.entity.Customer;
import com.techlabs.service.AdminService;
import com.techlabs.service.CustomerService;
import com.techlabs.service.DbService;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    private DbService dbService = null;
    private AdminService adminService = null;
    private CustomerService customerService = null;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");

        dbService = new DbService();
        adminService = new AdminService();
        customerService = new CustomerService();

        Connection connection = dbService.connectToDb();

        if (connection != null) {
            try {
                if ("Admin".equals(role)) {
                    String adminId = request.getParameter("adminId");
                    String password = request.getParameter("password");
                    Admin admin = adminService.verifyAdminCredentials(connection, adminId, password);

                    if (admin != null) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("admin", admin);
                        session.setAttribute("loggedInAdminId", admin.getAdminId());
                        response.sendRedirect("AdminDashboard.jsp");
                    } else {
                        request.setAttribute("error", "Invalid admin ID or password.");
                        request.getRequestDispatcher("Login.jsp").forward(request, response);
                    }
                } else if ("Customer".equals(role)) {
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    Customer customer = customerService.verifyCustomerCredentials(connection, email, password);

                    if (customer != null) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("customer", customer);
                        session.setAttribute("loggedInCustomerId", customer.getId());
                        response.sendRedirect("CustomerDashboard.jsp");
                    } else {
                        request.setAttribute("error", "Invalid email or password.");
                        request.getRequestDispatcher("Login.jsp").forward(request, response);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error. Please try again later.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } finally {
                dbService.closeConnection();
            }
        } else {
            request.setAttribute("error", "Database connection error.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("admin") != null) {
            response.sendRedirect("AdminDashboard.jsp");
        } else if (session != null && session.getAttribute("customer") != null) {
            response.sendRedirect("CustomerDashboard.jsp");
        } else {
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}
