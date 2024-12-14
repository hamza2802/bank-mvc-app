package com.techlabs.controller;

import com.techlabs.entity.Account;
import com.techlabs.service.AccountService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/ViewAccountsController")
public class ViewAccountsController extends HttpServlet {

    private AccountService accountService;

    @Override
    public void init() throws ServletException {
        super.init();
        accountService = new AccountService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer loggedInAdminId = (Integer) session.getAttribute("loggedInAdminId");

        if (loggedInAdminId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String searchQuery = request.getParameter("searchQuery");
        List<Account> accounts;

        // If search query is provided, filter by Account Number or Customer ID
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            accounts = accountService.getFilteredAccounts(searchQuery);
        } else {
            accounts = accountService.getAllAccounts();
        }

        request.setAttribute("accounts", accounts);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewAccounts.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
