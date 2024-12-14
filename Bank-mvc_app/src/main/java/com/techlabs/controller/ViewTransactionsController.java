package com.techlabs.controller;

import com.techlabs.entity.Transaction;
import com.techlabs.service.TransactionService;
import com.techlabs.service.DbService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ViewTransactionsController")
public class ViewTransactionsController extends HttpServlet {

    private DbService dbService = new DbService();
    private TransactionService transactionService = new TransactionService(dbService);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer loggedInAdminId = (Integer) session.getAttribute("loggedInAdminId");

        if (loggedInAdminId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Transaction> transactions = null;
        String searchQuery = request.getParameter("searchQuery");

        try {
            if (searchQuery != null && !searchQuery.isEmpty()) {
                transactions = transactionService.searchTransactions(searchQuery);
            } else {
                transactions = transactionService.getAllTransactions();
            }

            request.setAttribute("transactions", transactions);

            RequestDispatcher dispatcher = request.getRequestDispatcher("ViewTransactions.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error retrieving transaction data from the database.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
