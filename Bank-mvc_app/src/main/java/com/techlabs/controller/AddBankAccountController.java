package com.techlabs.controller;

import com.techlabs.entity.Account;
import com.techlabs.entity.Customer;
import com.techlabs.service.AccountService;
import com.techlabs.service.CustomerService;
import com.techlabs.service.DbService;

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

@WebServlet("/AddBankAccountController")
public class AddBankAccountController extends HttpServlet {

    private DbService dbService;

    @Override
    public void init() throws ServletException {
        System.out.println("Initializing AddBankAccountController");

        dbService = new DbService(); 
        if (dbService == null) {
            System.out.println("DbService failed to initialize.");
        } else {
            System.out.println("DbService initialized successfully.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (dbService == null) {
            System.out.println("DbService is null in doGet.");
        } else {
            System.out.println("DbService is instantiated in doGet.");
        }

        HttpSession session = request.getSession();
        Integer loggedInAdminId = (Integer) session.getAttribute("loggedInAdminId");

        if (loggedInAdminId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String customerIdSearchStr = request.getParameter("customerIdSearch");

        try {
            if (customerIdSearchStr != null && !customerIdSearchStr.isEmpty()) {
                int customerIdSearch = Integer.parseInt(customerIdSearchStr);

                CustomerService customerService = new CustomerService(dbService);
                Customer customer = customerService.getCustomerDetails(customerIdSearch);

                if (customer != null) {
                    AccountService accountService = new AccountService();
                    int accountNumber = accountService.generateRandomAccountNumber();
                    request.setAttribute("customer", customer);
                    request.setAttribute("accountNumber", accountNumber);
                    request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Customer not found.");
                    request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Please enter a valid customer ID.");
                request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Customer ID format.");
            request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (dbService == null) {
            System.out.println("DbService is null in doPost.");
        } else {
            System.out.println("DbService is instantiated in doPost.");
        }

        String accountNumberStr = request.getParameter("accountNumber");
        String accountType = request.getParameter("accountType");
        String balanceStr = request.getParameter("balance");
        String customerIdStr = request.getParameter("customerId");

        Connection conn = dbService.connectToDb();  // Establish a database connection
        if (conn == null) {
            System.out.println("Database connection failed.");
            request.setAttribute("error", "Database connection failed.");
            request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
            return;
        }

        try {
            int accountNumber = Integer.parseInt(accountNumberStr);
            double balance = Double.parseDouble(balanceStr);
            int customerId = Integer.parseInt(customerIdStr);

            Account account = new Account(accountNumber, accountType, customerId, balance);

            AccountService accountService = new AccountService();
            boolean isAccountAdded = accountService.addAccount(account);

            if (isAccountAdded) {
                String query = "INSERT INTO account (account_number, account_type, customer_id, balance) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setInt(1, accountNumber);
                    stmt.setString(2, accountType);
                    stmt.setInt(3, customerId);
                    stmt.setDouble(4, balance);

                    int rowsInserted = stmt.executeUpdate();

                    if (rowsInserted > 0) {
                        request.setAttribute("message", "Bank account added successfully!");
                        request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
                        response.sendRedirect("AdminDashboard.jsp");
                    } else {
                        request.setAttribute("error", "Failed to add bank account.");
                        request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Database error: " + e.getMessage());
                    request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Failed to add bank account.");
                request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input for account number or balance.");
            request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.getRequestDispatcher("/AddBankAccount.jsp").forward(request, response);
        } finally {
            dbService.closeConnection();  
        }
    }
}
