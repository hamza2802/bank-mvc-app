package com.techlabs.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.techlabs.entity.Transaction;
import com.techlabs.service.DbService;
import com.techlabs.service.TransactionService;

@WebServlet("/PassbookController")
public class PassbookController extends HttpServlet {

	private TransactionService transactionService;

	public PassbookController() {
		this.transactionService = new TransactionService(new DbService());
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer customerId = (Integer) session.getAttribute("loggedInCustomerId");

		if (customerId != null) {
			try {
				List<Transaction> transactions = transactionService.getTransactionsByCustomerId(customerId);
				request.setAttribute("transactions", transactions);
				request.getRequestDispatcher("/Passbook.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving transactions.");
			}
		} else {
			response.sendRedirect("Login.jsp");
		}
	}
}
