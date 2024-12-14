package com.techlabs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techlabs.entity.Account;
import com.techlabs.service.DbService;
import com.techlabs.service.TransactionService;

@WebServlet("/TransactionController")
public class TransactionController extends HttpServlet {

	private TransactionService transactionService;

	@Override
	public void init() throws ServletException {
		transactionService = new TransactionService(new DbService());
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer customerId = (Integer) session.getAttribute("loggedInCustomerId");

		if (customerId == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		List<Account> accounts = transactionService.getAccountsForCustomer(customerId);

		request.setAttribute("accounts", accounts);

		request.getRequestDispatcher("Transaction.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int accountNumber = Integer.parseInt(request.getParameter("accountSelect"));
		double amount = Double.parseDouble(request.getParameter("amount"));
		String transactionType = request.getParameter("transactionType");

		String message = "";
		boolean transactionSuccess = false;

		if ("Credit".equalsIgnoreCase(transactionType)) {
			transactionSuccess = transactionService.creditAccount(accountNumber, amount);
			message = "Amount has been credited to the account!";
		} else if ("Debit".equalsIgnoreCase(transactionType)) {
			transactionSuccess = transactionService.debitAccount(accountNumber, amount);
			message = "Amount has been debited from the account!";
		} else if ("Transfer".equalsIgnoreCase(transactionType)) {
			int receiverAccountNumber = Integer.parseInt(request.getParameter("accountNumber"));

			if (amount <= 0) {
				message = "Transfer amount must be greater than zero.";
				transactionSuccess = false;
			} else {
				transactionSuccess = transactionService.transferFunds(accountNumber, receiverAccountNumber, amount);
				if (transactionSuccess) {
					message = "Transfer successful! Amount has been transferred.";
				} else {
					message = "Transfer failed! Please check the account details or balance.";
				}
			}
		}

		if (!transactionSuccess) {
			message = "Transaction failed! Please try again.";
		}
		request.setAttribute("message", message);

		request.getRequestDispatcher("Transaction.jsp").forward(request, response);
	}
}
