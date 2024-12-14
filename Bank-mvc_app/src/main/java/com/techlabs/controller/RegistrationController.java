package com.techlabs.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.techlabs.entity.Admin;
import com.techlabs.service.AdminService;
import com.techlabs.service.DbService;

@WebServlet("/RegistrationController")
public class RegistrationController extends HttpServlet {
	AdminService adminService = null;
	DbService dbService = null;
	Admin admin = null;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		if (!password.equals(confirmPassword)) {
			request.setAttribute("message", "Passwords do not match. Please try again.");
			request.setAttribute("messageType", "error");
			request.getRequestDispatcher("Registration.jsp").forward(request, response);
			return;
		}

		int adminId = Integer.parseInt(request.getParameter("adminid"));
		String adminName = request.getParameter("username");

		admin = new Admin(adminId, adminName, password);

		dbService = new DbService();
		dbService.connectToDb();

		if (admin != null) {
			adminService = new AdminService(admin, dbService);

			boolean isAdded = adminService.addAdmin();

			if (isAdded) {
				request.setAttribute("message", "Admin Registration Successful! You can now log in.");
				request.setAttribute("messageType", "success");
				request.setAttribute("registrationSuccess", true);
			} else {
				request.setAttribute("message", "Failed to register the admin. Please try again later.");
				request.setAttribute("messageType", "error");
			}
		} else {
			request.setAttribute("message", "Invalid Admin Data. Please try again.");
			request.setAttribute("messageType", "error");
		}

		request.getRequestDispatcher("Registration.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
